<?php
require_once __DIR__ . '/../config/app.php';

session_name(SESSION_NAME);
session_start();
session_destroy();

header("Location: index.php");
exit;
