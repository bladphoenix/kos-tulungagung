<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/app.php';
require_once __DIR__ . '/includes/auth.php';

$db = getDB();
$action = $_GET['action'] ?? 'list';

// Handle Delete
if ($action === 'delete' && isset($_GET['id'])) {
    $stmt = $db->prepare("DELETE FROM kecamatan WHERE id = ?");
    $stmt->execute([$_GET['id']]);
    setFlash('success', 'Kecamatan berhasil dihapus.');
    header("Location: kecamatan.php");
    exit;
}

// Handle Form Submit (Add/Edit)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && verifyCsrf()) {
    $id = $_POST['id'] ?? '';
    $nama = trim($_POST['nama'] ?? '');
    $slug = trim($_POST['slug'] ?? '');
    if (empty($slug)) {
        $slug = strtolower(preg_replace('/[^A-Za-z0-9-]+/', '-', $nama));
    }
    $rating = $_POST['rating'] ?? 0;
    $urutan = $_POST['urutan'] ?? 0;
    
    // Handle photo upload if present
    $foto_url = $_POST['foto_url_existing'] ?? '';
    if (!empty($_FILES['foto']['name'])) {
        $uploaded = handleUpload('foto', 'kec');
        if ($uploaded) {
            $foto_url = $uploaded;
        } else {
            setFlash('error', 'Gagal upload foto. Pastikan format gambar benar dan ukuran maksimal 5MB.');
        }
    } elseif (!empty($_POST['foto_url_external'])) {
        $foto_url = trim($_POST['foto_url_external']);
    }

    try {
        if ($id) {
            // Update
            $stmt = $db->prepare("UPDATE kecamatan SET nama=?, slug=?, foto_url=?, rating=?, urutan=? WHERE id=?");
            $stmt->execute([$nama, $slug, $foto_url, $rating, $urutan, $id]);
            setFlash('success', 'Kecamatan berhasil diupdate.');
        } else {
            // Insert
            $stmt = $db->prepare("INSERT INTO kecamatan (nama, slug, foto_url, rating, urutan) VALUES (?, ?, ?, ?, ?)");
            $stmt->execute([$nama, $slug, $foto_url, $rating, $urutan]);
            setFlash('success', 'Kecamatan berhasil ditambahkan.');
        }
        header("Location: kecamatan.php");
        exit;
    } catch (PDOException $e) {
        setFlash('error', 'Error: ' . $e->getMessage());
    }
}

$pageTitle = 'Data Kecamatan';
include __DIR__ . '/includes/header.php';

if ($action === 'add' || $action === 'edit'):
    $kec = null;
    if ($action === 'edit' && isset($_GET['id'])) {
        $stmt = $db->prepare("SELECT * FROM kecamatan WHERE id = ?");
        $stmt->execute([$_GET['id']]);
        $kec = $stmt->fetch();
    }
?>
    <div class="card" style="max-width: 600px; margin: 0 auto;">
        <div class="card-header">
            <h4><?= $kec ? 'Edit Kecamatan' : 'Tambah Kecamatan' ?></h4>
            <a href="kecamatan.php" class="btn btn-sm" style="background:var(--glass-md);color:var(--text);border:1px solid var(--border-glass)">Batal</a>
        </div>
        <div class="card-body">
            <form method="POST" action="kecamatan.php?action=<?= $action ?>" enctype="multipart/form-data">
                <input type="hidden" name="csrf_token" value="<?= csrfToken() ?>">
                <?php if($kec): ?>
                <input type="hidden" name="id" value="<?= $kec['id'] ?>">
                <input type="hidden" name="foto_url_existing" value="<?= htmlspecialchars($kec['foto_url']) ?>">
                <?php endif; ?>

                <div class="form-group">
                    <label class="form-label">Nama Kecamatan *</label>
                    <input type="text" name="nama" class="form-control" required value="<?= $kec ? htmlspecialchars($kec['nama']) : '' ?>">
                </div>
                
                <div class="form-group">
                    <label class="form-label">Slug (Kosongkan untuk auto-generate dari nama)</label>
                    <input type="text" name="slug" class="form-control" value="<?= $kec ? htmlspecialchars($kec['slug']) : '' ?>">
                </div>

                <div class="form-group">
                    <label class="form-label">Upload Foto Lokal (Opsional)</label>
                    <input type="file" name="foto" class="form-control" accept=".jpg,.jpeg,.png,.webp,.gif">
                </div>

                <div class="form-group">
                    <label class="form-label">ATAU URL Foto External (Opsional)</label>
                    <input type="url" name="foto_url_external" class="form-control" placeholder="https://..." value="<?= $kec && strpos($kec['foto_url'], 'http') === 0 ? htmlspecialchars($kec['foto_url']) : '' ?>">
                    <small style="color:var(--text-muted);display:block;margin-top:5px;">Upload foto akan memprioritaskan file lokal, lalu URL external.</small>
                    <?php if($kec && $kec['foto_url']): ?>
                        <div style="margin-top:10px;">
                            <img src="<?= getImageSrc($kec['foto_url']) ?>" alt="Preview" style="height:80px;border-radius:8px;object-fit:cover;">
                        </div>
                    <?php endif; ?>
                </div>

                <div class="d-flex gap-3">
                    <div class="form-group" style="flex:1">
                        <label class="form-label">Rating (1.0 - 5.0)</label>
                        <input type="number" step="0.1" min="1" max="5" name="rating" class="form-control" value="<?= $kec ? $kec['rating'] : '4.5' ?>">
                    </div>
                    <div class="form-group" style="flex:1">
                        <label class="form-label">Urutan Tampil</label>
                        <input type="number" name="urutan" class="form-control" value="<?= $kec ? $kec['urutan'] : '0' ?>">
                    </div>
                </div>

                <button type="submit" class="btn btn-primary mt-3">Simpan Data</button>
            </form>
        </div>
    </div>
<?php else: // List view ?>
    <div class="card">
        <div class="card-header">
            <h4>Daftar Kecamatan</h4>
            <a href="kecamatan.php?action=add" class="btn btn-sm btn-primary">+ Tambah Kecamatan</a>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>Urutan</th>
                            <th>Foto</th>
                            <th>Nama Kecamatan</th>
                            <th>Jumlah Kos (Auto)</th>
                            <th>Rating</th>
                            <th width="150">Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php 
                        $kecamatan = $db->query("SELECT k.*, (SELECT COUNT(*) FROM kos WHERE kecamatan_id = k.id) as real_jumlah_kos FROM kecamatan k ORDER BY k.urutan ASC")->fetchAll();
                        foreach ($kecamatan as $k): 
                        ?>
                        <tr>
                            <td><?= $k['urutan'] ?></td>
                            <td>
                                <img src="<?= getImageSrc($k['foto_url']) ?>" style="width:50px;height:50px;object-fit:cover;border-radius:8px;">
                            </td>
                            <td style="font-weight:600"><?= htmlspecialchars($k['nama']) ?><br><small style="color:var(--text-muted);font-weight:400"><?= htmlspecialchars($k['slug']) ?></small></td>
                            <td><?= $k['real_jumlah_kos'] ?></td>
                            <td>⭐ <?= $k['rating'] ?></td>
                            <td>
                                <a href="kecamatan.php?action=edit&id=<?= $k['id'] ?>" class="btn btn-sm" style="background:var(--glass-md);color:var(--text);border:1px solid var(--border-glass)">Edit</a>
                                <a href="kecamatan.php?action=delete&id=<?= $k['id'] ?>" class="btn btn-sm btn-danger" onclick="return confirm('Hapus kecamatan ini? Semua kos di dalamnya juga akan terhapus!');">Hapus</a>
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
