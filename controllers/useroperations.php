<?php
// Fix the require path - adjust according to your directory structure
require_once(__DIR__ . '/../models/users.php');
$user = new user();

if (isset($_POST['saveuser'])) {
    $userid = $_POST['userid'];
    $username = $_POST['username'];
    $firstname = $_POST['firstname'];
    $lastname = $_POST['lastname'];
    $password = $_POST['password'];
    
    // generate salt
    $salt = generateRandomString(20);
    // hash the password with salt
    $userpassword = hash('SHA256', $password . $salt);
    
    $mobile = isset($_POST['mobile']) ? $_POST['mobile'] : '';
    $email = isset($_POST['email']) ? $_POST['email'] : '';
    $systemadmin = isset($_POST['systemadmin']) ? $_POST['systemadmin'] : 0;
    $addedby = isset($_POST['addedby']) ? $_POST['addedby'] : 0;
    
    $response = $user->saveuser($userid, $username, $firstname, $lastname, $userpassword, $salt, $mobile, $email, $systemadmin, $addedby);
    echo json_encode($response);
}

if (isset($_GET['getusers'])) {
    echo $user->getusers();
}

if (isset($_GET['getuserdetails'])) {
    $userid = $_GET['userid'];
    echo $user->getuserdetails($userid);
}

if (isset($_POST['activateuser'])) {
    $userid = $_POST['userid'];
    $response = $user->activateUser($userid);
    echo json_encode($response);
}

if (isset($_POST['deactivateuser'])) {
    $userid = $_POST['userid'];
    $reason = $_POST['reason'];
    $deactivatedby = $_POST['deactivatedby'];
    $response = $user->deactivateUser($userid, $reason, $deactivatedby);
    echo json_encode($response);
}

if (isset($_POST['updateuser'])) {
    $userid = $_POST['userid'];
    $username = $_POST['username'];
    $firstname = $_POST['firstname'];
    $lastname = $_POST['lastname'];
    $mobile = isset($_POST['mobile']) ? $_POST['mobile'] : '';
    $email = isset($_POST['email']) ? $_POST['email'] : '';
    $systemadmin = isset($_POST['systemadmin']) ? $_POST['systemadmin'] : 0;
    
    $response = $user->updateUser($userid, $username, $firstname, $lastname, $mobile, $email, $systemadmin);
    echo json_encode($response);
}

?>