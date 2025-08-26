<?php
require_once("db.php");

class airline {
    private $db;

    public function __construct() {
        $this->db = new db();
    }

    // ✅ Save or update airline
    public function saveairline($id, $name, $iatacode, $logo, $countryid, $email, $website) {
        $result = $this->db->execute(
            "CALL sp_saveairline(:id, :name, :iatacode, :logo, :countryid, :email, :website)",
            [
                ':id'        => $id,
                ':name'      => $name,
                ':iatacode'  => $iatacode,
                ':logo'      => $logo,
                ':countryid' => $countryid,
                ':email'     => $email,
                ':website'   => $website
            ]
        );

        return [
            "status"  => "success",
            "message" => $id == 0 ? "Airline created successfully" : "Airline updated successfully",
            "result"  => $result
        ];
    }

    // ✅ Get all airlines
    public function getairlines() {
        return $this->db->getJSON("CALL sp_getairlines()");
    }

    // ✅ Get details of a single airline
    public function getairlinedetails($id) {
        return $this->db->getJSON(
            "CALL sp_getairlinedetails(:id)",
            [':id' => $id]
        );
    }

    // ✅ Delete airline
    public function deleteairline($id) {
        $result = $this->db->execute(
            "CALL sp_deleteairline(:id)",
            [':id' => $id]
        );

        return [
            "status"  => "success",
            "message" => "Airline deleted successfully",
            "result"  => $result
        ];
    }

    // ✅ Optional: Filter airlines (by name or country)
    public function filterairlines($airlinename, $countryname) {
        return $this->db->getJSON(
            "CALL sp_filterairlines(:airlinename, :countryname)",
            [
                ':airlinename' => $airlinename,
                ':countryname' => $countryname
            ]
        );
    }
}
?>
