<?php
$currentPage = basename($_SERVER['PHP_SELF']);
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Panel - <?= SITE_NAME ?></title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Nunito:wght@400;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="assets/admin.css">
</head>
<body>
    <aside class="sidebar">
        <div class="sidebar-header">
            <h3>Admin Panel</h3>
        </div>
        <nav class="sidebar-nav">
            <a href="dashboard.php" class="nav-item <?= $currentPage === 'dashboard.php' ? 'active' : '' ?>">
                📊 Dashboard
            </a>
            <a href="kecamatan.php" class="nav-item <?= $currentPage === 'kecamatan.php' ? 'active' : '' ?>">
                📍 Data Kecamatan
            </a>
            <a href="kos.php" class="nav-item <?= $currentPage === 'kos.php' ? 'active' : '' ?>">
                🏠 Data Kos
            </a>
            <a href="fasilitas.php" class="nav-item <?= $currentPage === 'fasilitas.php' ? 'active' : '' ?>">
                ✨ Fasilitas
            </a>
            <a href="users.php" class="nav-item <?= $currentPage === 'users.php' ? 'active' : '' ?>">
                👤 Admin Users
            </a>
        </nav>
        <div class="sidebar-footer">
            <a href="logout.php" class="btn btn-danger btn-block">Logout</a>
        </div>
    </aside>

    <main class="main-content">
        <header class="topbar">
            <div class="page-title"><?= isset($pageTitle) ? $pageTitle : 'Dashboard' ?></div>
            <div class="user-info">
                <span>Halo, <?= htmlspecialchars($_SESSION['admin_nama'] ?? 'Admin') ?></span>
                <a href="../index.php" target="_blank" class="btn btn-sm btn-primary">Lihat Web ↗</a>
            </div>
        </header>
        <div class="content-body">
            <?php 
            $flash = getFlash();
            if ($flash): 
            ?>
                <div class="alert alert-<?= $flash['type'] ?>">
                    <?= htmlspecialchars($flash['message']) ?>
                </div>
            <?php endif; ?>
