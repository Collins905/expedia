<?php
session_start();

class db {
    private $servername;
    private $databasename;
    private $username;
    private $password;
    private $charset;
    private $pdo;

    public function __construct() {
        $this->servername   = "localhost";
        $this->databasename = "expediaflightbooking"; // ✅ Make sure this DB exists
        $this->username     = "root";
        $this->password     = "";
        $this->charset      = "utf8mb4";
        $this->connect(); // establish connection on construct
    }

    private function connect() {
        try {
            $dsn = "mysql:host={$this->servername};dbname={$this->databasename};charset={$this->charset}";
            $this->pdo = new PDO($dsn, $this->username, $this->password);
            $this->pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        } catch (PDOException $e) {
            echo json_encode([
                "status"  => "error",
                "message" => "Connection failed: " . $e->getMessage()
            ]);
            exit;
        }
    }

    public function getData($sql, $params = []) {
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        return $stmt;
    }

    public function getJSON($sql, $params = []) {
        $stmt = $this->getData($sql, $params);
        return json_encode([
            "status" => "success",
            "data"   => $stmt->fetchAll(PDO::FETCH_ASSOC)
        ]);
    }

    public function execute($sql, $params = []) {
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute($params);
        return [
            "status"       => "success",
            "rowsAffected" => $stmt->rowCount()
        ];
    }
}
?>
