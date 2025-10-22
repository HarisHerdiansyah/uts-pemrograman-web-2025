<?php session_start(); ?>
<?php include "../layouts/top.php"; ?>
<style>
    main > section {
        background-color: #1b3c53;
        color: #f9f3ef;
        padding: 2rem 4rem;
    }

    .dropdown-parts {
        display: flex;
        gap: 3rem;
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

    #search-button {
        margin-top: 1.5rem;
        display: flex;
        justify-content: flex-end;
    }

    #search-button button {
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

    #search-button button:hover {
        background-color: #98a1bc;
    }
</style>
</head>
<body>
<?php include "../layouts/navbar.php"; ?>
<main>
    <section>
        <div class="dropdown-parts">
            <div id="form-control">
                <label for="source">Sumber:</label>
                <select name="source" id="source" class="form-select">
                    <option value="option1">Option 1</option>
                    <option value="option2">Option 2</option>
                    <option value="option3">Option 3</option>
                </select>
            </div>
            <div id="form-control">
                <label for="search-mode">Mode Pencarian:</label>
                <select name="search-mode" id="search-mode" class="form-select">
                    <option value="option1">Option 1</option>
                    <option value="option2">Option 2</option>
                    <option value="option3">Option 3</option>
                </select>
            </div>
        </div>
        <div id="form-control">
            <label for="phrase">Cari Kata/Frasa:</label>
            <input type="text" id="phrase" name="phrase" class="form-input"/>
        </div>
        <div id="search-button">
            <button>Cari Kata/Frasa</button>
        </div>
    </section>
</main>

<?php include "../layouts/bottom.php"; ?>