<?php session_start() ?>
<?php include "../layouts/top.php"; ?>
    <style>
        main > section.search-control {
            margin-bottom: 2rem;
        }

        .heading {
            margin-bottom: 1.5rem;
        }

        #form-control {
            flex: 1 0 0;
            display: flex;
            flex-direction: column;
        }

        #form-control label {
            margin-bottom: 0.5rem;
        }

        .input-wrapper {
            display: flex;
            gap: 1rem;
        }

        .input-wrapper button {
            font-family: "Montserrat", sans-serif;
            padding: 0.5rem 1rem;
            background-color: #456882;
            color: #f9f3ef;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .input-wrapper button:hover {
            background-color: #98a1bc;
        }

        .input-wrapper input[type="text"] {
            flex: 1 0 0;
        }

        .search-result-item {
            border-bottom: 1px solid #1b3c53;
            padding: 0.5rem 0;
            margin-top: 0.75rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .search-result-item p {
            margin: 0.5rem 0;
        }

        .search-result-item .fa-bookmark {
            color: #456882;
            font-size: 1.5rem;
            cursor: pointer;
        }

        .search-result-control {
            margin-top: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .search-result-limit {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .search-result-pagination {
            display: flex;
            align-items: center;
            gap: 0.25rem;
        }

        .search-result-pagination input[type="number"] {
            font-family: "Montserrat", sans-serif;
            border: 1px solid #ccc;
            width: 3rem;
            height: 2rem;
            text-align: center;
            font-size: 1rem;
            border-radius: 8px;
        }

        .search-result-pagination input[type="number"]:focus {
            outline: none;
            border-color: #456882;
            box-shadow: 0 0 5px rgba(0, 123, 255, 0.5);
        }

        .search-result-pagination button {
            background-color: #456882;
            color: #f9f3ef;
            border: none;
            padding: 0.5rem;
            cursor: pointer;
            transition: all 0.3s ease;
            border-radius: 8px;
        }

        .search-result-pagination button:disabled {
            background-color: #ccc;
            cursor: not-allowed;
        }

        .source-link {
            font-weight: bold;
            color: #1b3c53;
        }
    </style>
    </head>
    <body>

<?php include "../layouts/navbar.php"; ?>
<?php
include "../service/search.service.php";
include "../config/database.php";
global $pdo;

$page = isset($_GET["page"]) ? (int)$_GET["page"] : 1;
$limit = isset($_GET["limit"]) ? (int)$_GET["limit"] : 5;
$phrase = $_GET["phrase"] ?? "";
$source = $_GET["source"] ?? "";

$searchResults = searchDictionaries($page, $limit, $phrase, $source);
$totalPage = ceil(count($searchResults) / $limit);

$sourceStmt = $pdo->prepare("SELECT title FROM lexicons WHERE lexicon_id = :source");
$sourceStmt->bindParam(":source", $source);
$sourceStmt->execute();
$sourceData = $sourceStmt->fetch(PDO::FETCH_ASSOC);
?>

    <main>
        <section class="search-control">
            <div class="heading">
                <a href="dashboard.php" style="font-weight: bold; cursor: pointer; text-decoration: underline;">
                    <i class="fa-solid fa-chevron-left"></i>
                    Kembali
                </a>
                <h3>Sumber: <?= $source === "all" ? "Semua" : $sourceData["title"] ?></h3>
            </div>
            <div id="form-control">
                <label for="phrase">Cari Kata/Frasa:</label>
                <div class="input-wrapper">
                    <input type="text" id="phrase" name="phrase" class="form-input"/>
                    <button id="search-button">Cari Kata/Frasa</button>
                </div>
            </div>
        </section>
        <section class="search-results">
            <h1><?= $phrase ?></h1>
            <div class="search-result-lists">
                <?php foreach ($searchResults as $result): ?>
                    <div class="search-result-item">
                        <article>
                            <p>
                                <?= htmlspecialchars($result["entry"]) ?>: <?= htmlspecialchars($result["meaning"]) ?>
                            </p>
                            <p>
                                Sumber: <a href="#" class="source-link"><?= htmlspecialchars($result["title"]) ?></a>
                            </p>
                        </article>
                        <aside id="bookmark-btn" data-dictId="<?= $result["dict_id"] ?>" data-isBookmarked="<?= $result["is_bookmarked"] ? "1" : "0" ?>">
                            <?php if ($result["is_bookmarked"]): ?>
                                <i class="fa-solid fa-bookmark"></i>
                            <?php else: ?>
                                <i class="fa-regular fa-bookmark"></i>
                            <?php endif;  ?>
                        </aside>
                    </div>
                <?php endforeach; ?>
            </div>
            <div class="search-result-control">
                <div class="search-result-limit">
                    <label for="limit">Jumlah per halaman:</label>
                    <select id="limit" name="limit">
                        <option value="5">5</option>
                        <option value="10">10</option>
                        <option value="25">25</option>
                    </select>
                </div>
                <div class="search-result-pagination">
                    <button id="prev-btn" <?= $page <= 1 ? "disabled" : "" ?>>
                        <i class="fas fa-chevron-left"></i>
                    </button>
                    <p style="width: 40px; text-align: center; font-size: 20px"><?= $page ?></p>
                    <button id="next-btn" <?= $page >= $totalPage ? "disabled" : "" ?>>
                        <i class="fas fa-chevron-right"></i>
                    </button>
                </div>
            </div>
        </section>
    </main>
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const url = new URL(window.location);

            const limitSelect = document.getElementById("limit");
            const phraseInput = document.getElementById("phrase");
            const searchButton = document.getElementById("search-button");
            const prevBtn = document.getElementById("prev-btn");
            const nextBtn = document.getElementById("next-btn");

            const limitParam = url.searchParams.get("limit");
            if (limitParam) limitSelect.value = limitParam;

            const phraseParam = url.searchParams.get("phrase");
            if (phraseParam) phraseInput.value = phraseParam;

            limitSelect.addEventListener("change", (e) => {
                url.searchParams.set("limit", e.target.value);
                url.searchParams.set("page", 1);
                window.location.href = url.toString();
            });

            searchButton.addEventListener("click", () => {
                url.searchParams.set("phrase", phraseInput.value);
                url.searchParams.set("limit", 5);
                url.searchParams.set("page", 1);
                window.location.href = url.toString();
            });

            prevBtn.addEventListener("click", () => {
                let currentPage = parseInt(url.searchParams.get("page")) || 1;
                if (currentPage > 1) {
                    url.searchParams.set("page", currentPage - 1);
                    window.location.href = url.toString();
                }
            });

            nextBtn.addEventListener("click", () => {
                let currentPage = parseInt(url.searchParams.get("page")) || 1;
                url.searchParams.set("page", currentPage + 1);
                window.location.href = url.toString();
            });

            document.querySelectorAll("#bookmark-btn").forEach((btn) => {
                btn.addEventListener("click", async () => {
                    const id = btn.getAttribute("data-dictId");
                    const isBookmarked = btn.getAttribute("data-isBookmarked");
                    const formData = new FormData();
                    formData.append("dict_id", id);
                    formData.append("is_bookmarked", isBookmarked);
                    try {
                        const response = await fetch("../service/bookmark.service.php", {
                            method: "POST",
                            body: formData
                        });
                        if (response.status === 401) {
                            alert("Silakan login terlebih dahulu untuk menambahkan bookmark.");
                            window.location.href = "login.php";
                            return;
                        }
                        alert("Bookmark berhasil" + (isBookmarked === "1" ? " dihapus." : " ditambahkan."));
                        window.location.reload();
                    } catch (e) {
                        console.error("Error bookmarking entry:", e);
                        alert("Gagal menambahkan bookmark. Silakan coba lagi.");
                    }
                });
            });
        });
    </script>

<?php include "../layouts/bottom.php"; ?>