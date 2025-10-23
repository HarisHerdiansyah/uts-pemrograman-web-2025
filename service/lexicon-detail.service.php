<?php
require_once "../config/database.php";
session_start();

function getLexiconDetail($lexiconId) {
    global $pdo;
    $stmt = $pdo->prepare("
        SELECT l.lexicon_id, l.title, l.words_in_total, l.description, 
               l.date_of_prep, l.place_of_prep, a.author_name,
               IF(lb.bookmark_id IS NOT NULL, TRUE, FALSE) AS is_bookmarked
        FROM lexicons l
        INNER JOIN authors a ON l.author_id = a.author_id
        LEFT JOIN lexicon_bookmarks lb ON l.lexicon_id = lb.lexicon_id AND lb.user_id = :user_id
        WHERE l.lexicon_id = :lexicon_id
    ");
    $userId = $_SESSION['id'] ?? "";
    $stmt->bindParam(":user_id", $userId);
    $stmt->bindParam(":lexicon_id", $lexiconId);
    $stmt->execute();
    return $stmt->fetch(PDO::FETCH_ASSOC);
}