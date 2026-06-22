<?php
if (session_status() === PHP_SESSION_NONE) {
    session_name(SESSION_NAME);
    session_start();
}

// Redirect to login if not authenticated
if (!isset($_SESSION['admin_id'])) {
    header("Location: ../admin/index.php");
    exit;
}
