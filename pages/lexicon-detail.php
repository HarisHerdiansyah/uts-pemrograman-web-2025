<?php include "../layouts/top.php"; ?>

<?php
require_once "../service/lexicon-detail.service.php";
$lexiconId = $_GET["lexiconId"] ?? "";
$lexiconDetail = getLexiconDetail($lexiconId);
?>

    <style>
        main h1 {
            margin-bottom: 1.25rem;
            color: #1b3c53;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            border-radius: 12px;
            overflow: hidden;
        }

        table th,
        table td {
            text-align: left;
            padding: 0.9rem 1.1rem;
            border-bottom: 1px solid #e9eef3;
            vertical-align: top;
        }

        table tr:last-child th,
        table tr:last-child td {
            border-bottom: none;
        }

        table tr > th:first-child {
            width: 38%;
            color: #1b3c53;
            font-weight: 600;
        }

        main > .heading {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            margin-bottom: 1.5rem;
            justify-content: space-between;
        }

        main > .heading i {
            font-size: 2.5rem;
            color: #1b3c53;
            cursor: pointer;
        }
    </style>
    </head>
    <body>
<?php include "../layouts/navbar.php"; ?>
    <main>
        <div class="heading">
            <h1><?= $lexiconDetail["title"] ?></h1>
            <aside id="bookmark-btn" data-lexiconId="<?= $lexiconId ?>" data-isBookmarked="<?= $lexiconDetail["is_bookmarked"] ? "1" : "0" ?>">
                <?php if ($lexiconDetail["is_bookmarked"]): ?>
                    <i class="fa-solid fa-bookmark"></i>
                <?php else: ?>
                    <i class="fa-regular fa-bookmark"></i>
                <?php endif; ?>
            </aside>
        </div>
        <table>
            <tr>
                <th>Title</th>
                <th>: <?= $lexiconDetail["title"] ?></th>
            </tr>
            <tr>
                <th>Penyusun</th>
                <th>: <?= $lexiconDetail["author_name"] ?></th>
            </tr>
            <tr>
                <th>Jumlah Kata</th>
                <td>: <?= $lexiconDetail["words_in_total"] ?></td>
            </tr>
            <tr>
                <th>Tanggal Penerbitan</th>
                <th>: <?= $lexiconDetail["date_of_prep"] ?></th>
            </tr>
            <tr>
                <th>Tempat Penerbitan</th>
                <th>: <?= $lexiconDetail["place_of_prep"] ?></th>
            </tr>
            <tr>
                <th>Deskripsi</th>
                <td>: <?= $lexiconDetail["description"] ?></td>
            </tr>
        </table>
    </main>
    <script>
        document.addEventListener("DOMContentLoaded", () => {
            const bookmarkBtn = document.getElementById("bookmark-btn");
            const lexiconId = bookmarkBtn.getAttribute("data-lexiconId");
            const isBookmarked = bookmarkBtn.getAttribute("data-isBookmarked");

            bookmarkBtn.addEventListener("click", async () => {
                const formData = new FormData();
                formData.append("lexicon_id", lexiconId);
                formData.append("action", isBookmarked === "0" ? "UPDATE" : "DELETE");

                try {
                    const response = await fetch("../service/lexicon-bookmark.service.php", {
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
                    console.error("Error updating bookmark:", e);
                    alert("Gagal menambahkan bookmark. Silakan coba lagi.");
                }
            });
        });
    </script>

<?php include "../layouts/bottom.php"; ?>