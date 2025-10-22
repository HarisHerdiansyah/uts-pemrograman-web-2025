<?php
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    session_start();
    $_SESSION = array();
    session_unset();
    session_destroy();

    http_response_code(302);
    echo json_encode(["message" => "Logout success."]);
}