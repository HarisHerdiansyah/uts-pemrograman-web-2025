<?php
require_once "../config/database.php";
function loginUser($email, $password) {
    global $pdo;
    $stmt = $pdo->prepare("SELECT * FROM users WHERE email = :email");
    $stmt->bindParam(':email', $email);

    if (!$stmt->execute()) {
        http_response_code(500);
        echo json_encode(["message" => "Database error."]);
        exit;
    }

    $users = $stmt->fetchAll(PDO::FETCH_ASSOC);
    if (count($users) === 0) {
        http_response_code(404);
        echo json_encode(["message" => "Akun tidak ditemukan."]);
        exit;
    }

    $firstUser = $users[0];
    if (!password_verify($password, $firstUser['password'])) {
        http_response_code(401);
        echo json_encode(["message" => "Kata sandi salah."]);
        exit;
    }

    session_start();
    $_SESSION["is_logged_in"] = true;
    $_SESSION["id"] = $firstUser["user_id"];
    $_SESSION["username"] = $firstUser["username"];
    $_SESSION["email"] = $firstUser["email"];

    http_response_code(201);
    echo json_encode(["message" => "Login berhasil."]);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $email = $_POST['email'];
    $password = $_POST['password'];
    loginUser($email, $password);
}