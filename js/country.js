$(document).ready(function () {
    // Declare reusable variables
    const countryModal = $("#countryModal");
    const addCountryBtn = $("#addCountryBtn");
    const saveCountryBtn = $("#saveCountryBtn");
    const countryIdField = $("#countryid");
    const countryNameField = $("#countryname");
    const notifications = $("#notifications");
    const countryTableBody = $("#countryTableBody");

    // Debug dependencies
    console.log("jQuery:", typeof $ !== "undefined");
    console.log("Bootstrap Modal:", typeof $.fn.modal !== "undefined");

    // Function: Display notifications
    function showNotification(message, type = "primary") {
        if (!notifications.length) {
            console.error("Notifications container (#notifications) not found");
            return;
        }
        notifications.html(`<div class="alert alert-${type} alert-dismissible fade show" role="alert">
            ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>`);
        setTimeout(() => $(".alert").alert("close"), 4000);
    }

    function loadCountries() {
    $.get("controllers/countryoperations.php?getcountries=true", function (res) {
        console.log("loadCountries Response:", res);
        if (res.status === "success" && Array.isArray(res.data)) {
            let rows = "";
            res.data.forEach((c, i) => {
                rows += `
                    <tr>
                        <td>${i + 1}</td>
                        <td>${c.countryname}</td>
                        <td>${c.cities || 0}</td>
                        <td>${c.airports || 0}</td>
                        <td>${c.airlines || 0}</td>
                        <td>
                            <button class="btn btn-sm btn-primary edit-btn" data-id="${c.countryid}">
                                <i class="fa fa-edit"></i>
                            </button>
                            <button class="btn btn-sm btn-danger delete-btn" data-id="${c.countryid}">
                                <i class="fa fa-trash"></i>
                            </button>
                        </td>
                    </tr>`;
            });
            countryTableBody.empty().html(rows);
        } else {
            showNotification("❌ Failed to load countries: " + (res.message || "Invalid response"), "danger");
        }
    }, "json").fail(function (jqXHR, textStatus, errorThrown) {
        console.error("loadCountries Error:", {
            status: jqXHR.status,
            statusText: jqXHR.statusText,
            responseText: jqXHR.responseText
        });
        showNotification("❌ Error loading countries (" + jqXHR.status + "): " + jqXHR.statusText, "danger");
    });
}


    // Call loader initially
    loadCountries();

    // Add new country button
    addCountryBtn.on("click", function () {
        console.log("Add Country button clicked");
        countryIdField.val(0);
        countryNameField.val("");
        notifications.empty();
        if (countryModal.length) {
            countryModal.modal("show");
        } else {
            console.error("Country modal (#countryModal) not found");
            showNotification("❌ Modal not found.", "danger");
        }
    });

    // When modal hides, reset form
    countryModal.on("hidden.bs.modal", function () {
        console.log("Modal hidden");
        saveCountryBtn.prop("disabled", false).html("Save");
        countryIdField.val(0);
        countryNameField.val("");
        notifications.empty();
    });

    // Save country button
    saveCountryBtn.on("click", function () {
        const countryName = countryNameField.val().trim();
        const countryId = countryIdField.val();
        console.log("Sending:", { savecountry: true, countryid: countryId, countryname: countryName });
        if (countryName === "") {
            showNotification("⚠️ Please enter a country name.", "warning");
            countryNameField.focus();
            return;
        }

        saveCountryBtn.prop("disabled", true).html(`<span class="spinner-border spinner-border-sm"></span> Saving...`);

        $.post("controllers/countryoperations.php", {
            savecountry: true,
            countryid: countryId,
            countryname: countryName
        }, function (res) {
            console.log("Save Response:", res);
            if (res.status === "success") {
                countryModal.modal("hide");
                loadCountries();
                showNotification("✅ Country saved successfully!", "success");
            } else {
                showNotification("❌ " + (res.message || "Failed to save country"), "danger");
                saveCountryBtn.prop("disabled", false).html("Save");
            }
        }, "json").fail(function (jqXHR, textStatus, errorThrown) {
            console.error("Save Error:", {
                status: jqXHR.status,
                statusText: jqXHR.statusText,
                responseText: jqXHR.responseText
            });
            showNotification("❌ Server error (" + jqXHR.status + "): " + jqXHR.statusText, "danger");
            saveCountryBtn.prop("disabled", false).html("Save");
        });
    });

    // Edit country button
    $(document).on("click", ".edit-btn", function () {
        console.log("Edit button clicked");
        let id = $(this).data("id");
        $.get("controllers/countryoperations.php?getcountrydetails=true&countryid=" + id, function (res) {
            console.log("Edit Response:", res);
            if (res.status === "success" && res.data.length > 0) {
                let c = res.data[0];
                countryIdField.val(c.countryid);
                countryNameField.val(c.countryname);
                notifications.empty();
                if (countryModal.length) {
                    countryModal.modal("show");
                } else {
                    console.error("Country modal (#countryModal) not found");
                    showNotification("❌ Modal not found.", "danger");
                }
            } else {
                showNotification("❌ Failed to load country details.", "danger");
            }
        }, "json").fail(function (jqXHR, textStatus, errorThrown) {
            console.error("Edit Error:", {
                status: jqXHR.status,
                statusText: jqXHR.statusText,
                responseText: jqXHR.responseText
            });
            showNotification("❌ Error loading country details (" + jqXHR.status + ")", "danger");
        });
    });

    // Delete country button
    $(document).on("click", ".delete-btn", function () {
        if (!confirm("🗑️ Are you sure you want to delete this country?")) return;
        let id = $(this).data("id");
        $.post("controllers/countryoperations.php", {
            deletecountry: true,
            countryid: id
        }, function (res) {
            console.log("Delete Response:", res);
            if (res.status === "success") {
                loadCountries();
                showNotification("🗑️ Country deleted successfully!", "success");
            } else {
                showNotification("❌ " + (res.message || "Failed to delete country"), "danger");
            }
        }, "json").fail(function (jqXHR, textStatus, errorThrown) {
            console.error("Delete Error:", {
                status: jqXHR.status,
                statusText: jqXHR.statusText,
                responseText: jqXHR.responseText
            });
            showNotification("❌ Error deleting country (" + jqXHR.status + ")", "danger");
        });
    });
});
