$(document).ready(function () {
    loadCities();

    function loadCities() {
        $.get("../controllers/cityoperations.php?getcities=true", function (data) {
            let rows = "";
            $.each(data.data, function (i, city) {
                rows += `<tr>
                    <td>${i + 1}</td>
                    <td>${city.cityname}</td>
                    <td>${city.countryname}</td>
                    <td>${city.airports || ""}</td>
                    <td>
                        <button class="btn btn-sm btn-primary editcity" data-id="${city.cityid}"><i class="fa fa-edit"></i></button>
                        <button class="btn btn-sm btn-danger deletecity" data-id="${city.cityid}"><i class="fa fa-trash"></i></button>
                    </td>
                </tr>`;
            });
            $("#citylist").html(rows);
        }, "json");
    }

    $("#addnewcity").click(function () {
        $("#cityid").val(0);
        $("#cityname").val("");
        $("#countryid").val("");
        $("#citydetailsmodal").modal("show");
    });

    $("#savecity").click(function () {
        $.post("../controllers/cityoperations.php", {
            savecity: true,
            cityid: $("#cityid").val(),
            cityname: $("#cityname").val(),
            countryid: $("#countryid").val()
        }, function (response) {
            alert(response.message);
            $("#citydetailsmodal").modal("hide");
            loadCities();
        }, "json");
    });

    $(document).on("click", ".editcity", function () {
        let id = $(this).data("id");
        $.get("../controllers/cityoperations.php?getcitydetails=true&cityid=" + id, function (data) {
            let city = data.data[0];
            $("#cityid").val(city.cityid);
            $("#cityname").val(city.cityname);
            $("#countryid").val(city.countryid);
            $("#citydetailsmodal").modal("show");
        }, "json");
    });

    $(document).on("click", ".deletecity", function () {
        if (confirm("Delete this city?")) {
            let id = $(this).data("id");
            $.post("../controllers/cityoperations.php", { deletecity: true, cityid: id }, function (response) {
                alert(response.message);
                loadCities();
            }, "json");
        }
    });
});
