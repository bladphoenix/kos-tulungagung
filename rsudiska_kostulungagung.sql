-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Jun 22, 2026 at 11:21 PM
-- Server version: 10.6.25-MariaDB-cll-lve
-- PHP Version: 8.4.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `rsudiska_kostulungagung`
--

-- --------------------------------------------------------

--
-- Table structure for table `admin`
--

CREATE TABLE `admin` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `nama_lengkap` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `admin`
--

INSERT INTO `admin` (`id`, `username`, `password`, `nama_lengkap`, `created_at`) VALUES
(1, 'admin', '$2y$12$m6CurUoNKg6MSTdxk7qNtewKJFxmOPDiuPNmXTnWb4Poo.aCW/E5C', 'Administrator', '2026-06-18 14:50:02');

-- --------------------------------------------------------

--
-- Table structure for table `fasilitas`
--

CREATE TABLE `fasilitas` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `icon` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `fasilitas`
--

INSERT INTO `fasilitas` (`id`, `nama`, `icon`) VALUES
(1, 'AC', '✅'),
(2, 'TV', '✅'),
(3, 'Lemari', '✅'),
(4, 'KM Dalam', '✅'),
(5, 'Listrik Token', '✅'),
(6, 'Laundry', '✅'),
(7, 'Meja Kursi', '✅'),
(8, 'Parkir Motor / Mobil', '✅'),
(9, 'Air PDAM', '✅'),
(10, 'Kunci Digital', '✅'),
(11, 'WiFi', '✅'),
(12, 'Kasur', '✅'),
(13, 'Dapur Bersama', '✅'),
(14, 'CCTV', '✅');

-- --------------------------------------------------------

--
-- Table structure for table `kecamatan`
--

CREATE TABLE `kecamatan` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `slug` varchar(100) NOT NULL,
  `foto_url` varchar(500) DEFAULT NULL,
  `jumlah_kos` int(11) DEFAULT 0,
  `rating` decimal(2,1) DEFAULT 0.0,
  `urutan` int(11) DEFAULT 0,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kecamatan`
--

INSERT INTO `kecamatan` (`id`, `nama`, `slug`, `foto_url`, `jumlah_kos`, `rating`, `urutan`, `created_at`, `updated_at`) VALUES
(1, 'Tulungagung', 'tulungagung', 'kec_1781796278_b394e5d1.png', 24, 4.8, 1, '2026-06-18 14:45:29', '2026-06-18 15:24:38'),
(2, 'Boyolangu', 'boyolangu', 'kec_1781797823_184c1ae3.webp', 18, 4.7, 2, '2026-06-18 14:45:29', '2026-06-18 15:50:23'),
(3, 'Kedungwaru', 'kedungwaru', 'kec_1781797868_fac17ed9.webp', 15, 4.8, 3, '2026-06-18 14:45:29', '2026-06-18 15:51:08'),
(4, 'Ngantru', 'ngantru', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=600&q=80', 12, 4.6, 4, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(5, 'Kauman', 'kauman', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=600&q=80', 9, 4.7, 5, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(6, 'Sumbergempol', 'sumbergempol', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=600&q=80', 8, 4.7, 6, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(7, 'Karangrejo', 'karangrejo', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=600&q=80', 11, 4.5, 7, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(8, 'Gondang', 'gondang', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=600&q=80', 13, 4.6, 8, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(9, 'Sendang', 'sendang', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=600&q=80', 7, 4.5, 9, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(10, 'Pagerwojo', 'pagerwojo', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=600&q=80', 6, 4.4, 10, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(11, 'Campurdarat', 'campurdarat', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=600&q=80', 10, 4.6, 11, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(12, 'Besuki', 'besuki', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=600&q=80', 14, 4.7, 12, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(13, 'Pakel', 'pakel', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=600&q=80', 8, 4.5, 13, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(14, 'Bandung', 'bandung', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=600&q=80', 9, 4.6, 14, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(15, 'Kalidawir', 'kalidawir', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=600&q=80', 16, 4.7, 15, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(16, 'Ngunut', 'ngunut', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=600&q=80', 20, 4.8, 16, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(17, 'Rejotangan', 'rejotangan', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=600&q=80', 17, 4.6, 17, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(18, 'Pucanglaban', 'pucanglaban', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=600&q=80', 5, 4.5, 18, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(19, 'Tanggunggunung', 'tanggunggunung', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=600&q=80', 4, 4.4, 19, '2026-06-18 14:45:29', '2026-06-18 14:45:29');

-- --------------------------------------------------------

--
-- Table structure for table `kos`
--

CREATE TABLE `kos` (
  `id` int(11) NOT NULL,
  `kecamatan_id` int(11) NOT NULL,
  `nama` varchar(200) NOT NULL,
  `alamat` mediumtext NOT NULL,
  `tipe` enum('putra','putri','campur') NOT NULL DEFAULT 'campur',
  `harga` int(11) NOT NULL DEFAULT 0,
  `status` enum('tersedia','penuh') NOT NULL DEFAULT 'tersedia',
  `rating` decimal(2,1) DEFAULT 4.5,
  `telepon` varchar(20) DEFAULT NULL,
  `whatsapp` varchar(20) DEFAULT NULL,
  `foto_1` varchar(500) DEFAULT NULL,
  `foto_2` varchar(500) DEFAULT NULL,
  `foto_3` varchar(500) DEFAULT NULL,
  `foto_4` varchar(500) DEFAULT NULL,
  `foto_5` varchar(500) DEFAULT NULL,
  `foto_6` varchar(500) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kos`
--

INSERT INTO `kos` (`id`, `kecamatan_id`, `nama`, `alamat`, `tipe`, `harga`, `status`, `rating`, `telepon`, `whatsapp`, `foto_1`, `foto_2`, `foto_3`, `foto_4`, `foto_5`, `foto_6`, `created_at`, `updated_at`) VALUES
(1, 1, 'Olive Kost', 'Jl. MT. Haryono Gg. 3 No.56C, Bago, Kec. Tulungagung, Kabupaten Tulungagung, Jawa Timur 66218', 'campur', 600000, 'tersedia', 4.5, '081234567801', '6281234567801', 'kos1_1781794946_f0f76d57.png', 'kos2_1781794947_9864da3d.png', 'kos3_1781794947_9575abb8.png', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 15:02:27'),
(2, 1, 'KOST BU GATOT', 'Kepatihan, Kec. Tulungagung, Kabupaten Tulungagung, Jawa Timur 66219', 'campur', 950000, 'tersedia', 4.5, '081234567802', '6281234567802', 'kos1_1781795839_cc64151a.png', 'kos2_1781795839_687e434e.png', 'kos3_1781795839_c05478f6.png', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 15:17:19'),
(3, 1, 'Kinara Kost', 'Jl. Urip Sumoharjo, Kepatihan, Kec. Tulungagung, Kabupaten Tulungagung, Jawa Timur 66219', 'campur', 1200000, 'penuh', 4.5, '081234567803', '6281234567803', 'kos1_1781796121_e5d0a531.png', 'kos2_1781796121_602a498f.png', 'kos3_1781796121_79b5a708.png', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 15:22:01'),
(4, 2, 'Rumah kost 2 Puteri Al Istiqomah', 'Area Persawahan/ Perk, Tanjungsari, Kec. Boyolangu, Kabupaten Tulungagung, Jawa Timur 66235', 'putri', 550000, 'tersedia', 4.5, '081234567804', '6281234567804', 'kos1_1781798095_5856a014.png', 'kos2_1781798095_0c29ab72.png', 'kos3_1781798095_aa316f08.png', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 15:54:55'),
(5, 2, 'Rumah Kost Tiga Putra', 'Jl. HOS Cokroaminoto, Moyoketen, Kec. Boyolangu, Kabupaten Tulungagung, Jawa Timur 66235', 'putra', 700000, 'tersedia', 4.5, '081234567805', '6281234567805', 'kos1_1781798278_d7e560fd.png', 'kos2_1781798278_677f6cfa.png', 'kos3_1781798278_931c82c9.png', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 15:57:58'),
(6, 2, 'Titik Nol Kost', 'Jl. Tanjung No.11, dusun Pelem, Serut, Kec. Boyolangu, Kabupaten Tulungagung, Jawa Timur 66235', 'campur', 900000, 'penuh', 4.5, '081234567806', '6281234567806', 'kos1_1781798415_a76dc19e.png', 'kos2_1781798415_97e81ba4.png', 'kos3_1781798415_6aa94938.png', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 16:00:15'),
(7, 3, 'Arra inn Kost & Guest House', 'Jl. MT Haryono, Wadu Jaya, Kedungwaru, Kec. Kedungwaru, Kabupaten Tulungagung, Jawa Timur 66229', 'campur', 850000, 'tersedia', 4.5, '081234567807', '6281234567807', 'kos1_1781802927_1b840e92.png', 'kos2_1781802927_36673789.png', 'kos3_1781802927_05438246.png', 'kos4_1781802927_c447a7d9.png', 'kos5_1781802927_dd49e839.png', 'kos6_1781802927_2d24a2dc.png', '2026-06-18 14:45:29', '2026-06-18 17:15:27'),
(8, 3, 'Kos Cempaka', 'Jl. Soekarno-Hatta No. 35, RT 05/RW 02, Kec. Kedungwaru, Tulungagung', 'putra', 800000, 'tersedia', 4.5, '081234567808', '6281234567808', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(9, 3, 'Kos Modern Residence', 'Jl. Kartini No. 11, RT 01/RW 01, Kec. Kedungwaru, Tulungagung', 'campur', 1500000, 'tersedia', 4.5, '081234567809', '6281234567809', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(10, 4, 'Kos Bougenville', 'Jl. Raya Ngantru No. 25, RT 02/RW 04, Kec. Ngantru, Tulungagung', 'putri', 450000, 'tersedia', 4.5, '081234567810', '6281234567810', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(11, 4, 'Kos Sentosa', 'Jl. Merdeka No. 40, RT 03/RW 01, Kec. Ngantru, Tulungagung', 'putra', 600000, 'tersedia', 4.5, '081234567811', '6281234567811', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(12, 4, 'Kos Asri', 'Jl. A. Yani No. 18, RT 01/RW 05, Kec. Ngantru, Tulungagung', 'campur', 750000, 'penuh', 4.5, '081234567812', '6281234567812', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(13, 5, 'Kos Flamboyan', 'Jl. Raya Kauman No. 30, RT 04/RW 02, Kec. Kauman, Tulungagung', 'putri', 500000, 'tersedia', 4.5, '081234567813', '6281234567813', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(14, 5, 'Kos Arjuna', 'Jl. Gajah Mada No. 22, RT 02/RW 03, Kec. Kauman, Tulungagung', 'putra', 700000, 'tersedia', 4.5, '081234567814', '6281234567814', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(15, 5, 'Kos Elegan', 'Jl. Sudirman No. 55, RT 01/RW 06, Kec. Kauman, Tulungagung', 'campur', 1000000, 'tersedia', 4.5, '081234567815', '6281234567815', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(16, 6, 'Kos Sakura', 'Jl. Imam Bonjol No. 86, RT 04/RW 06, Kec. Sumbergempol, Tulungagung', 'putri', 500000, 'tersedia', 4.5, '081277686350', '6281277686350', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(17, 6, 'Kos Teratai', 'Jl. Veteran No. 97, RT 01/RW 05, Kec. Sumbergempol, Tulungagung', 'putra', 900000, 'penuh', 4.5, '081286445760', '62812864457600', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(18, 6, 'Kos Ungu Residence', 'Jl. Soekarno-Hatta No. 9, RT 07/RW 04, Kec. Sumbergempol, Tulungagung', 'campur', 1500000, 'tersedia', 4.5, '081295205170', '62812952051700', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(19, 7, 'Kos Pelangi', 'Jl. Raya Karangrejo No. 14, RT 03/RW 02, Kec. Karangrejo, Tulungagung', 'putri', 400000, 'tersedia', 4.5, '081234567819', '6281234567819', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(20, 7, 'Kos Bintang', 'Jl. Pahlawan No. 38, RT 01/RW 04, Kec. Karangrejo, Tulungagung', 'putra', 650000, 'tersedia', 4.5, '081234567820', '6281234567820', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(21, 7, 'Kos Grand Karangrejo', 'Jl. A. Yani No. 5, RT 05/RW 01, Kec. Karangrejo, Tulungagung', 'campur', 1100000, 'tersedia', 4.5, '081234567821', '6281234567821', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(22, 8, 'Kos Melati', 'Jl. Raya Gondang No. 27, RT 02/RW 03, Kec. Gondang, Tulungagung', 'putri', 500000, 'tersedia', 4.5, '081234567822', '6281234567822', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(23, 8, 'Kos Sejahtera', 'Jl. Merdeka No. 60, RT 04/RW 05, Kec. Gondang, Tulungagung', 'putra', 750000, 'penuh', 4.5, '081234567823', '6281234567823', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(24, 8, 'Kos Nyaman Residence', 'Jl. Kartini No. 15, RT 01/RW 01, Kec. Gondang, Tulungagung', 'campur', 1000000, 'tersedia', 4.5, '081234567824', '6281234567824', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(25, 9, 'Kos Matahari', 'Jl. Raya Sendang No. 10, RT 03/RW 02, Kec. Sendang, Tulungagung', 'putri', 400000, 'tersedia', 4.5, '081234567825', '6281234567825', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(26, 9, 'Kos Wisma Sendang', 'Jl. Diponegoro No. 32, RT 02/RW 04, Kec. Sendang, Tulungagung', 'putra', 600000, 'tersedia', 4.5, '081234567826', '6281234567826', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(27, 9, 'Kos Tenteram', 'Jl. Imam Bonjol No. 50, RT 01/RW 06, Kec. Sendang, Tulungagung', 'campur', 800000, 'tersedia', 4.5, '081234567827', '6281234567827', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(28, 10, 'Kos Bulan', 'Jl. Raya Pagerwojo No. 8, RT 04/RW 03, Kec. Pagerwojo, Tulungagung', 'putri', 350000, 'tersedia', 4.5, '081234567828', '6281234567828', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(29, 10, 'Kos Pondok Damai', 'Jl. Veteran No. 20, RT 02/RW 01, Kec. Pagerwojo, Tulungagung', 'putra', 500000, 'tersedia', 4.5, '081234567829', '6281234567829', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(30, 10, 'Kos Langit', 'Jl. Sudirman No. 12, RT 01/RW 05, Kec. Pagerwojo, Tulungagung', 'campur', 700000, 'penuh', 4.5, '081234567830', '6281234567830', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(31, 11, 'Kos Ruby', 'Jl. Raya Campurdarat No. 35, RT 03/RW 04, Kec. Campurdarat, Tulungagung', 'putri', 550000, 'tersedia', 4.5, '081234567831', '6281234567831', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(32, 11, 'Kos Safir', 'Jl. A. Yani No. 48, RT 05/RW 02, Kec. Campurdarat, Tulungagung', 'putra', 700000, 'tersedia', 4.5, '081234567832', '6281234567832', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(33, 11, 'Kos Premium House', 'Jl. Kartini No. 22, RT 01/RW 06, Kec. Campurdarat, Tulungagung', 'campur', 1200000, 'tersedia', 4.5, '081234567833', '6281234567833', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(34, 12, 'Kos Topaz', 'Jl. Raya Besuki No. 18, RT 02/RW 03, Kec. Besuki, Tulungagung', 'putri', 500000, 'tersedia', 4.5, '081234567834', '6281234567834', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(35, 12, 'Kos Opal', 'Jl. Diponegoro No. 44, RT 04/RW 01, Kec. Besuki, Tulungagung', 'putra', 650000, 'penuh', 4.5, '081234567835', '6281234567835', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(36, 12, 'Kos Jade Residence', 'Jl. Gajah Mada No. 7, RT 01/RW 05, Kec. Besuki, Tulungagung', 'campur', 950000, 'tersedia', 4.5, '081234567836', '6281234567836', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(37, 13, 'Kos Emerald', 'Jl. Raya Pakel No. 25, RT 03/RW 02, Kec. Pakel, Tulungagung', 'putri', 450000, 'tersedia', 4.5, '081234567837', '6281234567837', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(38, 13, 'Kos Srikandi', 'Jl. Veteran No. 33, RT 02/RW 04, Kec. Pakel, Tulungagung', 'putra', 600000, 'tersedia', 4.5, '081234567838', '6281234567838', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(39, 13, 'Kos Deluxe Pakel', 'Jl. Sudirman No. 19, RT 01/RW 06, Kec. Pakel, Tulungagung', 'campur', 900000, 'tersedia', 4.5, '081234567839', '6281234567839', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(40, 14, 'Kos Berlian', 'Jl. Raya Bandung No. 30, RT 04/RW 01, Kec. Bandung, Tulungagung', 'putri', 500000, 'tersedia', 4.5, '081234567840', '6281234567840', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(41, 14, 'Kos Nakula', 'Jl. Pahlawan No. 15, RT 02/RW 03, Kec. Bandung, Tulungagung', 'putra', 700000, 'penuh', 4.5, '081234567841', '6281234567841', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(42, 14, 'Kos Exclusive Bandung', 'Jl. A. Yani No. 42, RT 01/RW 05, Kec. Bandung, Tulungagung', 'campur', 1100000, 'tersedia', 4.5, '081234567842', '6281234567842', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(43, 15, 'Kos Sadewa', 'Jl. Raya Kalidawir No. 20, RT 03/RW 04, Kec. Kalidawir, Tulungagung', 'putri', 450000, 'tersedia', 4.5, '081234567843', '6281234567843', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(44, 15, 'Kos Pandu', 'Jl. Merdeka No. 28, RT 05/RW 02, Kec. Kalidawir, Tulungagung', 'putra', 650000, 'tersedia', 4.5, '081234567844', '6281234567844', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(45, 15, 'Kos Grand Kalidawir', 'Jl. Kartini No. 35, RT 01/RW 01, Kec. Kalidawir, Tulungagung', 'campur', 1000000, 'tersedia', 4.5, '081234567845', '6281234567845', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(46, 16, 'Kos Jasmine', 'Jl. Raya Ngunut No. 40, RT 02/RW 03, Kec. Ngunut, Tulungagung', 'putri', 550000, 'tersedia', 4.5, '081234567846', '6281234567846', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(47, 16, 'Kos Bahagia', 'Jl. Diponegoro No. 55, RT 04/RW 05, Kec. Ngunut, Tulungagung', 'putra', 800000, 'penuh', 4.5, '081234567847', '6281234567847', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(48, 16, 'Kos Modern Ngunut', 'Jl. Imam Bonjol No. 18, RT 01/RW 01, Kec. Ngunut, Tulungagung', 'campur', 1300000, 'tersedia', 4.5, '081234567848', '6281234567848', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(49, 17, 'Kos Lavender', 'Jl. Raya Rejotangan No. 22, RT 03/RW 02, Kec. Rejotangan, Tulungagung', 'putri', 500000, 'tersedia', 4.5, '081234567849', '6281234567849', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(50, 17, 'Kos Mandiri', 'Jl. Veteran No. 45, RT 02/RW 04, Kec. Rejotangan, Tulungagung', 'putra', 700000, 'tersedia', 4.5, '081234567850', '6281234567850', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(51, 17, 'Kos Wisma Rejotangan', 'Jl. Gajah Mada No. 30, RT 01/RW 06, Kec. Rejotangan, Tulungagung', 'campur', 950000, 'tersedia', 4.5, '081234567851', '6281234567851', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(52, 18, 'Kos Orchid', 'Jl. Raya Pucanglaban No. 10, RT 04/RW 01, Kec. Pucanglaban, Tulungagung', 'putri', 400000, 'tersedia', 4.5, '081234567852', '6281234567852', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(53, 18, 'Kos Omah Pucanglaban', 'Jl. A. Yani No. 25, RT 02/RW 03, Kec. Pucanglaban, Tulungagung', 'putra', 550000, 'penuh', 4.5, '081234567853', '6281234567853', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1522771739844-6a9f6d5f14af?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1512917774080-9991f1c4c750?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(54, 18, 'Kos Damai', 'Jl. Sudirman No. 8, RT 01/RW 05, Kec. Pucanglaban, Tulungagung', 'campur', 700000, 'tersedia', 4.5, '081234567854', '6281234567854', 'https://images.unsplash.com/photo-1493663284031-b7e3aefcae8e?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1554995207-c18c203602cb?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1513694203232-719a280e022f?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(55, 19, 'Kos Tulip', 'Jl. Raya Tanggunggunung No. 5, RT 03/RW 02, Kec. Tanggunggunung, Tulungagung', 'putri', 350000, 'tersedia', 4.5, '081234567855', '6281234567855', 'https://images.unsplash.com/photo-1502672260266-1c1ef2d93688?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1584622650111-993a426fbf0a?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1598928506311-c55ded91a20c?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(56, 19, 'Kos Jaya', 'Jl. Merdeka No. 15, RT 05/RW 04, Kec. Tanggunggunung, Tulungagung', 'putra', 500000, 'tersedia', 4.5, '081234567856', '6281234567856', 'https://images.unsplash.com/photo-1484154218962-a197022b5858?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1524758631624-e2822e304c36?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1540518614846-7eded433c457?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(57, 19, 'Kos Griya Gunung', 'Jl. Kartini No. 10, RT 01/RW 01, Kec. Tanggunggunung, Tulungagung', 'campur', 800000, 'tersedia', 4.5, '081234567857', '6281234567857', 'https://images.unsplash.com/photo-1560185127-6ed189bf02f4?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560448204-61dc36dc98c8?auto=format&fit=crop&w=800&q=80', 'https://images.unsplash.com/photo-1560184897-ae75f418493e?auto=format&fit=crop&w=800&q=80', NULL, NULL, NULL, '2026-06-18 14:45:29', '2026-06-18 14:45:29'),
(58, 1, 'SKY GARDEN KOST 2', 'Kepatihan, Kec. Tulungagung, Kabupaten Tulungagung, Jawa Timur 66212', 'campur', 1000000, 'tersedia', 4.5, '081234567801', '6281234567801', 'kos1_1781797008_6ff29b9a.png', 'kos2_1781797008_506a2334.png', 'kos3_1781797008_130b2bbc.png', NULL, NULL, NULL, '2026-06-18 15:36:48', '2026-06-18 15:36:48'),
(59, 2, 'Cavendish - Rumah Kost', 'RT.002/RW.002, Dusun Selatan, Gedangsewu, Kec. Boyolangu, Kabupaten Tulungagung, Jawa Timur 66231', 'campur', 1000000, 'tersedia', 4.5, '081234567806', '6281234567806', 'kos1_1781798634_2f494a38.png', 'kos2_1781798634_3415d1ec.png', 'kos3_1781798634_c83cb0c2.png', NULL, NULL, NULL, '2026-06-18 16:03:54', '2026-06-18 16:03:54');

-- --------------------------------------------------------

--
-- Table structure for table `kos_fasilitas`
--

CREATE TABLE `kos_fasilitas` (
  `kos_id` int(11) NOT NULL,
  `fasilitas_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `kos_fasilitas`
--

INSERT INTO `kos_fasilitas` (`kos_id`, `fasilitas_id`) VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12),
(1, 13),
(1, 14),
(2, 1),
(2, 2),
(2, 3),
(2, 4),
(2, 5),
(2, 8),
(2, 9),
(2, 11),
(2, 12),
(2, 13),
(2, 14),
(3, 1),
(3, 3),
(3, 4),
(3, 5),
(3, 8),
(3, 11),
(3, 12),
(3, 14),
(4, 3),
(4, 4),
(4, 8),
(4, 9),
(4, 12),
(5, 8),
(5, 11),
(5, 12),
(6, 3),
(6, 4),
(6, 8),
(6, 11),
(6, 12),
(7, 3),
(7, 4),
(7, 7),
(7, 9),
(7, 11),
(7, 12),
(7, 14),
(8, 3),
(8, 8),
(9, 1),
(9, 4),
(9, 11),
(10, 3),
(10, 9),
(11, 2),
(11, 12),
(12, 8),
(12, 11),
(13, 3),
(13, 12),
(14, 4),
(14, 8),
(15, 1),
(15, 2),
(15, 11),
(16, 1),
(16, 10),
(17, 2),
(17, 3),
(18, 4),
(18, 5),
(19, 9),
(19, 12),
(20, 2),
(20, 3),
(21, 1),
(21, 4),
(21, 11),
(22, 3),
(22, 12),
(23, 4),
(23, 8),
(24, 1),
(24, 11),
(25, 9),
(25, 12),
(26, 3),
(26, 8),
(27, 2),
(27, 11),
(28, 9),
(28, 12),
(29, 3),
(29, 8),
(30, 2),
(30, 4),
(31, 3),
(31, 12),
(32, 2),
(32, 8),
(33, 1),
(33, 4),
(33, 11),
(34, 9),
(34, 12),
(35, 3),
(35, 8),
(36, 4),
(36, 11),
(37, 3),
(37, 12),
(38, 2),
(38, 9),
(39, 1),
(39, 4),
(40, 3),
(40, 12),
(41, 4),
(41, 8),
(42, 1),
(42, 2),
(42, 11),
(43, 9),
(43, 12),
(44, 3),
(44, 8),
(45, 1),
(45, 4),
(45, 11),
(46, 3),
(46, 12),
(47, 2),
(47, 4),
(48, 1),
(48, 8),
(48, 11),
(49, 3),
(49, 12),
(50, 4),
(50, 8),
(51, 1),
(51, 2),
(51, 11),
(52, 9),
(52, 12),
(53, 3),
(53, 8),
(54, 2),
(54, 11),
(55, 9),
(55, 12),
(56, 3),
(56, 8),
(57, 2),
(57, 4),
(58, 1),
(58, 3),
(58, 4),
(58, 5),
(58, 7),
(58, 8),
(58, 9),
(58, 11),
(58, 12),
(58, 14),
(59, 1),
(59, 3),
(59, 4),
(59, 5),
(59, 8),
(59, 9),
(59, 11),
(59, 12),
(59, 14);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admin`
--
ALTER TABLE `admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `fasilitas`
--
ALTER TABLE `fasilitas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kecamatan`
--
ALTER TABLE `kecamatan`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `kos`
--
ALTER TABLE `kos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `kecamatan_id` (`kecamatan_id`);

--
-- Indexes for table `kos_fasilitas`
--
ALTER TABLE `kos_fasilitas`
  ADD PRIMARY KEY (`kos_id`,`fasilitas_id`),
  ADD KEY `fasilitas_id` (`fasilitas_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admin`
--
ALTER TABLE `admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `fasilitas`
--
ALTER TABLE `fasilitas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT for table `kecamatan`
--
ALTER TABLE `kecamatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `kos`
--
ALTER TABLE `kos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=60;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `kos`
--
ALTER TABLE `kos`
  ADD CONSTRAINT `kos_ibfk_1` FOREIGN KEY (`kecamatan_id`) REFERENCES `kecamatan` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `kos_fasilitas`
--
ALTER TABLE `kos_fasilitas`
  ADD CONSTRAINT `kos_fasilitas_ibfk_1` FOREIGN KEY (`kos_id`) REFERENCES `kos` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `kos_fasilitas_ibfk_2` FOREIGN KEY (`fasilitas_id`) REFERENCES `fasilitas` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
