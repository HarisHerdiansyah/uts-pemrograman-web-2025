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
            <div class="bookmark-item">
                <article>
                    <p>makanan [Ind]: pemaknaan makanan</p>
                    <p>Sumber: -</p>
                </article>
                <aside>
                    <i class="fa-solid fa-circle-minus"></i>
                </aside>
            </div>
        </div>
    </section>
    <section>
        <h1>Daftar Sumber:</h1>
        <div class="bookmark-list">
            <div class="bookmark-item">
                <article>
                    <p>makanan [Ind]: pemaknaan makanan</p>
                </article>
                <aside>
                    <i class="fa-solid fa-circle-minus"></i>
                </aside>
            </div>
        </div>
    </section>
</main>
</body>

</html>