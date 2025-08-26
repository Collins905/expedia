<?php
require_once("db.php");

class city {
    private $db;
    public function __construct() { $this->db = new db(); }

    public function savecity($id, $name, $countryid) {
        return $this->db->execute("CALL sp_savecity(?, ?, ?)", [$id, $name, $countryid]);
    }

    public function getcities() {
        return $this->db->getJSON("CALL sp_getcities()");
    }

    public function getcitydetails($id) {
        return $this->db->getJSON("CALL sp_getcitydetails(?)", [$id]);
    }

    public function deletecity($id) {
        return $this->db->execute("CALL sp_deletecity(?)", [$id]);
    }
}
?>
