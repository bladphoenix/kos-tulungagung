<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/app.php';
require_once __DIR__ . '/includes/auth.php';

$db = getDB();
$action = $_GET['action'] ?? 'list';

// Handle Delete
if ($action === 'delete' && isset($_GET['id'])) {
    $stmt = $db->prepare("DELETE FROM kos WHERE id = ?");
    $stmt->execute([$_GET['id']]);
    setFlash('success', 'Data kos berhasil dihapus.');
    header("Location: kos.php");
    exit;
}

// Handle Form Submit (Add/Edit)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && verifyCsrf()) {
    $id = $_POST['id'] ?? '';
    $kecamatan_id = $_POST['kecamatan_id'] ?? '';
    $nama = trim($_POST['nama'] ?? '');
    $alamat = trim($_POST['alamat'] ?? '');
    $tipe = $_POST['tipe'] ?? 'campur';
    $harga = $_POST['harga'] ?? 0;
    $status = $_POST['status'] ?? 'tersedia';
    $rating = $_POST['rating'] ?? 4.5;
    $telepon = trim($_POST['telepon'] ?? '');
    $whatsapp = trim($_POST['whatsapp'] ?? '');
    
    // Fasilitas
    $fasilitas_ids = $_POST['fasilitas'] ?? [];

    // Foto handling (6 foto)
    $fotos = [];
    for ($fi = 1; $fi <= 6; $fi++) {
        $key = 'foto_' . $fi;
        $val = $_POST[$key . '_existing'] ?? '';
        if (!empty($_FILES[$key]['name'])) {
            $up = handleUpload($key, 'kos' . $fi);
            if ($up) $val = $up;
        } elseif (!empty($_POST[$key . '_external'])) {
            $val = trim($_POST[$key . '_external']);
        }
        $fotos[$key] = $val;
    }

    try {
        $db->beginTransaction();

        if ($id) {
            // Update Kos
            $stmt = $db->prepare("UPDATE kos SET kecamatan_id=?, nama=?, alamat=?, tipe=?, harga=?, status=?, rating=?, telepon=?, whatsapp=?, foto_1=?, foto_2=?, foto_3=?, foto_4=?, foto_5=?, foto_6=? WHERE id=?");
            $stmt->execute([$kecamatan_id, $nama, $alamat, $tipe, $harga, $status, $rating, $telepon, $whatsapp, $fotos['foto_1'], $fotos['foto_2'], $fotos['foto_3'], $fotos['foto_4'], $fotos['foto_5'], $fotos['foto_6'], $id]);
            
            // Delete old fasilitas
            $stmt = $db->prepare("DELETE FROM kos_fasilitas WHERE kos_id=?");
            $stmt->execute([$id]);
            setFlash('success', 'Data kos berhasil diupdate.');
        } else {
            // Insert Kos
            $stmt = $db->prepare("INSERT INTO kos (kecamatan_id, nama, alamat, tipe, harga, status, rating, telepon, whatsapp, foto_1, foto_2, foto_3, foto_4, foto_5, foto_6) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)");
            $stmt->execute([$kecamatan_id, $nama, $alamat, $tipe, $harga, $status, $rating, $telepon, $whatsapp, $fotos['foto_1'], $fotos['foto_2'], $fotos['foto_3'], $fotos['foto_4'], $fotos['foto_5'], $fotos['foto_6']]);
            $id = $db->lastInsertId();
            setFlash('success', 'Data kos berhasil ditambahkan.');
        }

        // Insert new fasilitas mappings
        if (!empty($fasilitas_ids)) {
            $stmt = $db->prepare("INSERT INTO kos_fasilitas (kos_id, fasilitas_id) VALUES (?, ?)");
            foreach ($fasilitas_ids as $fid) {
                $stmt->execute([$id, $fid]);
            }
        }

        $db->commit();
        header("Location: kos.php");
        exit;
    } catch (PDOException $e) {
        $db->rollBack();
        setFlash('error', 'Error: ' . $e->getMessage());
    }
}

$pageTitle = 'Data Kos';
include __DIR__ . '/includes/header.php';

if ($action === 'add' || $action === 'edit'):
    $kos = null;
    $selectedFasilitas = [];
    if ($action === 'edit' && isset($_GET['id'])) {
        $stmt = $db->prepare("SELECT * FROM kos WHERE id = ?");
        $stmt->execute([$_GET['id']]);
        $kos = $stmt->fetch();
        
        $stmt = $db->prepare("SELECT fasilitas_id FROM kos_fasilitas WHERE kos_id = ?");
        $stmt->execute([$_GET['id']]);
        $selectedFasilitas = $stmt->fetchAll(PDO::FETCH_COLUMN);
    }
    $kecamatanList = $db->query("SELECT id, nama FROM kecamatan ORDER BY nama ASC")->fetchAll();
    $fasilitasList = $db->query("SELECT * FROM fasilitas ORDER BY nama ASC")->fetchAll();
?>
    <div class="card" style="max-width: 800px; margin: 0 auto;">
        <div class="card-header">
            <h4><?= $kos ? 'Edit Kos' : 'Tambah Kos' ?></h4>
            <a href="kos.php" class="btn btn-sm" style="background:var(--glass-md);color:var(--text);border:1px solid var(--border-glass)">Batal</a>
        </div>
        <div class="card-body">
            <form method="POST" action="kos.php?action=<?= $action ?>" enctype="multipart/form-data">
                <input type="hidden" name="csrf_token" value="<?= csrfToken() ?>">
                <?php if($kos): ?>
                <input type="hidden" name="id" value="<?= $kos['id'] ?>">
                <?php for ($fi = 1; $fi <= 6; $fi++): ?>
                <input type="hidden" name="foto_<?= $fi ?>_existing" value="<?= htmlspecialchars($kos['foto_'.$fi] ?? '') ?>">
                <?php endfor; ?>
                <?php endif; ?>

                <div class="d-flex gap-3">
                    <div class="form-group" style="flex:2">
                        <label class="form-label">Nama Kos *</label>
                        <input type="text" name="nama" class="form-control" required value="<?= $kos ? htmlspecialchars($kos['nama']) : '' ?>">
                    </div>
                    <div class="form-group" style="flex:1">
                        <label class="form-label">Kecamatan *</label>
                        <select name="kecamatan_id" class="form-control" required>
                            <option value="">-- Pilih Kecamatan --</option>
                            <?php foreach($kecamatanList as $kec): ?>
                            <option value="<?= $kec['id'] ?>" <?= ($kos && $kos['kecamatan_id'] == $kec['id']) ? 'selected' : '' ?>><?= htmlspecialchars($kec['nama']) ?></option>
                            <?php endforeach; ?>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Alamat Lengkap *</label>
                    <textarea name="alamat" class="form-control" required rows="2"><?= $kos ? htmlspecialchars($kos['alamat']) : '' ?></textarea>
                </div>

                <div class="d-flex gap-3">
                    <div class="form-group" style="flex:1">
                        <label class="form-label">Tipe Kos</label>
                        <select name="tipe" class="form-control">
                            <option value="campur" <?= ($kos && $kos['tipe'] == 'campur') ? 'selected' : '' ?>>Campur</option>
                            <option value="putra" <?= ($kos && $kos['tipe'] == 'putra') ? 'selected' : '' ?>>Putra</option>
                            <option value="putri" <?= ($kos && $kos['tipe'] == 'putri') ? 'selected' : '' ?>>Putri</option>
                        </select>
                    </div>
                    <div class="form-group" style="flex:1">
                        <label class="form-label">Harga/Bulan (Rp) *</label>
                        <input type="number" name="harga" class="form-control" required value="<?= $kos ? $kos['harga'] : '0' ?>">
                    </div>
                    <div class="form-group" style="flex:1">
                        <label class="form-label">Status</label>
                        <select name="status" class="form-control">
                            <option value="tersedia" <?= ($kos && $kos['status'] == 'tersedia') ? 'selected' : '' ?>>Tersedia</option>
                            <option value="penuh" <?= ($kos && $kos['status'] == 'penuh') ? 'selected' : '' ?>>Penuh</option>
                        </select>
                    </div>
                    <div class="form-group" style="flex:1">
                        <label class="form-label">Rating (1.0 - 5.0)</label>
                        <input type="number" step="0.1" min="1" max="5" name="rating" class="form-control" value="<?= $kos ? $kos['rating'] : '4.5' ?>">
                    </div>
                </div>

                <div class="d-flex gap-3">
                    <div class="form-group" style="flex:1">
                        <label class="form-label">Telepon Biasa (Opsional)</label>
                        <input type="text" name="telepon" class="form-control" value="<?= $kos ? htmlspecialchars($kos['telepon'] ?? '') : '' ?>" placeholder="081...">
                    </div>
                    <div class="form-group" style="flex:1">
                        <label class="form-label">Nomor WhatsApp (Opsional)</label>
                        <input type="text" name="whatsapp" class="form-control" value="<?= $kos ? htmlspecialchars($kos['whatsapp'] ?? '') : '' ?>" placeholder="6281...">
                        <small style="color:var(--text-muted)">Awali dengan 62 (contoh: 628123...)</small>
                    </div>
                </div>

                <div class="form-group mt-3">
                    <label class="form-label">Fasilitas Kos</label>
                    <div class="checkbox-grid">
                        <?php foreach($fasilitasList as $f): ?>
                        <label class="checkbox-item">
                            <input type="checkbox" name="fasilitas[]" value="<?= $f['id'] ?>" <?= in_array($f['id'], $selectedFasilitas) ? 'checked' : '' ?>>
                            <?= $f['icon'] ?> <?= htmlspecialchars($f['nama']) ?>
                        </label>
                        <?php endforeach; ?>
                    </div>
                </div>

                <hr style="border:0;border-top:1px solid var(--border-glass);margin:24px 0;">
                <h5 style="margin-bottom:5px;">Foto Kos (Maksimal 6)</h5>
                <small style="color:var(--text-muted);display:block;margin-bottom:15px;">Upload file lokal atau isi URL external. Prioritas: file lokal > URL.</small>
                
                <div style="display:grid;grid-template-columns:repeat(3,1fr);gap:16px;">
                    <?php for ($fi = 1; $fi <= 6; $fi++): 
                        $fotoKey = 'foto_' . $fi;
                        $fotoVal = $kos ? ($kos[$fotoKey] ?? '') : '';
                    ?>
                    <div class="form-group" style="margin-bottom:0">
                        <label class="form-label">Foto <?= $fi ?></label>
                        <input type="file" name="<?= $fotoKey ?>" class="form-control" accept=".jpg,.jpeg,.png,.webp" style="font-size:.8rem;padding:8px 10px;">
                        <input type="url" name="<?= $fotoKey ?>_external" class="form-control" style="margin-top:6px;font-size:.8rem;padding:8px 10px;" placeholder="URL External" value="<?= $fotoVal && strpos($fotoVal, 'http') === 0 ? htmlspecialchars($fotoVal) : '' ?>">
                        <?php if($fotoVal): ?>
                            <img src="<?= getImageSrc($fotoVal) ?>" style="width:100%;height:60px;margin-top:8px;border-radius:4px;object-fit:cover;border:1px solid var(--border-glass);">
                        <?php endif; ?>
                    </div>
                    <?php endfor; ?>
                </div>

                <button type="submit" class="btn btn-primary mt-4 btn-block">Simpan Data Kos</button>
            </form>
        </div>
    </div>
<?php else: // List view ?>
    <div class="card">
        <div class="card-header">
            <h4>Daftar Kos</h4>
            <a href="kos.php?action=add" class="btn btn-sm btn-primary">+ Tambah Kos</a>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>Kecamatan</th>
                            <th>Nama Kos</th>
                            <th>Tipe</th>
                            <th>Harga</th>
                            <th>Status</th>
                            <th width="150">Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php 
                        $kosList = $db->query("SELECT k.*, kec.nama as nama_kecamatan FROM kos k JOIN kecamatan kec ON k.kecamatan_id = kec.id ORDER BY k.created_at DESC")->fetchAll();
                        foreach ($kosList as $k): 
                        ?>
                        <tr>
                            <td><?= htmlspecialchars($k['nama_kecamatan']) ?></td>
                            <td style="font-weight:600"><?= htmlspecialchars($k['nama']) ?></td>
                            <td><?= ucfirst($k['tipe']) ?></td>
                            <td style="color:var(--success);font-weight:600"><?= formatRupiah($k['harga']) ?></td>
                            <td><span class="badge badge-<?= $k['status'] ?>"><?= ucfirst($k['status']) ?></span></td>
                            <td>
                                <a href="kos.php?action=edit&id=<?= $k['id'] ?>" class="btn btn-sm" style="background:var(--glass-md);color:var(--text);border:1px solid var(--border-glass)">Edit</a>
                                <a href="kos.php?action=delete&id=<?= $k['id'] ?>" class="btn btn-sm btn-danger" onclick="return confirm('Hapus kos ini?');">Hapus</a>
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
