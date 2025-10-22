<?php
$dsn = "mysql:host=localhost;dbname=dbkamus;charset=utf8mb4";
$username = "root";
$password = "yamabuki";

try {
    $pdo = new PDO($dsn, $username, $password);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
//    echo "Connected successfully";
} catch (PDOException $e) {
    echo "Connection failed: " . $e->getMessage();
    exit();
}