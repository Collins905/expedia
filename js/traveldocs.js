$(document).ready(function () {
    loadTravelDocs();

    function loadTravelDocs() {
        $.get("../controllers/traveldocoperations.php?gettraveldocs=true", function (data) {
            let rows = "";
            $.each(data.data, function (i, t) {
                rows += `<tr>
                    <td>${i + 1}</td>
                    <td>${t.doctype}</td>
                    <td>${t.docnumber}</td>
                    <td>${t.expirydate}</td>
                    <td>${t.passengername}</td>
                    <td>
                        <button class="btn btn-sm btn-primary edittraveldoc" data-id="${t.docid}"><i class="fa fa-edit"></i></button>
                        <button class="btn btn-sm btn-danger deletetraveldoc" data-id="${t.docid}"><i class="fa fa-trash"></i></button>
                    </td>
                </tr>`;
            });
            $("#traveldoclist").html(rows);
        }, "json");
    }

    $("#addnewtraveldoc").click(function () {
        $("#docid").val(0);
        $("#traveldocdetailsmodal").modal("show");
    });

    $("#savetraveldoc").click(function () {
        $.post("../controllers/traveldocoperations.php", {
            savetraveldoc: true,
            docid: $("#docid").val(),
            passengerid: $("#passengerid").val(),
            doctype: $("#doctype").val(),
            docnumber: $("#docnumber").val(),
            expirydate: $("#expirydate").val()
        }, function (response) {
            alert(response.message);
            $("#traveldocdetailsmodal").modal("hide");
            loadTravelDocs();
        }, "json");
    });

    $(document).on("click", ".edittraveldoc", function () {
        let id = $(this).data("id");
        $.get("../controllers/traveldocoperations.php?gettraveldocdetails=true&docid=" + id, function (data) {
            let t = data.data[0];
            $("#docid").val(t.docid);
            $("#passengerid").val(t.passengerid);
            $("#doctype").val(t.doctype);
            $("#docnumber").val(t.docnumber);
            $("#expirydate").val(t.expirydate);
            $("#traveldocdetailsmodal").modal("show");
        }, "json");
    });

    $(document).on("click", ".deletetraveldoc", function () {
        if (confirm("Delete this travel document?")) {
            let id = $(this).data("id");
            $.post("../controllers/traveldocoperations.php", { deletetraveldoc: true, docid: id }, function (response) {
                alert(response.message);
                loadTravelDocs();
            }, "json");
        }
    });
});
