# Direktori Kos Tulungagung

Sebuah platform aplikasi berbasis web untuk mencari dan menemukan tempat kos terbaik di wilayah Kabupaten Tulungagung.

## 🚀 Fitur Utama
- **Pencarian Berdasarkan Kecamatan**: Tersedia informasi kos yang tersebar di 19 kecamatan se-Kabupaten Tulungagung.
- **Detail Lengkap Kos**: Menampilkan informasi secara mendetail mulai dari harga sewa, alamat lengkap, status ketersediaan, hingga galeri foto kos.
- **Kategori Kos**: Pemisahan kategori secara jelas (Kos Putra, Kos Putri, dan Kos Campur).
- **Informasi Fasilitas**: Indikator fasilitas pendukung yang lengkap (AC, WiFi, Kamar Mandi Dalam, Parkir, dll).
- **Halaman Admin**: Panel khusus admin untuk mengelola (CRUD) data kos, data kecamatan, dan fasilitas.

## 🛠️ Teknologi yang Digunakan
- **Frontend**: HTML, CSS, JavaScript (Native)
- **Backend**: PHP (Native)
- **Database**: MySQL / MariaDB

## 📦 Instalasi & Cara Menjalankan di Lokal (Localhost)

1. **Clone Repository**
   ```bash
   git clone https://github.com/username_github_anda/kostulungagung.git
   ```
2. **Pindahkan ke Server Lokal**
   Pindahkan folder repositori ini ke dalam folder server lokal Anda, misal `htdocs` (jika menggunakan XAMPP) atau `www` (Laragon).

3. **Konfigurasi Database**
   - Buka phpMyAdmin (biasanya di `http://localhost/phpmyadmin`).
   - Buat database baru dengan nama `rsudiska_kostulungagung`.
   - Pilih menu Import, lalu masukkan salah satu file SQL berikut:
     - `rsudiska_kostulungagung.sql` *(Disarankan: Berisi struktur tabel dan data nyata/asli).*
     - `database.sql` *(Opsional: Berisi struktur awal dan data contoh/dummy dari internet).*
   - Buka folder `config` (misalnya pada file `koneksi.php` atau `database.php`) dan pastikan kredensial database sudah sesuai (`root` dan password kosong secara default untuk XAMPP).

4. **Akses Website**
   - **Halaman Pengunjung Utama**: `http://localhost/kostulungagung` (sesuaikan dengan nama folder Anda).
   - **Halaman Panel Admin**: `http://localhost/kostulungagung/admin`.

## 📂 Struktur Direktori Utama
- `/admin` — Berisi *source code* untuk halaman panel kontrol admin (tambah/edit/hapus data).
- `/config` — File pengaturan koneksi database dan *helper* global.
- `/uploads` — Direktori tempat penyimpanan gambar/foto kos yang diunggah ke server.
- `index.php` — Beranda utama aplikasi.
- `kecamatan.php` — Halaman untuk menampilkan daftar kos pada spesifik kecamatan.
- `database.sql` / `rsudiska_kostulungagung.sql` — File *dump* database SQL.

## 🤝 Kontribusi
Jika Anda ingin berkontribusi pada proyek ini, silakan *fork* repository ini, lakukan perubahan, dan ajukan *Pull Request*.

## 📄 Lisensi
Proyek ini bersifat *Open Source*. Silakan gunakan, pelajari, atau kembangkan sesuai kebutuhan Anda.

---
*Dibuat untuk memudahkan mahasiswa, pekerja, dan pendatang dalam mencari tempat tinggal di Tulungagung.*
