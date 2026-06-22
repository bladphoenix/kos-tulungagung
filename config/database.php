<?php
/**
 * Database Configuration
 * Sesuaikan pengaturan di bawah dengan hosting Anda
 */

define('DB_HOST', 'localhost');
define('DB_NAME', 'rsudiska_kostulungagung');
define('DB_USER', 'rsudiska_kostulungagung');
define('DB_PASS', 'sipaloma123');
define('DB_CHARSET', 'utf8mb4');

/**
 * PDO Connection
 */
function getDB() {
    static $pdo = null;
    if ($pdo === null) {
        try {
            $dsn = "mysql:host=" . DB_HOST . ";dbname=" . DB_NAME . ";charset=" . DB_CHARSET;
            $pdo = new PDO($dsn, DB_USER, DB_PASS, [
                PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
                PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
                PDO::ATTR_EMULATE_PREPARES   => false,
            ]);
        } catch (PDOException $e) {
            die('<div style="font-family:sans-serif;padding:40px;text-align:center;color:#e74c3c;">
                <h2>Koneksi Database Gagal</h2>
                <p>' . htmlspecialchars($e->getMessage()) . '</p>
                <p style="color:#888;">Periksa konfigurasi di <code>config/database.php</code></p>
            </div>');
        }
    }
    return $pdo;
}
