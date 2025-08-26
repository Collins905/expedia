<?php
require_once("../models/airports.php");
header("Content-Type: application/json");

$airport = new airport();

if (isset($_POST['saveairport'])) {
    echo json_encode(["success" => $airport->saveairport($_POST['airportid'] ?? 0, $_POST['airportcode'] ?? "", $_POST['airportname'] ?? "", $_POST['cityid'] ?? 0)]);
    exit;
}
if (isset($_GET['getairports'])) { echo $airport->getairports(); exit; }
if (isset($_GET['getairportdetails'])) { echo $airport->getairportdetails($_GET['airportid'] ?? 0); exit; }
if (isset($_POST['deleteairport'])) { echo json_encode(["success" => $airport->deleteairport($_POST['airportid'] ?? 0)]); exit; }

echo json_encode(["error" => "Invalid request"]);
?>
