<?php
require_once(__DIR__ . "/../models/airlines.php");

header('Content-Type: application/json');

$airline = new airline();

// Merge GET and POST into one array
$data = array_merge($_GET, $_POST);

// ✅ Save / Update airline
if (isset($data['saveairline'])) {
    $id        = $data['airlineid']    ?? 0;
    $name      = $data['airlinename']  ?? '';
    $iatacode  = $data['iatacode']     ?? '';
    $logo      = $data['airlinelogo']  ?? '';
    $countryid = $data['countryid']    ?? 0;
    $email     = $data['email']        ?? '';
    $website   = $data['website']      ?? '';

    $response = $airline->saveairline($id, $name, $iatacode, $logo, $countryid, $email, $website);
    echo json_encode($response);
    exit;
}

// ✅ Get all airlines
if (isset($data['getairlines'])) {
    $result = $airline->getairlines();
    echo json_encode([
        "status" => "success",
        "data"   => json_decode($result, true)
    ]);
    exit;
}

// ✅ Get single airline details
if (isset($data['getairlinedetails'])) {
    $id     = $data['airlineid'] ?? 0;
    $result = $airline->getairlinedetails($id);
    echo json_encode([
        "status" => "success",
        "data"   => json_decode($result, true)
    ]);
    exit;
}

// ✅ Delete airline
if (isset($data['deleteairline'])) {
    $id       = $data['airlineid'] ?? 0;
    $response = $airline->deleteairline($id);
    echo json_encode($response);
    exit;
}

// ✅ Filter airlines
if (isset($data['filterairlines'])) {
    $airlinename = $data['airlinename'] ?? '';
    $countryname = $data['countryname'] ?? '';
    $result      = $airline->filterairlines($airlinename, $countryname);
    echo json_encode([
        "status" => "success",
        "data"   => json_decode($result, true)
    ]);
    exit;
}

// ✅ Default: invalid request
echo json_encode([
    "status"  => "error",
    "message" => "Invalid request"
]);
