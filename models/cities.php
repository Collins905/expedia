<?php
class City {
    private $db;

    public function __construct($db) {
        $this->db = $db; // pass db instance
    }

    // ✅ Fetch cities
    public function getCities($countryid = null, $cityname = null) {
        $sql = "SELECT c.cityid, c.cityname, co.countryname,
                       (SELECT COUNT(*) FROM airports a WHERE a.cityid = c.cityid) AS airports,
                       (SELECT COUNT(*) FROM airlines al WHERE al.homecountryid = co.countryid) AS airlines
                FROM cities c
                INNER JOIN countries co ON co.countryid = c.countryid
                WHERE 1=1";

        $params = [];

        if ($countryid) {
            $sql .= " AND c.countryid = ?";
            $params[] = $countryid;
        }
        if ($cityname) {
            $sql .= " AND c.cityname LIKE ?";
            $params[] = "%$cityname%";
        }

        $sql .= " ORDER BY co.countryname, c.cityname";

        return $this->db->getJSON($sql, $params);
    }

    // ✅ Get single city details
    public function getCityDetails($cityid) {
        $sql = "SELECT cityid, cityname, countryid 
                FROM cities 
                WHERE cityid = ?";
        return $this->db->getJSON($sql, [$cityid]);
    }

    // ✅ Save city
    public function saveCity($cityid, $cityname, $countryid) {
        // check if exists
        $check = $this->db->getData(
            "SELECT * FROM cities WHERE cityname = ? AND countryid = ? AND cityid != ?",
            [$cityname, $countryid, $cityid]
        );
        if ($check->rowCount() > 0) {
            return json_encode(["status" => "exists"]);
        }

        if ($cityid == 0) {
            // insert new
            $this->db->execute(
                "INSERT INTO cities (cityname, countryid) VALUES (?, ?)",
                [$cityname, $countryid]
            );
        } else {
            // update existing
            $this->db->execute(
                "UPDATE cities SET cityname = ?, countryid = ? WHERE cityid = ?",
                [$cityname, $countryid, $cityid]
            );
        }

        return json_encode(["status" => "success"]);
    }

    // ✅ Delete city
    public function deleteCity($cityid) {
        $this->db->execute("DELETE FROM cities WHERE cityid = ?", [$cityid]);
        return json_encode(["status" => "success"]);
    }
}
?>
