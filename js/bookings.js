$(document).ready(function () {
    loadBookings();

    function loadBookings() {
        $.get("../controllers/bookingoperations.php?getbookings=true", function (data) {
            let rows = "";
            $.each(data.data, function (i, b) {
                rows += `<tr>
                    <td>${i + 1}</td>
                    <td>${b.passengername}</td>
                    <td>${b.flightnumber}</td>
                    <td>${b.bookingdate}</td>
                    <td>${b.status}</td>
                    <td>
                        <button class="btn btn-sm btn-primary editbooking" data-id="${b.bookingid}"><i class="fa fa-edit"></i></button>
                        <button class="btn btn-sm btn-danger deletebooking" data-id="${b.bookingid}"><i class="fa fa-trash"></i></button>
                    </td>
                </tr>`;
            });
            $("#bookinglist").html(rows);
        }, "json");
    }

    $("#addnewbooking").click(function () {
        $("#bookingid").val(0);
        $("#bookingdetailsmodal").modal("show");
    });

    $("#savebooking").click(function () {
        $.post("../controllers/bookingoperations.php", {
            savebooking: true,
            bookingid: $("#bookingid").val(),
            passengerid: $("#passengerid").val(),
            flightid: $("#flightid").val(),
            bookingdate: $("#bookingdate").val(),
            status: $("#status").val()
        }, function (response) {
            alert(response.message);
            $("#bookingdetailsmodal").modal("hide");
            loadBookings();
        }, "json");
    });

    $(document).on("click", ".editbooking", function () {
        let id = $(this).data("id");
        $.get("../controllers/bookingoperations.php?getbookingdetails=true&bookingid=" + id, function (data) {
            let b = data.data[0];
            $("#bookingid").val(b.bookingid);
            $("#passengerid").val(b.passengerid);
            $("#flightid").val(b.flightid);
            $("#bookingdate").val(b.bookingdate);
            $("#status").val(b.status);
            $("#bookingdetailsmodal").modal("show");
        }, "json");
    });

    $(document).on("click", ".deletebooking", function () {
        if (confirm("Delete this booking?")) {
            let id = $(this).data("id");
            $.post("../controllers/bookingoperations.php", { deletebooking: true, bookingid: id }, function (response) {
                alert(response.message);
                loadBookings();
            }, "json");
        }
    });
});
