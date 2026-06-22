<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/app.php';
require_once __DIR__ . '/includes/auth.php';

$db = getDB();

// Get stats
$totalKec = $db->query("SELECT COUNT(*) FROM kecamatan")->fetchColumn();
$totalKos = $db->query("SELECT COUNT(*) FROM kos")->fetchColumn();
$kosTersedia = $db->query("SELECT COUNT(*) FROM kos WHERE status = 'tersedia'")->fetchColumn();
$kosPenuh = $db->query("SELECT COUNT(*) FROM kos WHERE status = 'penuh'")->fetchColumn();

// Get recently added kos
$recentKos = $db->query("SELECT k.*, kec.nama as nama_kecamatan FROM kos k JOIN kecamatan kec ON k.kecamatan_id = kec.id ORDER BY k.created_at DESC LIMIT 5")->fetchAll();

$pageTitle = 'Dashboard';
include __DIR__ . '/includes/header.php';
?>

<div class="stat-grid">
    <div class="stat-card">
        <div class="stat-card-title">Total Kecamatan</div>
        <div class="stat-card-value"><?= $totalKec ?></div>
    </div>
    <div class="stat-card">
        <div class="stat-card-title">Total Kos</div>
        <div class="stat-card-value"><?= $totalKos ?></div>
    </div>
    <div class="stat-card">
        <div class="stat-card-title" style="color:var(--success)">Kos Tersedia</div>
        <div class="stat-card-value" style="color:var(--success)"><?= $kosTersedia ?></div>
    </div>
    <div class="stat-card">
        <div class="stat-card-title" style="color:var(--danger)">Kos Penuh</div>
        <div class="stat-card-value" style="color:var(--danger)"><?= $kosPenuh ?></div>
    </div>
</div>

<div class="card">
    <div class="card-header">
        <h4>Kos Terbaru Ditambahkan</h4>
        <a href="kos.php" class="btn btn-sm btn-primary">Lihat Semua Data Kos</a>
    </div>
    <div class="card-body">
        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>Nama Kos</th>
                        <th>Kecamatan</th>
                        <th>Tipe</th>
                        <th>Harga</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <?php if (empty($recentKos)): ?>
                        <tr><td colspan="5" class="text-center" style="color:var(--text-muted)">Belum ada data kos</td></tr>
                    <?php else: ?>
                        <?php foreach ($recentKos as $kos): ?>
                        <tr>
                            <td style="font-weight:600"><?= htmlspecialchars($kos['nama']) ?></td>
                            <td><?= htmlspecialchars($kos['nama_kecamatan']) ?></td>
                            <td><?= ucfirst($kos['tipe']) ?></td>
                            <td style="color:var(--success);font-weight:600"><?= formatRupiah($kos['harga']) ?></td>
                            <td>
                                <span class="badge badge-<?= $kos['status'] ?>"><?= ucfirst($kos['status']) ?></span>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                    <?php endif; ?>
                </tbody>
            </table>
        </div>
    </div>
</div>

<?php include __DIR__ . '/includes/footer.php'; ?>
