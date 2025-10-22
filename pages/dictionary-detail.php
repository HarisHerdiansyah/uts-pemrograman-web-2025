<?php include "../layouts/top.php"; ?>
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
        width: 25%;
        color: #1b3c53;
        font-weight: 600;
    }
</style>
</head>
<body>
<?php include "../layouts/navbar.php"; ?>
<main>
    <h1>ma.ka.nan</h1>
    <table>
        <tr>
            <th>Makna</th>
            <th>: -</th>
        </tr>
        <tr>
            <th>Sumber</th>
            <td>: 1000</td>
        </tr>
    </table>
</main>

<?php include "../layouts/bottom.php"; ?>