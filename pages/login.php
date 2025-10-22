<?php include "../layouts/top.php"; ?>
<style>
    main > section {
        background-color: #1b3c53;
        color: #f9f3ef;
        padding: 2rem 4rem;
    }

    main > section h1 {
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

    .form-control-wrapper {
        display: flex;
        gap: 2rem;
    }

    #submit-button {
        margin-top: 1.5rem;
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    #submit-button button {
        font-family: "Montserrat", sans-serif;
        padding: 0.75rem 1.5rem;
        background-color: #456882;
        color: #f9f3ef;
        border: none;
        border-radius: 8px;
        font-size: 1rem;
        cursor: pointer;
        transition: all 0.3s ease;
    }

    #submit-button button:hover {
        background-color: #98a1bc;
    }

    #submit-button a {
        color: #f9f3ef;
        text-decoration: underline;
    }
</style>
</head>
<body>
<?php include "../layouts/navbar.php"; ?>
<main>
    <section>
        <h1>Masuk</h1>
        <form id="login-form">
            <div class="form-control-wrapper">
                <div id="form-control">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" class="form-input" required/>
                </div>
                <div id="form-control">
                    <label for="password">Kata Sandi:</label>
                    <input
                            type="password"
                            id="password"
                            name="password"
                            class="form-input"
                            required
                    />
                </div>
            </div>
            <div id="submit-button">
                <a href="./register.php">Daftar Akun</a>
                <button type="submit">Masuk</button>
            </div>
        </form>
    </section>
</main>

<script>
    async function loginUser(formData) {
        try {
            const response = await fetch("../service/login.service.php", {
                method: "POST",
                body: formData,
            });

            const result = await response.json();
            if (response.ok) {
                alert("Login berhasil!");
                window.location.href = "dashboard.php";
            } else {
                alert(result.message || "Login gagal. Silakan coba lagi.");
            }
        } catch (error) {
            console.error("Error during login:", error);
            alert("Terjadi kesalahan. Silakan coba lagi nanti.");
        }
    }

    const loginForm = document.getElementById("login-form");
    loginForm.addEventListener("submit", async (e) => {
        e.preventDefault();
        const formData = new FormData(loginForm);
        await loginUser(formData);
    });
</script>

<?php include "../layouts/bottom.php"; ?>