<?php
include 'db.php';
$db = new db();

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    echo $db->getJSON("CALL sp_FlightBooking_Get()");
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    $db->execute("CALL sp_FlightBooking_Add(:flightid, :bookingdate, :paymentmethod, :bookingtype)", [
        ':flightid' => $data['flightid'],
        ':bookingdate' => $data['bookingdate'],
        ':paymentmethod' => $data['paymentmethod'],
        ':bookingtype' => $data['bookingtype']
    ]);
    echo json_encode(["status" => "success"]);
}
?>
<?php
require_once("db.php");

class booking {
    private $db;
    public function __construct() { $this->db = new db(); }

    public function savebooking($id, $flightid, $bookingdate, $paymentid) {
        return $this->db->execute("CALL sp_savebooking(?, ?, ?, ?)", [$id, $flightid, $bookingdate, $paymentid]);
    }

    public function getbookings() {
        return $this->db->getJSON("CALL sp_getbookings()");
    }

    public function getbookingdetails($id) {
        return $this->db->getJSON("CALL sp_getbookingdetails(?)", [$id]);
    }

    public function deletebooking($id) {
        return $this->db->execute("CALL sp_deletebooking(?)", [$id]);
    }
}
?>
