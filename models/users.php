<?php
require_once("db.php");

class user extends db {
    function checkuser($userid, $username) {
        $sql = "CALL `sp_checkusername`($userid, '$username')";
        return $this->getData($sql)->rowCount();
    }

    function saveuser($userid, $username, $firstname, $lastname, $userpassword, $salt, $mobile, $email, $systemadmin, $addedby) {
        // Check if the user exists
        if ($this->checkuser($userid, $username)) {
            return ["status" => "exists", "message" => "user_exists"];
        } else {
            $sql = "CALL `sp_saveuser`($userid, '$username', '$firstname', '$lastname', '$userpassword', '$salt', '$mobile', '$email', $systemadmin, $addedby)";
            $this->getData($sql);
            return ["status" => "success", "message" => "user was saved successfully"];
        }
    }

    function getusers() {
        $sql = "CALL `sp_getallusers`()";
        return $this->getJSON($sql);
    }

    function getuserdetails($userid) {
        $sql = "CALL `sp_getuserdetails`($userid)";
        return $this->getJSON($sql);
    }

    function activateUser($userid) {
        $sql = "UPDATE users SET accountactive = 1, reasoninactive = NULL, deactivateddate = NULL, deactivatedby = NULL WHERE userid = $userid";
        $this->getData($sql);
        return ["status" => "success", "message" => "user activated successfully"];
    }

    function deactivateUser($userid, $reason, $deactivatedby) {
        $sql = "UPDATE users SET accountactive = 0, reasoninactive = '$reason', deactivateddate = NOW(), deactivatedby = $deactivatedby WHERE userid = $userid";
        $this->getData($sql);
        return ["status" => "success", "message" => "user deactivated successfully"];
    }

    function updateUser($userid, $username, $firstname, $lastname, $mobile, $email, $systemadmin) {
        // Check if username exists for other users
        if ($this->checkuser($userid, $username)) {
            return ["status" => "exists", "message" => "username_exists"];
        } else {
            $sql = "UPDATE users SET username = '$username', firstname = '$firstname', lastname = '$lastname', mobile = '$mobile', email = '$email', systemadmin = $systemadmin WHERE userid = $userid";
            $this->getData($sql);
            return ["status" => "success", "message" => "user updated successfully"];
        }
    }
}
?>