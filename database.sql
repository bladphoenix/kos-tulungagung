-- ============================================================
-- Database: rsudiska_kostulungagung
-- Direktori Kos Kabupaten Tulungagung
-- ============================================================

CREATE DATABASE IF NOT EXISTS `rsudiska_kostulungagung` CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `rsudiska_kostulungagung`;

-- ============================================================
-- TABLE: admin
-- ============================================================
CREATE TABLE `admin` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `username` VARCHAR(50) NOT NULL UNIQUE,
    `password` VARCHAR(255) NOT NULL,
    `nama_lengkap` VARCHAR(100) NOT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ============================================================
-- TABLE: kecamatan
-- ============================================================
CREATE TABLE `kecamatan` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `nama` VARCHAR(100) NOT NULL,
    `slug` VARCHAR(100) NOT NULL UNIQUE,
    `foto_url` VARCHAR(500) DEFAULT NULL,
    `jumlah_kos` INT DEFAULT 0,
    `rating` DECIMAL(2,1) DEFAULT 0.0,
    `urutan` INT DEFAULT 0,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- ============================================================
-- TABLE: fasilitas
-- ============================================================
CREATE TABLE `fasilitas` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `nama` VARCHAR(100) NOT NULL,
    `icon` VARCHAR(10) NOT NULL
) ENGINE=InnoDB;

-- ============================================================
-- TABLE: kos
-- ============================================================
CREATE TABLE `kos` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `kecamatan_id` INT NOT NULL,
    `nama` VARCHAR(200) NOT NULL,
    `alamat` TEXT NOT NULL,
    `tipe` ENUM('putra','putri','campur') NOT NULL DEFAULT 'campur',
    `harga` INT NOT NULL DEFAULT 0,
    `status` ENUM('tersedia','penuh') NOT NULL DEFAULT 'tersedia',
    `rating` DECIMAL(2,1) DEFAULT 4.5,
    `telepon` VARCHAR(20) DEFAULT NULL,
    `whatsapp` VARCHAR(20) DEFAULT NULL,
    `foto_1` VARCHAR(500) DEFAULT NULL,
    `foto_2` VARCHAR(500) DEFAULT NULL,
    `foto_3` VARCHAR(500) DEFAULT NULL,
    `foto_4` VARCHAR(500) DEFAULT NULL,
    `foto_5` VARCHAR(500) DEFAULT NULL,
    `foto_6` VARCHAR(500) DEFAULT NULL,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (`kecamatan_id`) REFERENCES `kecamatan`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- TABLE: kos_fasilitas (pivot many-to-many)
-- ============================================================
CREATE TABLE `kos_fasilitas` (
    `kos_id` INT NOT NULL,
    `fasilitas_id` INT NOT NULL,
    PRIMARY KEY (`kos_id`, `fasilitas_id`),
    FOREIGN KEY (`kos_id`) REFERENCES `kos`(`id`) ON DELETE CASCADE,
    FOREIGN KEY (`fasilitas_id`) REFERENCES `fasilitas`(`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- SEED: Kecamatan (19 kecamatan Kabupaten Tulungagung)
-- ============================================================
INSERT INTO `kecamatan` (`nama`, `slug`, `foto_url`, `jumlah_kos`, `rating`, `urutan`) VALUES
('Tulungagung', 'tulungagung', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=600&q=80', 24, 4.8, 1),
('Boyolangu', 'boyolangu', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=600&q=80', 18, 4.7, 2),
('Kedungwaru', 'kedungwaru', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=600&q=80', 15, 4.8, 3),
('Ngantru', 'ngantru', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=600&q=80', 12, 4.6, 4),
('Kauman', 'kauman', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=600&q=80', 9, 4.7, 5),
('Sumbergempol', 'sumbergempol', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=600&q=80', 8, 4.7, 6),
('Karangrejo', 'karangrejo', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=600&q=80', 11, 4.5, 7),
('Gondang', 'gondang', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=600&q=80', 13, 4.6, 8),
('Sendang', 'sendang', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=600&q=80', 7, 4.5, 9),
('Pagerwojo', 'pagerwojo', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=600&q=80', 6, 4.4, 10),
('Campurdarat', 'campurdarat', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=600&q=80', 10, 4.6, 11),
('Besuki', 'besuki', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=600&q=80', 14, 4.7, 12),
('Pakel', 'pakel', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=600&q=80', 8, 4.5, 13),
('Bandung', 'bandung', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=600&q=80', 9, 4.6, 14),
('Kalidawir', 'kalidawir', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=600&q=80', 16, 4.7, 15),
('Ngunut', 'ngunut', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=600&q=80', 20, 4.8, 16),
('Rejotangan', 'rejotangan', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=600&q=80', 17, 4.6, 17),
('Pucanglaban', 'pucanglaban', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=600&q=80', 5, 4.5, 18),
('Tanggunggunung', 'tanggunggunung', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=600&q=80', 4, 4.4, 19);

-- ============================================================
-- SEED: Fasilitas
-- ============================================================
INSERT INTO `fasilitas` (`nama`, `icon`) VALUES
('AC', '❄️'),
('TV', '📺'),
('Lemari', '📦'),
('KM Dalam', '🚿'),
('Listrik Token', '💡'),
('Laundry', '🧺'),
('Meja Kursi', '🪑'),
('Parkir Motor', '🅿️'),
('Air PDAM', '🌊'),
('Kunci Digital', '🔐'),
('WiFi', '📶'),
('Kasur', '🛏️'),
('Dapur Bersama', '🍳'),
('CCTV', '🛡️');

-- ============================================================
-- SEED: Kos (3 per kecamatan = 57 entries)
-- ============================================================
INSERT INTO `kos` (`kecamatan_id`, `nama`, `alamat`, `tipe`, `harga`, `status`, `telepon`, `whatsapp`, `foto_1`, `foto_2`, `foto_3`) VALUES
-- Kec. Tulungagung (id=1)
(1, 'Kos Permata', 'Jl. Mayor Sujadi No. 45, RT 02/RW 03, Kec. Tulungagung, Tulungagung', 'putri', 600000, 'tersedia', '081234567801', '6281234567801', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80'),
(1, 'Kos Mutiara Residence', 'Jl. Pangeran Diponegoro No. 12, RT 01/RW 05, Kec. Tulungagung, Tulungagung', 'putra', 850000, 'tersedia', '081234567802', '6281234567802', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80'),
(1, 'Kos Zamrud', 'Jl. KH. Agus Salim No. 78, RT 03/RW 02, Kec. Tulungagung, Tulungagung', 'campur', 1200000, 'penuh', '081234567803', '6281234567803', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80'),
-- Kec. Boyolangu (id=2)
(2, 'Kos Dahlia', 'Jl. Raya Boyolangu No. 15, RT 04/RW 01, Kec. Boyolangu, Tulungagung', 'putri', 550000, 'tersedia', '081234567804', '6281234567804', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80'),
(2, 'Kos Kenanga', 'Jl. Veteran No. 52, RT 02/RW 03, Kec. Boyolangu, Tulungagung', 'putra', 700000, 'tersedia', '081234567805', '6281234567805', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80'),
(2, 'Kos Mawar Indah', 'Jl. Pahlawan No. 8, RT 01/RW 06, Kec. Boyolangu, Tulungagung', 'campur', 900000, 'penuh', '081234567806', '6281234567806', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80'),
-- Kec. Kedungwaru (id=3)
(3, 'Kos Anggrek', 'Jl. Raya Kedungwaru No. 20, RT 03/RW 04, Kec. Kedungwaru, Tulungagung', 'putri', 650000, 'tersedia', '081234567807', '6281234567807', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80'),
(3, 'Kos Cempaka', 'Jl. Soekarno-Hatta No. 35, RT 05/RW 02, Kec. Kedungwaru, Tulungagung', 'putra', 800000, 'tersedia', '081234567808', '6281234567808', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80'),
(3, 'Kos Modern Residence', 'Jl. Kartini No. 11, RT 01/RW 01, Kec. Kedungwaru, Tulungagung', 'campur', 1500000, 'tersedia', '081234567809', '6281234567809', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80'),
-- Kec. Ngantru (id=4)
(4, 'Kos Bougenville', 'Jl. Raya Ngantru No. 25, RT 02/RW 04, Kec. Ngantru, Tulungagung', 'putri', 450000, 'tersedia', '081234567810', '6281234567810', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80'),
(4, 'Kos Sentosa', 'Jl. Merdeka No. 40, RT 03/RW 01, Kec. Ngantru, Tulungagung', 'putra', 600000, 'tersedia', '081234567811', '6281234567811', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80'),
(4, 'Kos Asri', 'Jl. A. Yani No. 18, RT 01/RW 05, Kec. Ngantru, Tulungagung', 'campur', 750000, 'penuh', '081234567812', '6281234567812', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80'),
-- Kec. Kauman (id=5)
(5, 'Kos Flamboyan', 'Jl. Raya Kauman No. 30, RT 04/RW 02, Kec. Kauman, Tulungagung', 'putri', 500000, 'tersedia', '081234567813', '6281234567813', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80'),
(5, 'Kos Arjuna', 'Jl. Gajah Mada No. 22, RT 02/RW 03, Kec. Kauman, Tulungagung', 'putra', 700000, 'tersedia', '081234567814', '6281234567814', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80'),
(5, 'Kos Elegan', 'Jl. Sudirman No. 55, RT 01/RW 06, Kec. Kauman, Tulungagung', 'campur', 1000000, 'tersedia', '081234567815', '6281234567815', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80'),
-- Kec. Sumbergempol (id=6)
(6, 'Kos Sakura', 'Jl. Imam Bonjol No. 86, RT 04/RW 06, Kec. Sumbergempol, Tulungagung', 'putri', 500000, 'tersedia', '081277686350', '6281277686350', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80'),
(6, 'Kos Teratai', 'Jl. Veteran No. 97, RT 01/RW 05, Kec. Sumbergempol, Tulungagung', 'putra', 900000, 'penuh', '081286445760', '62812864457600', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80'),
(6, 'Kos Ungu Residence', 'Jl. Soekarno-Hatta No. 9, RT 07/RW 04, Kec. Sumbergempol, Tulungagung', 'campur', 1500000, 'tersedia', '081295205170', '62812952051700', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80'),
-- Kec. Karangrejo (id=7)
(7, 'Kos Pelangi', 'Jl. Raya Karangrejo No. 14, RT 03/RW 02, Kec. Karangrejo, Tulungagung', 'putri', 400000, 'tersedia', '081234567819', '6281234567819', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80'),
(7, 'Kos Bintang', 'Jl. Pahlawan No. 38, RT 01/RW 04, Kec. Karangrejo, Tulungagung', 'putra', 650000, 'tersedia', '081234567820', '6281234567820', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80'),
(7, 'Kos Grand Karangrejo', 'Jl. A. Yani No. 5, RT 05/RW 01, Kec. Karangrejo, Tulungagung', 'campur', 1100000, 'tersedia', '081234567821', '6281234567821', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80'),
-- Kec. Gondang (id=8)
(8, 'Kos Melati', 'Jl. Raya Gondang No. 27, RT 02/RW 03, Kec. Gondang, Tulungagung', 'putri', 500000, 'tersedia', '081234567822', '6281234567822', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80'),
(8, 'Kos Sejahtera', 'Jl. Merdeka No. 60, RT 04/RW 05, Kec. Gondang, Tulungagung', 'putra', 750000, 'penuh', '081234567823', '6281234567823', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80'),
(8, 'Kos Nyaman Residence', 'Jl. Kartini No. 15, RT 01/RW 01, Kec. Gondang, Tulungagung', 'campur', 1000000, 'tersedia', '081234567824', '6281234567824', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80'),
-- Kec. Sendang (id=9)
(9, 'Kos Matahari', 'Jl. Raya Sendang No. 10, RT 03/RW 02, Kec. Sendang, Tulungagung', 'putri', 400000, 'tersedia', '081234567825', '6281234567825', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80'),
(9, 'Kos Wisma Sendang', 'Jl. Diponegoro No. 32, RT 02/RW 04, Kec. Sendang, Tulungagung', 'putra', 600000, 'tersedia', '081234567826', '6281234567826', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80'),
(9, 'Kos Tenteram', 'Jl. Imam Bonjol No. 50, RT 01/RW 06, Kec. Sendang, Tulungagung', 'campur', 800000, 'tersedia', '081234567827', '6281234567827', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80'),
-- Kec. Pagerwojo (id=10)
(10, 'Kos Bulan', 'Jl. Raya Pagerwojo No. 8, RT 04/RW 03, Kec. Pagerwojo, Tulungagung', 'putri', 350000, 'tersedia', '081234567828', '6281234567828', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80'),
(10, 'Kos Pondok Damai', 'Jl. Veteran No. 20, RT 02/RW 01, Kec. Pagerwojo, Tulungagung', 'putra', 500000, 'tersedia', '081234567829', '6281234567829', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80'),
(10, 'Kos Langit', 'Jl. Sudirman No. 12, RT 01/RW 05, Kec. Pagerwojo, Tulungagung', 'campur', 700000, 'penuh', '081234567830', '6281234567830', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80'),
-- Kec. Campurdarat (id=11)
(11, 'Kos Ruby', 'Jl. Raya Campurdarat No. 35, RT 03/RW 04, Kec. Campurdarat, Tulungagung', 'putri', 550000, 'tersedia', '081234567831', '6281234567831', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80'),
(11, 'Kos Safir', 'Jl. A. Yani No. 48, RT 05/RW 02, Kec. Campurdarat, Tulungagung', 'putra', 700000, 'tersedia', '081234567832', '6281234567832', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80'),
(11, 'Kos Premium House', 'Jl. Kartini No. 22, RT 01/RW 06, Kec. Campurdarat, Tulungagung', 'campur', 1200000, 'tersedia', '081234567833', '6281234567833', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80'),
-- Kec. Besuki (id=12)
(12, 'Kos Topaz', 'Jl. Raya Besuki No. 18, RT 02/RW 03, Kec. Besuki, Tulungagung', 'putri', 500000, 'tersedia', '081234567834', '6281234567834', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80'),
(12, 'Kos Opal', 'Jl. Diponegoro No. 44, RT 04/RW 01, Kec. Besuki, Tulungagung', 'putra', 650000, 'penuh', '081234567835', '6281234567835', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80'),
(12, 'Kos Jade Residence', 'Jl. Gajah Mada No. 7, RT 01/RW 05, Kec. Besuki, Tulungagung', 'campur', 950000, 'tersedia', '081234567836', '6281234567836', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80'),
-- Kec. Pakel (id=13)
(13, 'Kos Emerald', 'Jl. Raya Pakel No. 25, RT 03/RW 02, Kec. Pakel, Tulungagung', 'putri', 450000, 'tersedia', '081234567837', '6281234567837', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80'),
(13, 'Kos Srikandi', 'Jl. Veteran No. 33, RT 02/RW 04, Kec. Pakel, Tulungagung', 'putra', 600000, 'tersedia', '081234567838', '6281234567838', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80'),
(13, 'Kos Deluxe Pakel', 'Jl. Sudirman No. 19, RT 01/RW 06, Kec. Pakel, Tulungagung', 'campur', 900000, 'tersedia', '081234567839', '6281234567839', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80'),
-- Kec. Bandung (id=14)
(14, 'Kos Berlian', 'Jl. Raya Bandung No. 30, RT 04/RW 01, Kec. Bandung, Tulungagung', 'putri', 500000, 'tersedia', '081234567840', '6281234567840', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80'),
(14, 'Kos Nakula', 'Jl. Pahlawan No. 15, RT 02/RW 03, Kec. Bandung, Tulungagung', 'putra', 700000, 'penuh', '081234567841', '6281234567841', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80'),
(14, 'Kos Exclusive Bandung', 'Jl. A. Yani No. 42, RT 01/RW 05, Kec. Bandung, Tulungagung', 'campur', 1100000, 'tersedia', '081234567842', '6281234567842', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80'),
-- Kec. Kalidawir (id=15)
(15, 'Kos Sadewa', 'Jl. Raya Kalidawir No. 20, RT 03/RW 04, Kec. Kalidawir, Tulungagung', 'putri', 450000, 'tersedia', '081234567843', '6281234567843', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80'),
(15, 'Kos Pandu', 'Jl. Merdeka No. 28, RT 05/RW 02, Kec. Kalidawir, Tulungagung', 'putra', 650000, 'tersedia', '081234567844', '6281234567844', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80'),
(15, 'Kos Grand Kalidawir', 'Jl. Kartini No. 35, RT 01/RW 01, Kec. Kalidawir, Tulungagung', 'campur', 1000000, 'tersedia', '081234567845', '6281234567845', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80'),
-- Kec. Ngunut (id=16)
(16, 'Kos Jasmine', 'Jl. Raya Ngunut No. 40, RT 02/RW 03, Kec. Ngunut, Tulungagung', 'putri', 550000, 'tersedia', '081234567846', '6281234567846', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80'),
(16, 'Kos Bahagia', 'Jl. Diponegoro No. 55, RT 04/RW 05, Kec. Ngunut, Tulungagung', 'putra', 800000, 'penuh', '081234567847', '6281234567847', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80'),
(16, 'Kos Modern Ngunut', 'Jl. Imam Bonjol No. 18, RT 01/RW 01, Kec. Ngunut, Tulungagung', 'campur', 1300000, 'tersedia', '081234567848', '6281234567848', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80'),
-- Kec. Rejotangan (id=17)
(17, 'Kos Lavender', 'Jl. Raya Rejotangan No. 22, RT 03/RW 02, Kec. Rejotangan, Tulungagung', 'putri', 500000, 'tersedia', '081234567849', '6281234567849', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80'),
(17, 'Kos Mandiri', 'Jl. Veteran No. 45, RT 02/RW 04, Kec. Rejotangan, Tulungagung', 'putra', 700000, 'tersedia', '081234567850', '6281234567850', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80'),
(17, 'Kos Wisma Rejotangan', 'Jl. Gajah Mada No. 30, RT 01/RW 06, Kec. Rejotangan, Tulungagung', 'campur', 950000, 'tersedia', '081234567851', '6281234567851', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80'),
-- Kec. Pucanglaban (id=18)
(18, 'Kos Orchid', 'Jl. Raya Pucanglaban No. 10, RT 04/RW 01, Kec. Pucanglaban, Tulungagung', 'putri', 400000, 'tersedia', '081234567852', '6281234567852', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80'),
(18, 'Kos Omah Pucanglaban', 'Jl. A. Yani No. 25, RT 02/RW 03, Kec. Pucanglaban, Tulungagung', 'putra', 550000, 'penuh', '081234567853', '6281234567853', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80'),
(18, 'Kos Damai', 'Jl. Sudirman No. 8, RT 01/RW 05, Kec. Pucanglaban, Tulungagung', 'campur', 700000, 'tersedia', '081234567854', '6281234567854', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80'),
-- Kec. Tanggunggunung (id=19)
(19, 'Kos Tulip', 'Jl. Raya Tanggunggunung No. 5, RT 03/RW 02, Kec. Tanggunggunung, Tulungagung', 'putri', 350000, 'tersedia', '081234567855', '6281234567855', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80'),
(19, 'Kos Jaya', 'Jl. Merdeka No. 15, RT 05/RW 04, Kec. Tanggunggunung, Tulungagung', 'putra', 500000, 'tersedia', '081234567856', '6281234567856', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80'),
(19, 'Kos Griya Gunung', 'Jl. Kartini No. 10, RT 01/RW 01, Kec. Tanggunggunung, Tulungagung', 'campur', 800000, 'tersedia', '081234567857', '6281234567857', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80');

-- ============================================================
-- SEED: Kos Fasilitas (pivot mappings)
-- Fasilitas IDs: 1=AC, 2=TV, 3=Lemari, 4=KM Dalam, 5=Listrik Token,
-- 6=Laundry, 7=Meja Kursi, 8=Parkir Motor, 9=Air PDAM, 10=Kunci Digital,
-- 11=WiFi, 12=Kasur, 13=Dapur Bersama, 14=CCTV
-- ============================================================
INSERT INTO `kos_fasilitas` (`kos_id`, `fasilitas_id`) VALUES
-- Kec. Tulungagung
(1,1),(1,11),       -- Permata: AC, WiFi
(2,4),(2,3),        -- Mutiara: KM Dalam, Lemari
(3,1),(3,4),(3,11), -- Zamrud: AC, KM Dalam, WiFi
-- Kec. Boyolangu
(4,3),(4,12),       -- Dahlia: Lemari, Kasur
(5,2),(5,8),        -- Kenanga: TV, Parkir Motor
(6,1),(6,4),        -- Mawar Indah: AC, KM Dalam
-- Kec. Kedungwaru
(7,11),(7,12),      -- Anggrek: WiFi, Kasur
(8,8),(8,3),        -- Cempaka: Parkir Motor, Lemari
(9,1),(9,4),(9,11), -- Modern Residence: AC, KM Dalam, WiFi
-- Kec. Ngantru
(10,3),(10,9),      -- Bougenville: Lemari, Air PDAM
(11,2),(11,12),     -- Sentosa: TV, Kasur
(12,11),(12,8),     -- Asri: WiFi, Parkir Motor
-- Kec. Kauman
(13,12),(13,3),     -- Flamboyan: Kasur, Lemari
(14,4),(14,8),      -- Arjuna: KM Dalam, Parkir Motor
(15,1),(15,11),(15,2), -- Elegan: AC, WiFi, TV
-- Kec. Sumbergempol
(16,1),(16,10),     -- Sakura: AC, Kunci Digital
(17,2),(17,3),      -- Teratai: TV, Lemari
(18,4),(18,5),      -- Ungu Residence: KM Dalam, Listrik Token
-- Kec. Karangrejo
(19,12),(19,9),     -- Pelangi: Kasur, Air PDAM
(20,2),(20,3),      -- Bintang: TV, Lemari
(21,1),(21,4),(21,11), -- Grand Karangrejo: AC, KM Dalam, WiFi
-- Kec. Gondang
(22,12),(22,3),     -- Melati: Kasur, Lemari
(23,4),(23,8),      -- Sejahtera: KM Dalam, Parkir Motor
(24,1),(24,11),     -- Nyaman Residence: AC, WiFi
-- Kec. Sendang
(25,12),(25,9),     -- Matahari: Kasur, Air PDAM
(26,3),(26,8),      -- Wisma Sendang: Lemari, Parkir Motor
(27,2),(27,11),     -- Tenteram: TV, WiFi
-- Kec. Pagerwojo
(28,12),(28,9),     -- Bulan: Kasur, Air PDAM
(29,3),(29,8),      -- Pondok Damai: Lemari, Parkir Motor
(30,4),(30,2),      -- Langit: KM Dalam, TV
-- Kec. Campurdarat
(31,12),(31,3),     -- Ruby: Kasur, Lemari
(32,2),(32,8),      -- Safir: TV, Parkir Motor
(33,1),(33,4),(33,11), -- Premium House: AC, KM Dalam, WiFi
-- Kec. Besuki
(34,12),(34,9),     -- Topaz: Kasur, Air PDAM
(35,3),(35,8),      -- Opal: Lemari, Parkir Motor
(36,4),(36,11),     -- Jade Residence: KM Dalam, WiFi
-- Kec. Pakel
(37,12),(37,3),     -- Emerald: Kasur, Lemari
(38,2),(38,9),      -- Srikandi: TV, Air PDAM
(39,1),(39,4),      -- Deluxe Pakel: AC, KM Dalam
-- Kec. Bandung
(40,12),(40,3),     -- Berlian: Kasur, Lemari
(41,4),(41,8),      -- Nakula: KM Dalam, Parkir Motor
(42,1),(42,11),(42,2), -- Exclusive Bandung: AC, WiFi, TV
-- Kec. Kalidawir
(43,12),(43,9),     -- Sadewa: Kasur, Air PDAM
(44,3),(44,8),      -- Pandu: Lemari, Parkir Motor
(45,1),(45,4),(45,11), -- Grand Kalidawir: AC, KM Dalam, WiFi
-- Kec. Ngunut
(46,12),(46,3),     -- Jasmine: Kasur, Lemari
(47,2),(47,4),      -- Bahagia: TV, KM Dalam
(48,1),(48,11),(48,8), -- Modern Ngunut: AC, WiFi, Parkir Motor
-- Kec. Rejotangan
(49,12),(49,3),     -- Lavender: Kasur, Lemari
(50,4),(50,8),      -- Mandiri: KM Dalam, Parkir Motor
(51,1),(51,2),(51,11), -- Wisma Rejotangan: AC, TV, WiFi
-- Kec. Pucanglaban
(52,12),(52,9),     -- Orchid: Kasur, Air PDAM
(53,3),(53,8),      -- Omah Pucanglaban: Lemari, Parkir Motor
(54,2),(54,11),     -- Damai: TV, WiFi
-- Kec. Tanggunggunung
(55,12),(55,9),     -- Tulip: Kasur, Air PDAM
(56,3),(56,8),      -- Jaya: Lemari, Parkir Motor
(57,4),(57,2);      -- Griya Gunung: KM Dalam, TV

-- ============================================================
-- NOTE: Admin user akan dibuat otomatis saat pertama kali
-- mengakses halaman admin. Default: admin / admin123
-- ============================================================
