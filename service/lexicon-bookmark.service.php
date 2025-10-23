<?php
require_once "../config/database.php";

function addLexiconBookmark($userId, $lexiconId)
{
    if (!isset($_SESSION["is_logged_in"]) || !$_SESSION["is_logged_in"]) {
        http_response_code(401);
        echo json_encode(["message" => "Otorisasi gagal. Silakan masuk terlebih dahulu."]);
        exit();
    }

    global $pdo;
    $stmt = $pdo->prepare("INSERT INTO lexicon_bookmarks (bookmark_id, user_id, lexicon_id) VALUES (:bookmark_id, :user_id, :lexicon_id)");
    $bookmarkId = bin2hex(random_bytes(16));
    $stmt->bindParam(":bookmark_id", $bookmarkId);
    $stmt->bindParam(":user_id", $userId);
    $stmt->bindParam(":lexicon_id", $lexiconId);

    if (!$stmt->execute()) {
        http_response_code(500);
        echo json_encode(["message" => "Gagal menambahkan bookmark."]);
        exit();
    }

    http_response_code(201);
    echo json_encode(["message" => "Bookmark berhasil ditambahkan."]);
}

function removeLexiconBookmark($userId, $lexiconId)
{
    if (!isset($_SESSION["is_logged_in"]) || !$_SESSION["is_logged_in"]) {
        http_response_code(401);
        echo json_encode(["message" => "Otorisasi gagal. Silakan masuk terlebih dahulu."]);
        exit();
    }

    global $pdo;
    $stmt = $pdo->prepare("DELETE FROM lexicon_bookmarks WHERE user_id = :user_id AND lexicon_id = :lexicon_id");
    $stmt->bindParam(":user_id", $userId);
    $stmt->bindParam(":lexicon_id", $lexiconId);

    if (!$stmt->execute()) {
        http_response_code(500);
        echo json_encode(["message" => "Gagal menghapus bookmark."]);
        exit();
    }

    http_response_code(200);
    echo json_encode(["message" => "Bookmark berhasil dihapus."]);
}

function getLexiconBookmarks($userId): array
{
    global $pdo;
    $stmt = $pdo->prepare("
        SELECT lb.bookmark_id, l.lexicon_id, l.title, l.description
        FROM lexicon_bookmarks lb
        JOIN lexicons l ON lb.lexicon_id = l.lexicon_id
        WHERE lb.user_id = :user_id
    ");
    $stmt->bindParam(":user_id", $userId);
    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    session_start();
    $action = $_POST["action"];
    $userId = $_SESSION["id"];
    $lexiconId = $_POST["lexicon_id"];
    if ($_POST["action"] === "UPDATE") {
        addLexiconBookmark($userId, $lexiconId);
    } else {
        removeLexiconBookmark($userId, $lexiconId);
    }
}