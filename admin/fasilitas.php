<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/app.php';
require_once __DIR__ . '/includes/auth.php';

$db = getDB();
$action = $_GET['action'] ?? 'list';

// Handle Delete
if ($action === 'delete' && isset($_GET['id'])) {
    $stmt = $db->prepare("DELETE FROM fasilitas WHERE id = ?");
    $stmt->execute([$_GET['id']]);
    setFlash('success', 'Fasilitas berhasil dihapus.');
    header("Location: fasilitas.php");
    exit;
}

// Handle Form Submit (Add/Edit)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && verifyCsrf()) {
    $id = $_POST['id'] ?? '';
    $nama = trim($_POST['nama'] ?? '');
    $icon = trim($_POST['icon'] ?? '✨');

    try {
        if ($id) {
            $stmt = $db->prepare("UPDATE fasilitas SET nama=?, icon=? WHERE id=?");
            $stmt->execute([$nama, $icon, $id]);
            setFlash('success', 'Fasilitas berhasil diupdate.');
        } else {
            $stmt = $db->prepare("INSERT INTO fasilitas (nama, icon) VALUES (?, ?)");
            $stmt->execute([$nama, $icon]);
            setFlash('success', 'Fasilitas berhasil ditambahkan.');
        }
        header("Location: fasilitas.php");
        exit;
    } catch (PDOException $e) {
        setFlash('error', 'Error: ' . $e->getMessage());
    }
}

$pageTitle = 'Data Fasilitas';
include __DIR__ . '/includes/header.php';

if ($action === 'add' || $action === 'edit'):
    $fas = null;
    if ($action === 'edit' && isset($_GET['id'])) {
        $stmt = $db->prepare("SELECT * FROM fasilitas WHERE id = ?");
        $stmt->execute([$_GET['id']]);
        $fas = $stmt->fetch();
    }
?>
    <div class="card" style="max-width: 500px; margin: 0 auto;">
        <div class="card-header">
            <h4><?= $fas ? 'Edit Fasilitas' : 'Tambah Fasilitas' ?></h4>
            <a href="fasilitas.php" class="btn btn-sm" style="background:var(--glass-md);color:var(--text);border:1px solid var(--border-glass)">Batal</a>
        </div>
        <div class="card-body">
            <form method="POST" action="fasilitas.php?action=<?= $action ?>">
                <input type="hidden" name="csrf_token" value="<?= csrfToken() ?>">
                <?php if($fas): ?>
                <input type="hidden" name="id" value="<?= $fas['id'] ?>">
                <?php endif; ?>

                <div class="form-group">
                    <label class="form-label">Nama Fasilitas *</label>
                    <input type="text" name="nama" class="form-control" required value="<?= $fas ? htmlspecialchars($fas['nama']) : '' ?>" placeholder="Contoh: AC, WiFi, Kasur">
                </div>

                <div class="form-group">
                    <label class="form-label">Icon (Emoji) *</label>
                    <input type="text" name="icon" class="form-control" required value="<?= $fas ? htmlspecialchars($fas['icon']) : '' ?>" placeholder="Contoh: ❄️, 📶, 🛏️">
                </div>

                <button type="submit" class="btn btn-primary mt-3">Simpan Data</button>
            </form>
        </div>
    </div>
<?php else: // List view ?>
    <div class="card">
        <div class="card-header">
            <h4>Daftar Fasilitas</h4>
            <a href="fasilitas.php?action=add" class="btn btn-sm btn-primary">+ Tambah Fasilitas</a>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>Icon</th>
                            <th>Nama Fasilitas</th>
                            <th>Digunakan Oleh</th>
                            <th width="150">Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php 
                        $fasilitas = $db->query("SELECT f.*, (SELECT COUNT(*) FROM kos_fasilitas WHERE fasilitas_id = f.id) as usage_count FROM fasilitas f ORDER BY f.nama ASC")->fetchAll();
                        foreach ($fasilitas as $f): 
                        ?>
                        <tr>
                            <td style="font-size:1.5rem;text-align:center;width:60px;"><?= htmlspecialchars($f['icon']) ?></td>
                            <td style="font-weight:600"><?= htmlspecialchars($f['nama']) ?></td>
                            <td><?= $f['usage_count'] ?> Kos</td>
                            <td>
                                <a href="fasilitas.php?action=edit&id=<?= $f['id'] ?>" class="btn btn-sm" style="background:var(--glass-md);color:var(--text);border:1px solid var(--border-glass)">Edit</a>
                                <a href="fasilitas.php?action=delete&id=<?= $f['id'] ?>" class="btn btn-sm btn-danger" onclick="return confirm('Hapus fasilitas ini?');">Hapus</a>
                            </td>
                        </tr>
                        <?php endforeach; ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
<?php endif; ?>

<?php include __DIR__ . '/includes/footer.php'; ?>
