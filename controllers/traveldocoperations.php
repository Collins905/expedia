<?php
require_once("../models/traveldocs.php");
header("Content-Type: application/json");

$doc = new traveldoc();

if (isset($_POST['savetraveldoc'])) {
    echo json_encode(["success" => $doc->savetraveldoc(
        $_POST['docid'] ?? 0,
        $_POST['docname'] ?? "",
        $_POST['expires'] ?? null
    )]);
    exit;
}
if (isset($_GET['gettraveldocs'])) { echo $doc->gettraveldocs(); exit; }

echo json_encode(["error" => "Invalid request"]);
?>
