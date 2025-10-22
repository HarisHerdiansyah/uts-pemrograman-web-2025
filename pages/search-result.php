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
</style>
</head>
<body>
<?php include "../layouts/navbar.php"; ?>
<main>
    <section class="search-control">
        <div class="heading">
            <h3>Sumber: -</h3>
            <h3>Mode Pencarian: -</h3>
        </div>
        <div id="form-control">
            <label for="phrase">Cari Kata/Frasa:</label>
            <div class="input-wrapper">
                <input type="text" id="phrase" name="phrase" class="form-input" />
                <button>Cari Kata/Frasa</button>
            </div>
        </div>
    </section>
    <section class="search-results">
        <h1>ma.ka.nan</h1>
        <div class="search-result-lists">
            <div class="search-result-item">
                <article>
                    <p>makanan [Ind]: pemaknaan makanan</p>
                    <p>Sumber: -</p>
                </article>
                <aside>
                    <i class="far fa-bookmark"></i>
                </aside>
            </div>
        </div>
        <div class="search-result-control">
            <div class="search-result-limit">
                <p>Jumlah per halaman:</p>
                <select>
                    <option value="5">5</option>
                    <option value="10">10</option>
                    <option value="20">20</option>
                </select>
            </div>
            <div class="search-result-pagination">
                <button>
                    <i class="fas fa-chevron-left"></i>
                </button>
                <input type="number" name="page" id="page" min="1" value="1" />
                <button>
                    <i class="fas fa-chevron-right"></i>
                </button>
            </div>
        </div>
    </section>
</main>
</body>

</html>