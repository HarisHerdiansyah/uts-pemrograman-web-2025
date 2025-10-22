<?php
require_once "../config/database.php";

function registerUser($username, $email, $password) {
    global $pdo;
    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = :email");
    $stmt->bindParam(':email', $email);

    if (!$stmt->execute()) {
        http_response_code(500);
        echo json_encode(["message" => "Database error."]);
        exit;
    }

    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if (count($users) > 0) {
        http_response_code(409);
        echo json_encode(["message" => "Email already registered."]);
        exit;
    }

    $id = bin2hex(random_bytes(16));
    $hashedPassword = password_hash($password, PASSWORD_BCRYPT);
    $insertStmt = $pdo->prepare("INSERT INTO users (user_id, username, email, password) VALUES (:user_id, :username, :email, :password)");
    $insertStmt->bindParam(':user_id', $id);
    $insertStmt->bindParam(':username', $username);
    $insertStmt->bindParam(':email', $email);
    $insertStmt->bindParam(':password', $hashedPassword);

    if (!$insertStmt->execute()) {
        http_response_code(500);
        echo json_encode(["message" => "Failed to register user."]);
        exit;
    }

    http_response_code(201);
    echo json_encode(["message" => "Registration successful."]);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $username = $_POST['username'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    registerUser($username, $email, $password);
}