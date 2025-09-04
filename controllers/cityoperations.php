<?php
require_once("../models/db.php");
require_once("../models/cities.php");

// ✅ Create DB connection
$db = new db();
$conn = $db;

// ✅ Create City instance
$city = new City($conn);

// --- Get cities ---
if (isset($_GET['getcities'])) {
    $countryid = !empty($_GET['countryid']) ? intval($_GET['countryid']) : null;
    $cityname  = !empty($_GET['cityname']) ? trim($_GET['cityname']) : null;

    echo $city->getCities($countryid, $cityname);
    exit;
}

// --- Get single city details ---
if (isset($_GET['getcitydetails'])) {
    $cityid = intval($_GET['cityid']);
    echo $city->getCityDetails($cityid);
    exit;
}

// --- Save city (add/update) ---
if (isset($_POST['savecity'])) {
    $cityid    = intval($_POST['cityid']);
    $cityname  = trim($_POST['cityname']);
    $countryid = intval($_POST['countryid']);

    echo $city->saveCity($cityid, $cityname, $countryid);
    exit;
}

// --- Delete city ---
if (isset($_POST['deletecity'])) {
    $cityid = intval($_POST['cityid']);
    echo $city->deleteCity($cityid);
    exit;
}

// --- Default fallback ---
echo json_encode(["status" => "error", "message" => "Invalid request"]);
exit;
?>
