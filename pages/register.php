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
        justify-content: flex-end;
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
</style>
</head>
<body>
<?php include "../layouts/navbar.php"; ?>
<main>
    <section>
        <h1>Daftar</h1>
        <form>
            <div class="form-control-wrapper">
                <div id="form-control">
                    <label for="username">Nama:</label>
                    <input
                        type="text"
                        id="username"
                        name="username"
                        class="form-input"
                    />
                </div>
                <div id="form-control">
                    <label for="email">Email:</label>
                    <input type="email" id="email" name="email" class="form-input" />
                </div>
            </div>
            <div class="form-control-wrapper" style="margin-top: 1.5rem">
                <div id="form-control">
                    <label for="password">Kata Sandi:</label>
                    <input
                        type="password"
                        id="password"
                        name="password"
                        class="form-input"
                    />
                </div>
                <div id="form-control">
                    <label for="confirm-password">Konfirmasi Kata Sandi:</label>
                    <input
                        type="password"
                        id="confirm-password"
                        name="confirm-password"
                        class="form-input"
                    />
                </div>
            </div>
            <div id="submit-button">
                <button type="submit">Daftar</button>
            </div>
        </form>
    </section>
</main>
</body>

</html>