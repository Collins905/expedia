<?php
require_once("../models/cities.php");
header("Content-Type: application/json");

$city = new city();

if (isset($_POST['savecity'])) {
    echo json_encode(["success" => $city->savecity($_POST['cityid'] ?? 0, $_POST['cityname'] ?? "", $_POST['countryid'] ?? 0)]);
    exit;
}
if (isset($_GET['getcities'])) { echo $city->getcities(); exit; }
if (isset($_GET['getcitydetails'])) { echo $city->getcitydetails($_GET['cityid'] ?? 0); exit; }
if (isset($_POST['deletecity'])) { echo json_encode(["success" => $city->deletecity($_POST['cityid'] ?? 0)]); exit; }

echo json_encode(["error" => "Invalid request"]);
?>
