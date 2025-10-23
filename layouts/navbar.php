<nav>
    <aside>
        <div class="avatar">
            <i class="fa-solid fa-user"></i>
        </div>
        <div class="profile-popover">
            <?php if (isset($_SESSION["is_logged_in"]) && $_SESSION["is_logged_in"]): ?>
                <p style="font-weight: 600; margin-bottom: 4px">
                    <?= $_SESSION["username"] ?>
                </p>
                <p style="margin-bottom: 4px">
                    <?= $_SESSION["email"] ?>
                </p>
                <hr/>
                <div style="display: flex; justify-content: flex-start; align-items: center; gap: 0.8rem">
                    <a href="../pages/bookmark.php">
                        <button class="bookmark-button-nav">
                            <i class="fa-solid fa-bookmark"></i>
                            Bookmark
                        </button>
                    </a>
                    <button class="logout-button">
                        <i class="fa-solid fa-right-from-bracket"></i>
                        Keluar
                    </button>
                </div>
            <?php else: ?>
                <a href="../pages/login.php">
                    <button class="login-button">
                        <i class="fa-solid fa-right-to-bracket"></i>
                        Masuk
                    </button>
                </a>
            <?php endif; ?>
        </div>
    </aside>
</nav>