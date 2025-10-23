<?php
require_once "../config/database.php";

function searchDictionaries($page, $limit, $phrase, $source): array
{
    global $pdo;
    $offset = ($page - 1) * $limit;

    $query = "SELECT d.dict_id, d.entry, d.meaning, l.title,
          CASE WHEN db.bookmark_id IS NOT NULL THEN 1 ELSE 0 END AS is_bookmarked
          FROM dictionaries d
          INNER JOIN lexicons l ON d.lexicon_id = l.lexicon_id
          LEFT JOIN dictionary_bookmarks db ON d.dict_id = db.dict_id AND db.user_id = :user_id";

    $conditions = [];

    if (!empty($phrase)) {
        $conditions[] = "d.entry LIKE :phrase";
    }
    if (!empty($source) && $source !== "all") {
        $conditions[] = "l.lexicon_id = :source";
    }

    if ($conditions) {
        $query .= " WHERE " . implode(" AND ", $conditions);
    }

    $query .= " LIMIT :limit OFFSET :offset";

    $stmt = $pdo->prepare($query);

    if (!empty($phrase)) {
        $phrase = "%$phrase%";
        $stmt->bindParam(":phrase", $phrase);
    }
    if (!empty($source) && $source !== "all") {
        $stmt->bindParam(":source", $source);
    }

    $userId = $_SESSION["id"] ?? "";
    $stmt->bindParam(":user_id", $userId);
    $stmt->bindParam(":limit", $limit, PDO::PARAM_INT);
    $stmt->bindParam(":offset", $offset, PDO::PARAM_INT);

    $stmt->execute();
    return $stmt->fetchAll(PDO::FETCH_ASSOC);
}
