<?php
require_once "../config/database.php";
session_start();

function addBookmark($userId, $dictId)
{
    echo "ok";
    if (!isset($_SESSION["is_logged_in"]) || !$_SESSION["is_logged_in"]) {
        http_response_code(401);
        echo json_encode(["message" => "Unauthorized. Please log in."]);
        exit();
    }

    global $pdo;
    $stmt = $pdo->prepare("INSERT INTO dictionary_bookmarks (bookmark_id, user_id, dict_id) VALUES (:bookmark_id, :user_id, :dict_id)");
    $bookmarkId = bin2hex(random_bytes(16));
    $stmt->bindParam(":bookmark_id", $bookmarkId);
    $stmt->bindParam(":user_id", $userId);
    $stmt->bindParam(":dict_id", $dictId);

    if (!$stmt->execute()) {
        http_response_code(500);
        echo json_encode(["message" => "Failed to add bookmark."]);
        exit();
    }

    http_response_code(201);
    echo json_encode(["message" => "Bookmark added successfully."]);
}

function removeBookmark($userId, $dictId)
{
    if (!isset($_SESSION["is_logged_in"]) || !$_SESSION["is_logged_in"]) {
        http_response_code(401);
        echo json_encode(["message" => "Unauthorized. Please log in."]);
        exit();
    }

    global $pdo;
    $stmt = $pdo->prepare("DELETE FROM dictionary_bookmarks WHERE user_id = :user_id AND dict_id = :dict_id");
    $stmt->bindParam(":user_id", $userId);
    $stmt->bindParam(":dict_id", $dictId);

    if (!$stmt->execute()) {
        http_response_code(500);
        echo json_encode(["message" => "Failed to remove bookmark."]);
        exit();
    }

    http_response_code(200);
    echo json_encode(["message" => "Bookmark removed successfully."]);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $dictId = $_POST["dict_id"] ?? "";
    $userId = $_SESSION["id"] ?? "";
    $isBookmarked = $_POST["is_bookmarked"] ?? "0";

    if ($isBookmarked === "0") {
        addBookmark($userId, $dictId);
    } else {
        removeBookmark($userId, $dictId);
    }
}