$(document).ready(function () {
    loadFlights();

    function loadFlights() {
        $.get("../controllers/flightoperations.php?getflights=true", function (data) {
            let rows = "";
            $.each(data.data, function (i, f) {
                rows += `<tr>
                    <td>${i + 1}</td>
                    <td>${f.flightnumber}</td>
                    <td>${f.airlinename}</td>
                    <td>${f.fromairport}</td>
                    <td>${f.toairport}</td>
                    <td>${f.departuretime}</td>
                    <td>${f.arrivaltime}</td>
                    <td>
                        <button class="btn btn-sm btn-primary editflight" data-id="${f.flightid}"><i class="fa fa-edit"></i></button>
                        <button class="btn btn-sm btn-danger deleteflight" data-id="${f.flightid}"><i class="fa fa-trash"></i></button>
                    </td>
                </tr>`;
            });
            $("#flightlist").html(rows);
        }, "json");
    }

    $("#addnewflight").click(function () {
        $("#flightid").val(0);
        $("#flightdetailsmodal").modal("show");
    });

    $("#saveflight").click(function () {
        $.post("../controllers/flightoperations.php", {
            saveflight: true,
            flightid: $("#flightid").val(),
            flightnumber: $("#flightnumber").val(),
            airlineid: $("#airlineid").val(),
            fromairportid: $("#fromairportid").val(),
            toairportid: $("#toairportid").val(),
            departuretime: $("#departuretime").val(),
            arrivaltime: $("#arrivaltime").val()
        }, function (response) {
            alert(response.message);
            $("#flightdetailsmodal").modal("hide");
            loadFlights();
        }, "json");
    });

    $(document).on("click", ".editflight", function () {
        let id = $(this).data("id");
        $.get("../controllers/flightoperations.php?getflightdetails=true&flightid=" + id, function (data) {
            let f = data.data[0];
            $("#flightid").val(f.flightid);
            $("#flightnumber").val(f.flightnumber);
            $("#airlineid").val(f.airlineid);
            $("#fromairportid").val(f.fromairportid);
            $("#toairportid").val(f.toairportid);
            $("#departuretime").val(f.departuretime);
            $("#arrivaltime").val(f.arrivaltime);
            $("#flightdetailsmodal").modal("show");
        }, "json");
    });

    $(document).on("click", ".deleteflight", function () {
        if (confirm("Delete this flight?")) {
            let id = $(this).data("id");
            $.post("../controllers/flightoperations.php", { deleteflight: true, flightid: id }, function (response) {
                alert(response.message);
                loadFlights();
            }, "json");
        }
    });
});
