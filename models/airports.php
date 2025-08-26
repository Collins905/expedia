<?php
require_once("db.php");

class airport {
    private $db;
    public function __construct() { $this->db = new db(); }

    public function saveairport($id, $code, $name, $cityid) {
        return $this->db->execute("CALL sp_saveairport(?, ?, ?, ?)", [$id, $code, $name, $cityid]);
    }

    public function getairports() {
        return $this->db->getJSON("CALL sp_getairports()");
    }

    public function getairportdetails($id) {
        return $this->db->getJSON("CALL sp_getairportdetails(?)", [$id]);
    }

    public function deleteairport($id) {
        return $this->db->execute("CALL sp_deleteairport(?)", [$id]);
    }
}
?>
