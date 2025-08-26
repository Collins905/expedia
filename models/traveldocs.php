<?php
include 'db.php';
$db = new db();

header('Content-Type: application/json');

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    echo $db->getJSON("CALL GetTravelDocuments()");
}

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $data = json_decode(file_get_contents("php://input"), true);
    $db->execute("CALL AddTravelDocument(:name, :expires)", [
        ':name' => $data['documentname'],
        ':expires' => $data['documentexpires']
    ]);
    echo json_encode(["status" => "success"]);
}
?>
<?php
require_once("db.php");

class traveldoc {
    private $db;
    public function __construct() { $this->db = new db(); }

    public function savetraveldoc($id, $name, $expires) {
        return $this->db->execute("CALL sp_savetraveldoc(?, ?, ?)", [$id, $name, $expires]);
    }

    public function gettraveldocs() {
        return $this->db->getJSON("CALL sp_gettraveldocs()");
    }
}
?>
