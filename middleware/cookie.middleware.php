<?php
if (!isset($_COOKIE['search_count'])) {
    setcookie("search_count", 5, 86400, "/");
}