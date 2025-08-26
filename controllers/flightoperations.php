<?php
require_once("../models/flights.php");
header("Content-Type: application/json");

$flight = new flight();

if (isset($_POST['saveflight'])) {
    echo json_encode(["success" => $flight->saveflight(
        $_POST['flightid'] ?? 0,
        $_POST['airlineid'] ?? 0,
        $_POST['flightno'] ?? "",
        $_POST['departure'] ?? "",
        $_POST['arrival'] ?? ""
    )]);
    exit;
}
if (isset($_GET['getflights'])) { echo $flight->getflights(); exit; }
if (isset($_GET['getflightdetails'])) { echo $flight->getflightdetails($_GET['flightid'] ?? 0); exit; }
if (isset($_POST['deleteflight'])) { echo json_encode(["success" => $flight->deleteflight($_POST['flightid'] ?? 0)]); exit; }

echo json_encode(["error" => "Invalid request"]);
?>
