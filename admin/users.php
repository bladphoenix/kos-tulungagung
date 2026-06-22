<?php
require_once __DIR__ . '/../config/database.php';
require_once __DIR__ . '/../config/app.php';
require_once __DIR__ . '/includes/auth.php';

$db = getDB();
$action = $_GET['action'] ?? 'list';

// Handle Delete
if ($action === 'delete' && isset($_GET['id'])) {
    if ($_GET['id'] == $_SESSION['admin_id']) {
        setFlash('error', 'Anda tidak dapat menghapus akun Anda sendiri saat sedang login.');
    } else {
        $stmt = $db->prepare("DELETE FROM admin WHERE id = ?");
        $stmt->execute([$_GET['id']]);
        setFlash('success', 'Admin berhasil dihapus.');
    }
    header("Location: users.php");
    exit;
}

// Handle Form Submit (Add/Edit)
if ($_SERVER['REQUEST_METHOD'] === 'POST' && verifyCsrf()) {
    $id = $_POST['id'] ?? '';
    $username = trim($_POST['username'] ?? '');
    $nama_lengkap = trim($_POST['nama_lengkap'] ?? '');
    $password = $_POST['password'] ?? '';

    try {
        // Cek username bentrok
        $stmt = $db->prepare("SELECT id FROM admin WHERE username = ? AND id != ?");
        $stmt->execute([$username, $id ?: 0]);
        if ($stmt->fetch()) {
            setFlash('error', 'Username sudah digunakan oleh admin lain.');
            header("Location: users.php?action=" . ($id ? "edit&id=$id" : "add"));
            exit;
        }

        if ($id) {
            // Update
            if (!empty($password)) {
                $hash = password_hash($password, PASSWORD_BCRYPT);
                $stmt = $db->prepare("UPDATE admin SET username=?, nama_lengkap=?, password=? WHERE id=?");
                $stmt->execute([$username, $nama_lengkap, $hash, $id]);
            } else {
                $stmt = $db->prepare("UPDATE admin SET username=?, nama_lengkap=? WHERE id=?");
                $stmt->execute([$username, $nama_lengkap, $id]);
            }
            // Update session jika yang diedit akun sendiri
            if ($id == $_SESSION['admin_id']) {
                $_SESSION['admin_nama'] = $nama_lengkap;
            }
            setFlash('success', 'Admin berhasil diupdate.');
        } else {
            // Insert
            if (empty($password)) {
                setFlash('error', 'Password harus diisi untuk admin baru.');
                header("Location: users.php?action=add");
                exit;
            }
            $hash = password_hash($password, PASSWORD_BCRYPT);
            $stmt = $db->prepare("INSERT INTO admin (username, password, nama_lengkap) VALUES (?, ?, ?)");
            $stmt->execute([$username, $hash, $nama_lengkap]);
            setFlash('success', 'Admin berhasil ditambahkan.');
        }
        header("Location: users.php");
        exit;
    } catch (PDOException $e) {
        setFlash('error', 'Error: ' . $e->getMessage());
    }
}

$pageTitle = 'Data Admin';
include __DIR__ . '/includes/header.php';

if ($action === 'add' || $action === 'edit'):
    $user = null;
    if ($action === 'edit' && isset($_GET['id'])) {
        $stmt = $db->prepare("SELECT * FROM admin WHERE id = ?");
        $stmt->execute([$_GET['id']]);
        $user = $stmt->fetch();
    }
?>
    <div class="card" style="max-width: 600px; margin: 0 auto;">
        <div class="card-header">
            <h4><?= $user ? 'Edit Admin' : 'Tambah Admin' ?></h4>
            <a href="users.php" class="btn btn-sm" style="background:var(--glass-md);color:var(--text);border:1px solid var(--border-glass)">Batal</a>
        </div>
        <div class="card-body">
            <form method="POST" action="users.php?action=<?= $action ?>">
                <input type="hidden" name="csrf_token" value="<?= csrfToken() ?>">
                <?php if($user): ?>
                <input type="hidden" name="id" value="<?= $user['id'] ?>">
                <?php endif; ?>

                <div class="form-group">
                    <label class="form-label">Username *</label>
                    <input type="text" name="username" class="form-control" required value="<?= $user ? htmlspecialchars($user['username']) : '' ?>">
                </div>

                <div class="form-group">
                    <label class="form-label">Nama Lengkap *</label>
                    <input type="text" name="nama_lengkap" class="form-control" required value="<?= $user ? htmlspecialchars($user['nama_lengkap']) : '' ?>">
                </div>

                <div class="form-group">
                    <label class="form-label">Password <?= $user ? '(Kosongkan jika tidak ingin mengubah)' : '*' ?></label>
                    <input type="password" name="password" class="form-control" <?= $user ? '' : 'required' ?>>
                </div>

                <button type="submit" class="btn btn-primary mt-3">Simpan Data</button>
            </form>
        </div>
    </div>
<?php else: // List view ?>
    <div class="card">
        <div class="card-header">
            <h4>Daftar Admin</h4>
            <a href="users.php?action=add" class="btn btn-sm btn-primary">+ Tambah Admin</a>
        </div>
        <div class="card-body">
            <div class="table-responsive">
                <table>
                    <thead>
                        <tr>
                            <th>Username</th>
                            <th>Nama Lengkap</th>
                            <th>Tanggal Dibuat</th>
                            <th width="150">Aksi</th>
                        </tr>
                    </thead>
                    <tbody>
                        <?php 
                        $users = $db->query("SELECT * FROM admin ORDER BY created_at DESC")->fetchAll();
                        foreach ($users as $u): 
                        ?>
                        <tr>
                            <td style="font-weight:600"><?= htmlspecialchars($u['username']) ?> <?php if($u['id']==$_SESSION['admin_id']) echo '<span class="badge badge-tersedia">Anda</span>'; ?></td>
                            <td><?= htmlspecialchars($u['nama_lengkap']) ?></td>
                            <td style="color:var(--text-muted)"><?= date('d M Y H:i', strtotime($u['created_at'])) ?></td>
                            <td>
                                <a href="users.php?action=edit&id=<?= $u['id'] ?>" class="btn btn-sm" style="background:var(--glass-md);color:var(--text);border:1px solid var(--border-glass)">Edit</a>
                                <?php if($u['id'] != $_SESSION['admin_id']): ?>
                                <a href="users.php?action=delete&id=<?= $u['id'] ?>" class="btn btn-sm btn-danger" onclick="return confirm('Hapus admin ini?');">Hapus</a>
                                <?php endif; ?>
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
