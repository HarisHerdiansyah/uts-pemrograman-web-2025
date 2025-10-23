<?php
require_once "../config/database.php";
session_start();

function addDictionaryBookmark($userId, $dictId)
{
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
        echo json_encode(["message" => "Gagal menambahkan bookmark."]);
        exit();
    }

    http_response_code(201);
    echo json_encode(["message" => "Bookmark berhasil ditambahkan."]);
}

function removeDictionaryBookmark($userId, $dictId)
{
    if (!isset($_SESSION["is_logged_in"]) || !$_SESSION["is_logged_in"]) {
        http_response_code(401);
        echo json_encode(["message" => "Otorisasi gagal. Silakan masuk terlebih dahulu."]);
        exit();
    }

    global $pdo;
    $stmt = $pdo->prepare("DELETE FROM dictionary_bookmarks WHERE user_id = :user_id AND dict_id = :dict_id");
    $stmt->bindParam(":user_id", $userId);
    $stmt->bindParam(":dict_id", $dictId);

    if (!$stmt->execute()) {
        http_response_code(500);
        echo json_encode(["message" => "Gagal menghapus bookmark."]);
        exit();
    }

    http_response_code(200);
    echo json_encode(["message" => "Bookmark berhasil dihapus."]);
}

function getDictionaryBookmarks($userId): array
{
    global $pdo;
    $stmt = $pdo->prepare("
        SELECT db.bookmark_id, d.dict_id, d.entry, d.meaning, l.title AS title
        FROM dictionary_bookmarks db
        JOIN dictionaries d ON db.dict_id = d.dict_id
        JOIN lexicons l ON d.lexicon_id = l.lexicon_id
        WHERE db.user_id = :user_id
    ");
    $stmt->bindParam(":user_id", $userId);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $action = $_POST["action"];
    $userId = $_SESSION["id"];
    $dictId = $_POST["dict_id"];
    if ($_POST["action"] === "UPDATE") {
        addDictionaryBookmark($userId, $dictId);
    } else {
        removeDictionaryBookmark($userId, $dictId);
    }
}