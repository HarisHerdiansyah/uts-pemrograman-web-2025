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
                <button class="logout-button">
                    <i class="fa-solid fa-right-from-bracket"></i>
                    Keluar
                </button>
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