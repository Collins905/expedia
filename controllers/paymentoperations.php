<?php
require_once("../models/payments.php");
header("Content-Type: application/json");

$payment = new payment();

if (isset($_POST['savepayment'])) {
    echo json_encode(["success" => $payment->savepayment($_POST['paymentid'] ?? 0, $_POST['paymentname'] ?? "")]);
    exit;
}
if (isset($_GET['getpayments'])) { echo $payment->getpayments(); exit; }
if (isset($_POST['deletepayment'])) { echo json_encode(["success" => $payment->deletepayment($_POST['paymentid'] ?? 0)]); exit; }

echo json_encode(["error" => "Invalid request"]);
?>
