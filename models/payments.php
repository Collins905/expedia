<?php
require_once("db.php");

class payment {
    private $db;
    public function __construct() { $this->db = new db(); }

    public function savepayment($id, $name) {
        return $this->db->execute("CALL sp_savepaymentmethod(?, ?)", [$id, $name]);
    }

    public function getpayments() {
        return $this->db->getJSON("CALL sp_getpaymentmethods()");
    }

    public function deletepayment($id) {
        return $this->db->execute("CALL sp_deletepaymentmethod(?)", [$id]);
    }
}
?>
