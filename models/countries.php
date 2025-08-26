<?php
require_once("db.php");

class country extends db
{
    function checkcountry($countryid, $countryname) {
        $sql = "CALL sp_checkcountry(:id, :name)";
        $this->getData($sql, [
            ':id'   => $countryid,
            ':name' => $countryname
        ]);
    }

    function savecountry($countryid, $countryname) {
        $sql = "CALL sp_savecountry(:id, :name)";
        $this->execute($sql, [
            ':id'   => $countryid,
            ':name' => $countryname
        ]);
        return ['status' => 'success', 'message' => 'Country saved successfully'];
    }

    function getcountries() {
        $sql = "CALL sp_getcountries()";
        return $this->getJSON($sql);
    }

    function getcountrydetails($countryid) {
        $sql = "CALL sp_getcountrydetails(:id)";
        return $this->getJSON($sql, [':id' => $countryid]);
    }

    function deletecountry($countryid) {
        $sql = "CALL sp_deletecountry(:id)";
        $this->execute($sql, [':id' => $countryid]);
        return ['status' => 'success', 'message' => 'The country was deleted successfully'];
    }
}
?>
