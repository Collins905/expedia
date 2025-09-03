<?php
header('Content-Type: application/json'); 
error_reporting(E_ALL); 
ini_set('display_errors', 1);

// Database connection
$servername = "localhost";
$username   = "root";
$password   = "";
$dbname     = "expediaflightbooking";

$conn = new mysqli($servername, $username, $password, $dbname);
if ($conn->connect_error) {
    echo json_encode(['status' => 'error', 'message' => 'Database connection failed: ' . $conn->connect_error]);
    exit;
}

// ----------------- SAVE COUNTRY -----------------
if (isset($_POST['savecountry'])) {
    $countryId   = intval($_POST['countryid']);
    $countryName = trim($_POST['countryname']);

    if ($countryName === '') {
        echo json_encode(['status' => 'error', 'message' => 'Country name is required']);
        exit;
    }

    // Check if country already exists (ignore case, ignore same id if updating)
    $stmt = $conn->prepare("SELECT countryid FROM countries WHERE LOWER(countryname) = LOWER(?) AND countryid != ?");
    $stmt->bind_param("si", $countryName, $countryId);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        echo json_encode(['status' => 'error', 'message' => 'Country already exists']);
        $stmt->close();
        $conn->close();
        exit;
    }
    $stmt->close();

    if ($countryId == 0) {
        // Insert new
        $stmt = $conn->prepare("INSERT INTO countries (countryname) VALUES (?)");
        $stmt->bind_param("s", $countryName);
    } else {
        // Update existing
        $stmt = $conn->prepare("UPDATE countries SET countryname = ? WHERE countryid = ?");
        $stmt->bind_param("si", $countryName, $countryId);
    }

    if ($stmt->execute()) {
        echo json_encode(['status' => 'success', 'message' => 'Country saved successfully']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Failed to save: ' . $stmt->error]);
    }
    $stmt->close();
    $conn->close();
    exit;
}


// ----------------- DELETE COUNTRY -----------------
if (isset($_POST['deletecountry'])) {
    $id = intval($_POST['countryid']);
    $stmt = $conn->prepare("DELETE FROM countries WHERE countryid = ?");
    $stmt->bind_param("i", $id);

    if ($stmt->execute()) {
        echo json_encode(['status' => 'success', 'message' => 'Country deleted successfully']);
    } else {
        echo json_encode(['status' => 'error', 'message' => 'Failed to delete: ' . $stmt->error]);
    }
    $stmt->close();
    $conn->close();
    exit;
}

if (isset($_GET['getcountries'])) {
    $sql = "
        SELECT c.countryid, 
               c.countryname,
               COUNT(DISTINCT ci.cityid) AS cities,
               COUNT(DISTINCT a.airportid) AS airports,
               COUNT(DISTINCT al.airlineid) AS airlines
        FROM countries c
        LEFT JOIN cities ci ON c.countryid = ci.countryid
        LEFT JOIN airports a ON ci.cityid = a.cityid
        LEFT JOIN airlines al ON c.countryid = al.homecountryid
        GROUP BY c.countryid, c.countryname
        ORDER BY c.countryname ASC
    ";

    $result = $conn->query($sql);
    if (!$result) {
        echo json_encode(['status' => 'error', 'message' => 'Query failed: ' . $conn->error]);
        $conn->close();
        exit;
    }

    $data = [];
    while ($row = $result->fetch_assoc()) {
        $data[] = $row;
    }

    echo json_encode(['status' => 'success', 'data' => $data]);
    $conn->close();
    exit;
}


// ----------------- GET SINGLE COUNTRY -----------------
if (isset($_GET['getcountrydetails']) && isset($_GET['countryid'])) {
    $id = intval($_GET['countryid']);
    $stmt = $conn->prepare("SELECT countryid, countryname FROM countries WHERE countryid = ?");
    $stmt->bind_param("i", $id);
    $stmt->execute();
    $result = $stmt->get_result();
    $data = $result->fetch_all(MYSQLI_ASSOC);

    echo json_encode(['status' => 'success', 'data' => $data]);
    $stmt->close();
    $conn->close();
    exit;
}

// ----------------- INVALID REQUEST -----------------
echo json_encode(['status' => 'error', 'message' => 'Invalid request']);
$conn->close();
exit;
?>
