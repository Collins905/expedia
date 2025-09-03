$(document).ready(function () {
    loadPayments();

    function loadPayments() {
        $.get("../controllers/paymentoperations.php?getpayments=true", function (data) {
            let rows = "";
            $.each(data.data, function (i, p) {
                rows += `<tr>
                    <td>${i + 1}</td>
                    <td>${p.paymentmethod}</td>
                    <td>${p.amount}</td>
                    <td>${p.paymentdate}</td>
                    <td>${p.bookingid}</td>
                    <td>
                        <button class="btn btn-sm btn-primary editpayment" data-id="${p.paymentid}"><i class="fa fa-edit"></i></button>
                        <button class="btn btn-sm btn-danger deletepayment" data-id="${p.paymentid}"><i class="fa fa-trash"></i></button>
                    </td>
                </tr>`;
            });
            $("#paymentlist").html(rows);
        }, "json");
    }

    $("#addnewpayment").click(function () {
        $("#paymentid").val(0);
        $("#paymentdetailsmodal").modal("show");
    });

    $("#savepayment").click(function () {
        $.post("../controllers/paymentoperations.php", {
            savepayment: true,
            paymentid: $("#paymentid").val(),
            bookingid: $("#bookingid").val(),
            paymentmethod: $("#paymentmethod").val(),
            amount: $("#amount").val(),
            paymentdate: $("#paymentdate").val()
        }, function (response) {
            alert(response.message);
            $("#paymentdetailsmodal").modal("hide");
            loadPayments();
        }, "json");
    });

    $(document).on("click", ".editpayment", function () {
        let id = $(this).data("id");
        $.get("../controllers/paymentoperations.php?getpaymentdetails=true&paymentid=" + id, function (data) {
            let p = data.data[0];
            $("#paymentid").val(p.paymentid);
            $("#bookingid").val(p.bookingid);
            $("#paymentmethod").val(p.paymentmethod);
            $("#amount").val(p.amount);
            $("#paymentdate").val(p.paymentdate);
            $("#paymentdetailsmodal").modal("show");
        }, "json");
    });

    $(document).on("click", ".deletepayment", function () {
        if (confirm("Delete this payment?")) {
            let id = $(this).data("id");
            $.post("../controllers/paymentoperations.php", { deletepayment: true, paymentid: id }, function (response) {
                alert(response.message);
                loadPayments();
            }, "json");
        }
    });
});
