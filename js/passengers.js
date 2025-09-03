$(document).ready(function () {
    loadPassengers();

    function loadPassengers() {
        $.get("../controllers/passengeroperations.php?getpassengers=true", function (data) {
            let rows = "";
            $.each(data.data, function (i, p) {
                rows += `<tr>
                    <td>${i + 1}</td>
                    <td>${p.firstname} ${p.lastname}</td>
                    <td>${p.gender}</td>
                    <td>${p.email}</td>
                    <td>${p.phone}</td>
                    <td>
                        <button class="btn btn-sm btn-primary editpassenger" data-id="${p.passengerid}"><i class="fa fa-edit"></i></button>
                        <button class="btn btn-sm btn-danger deletepassenger" data-id="${p.passengerid}"><i class="fa fa-trash"></i></button>
                    </td>
                </tr>`;
            });
            $("#passengerlist").html(rows);
        }, "json");
    }

    $("#addnewpassenger").click(function () {
        $("#passengerid").val(0);
        $("#passengerdetailsmodal").modal("show");
    });

    $("#savepassenger").click(function () {
        $.post("../controllers/passengeroperations.php", {
            savepassenger: true,
            passengerid: $("#passengerid").val(),
            firstname: $("#firstname").val(),
            lastname: $("#lastname").val(),
            gender: $("#gender").val(),
            email: $("#email").val(),
            phone: $("#phone").val()
        }, function (response) {
            alert(response.message);
            $("#passengerdetailsmodal").modal("hide");
            loadPassengers();
        }, "json");
    });

    $(document).on("click", ".editpassenger", function () {
        let id = $(this).data("id");
        $.get("../controllers/passengeroperations.php?getpassengerdetails=true&passengerid=" + id, function (data) {
            let p = data.data[0];
            $("#passengerid").val(p.passengerid);
            $("#firstname").val(p.firstname);
            $("#lastname").val(p.lastname);
            $("#gender").val(p.gender);
            $("#email").val(p.email);
            $("#phone").val(p.phone);
            $("#passengerdetailsmodal").modal("show");
        }, "json");
    });

    $(document).on("click", ".deletepassenger", function () {
        if (confirm("Delete this passenger?")) {
            let id = $(this).data("id");
            $.post("../controllers/passengeroperations.php", { deletepassenger: true, passengerid: id }, function (response) {
                alert(response.message);
                loadPassengers();
            }, "json");
        }
    });
});
