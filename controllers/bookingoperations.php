<?php
require_once("../models/bookings.php");
header("Content-Type: application/json");

$booking = new booking();

if (isset($_POST['savebooking'])) {
    echo json_encode(["success" => $booking->savebooking(
        $_POST['bookingid'] ?? 0,
        $_POST['flightid'] ?? 0,
        $_POST['bookingdate'] ?? "",
        $_POST['paymentid'] ?? 0
    )]);
    exit;
}
if (isset($_GET['getbookings'])) { echo $booking->getbookings(); exit; }
if (isset($_GET['getbookingdetails'])) { echo $booking->getbookingdetails($_GET['bookingid'] ?? 0); exit; }
if (isset($_POST['deletebooking'])) { echo json_encode(["success" => $booking->deletebooking($_POST['bookingid'] ?? 0)]); exit; }

echo json_encode(["error" => "Invalid request"]);
?>
