<?php
require_once("../models/countries.php");

header('Content-Type: application/json'); // Always return JSON

$country = new country();

// ✅ Save or update country
if (isset($_POST['savecountry'])) {
    $countryid   = $_POST['countryid'];
    $countryname = $_POST['countryname'];
    $response = $country->savecountry($countryid, $countryname);
    echo json_encode($response);
    exit;
}

// ✅ Get all countries
if (isset($_GET['getcountries'])) {
    echo $country->getcountries();
    exit;
}

// ✅ Get single country details
if (isset($_GET['getcountrydetails'])) {
    $countryid = $_GET['countryid'];
    echo $country->getcountrydetails($countryid);
    exit;
}

if (
    (isset($_POST['deletecountry']) && $_POST['deletecountry'] == "true") ||
    (isset($_GET['deletecountry']) && $_GET['deletecountry'] == "true")
) {
    $countryid = $_POST['countryid'] ?? $_GET['countryid']; // support both POST & GET
    $response  = $country->deletecountry($countryid);

    echo json_encode($response);
    exit;
}

// ✅ Default response if nothing matched
echo json_encode([
    "success" => false,
    "message" => "Invalid request"
]);
?>
