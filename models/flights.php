<?php
include 'db.php';
$db = new db();

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    echo $db->getJSON("CALL sp_Flight_Get()");
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    $db->execute("CALL sp_Flight_Add(:airlineid, :flightno, :dep, :dest, :deptime, :duration, :airportid)", [
        ':airlineid' => $data['airlineid'],
        ':flightno' => $data['flightno'],
        ':dep' => $data['departurecity'],
        ':dest' => $data['destinationcity'],
        ':deptime' => $data['departuretime'],
        ':duration' => $data['duration'],
        ':airportid' => $data['departureairportid']
    ]);
    echo json_encode(["status" => "success"]);
}
?>
<?php
require_once("db.php");

class flight {
    private $db;
    public function __construct() { $this->db = new db(); }

    public function saveflight($id, $airlineid, $flightno, $departure, $arrival) {
        return $this->db->execute("CALL sp_saveflight(?, ?, ?, ?, ?)", [$id, $airlineid, $flightno, $departure, $arrival]);
    }

    public function getflights() {
        return $this->db->getJSON("CALL sp_getflights()");
    }

    public function getflightdetails($id) {
        return $this->db->getJSON("CALL sp_getflightdetails(?)", [$id]);
    }

    public function deleteflight($id) {
        return $this->db->execute("CALL sp_deleteflight(?)", [$id]);
    }
}
?>
