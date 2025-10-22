<!--Popover-->
<script>
    const avatar = document.querySelector('.avatar');
    const profilePopover = document.querySelector('.profile-popover');

    avatar.addEventListener('click', () => {
        profilePopover.classList.toggle('visible');
    });
</script>

<!--Logout-->
<script>
    const logoutButton = document.querySelector(".logout-button");
    logoutButton.addEventListener("click", async () => {
        try {
            await fetch("../service/logout.service.php", {
                method: "POST",
            });

            alert("Logout berhasil!");
            window.location.href = "login.php";
        } catch (error) {
            console.error("Error during logout:", error);
            alert("Terjadi kesalahan. Silakan coba lagi nanti.");
        }
    });
</script>

</body>

</html>