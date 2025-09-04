// public/js/cities.js
$(document).ready(function () {
    // Elements
    const addnewcitybutton = $("#addnewcity"),
        cityidfield = $("#cityid"),
        citynamefield = $("#citydetailscityname"),
        citycountrylist = $("#citydetailscountry"),
        savecitybutton = $("#savecity"),
        citydetailnotifications = $("#citydetailsnotifications"),
        filtercountry = $("#filtercountry"),
        filtercityname = $("#filtercityname"),
        filtercitynotifications = $("#filtercitynotifications"),
        searchcitiesbutton = $("#searchcities"),
        citiesTableBody = $("#citiesTableBody");

    // initialize modal once (requires bootstrap bundle loaded before this file)
    const citymodalEl = document.getElementById("citydetailsmodal");
    const citymodal = citymodalEl ? new bootstrap.Modal(citymodalEl) : null;

    // small helper to show notifications
    function showNotification(container, type, msg, timeout = 3500) {
        const html = `<div class="alert alert-${type} alert-sm" role="alert">${msg}</div>`;
        container.html(html);
        if (timeout > 0) {
            setTimeout(() => container.html(""), timeout);
        }
    }

    // --- Load countries into dropdowns ---
    function getcountries(obj, option = "choose") {
        $.getJSON("controllers/countryoperations.php", { getcountries: true })
            .done(function (data) {
                let results = option === "choose" ? `<option value=""> &lt;Choose&gt; </option>` : `<option value="0"> &lt;All&gt; </option>`;
                if (data && data.status === "success" && Array.isArray(data.data)) {
                    data.data.forEach(function (country) {
                        results += `<option value="${country.countryid}">${country.countryname}</option>`;
                    });
                } else {
                    results += `<option disabled>No countries found</option>`;
                }
                obj.html(results);
            })
            .fail(function (xhr) {
                filtercitynotifications.html(`<div class="alert alert-danger">${xhr.responseText || "Error loading countries"}</div>`);
            });
    }

    // --- Load cities into table ---
    function getcitiesastable(countryid = "", cityname = "") {
        $.getJSON("controllers/cityoperations.php", {
            getcities: true,
            countryid: countryid,
            cityname: cityname
        })
            .done(function (data) {
                let rows = "";
                if (data && data.status === "success" && Array.isArray(data.data)) {
                    if (data.data.length === 0) {
                        rows = `<tr><td colspan="6" class="text-center">No cities found</td></tr>`;
                    } else {
                        data.data.forEach(function (city, index) {
                            rows += `
                                <tr>
                                    <td>${index + 1}</td>
                                    <td>${city.countryname || ""}</td>
                                    <td>${city.cityname || ""}</td>
                                    <td>${city.airports ?? 0}</td>
                                    <td>${city.airlines ?? 0}</td>
                                    <td>
                                        <button class="btn btn-sm btn-primary editcity" data-id="${city.cityid}"><i class="fas fa-edit"></i></button>
                                        <button class="btn btn-sm btn-danger deletecity" data-id="${city.cityid}"><i class="fas fa-trash"></i></button>
                                    </td>
                                </tr>
                            `;
                        });
                    }
                } else {
                    rows = `<tr><td colspan="6" class="text-center text-muted">Error loading cities</td></tr>`;
                }
                citiesTableBody.html(rows);
            })
            .fail(function (xhr) {
                citiesTableBody.html(`<tr><td colspan="6" class="text-danger">${xhr.responseText || "Request failed"}</td></tr>`);
            });
    }

    // --- Add New City (opens modal) ---
    addnewcitybutton.on("click", function () {
        if (!citymodal) {
            alert("Bootstrap modal not initialized. Make sure bootstrap.bundle.min.js is loaded before this script.");
            return;
        }
        cityidfield.val("0");
        citynamefield.val("");
        citycountrylist.val("");
        citydetailnotifications.html("");
        citymodal.show();
    });

    // --- Save city (Add / Update) ---
    savecitybutton.on("click", function () {
        const cityid = cityidfield.val(),
            countryid = citycountrylist.val(),
            cityname = citynamefield.val().trim();

        if (!countryid) {
            showNotification(citydetailnotifications, "info", "Please select a country first");
            citycountrylist.focus();
            return;
        }
        if (!cityname) {
            showNotification(citydetailnotifications, "info", "Please provide a city name");
            citynamefield.focus();
            return;
        }

        // Post and expect JSON back
        $.post("controllers/cityoperations.php", {
            savecity: true,
            cityid: cityid,
            cityname: cityname,
            countryid: countryid
        }, function (resp) {
            // resp is already parsed as JSON if server returns proper JSON and jQuery infers it.
            // However if server returns string, check:
            let data = resp;
            if (typeof resp === "string") {
                try { data = JSON.parse(resp); } catch (e) { data = { status: "error", message: resp }; }
            }

            if (data.status === "success") {
                showNotification(citydetailnotifications, "success", data.message || "Saved successfully");
                citynamefield.val("").focus();
                cityidfield.val("0");
                getcitiesastable(); // refresh table
                // close modal after a short delay
                setTimeout(() => { if (citymodal) citymodal.hide(); }, 600);
            } else if (data.status === "exists") {
                showNotification(citydetailnotifications, "info", data.message || "City already exists");
                citynamefield.focus();
            } else {
                showNotification(citydetailnotifications, "danger", data.message || "Error saving city");
            }
        }, "json").fail(function (xhr) {
            showNotification(citydetailnotifications, "danger", "Request failed: " + (xhr.statusText || xhr.responseText));
        });
    });

    // --- Edit city (delegated handler) ---
    citiesTableBody.on("click", ".editcity", function (e) {
        e.preventDefault();
        const id = $(this).data("id");
        if (!id) return;

        // fetch single city details
        $.getJSON("controllers/cityoperations.php", { getcitydetails: true, cityid: id })
            .done(function (res) {
                if (res && res.status === "success" && res.data) {
                    // res.data may be object or array; normalize:
                    const d = Array.isArray(res.data) ? res.data[0] : res.data;
                    cityidfield.val(d.cityid || id);
                    citynamefield.val(d.cityname || "");
                    // set country dropdown (if countryid or countryid key)
                    const countryIdKey = d.countryid ?? d.country_id ?? d.countryID ?? d.country; // try common keys
                    if (countryIdKey) citycountrylist.val(countryIdKey);
                    citydetailnotifications.html("");
                    if (citymodal) citymodal.show();
                } else {
                    showNotification(filtercitynotifications, "danger", res.message || "Failed to load city details");
                }
            })
            .fail(function (xhr) {
                showNotification(filtercitynotifications, "danger", "Request failed: " + (xhr.statusText || xhr.responseText));
            });
    });

    // --- Delete city (delegated handler) ---
    citiesTableBody.on("click", ".deletecity", function (e) {
        e.preventDefault();
        const id = $(this).data("id");
        if (!id) return;

        if (!confirm("Are you sure you want to delete this city? This action cannot be undone.")) return;

        const $btn = $(this);
        $btn.prop("disabled", true);

        $.post("controllers/cityoperations.php", { deletecity: true, cityid: id }, function (resp) {
            let data = resp;
            if (typeof resp === "string") {
                try { data = JSON.parse(resp); } catch (e) { data = { status: "error", message: resp }; }
            }

            if (data.status === "success") {
                showNotification(filtercitynotifications, "success", data.message || "City deleted");
                getcitiesastable(); // refresh table
            } else {
                showNotification(filtercitynotifications, "danger", data.message || "Failed to delete");
            }
        }, "json").fail(function (xhr) {
            showNotification(filtercitynotifications, "danger", "Request failed: " + (xhr.statusText || xhr.responseText));
        }).always(function () {
            $btn.prop("disabled", false);
        });
    });

    // --- Search / filter ---
    searchcitiesbutton.on("click", function () {
        getcitiesastable(filtercountry.val(), filtercityname.val());
    });

    // Enter key for search input triggers the same
    filtercityname.on ? filtercityname.on("keypress", function (e) {
        if (e.which === 13) getcitiesastable(filtercountry.val(), filtercityname.val());
    }) : null;

    // --- Initialize on load ---
    getcountries(filtercountry, "all");
    getcountries(citycountrylist, "choose");
    getcitiesastable();
});
