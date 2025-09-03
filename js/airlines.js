$(document).ready(function () {
    loadAirlines();

    function loadAirlines() {
        $.get("../controllers/airlineoperations.php?getairlines=true", function (res) {
            if (res.status === "success") {
                let rows = "";
                res.data.forEach((a, i) => {
                    rows += `
                      <tr>
                        <td>${i + 1}</td>
                        <td>${a.airlinename}</td>
                        <td>${a.iatacode}</td>
                        <td><img src="images/${a.airlinelogo}" alt="" width="50"></td>
                        <td>${a.countryid}</td>
                        <td>${a.email}</td>
                        <td>${a.website}</td>
                        <td>
                          <button class="btn btn-sm btn-primary edit-btn" data-id="${a.airlineid}">
                            <i class="fa fa-edit"></i>
                          </button>
                          <button class="btn btn-sm btn-danger delete-btn" data-id="${a.airlineid}">
                            <i class="fa fa-trash"></i>
                          </button>
                        </td>
                      </tr>`;
                });
                $("#airlineTableBody").html(rows);
            }
        }, "json");
    }

    $("#addAirlineBtn").click(function () {
        $("#airlineid").val(0);
        $("#airlinename, #iatacode, #airlinelogo, #countryid, #email, #website").val("");
        $("#airlineModal").modal("show");
    });

    $("#saveAirlineBtn").click(function () {
        $.post("../controllers/airlineoperations.php", {
            saveairline: true,
            airlineid: $("#airlineid").val(),
            airlinename: $("#airlinename").val(),
            iatacode: $("#iatacode").val(),
            airlinelogo: $("#airlinelogo").val(),
            countryid: $("#countryid").val(),
            email: $("#email").val(),
            website: $("#website").val()
        }, function (res) {
            if (res.status === "success") {
                $("#airlineModal").modal("hide");
                loadAirlines();
            } else {
                alert(res.message);
            }
        }, "json");
    });

    $(document).on("click", ".edit-btn", function () {
        let id = $(this).data("id");
        $.get("../controllers/airlineoperations.php?getairlinedetails=true&airlineid=" + id, function (res) {
            if (res.status === "success" && res.data.length > 0) {
                let a = res.data[0];
                $("#airlineid").val(a.airlineid);
                $("#airlinename").val(a.airlinename);
                $("#iatacode").val(a.iatacode);
                $("#airlinelogo").val(a.airlinelogo);
                $("#countryid").val(a.homecountryid);
                $("#email").val(a.email);
                $("#website").val(a.website);
                $("#airlineModal").modal("show");
            }
        }, "json");
    });

    $(document).on("click", ".delete-btn", function () {
        if (!confirm("Delete this airline?")) return;
        let id = $(this).data("id");
        $.post("../controllers/airlineoperations.php", {
            deleteairline: true,
            airlineid: id
        }, function (res) {
            if (res.status === "success") {
                loadAirlines();
            } else {
                alert(res.message);
            }
        }, "json");
    });
});
