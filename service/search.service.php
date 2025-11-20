<?php
require_once "../config/database.php";

function searchDictionaries($page, $limit, $phrase, $source): array
{
    global $pdo;
    $offset = ($page - 1) * $limit;

    // First, get the total count
    $countQuery = "SELECT COUNT(*) as total
          FROM dictionaries d
          INNER JOIN lexicons l ON d.lexicon_id = l.lexicon_id";

    $conditions = [];

    if (!empty($phrase)) {
        $conditions[] = "d.entry LIKE :phrase";
    }
    if (!empty($source) && $source !== "all") {
        $conditions[] = "l.lexicon_id = :source";
    }

    if ($conditions) {
        $countQuery .= " WHERE " . implode(" AND ", $conditions);
    }

    $countStmt = $pdo->prepare($countQuery);

    if (!empty($phrase)) {
        $phraseParam = "%$phrase%";
        $countStmt->bindParam(":phrase", $phraseParam);
    }
    if (!empty($source) && $source !== "all") {
        $countStmt->bindParam(":source", $source);
    }

    $countStmt->execute();
    $totalCount = $countStmt->fetch(PDO::FETCH_ASSOC)['total'];

    // Now get the paginated results
    $query = "SELECT d.dict_id, d.entry, d.meaning, l.title, l.lexicon_id,
          CASE WHEN db.bookmark_id IS NOT NULL THEN 1 ELSE 0 END AS is_bookmarked
          FROM dictionaries d
          INNER JOIN lexicons l ON d.lexicon_id = l.lexicon_id
          LEFT JOIN dictionary_bookmarks db ON d.dict_id = db.dict_id AND db.user_id = :user_id";

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
    $results = $stmt->fetchAll(PDO::FETCH_ASSOC);

    return [
        'data' => $results,
        'total' => $totalCount
    ];
}
