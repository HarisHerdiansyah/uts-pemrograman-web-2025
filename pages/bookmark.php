<?php
require_once "../service/dictionary-bookmark.service.php";
require_once "../service/lexicon-bookmark.service.php";

if (!isset($_SESSION['is_logged_in'])) {
    header("Location: login.php");
    exit();
}

$userId = $_SESSION['id'];
$dictionary = getDictionaryBookmarks($userId);
$lexicon = getLexiconBookmarks($userId);
?>

<?php include "../layouts/top.php"; ?>
    <style>
        main > section {
            margin-bottom: 2rem;
        }

        main > section > h1 {
            margin-bottom: 1rem;
        }

        .bookmark-item {
            border-bottom: 1px solid #1b3c53;
            padding: 0.5rem 0;
            margin-top: 0.75rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .bookmark-item p {
            margin: 0.5rem 0;
        }

        .bookmark-item .fa-circle-minus {
            color: #ba2020;
            font-size: 1.5rem;
            cursor: pointer;
        }
    </style>
    </head>
    <body>
<?php include "../layouts/navbar.php"; ?>
    <main>
        <section>
            <h1>Daftar Kosakata:</h1>
            <div class="bookmark-list">
                <?php if (empty($dictionary)): ?>
                    <p style="text-align: center">Tidak ada kosakata yang ditandai.</p>
                <?php else: ?>
                    <?php foreach ($dictionary as $bookmark): ?>
                        <div class="bookmark-item">
                            <article>
                                <p><?= htmlspecialchars($bookmark['entry']) ?>
                                    : <?= htmlspecialchars($bookmark['meaning']) ?></p>
                                <p>Sumber: <?= htmlspecialchars($bookmark['title']) ?></p>
                            </article>
                            <aside id="remove-bookmark" data-type="dictionary" data-dictId="<?= $bookmark['dict_id'] ?>">
                                <i class="fa-solid fa-circle-minus"></i>
                            </aside>
                        </div>
                    <?php endforeach; ?>
                <?php endif; ?>
            </div>
        </section>
        <section>
            <h1>Daftar Sumber:</h1>
            <div class="bookmark-list">
                <?php if (empty($lexicon)): ?>
                    <p style="text-align: center">Tidak ada sumber yang ditandai.</p>
                <?php else: ?>
                    <?php foreach ($lexicon as $bookmark): ?>
                        <div class="bookmark-item">
                            <article>
                                <p><?= htmlspecialchars($bookmark['title']) ?></p>
                            </article>
                            <aside id="remove-bookmark" data-type="lexicon" data-lexiconId="<?= $bookmark['lexicon_id'] ?>">
                                <i class="fa-solid fa-circle-minus"></i>
                            </aside>
                        </div>
                    <?php endforeach; ?>
                <?php endif; ?>
            </div>
        </section>
    </main>
    <script>
        document.querySelectorAll("#remove-bookmark").forEach((btn) => {
            btn.addEventListener("click", async () => {
                const bookmarkId = btn.getAttribute("data-bookmarkId");
                const type = btn.getAttribute("data-type");
                const formData = new FormData();
                formData.append("type", type);
                formData.append("action", "DELETE");

                try {
                    const servicePath = type === "dictionary" ? "dictionary-bookmark.service.php" : "lexicon-bookmark.service.php";
                    const idKey = type === "dictionary" ? btn.getAttribute("data-dictId") : btn.getAttribute("data-lexiconId");
                    formData.append(type === "dictionary" ? "dict_id" : "lexicon_id", idKey);

                    const response = await fetch("../service/" + servicePath, {
                        method: "POST",
                        body: formData,
                    });

                    const result = await response.json();

                    if (response.ok) {
                        alert(result.message);
                        location.reload();
                    } else {
                        alert(`Error: ${result.message}`);
                    }
                } catch (error) {
                    console.error("Error:", error);
                    alert("Terjadi kesalahan ketika memperbarui bookmark.");
                }
            });
        });
    </script>

<?php include "../layouts/bottom.php"; ?>