<?php
require_once("db.php");

class passenger {
    private $db;
    public function __construct() { $this->db = new db(); }

    public function savepassengerbooking($id, $bookingclassid, $name) {
        return $this->db->execute("CALL sp_savepassengerbooking(?, ?, ?)", [$id, $bookingclassid, $name]);
    }

    public function getpassengerbookings($bookingclassid) {
        return $this->db->getJSON("CALL sp_getpassengerbookings(?)", [$bookingclassid]);
    }
}
?>
