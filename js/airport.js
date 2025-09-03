$(document).ready(function () {
    loadAirports();

    function loadAirports() {
        $.get("../controllers/airportoperations.php?getairports=true", function (res) {
            if (res.status === "success") {
                let rows = "";
                res.data.forEach((a, i) => {
                    rows += `
                      <tr>
                        <td>${i + 1}</td>
                        <td>${a.airportname}</td>
                        <td>${a.airportcode}</td>
                        <td>${a.cityid}</td>
                        <td>${a.countryid}</td>
                        <td>
                          <button class="btn btn-sm btn-primary edit-btn" data-id="${a.airportid}">
                            <i class="fa fa-edit"></i>
                          </button>
                          <button class="btn btn-sm btn-danger delete-btn" data-id="${a.airportid}">
                            <i class="fa fa-trash"></i>
                          </button>
                        </td>
                      </tr>`;
                });
                $("#airportTableBody").html(rows);
            }
        }, "json");
    }

    $("#addAirportBtn").click(function () {
        $("#airportid").val(0);
        $("#airportname, #airportcode, #cityid, #countryid").val("");
        $("#airportModal").modal("show");
    });

    $("#saveAirportBtn").click(function () {
        $.post("../controllers/airportoperations.php", {
            saveairport: true,
            airportid: $("#airportid").val(),
            airportname: $("#airportname").val(),
            airportcode: $("#airportcode").val(),
            cityid: $("#cityid").val(),
            countryid: $("#countryid").val()
        }, function (res) {
            if (res.status === "success") {
                $("#airportModal").modal("hide");
                loadAirports();
            } else {
                alert(res.message);
            }
        }, "json");
    });

    $(document).on("click", ".edit-btn", function () {
        let id = $(this).data("id");
        $.get("../controllers/airportoperations.php?getairportdetails=true&airportid=" + id, function (res) {
            if (res.status === "success" && res.data.length > 0) {
                let a = res.data[0];
                $("#airportid").val(a.airportid);
                $("#airportname").val(a.airportname);
                $("#airportcode").val(a.airportcode);
                $("#cityid").val(a.cityid);
                $("#countryid").val(a.countryid);
                $("#airportModal").modal("show");
            }
        }, "json");
    });

    $(document).on("click", ".delete-btn", function () {
        if (!confirm("Delete this airport?")) return;
        let id = $(this).data("id");
        $.post("../controllers/airportoperations.php", {
            deleteairport: true,
            airportid: id
        }, function (res) {
            if (res.status === "success") {
                loadAirports();
            } else {
                alert(res.message);
            }
        }, "json");
    });
});
