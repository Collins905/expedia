<?php
require_once("../models/passengers.php");
header("Content-Type: application/json");

$passenger = new passenger();

if (isset($_POST['savepassengerbooking'])) {
    echo json_encode(["success" => $passenger->savepassengerbooking(
        $_POST['passengerid'] ?? 0,
        $_POST['bookingclassid'] ?? 0,
        $_POST['name'] ?? ""
    )]);
    exit;
}
if (isset($_GET['getpassengerbookings'])) { echo $passenger->getpassengerbookings($_GET['bookingclassid'] ?? 0); exit; }

echo json_encode(["error" => "Invalid request"]);
?>
