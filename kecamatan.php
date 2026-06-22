<?php
require_once __DIR__ . '/config/database.php';
require_once __DIR__ . '/config/app.php';

$db = getDB();

// Get slug from URL
$slug = isset($_GET['slug']) ? strtolower(trim($_GET['slug'])) : '';

if (empty($slug)) {
    header('Location: index.php');
    exit;
}

// Fetch kecamatan by slug
$stmt = $db->prepare("SELECT * FROM kecamatan WHERE slug = ?");
$stmt->execute([$slug]);
$kecamatan = $stmt->fetch();

if (!$kecamatan) {
    header('HTTP/1.0 404 Not Found');
    echo '<!DOCTYPE html><html><head><title>404</title></head><body style="font-family:sans-serif;text-align:center;padding:100px;background:#0d1225;color:#f0f4ff;">
    <h1>404 — Kecamatan Tidak Ditemukan</h1>
    <p style="color:rgba(240,244,255,0.5);">Kecamatan yang Anda cari tidak tersedia.</p>
    <a href="index.php" style="color:#82cfff;">← Kembali ke Beranda</a></body></html>';
    exit;
}

// Fetch kos for this kecamatan with fasilitas
$stmt = $db->prepare("
    SELECT k.*, 
           GROUP_CONCAT(DISTINCT CONCAT(f.icon, ' ', f.nama) SEPARATOR '||') as fasilitas_list
    FROM kos k
    LEFT JOIN kos_fasilitas kf ON k.id = kf.kos_id
    LEFT JOIN fasilitas f ON kf.fasilitas_id = f.id
    WHERE k.kecamatan_id = ?
    GROUP BY k.id
    ORDER BY k.created_at DESC
");
$stmt->execute([$kecamatan['id']]);
$kosList = $stmt->fetchAll();

$totalKos = count($kosList);
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kos Kecamatan <?= htmlspecialchars($kecamatan['nama']) ?> — Kost Tulungagung</title>
    <meta name="description" content="Daftar kos di Kecamatan <?= htmlspecialchars($kecamatan['nama']) ?>, Kabupaten Tulungagung. Temukan kos putra, putri, campur dengan fasilitas lengkap.">
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Nunito:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        :root{--bg-start:#0d1225;--accent:#82cfff;--accent2:#a78bfa;--green:#34d399;--glass:rgba(255,255,255,0.07);--glass-md:rgba(255,255,255,0.11);--glass-border:rgba(255,255,255,0.15);--glass-hover:rgba(130,207,255,0.4);--text:#f0f4ff;--text-muted:rgba(240,244,255,0.5);--text-sub:rgba(240,244,255,0.72);--card-shadow:0 20px 60px rgba(0,0,0,0.45);--r-card:24px;--r-sm:14px}
        *,*::before,*::after{margin:0;padding:0;box-sizing:border-box}
        body{font-family:'Nunito',sans-serif;background:var(--bg-start);min-height:100vh;color:var(--text);overflow-x:hidden}
        .bg-layer{position:fixed;inset:0;z-index:0;background:radial-gradient(ellipse 70% 60% at 15% 15%,#3b5fff40 0%,transparent 60%),radial-gradient(ellipse 55% 50% at 85% 85%,#7c3aed35 0%,transparent 60%),radial-gradient(ellipse 80% 70% at 50% 50%,#1a2560 0%,#0d1225 100%);animation:bgShift 14s ease-in-out infinite alternate}
        @keyframes bgShift{from{filter:hue-rotate(0deg) brightness(1)}to{filter:hue-rotate(12deg) brightness(1.08)}}
        .orb{position:fixed;border-radius:50%;filter:blur(80px);opacity:0.2;pointer-events:none;z-index:0;animation:floatOrb 18s ease-in-out infinite alternate}
        .orb-1{width:500px;height:500px;background:#60a5fa;top:-120px;left:-100px;animation-duration:14s}
        .orb-2{width:420px;height:420px;background:#a78bfa;bottom:-80px;right:-80px;animation-duration:20s}
        @keyframes floatOrb{from{transform:translate(0,0) scale(1)}to{transform:translate(35px,28px) scale(1.1)}}
        body::before{content:'';position:fixed;inset:0;z-index:1;background-image:url("data:image/svg+xml,%3Csvg viewBox='0 0 256 256' xmlns='http://www.w3.org/2000/svg'%3E%3Cfilter id='n'%3E%3CfeTurbulence type='fractalNoise' baseFrequency='0.9' numOctaves='4' stitchTiles='stitch'/%3E%3C/filter%3E%3Crect width='100%25' height='100%25' filter='url(%23n)' opacity='1'/%3E%3C/svg%3E");opacity:0.03;pointer-events:none}
        .wrapper{position:relative;z-index:2;max-width:1000px;margin:0 auto;padding:0 24px 80px}
        .page-header{padding:40px 0 30px;animation:fadeDown .8s cubic-bezier(.22,1,.36,1) both}
        @keyframes fadeDown{from{opacity:0;transform:translateY(-24px)}to{opacity:1;transform:translateY(0)}}
        .back-link{display:inline-flex;align-items:center;gap:8px;color:var(--text-muted);font-size:.85rem;font-weight:600;text-decoration:none;padding:8px 16px;background:var(--glass);border:1px solid var(--glass-border);border-radius:100px;backdrop-filter:blur(16px);transition:all .25s;margin-bottom:28px}
        .back-link:hover{color:var(--text);background:var(--glass-md);transform:translateX(-3px)}
        .header-kec{display:flex;align-items:flex-start;justify-content:space-between;flex-wrap:wrap;gap:16px}
        .kec-eyebrow{font-size:.75rem;font-weight:700;letter-spacing:.14em;text-transform:uppercase;color:var(--accent);margin-bottom:8px}
        .kec-h1{font-family:'Playfair Display',serif;font-size:clamp(2rem,5vw,3rem);font-weight:700;line-height:1.1;background:linear-gradient(135deg,#fff 30%,#82cfff 70%,#a78bfa 100%);-webkit-background-clip:text;-webkit-text-fill-color:transparent;background-clip:text}
        .kec-sub{color:var(--text-muted);font-size:.95rem;font-weight:500;margin-top:6px}
        .kec-stats{display:flex;flex-direction:column;align-items:flex-end;gap:8px}
        .stat-pill{background:var(--glass);border:1px solid var(--glass-border);backdrop-filter:blur(16px);border-radius:100px;padding:8px 20px;font-size:.82rem;font-weight:700;color:var(--text-muted);white-space:nowrap}
        .stat-pill strong{color:var(--text);margin-right:4px}
        .search-wrap{position:sticky;top:16px;z-index:50;margin-bottom:28px}
        .search-inner{position:relative}
        .search-icon{position:absolute;left:18px;top:50%;transform:translateY(-50%);color:var(--text-muted);pointer-events:none;display:flex}
        #searchInput{width:100%;padding:15px 18px 15px 48px;border-radius:100px;border:1px solid var(--glass-border);background:rgba(255,255,255,0.08);backdrop-filter:blur(30px);font-size:.95rem;font-family:'Nunito',sans-serif;font-weight:500;color:var(--text);outline:none;transition:all .35s;box-shadow:0 8px 32px rgba(0,0,0,.25)}
        #searchInput::placeholder{color:var(--text-muted)}
        #searchInput:focus{background:rgba(255,255,255,.13);border-color:rgba(130,207,255,.5);box-shadow:0 8px 40px rgba(10,132,255,.25),0 0 0 3px rgba(10,132,255,.12)}
        .section-label{font-size:.75rem;font-weight:700;letter-spacing:.12em;text-transform:uppercase;color:var(--text-muted);margin-bottom:18px;padding-left:2px}
        .kos-list{display:grid;grid-template-columns:repeat(auto-fit,minmax(350px,1fr));gap:24px;align-items:start}
        .kos-card{background:rgba(255,255,255,.05);border:1px solid var(--glass-border);border-radius:22px;overflow:hidden;transition:border-color .3s,transform .3s;animation:cardIn .6s both;animation-delay:calc(var(--ki)*80ms)}
        @keyframes cardIn{from{opacity:0;transform:translateY(24px)}to{opacity:1;transform:translateY(0)}}
        .kos-card:hover{border-color:var(--glass-hover);transform:translateY(-2px)}
        .kos-carousel{position:relative;overflow:hidden;height:260px}
        .kos-carousel-track{display:flex;height:100%;transition:transform .4s cubic-bezier(.22,1,.36,1)}
        .kos-carousel-img{min-width:100%;height:100%;object-fit:cover;display:block}
        .carousel-overlay{position:absolute;inset:0;background:linear-gradient(to bottom,transparent 50%,rgba(0,0,0,.6) 100%);pointer-events:none}
        .carousel-dots{position:absolute;bottom:14px;left:50%;transform:translateX(-50%);display:flex;gap:6px}
        .cdot{width:6px;height:6px;border-radius:50%;background:rgba(255,255,255,.4);transition:all .3s;cursor:pointer}
        .cdot.active{background:#fff;width:18px;border-radius:3px}
        .car-nav{position:absolute;top:50%;transform:translateY(-50%);width:34px;height:34px;border-radius:50%;background:rgba(0,0,0,.4);backdrop-filter:blur(8px);border:1px solid rgba(255,255,255,.15);display:flex;align-items:center;justify-content:center;cursor:pointer;color:#fff;transition:all .2s}
        .car-nav:hover{background:rgba(0,0,0,.7);transform:translateY(-50%) scale(1.1)}
        .car-prev{left:12px}.car-next{right:12px}
        .kos-price-badge{position:absolute;top:14px;left:14px;background:rgba(52,211,153,.9);backdrop-filter:blur(8px);border:1px solid rgba(255,255,255,.25);border-radius:100px;padding:6px 16px;font-weight:800;font-size:.85rem;color:#fff;pointer-events:none}
        .kos-status{position:absolute;top:14px;right:14px;border-radius:100px;padding:6px 16px;font-weight:700;font-size:.75rem;pointer-events:none}
        .kos-status.tersedia{background:rgba(10,132,255,.85);color:#fff;border:1px solid rgba(255,255,255,.2)}
        .kos-status.penuh{background:rgba(239,68,68,.8);color:#fff;border:1px solid rgba(255,255,255,.2)}
        .kos-info{padding:22px 24px 24px}
        .kos-name{font-family:'Playfair Display',serif;font-size:1.3rem;font-weight:700;color:var(--text);margin-bottom:8px}
        .kos-address{display:flex;align-items:flex-start;gap:7px;font-size:.83rem;color:var(--text-muted);font-weight:500;margin-bottom:16px;line-height:1.5}
        .kos-address svg{margin-top:2px;flex-shrink:0}
        .kos-fac-label{font-size:.7rem;font-weight:700;letter-spacing:.08em;text-transform:uppercase;color:var(--text-muted);margin-bottom:10px}
        .kos-facilities{display:grid;grid-template-columns:repeat(2,1fr);gap:6px;margin-bottom:18px}
        .fac-chip{display:flex;align-items:center;gap:6px;background:rgba(255,255,255,.04);border:1px solid rgba(255,255,255,.08);border-radius:8px;padding:7px 10px;font-size:.78rem;font-weight:600;color:var(--text-sub);transition:background .2s}
        .fac-chip:hover{background:rgba(255,255,255,.08)}
        .fac-chip .fac-icon{font-size:.9rem;width:20px;text-align:center;flex-shrink:0}
        .kos-divider{height:1px;background:var(--glass-border);margin:16px 0}
        .kos-bottom{display:flex;align-items:center;justify-content:space-between;gap:14px;flex-wrap:wrap}
        .price-main{font-size:1.3rem;font-weight:800;color:var(--green)}
        .price-period{font-size:.78rem;color:var(--text-muted);margin-top:2px}
        .kos-actions{display:flex;gap:10px}
        .kos-wa-btn,.kos-tel-btn{display:inline-flex;align-items:center;gap:7px;padding:11px 20px;border-radius:var(--r-sm);font-family:'Nunito',sans-serif;font-weight:700;font-size:.875rem;text-decoration:none;transition:all .25s;border:none;cursor:pointer}
        .kos-wa-btn{background:linear-gradient(135deg,#25d366,#128c7e);color:#fff;box-shadow:0 4px 16px rgba(37,211,102,.3)}
        .kos-wa-btn:hover{transform:translateY(-2px);box-shadow:0 8px 24px rgba(37,211,102,.45)}
        .kos-tel-btn{background:var(--glass-md);border:1px solid var(--glass-border)!important;color:var(--text)}
        .kos-tel-btn:hover{background:rgba(255,255,255,.16)}
        .no-results{display:none;text-align:center;padding:60px 20px;color:var(--text-muted);font-size:1rem;font-weight:500;line-height:1.8}
        .empty-state{text-align:center;padding:80px 20px;color:var(--text-muted)}
        .empty-state h3{font-size:1.3rem;margin-bottom:8px;color:var(--text)}
        footer{text-align:center;padding:40px 20px 0;color:var(--text-muted);font-size:.85rem;font-weight:500;border-top:1px solid var(--glass-border);margin-top:60px}
        footer span{color:var(--accent)}
        @media(max-width:768px){
            .kos-list{grid-template-columns:1fr}
            .page-header{padding:28px 0 20px}
            .kec-h1{font-size:1.8rem}
            .kec-stats{align-items:flex-start;flex-direction:row}
            .kos-carousel{height:200px}
            .kos-info{padding:16px 16px 18px}
            .kos-name{font-size:1.1rem}
            .kos-bottom{flex-direction:column;align-items:flex-start}
            .kos-actions{width:100%}
            .kos-wa-btn,.kos-tel-btn{flex:1;justify-content:center}
        }
        /* Lightbox */
        .lightbox{position:fixed;inset:0;z-index:9999;background:rgba(0,0,0,.92);backdrop-filter:blur(20px);display:none;align-items:center;justify-content:center;opacity:0;transition:opacity .3s ease}
        .lightbox.active{display:flex;opacity:1}
        .lightbox-close{position:absolute;top:20px;right:24px;width:44px;height:44px;border-radius:50%;background:rgba(255,255,255,.1);border:1px solid rgba(255,255,255,.15);display:flex;align-items:center;justify-content:center;cursor:pointer;color:#fff;font-size:1.3rem;transition:all .2s;z-index:10}
        .lightbox-close:hover{background:rgba(255,255,255,.2);transform:scale(1.1)}
        .lightbox-img{max-width:90vw;max-height:85vh;object-fit:contain;border-radius:12px;box-shadow:0 20px 60px rgba(0,0,0,.5);transition:transform .3s ease;user-select:none}
        .lightbox-nav{position:absolute;top:50%;transform:translateY(-50%);width:48px;height:48px;border-radius:50%;background:rgba(255,255,255,.1);border:1px solid rgba(255,255,255,.15);display:flex;align-items:center;justify-content:center;cursor:pointer;color:#fff;transition:all .2s;z-index:10}
        .lightbox-nav:hover{background:rgba(255,255,255,.25);transform:translateY(-50%) scale(1.1)}
        .lb-prev{left:24px}.lb-next{right:24px}
        .lightbox-counter{position:absolute;bottom:24px;left:50%;transform:translateX(-50%);color:rgba(255,255,255,.6);font-size:.85rem;font-weight:600;background:rgba(0,0,0,.4);padding:6px 16px;border-radius:100px}
    </style>
</head>
<body>
    <div class="bg-layer"></div>
    <div class="orb orb-1"></div>
    <div class="orb orb-2"></div>

    <div class="wrapper">
        <div class="page-header">
            <a href="index.php" class="back-link">
                <svg width="15" height="15" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path d="M19 12H5M12 5l-7 7 7 7"/></svg>
                Kembali ke Direktori
            </a>
            <div class="header-kec">
                <div class="kec-title-group">
                    <div class="kec-eyebrow">📍 Kabupaten Tulungagung</div>
                    <h1 class="kec-h1">Kecamatan <?= htmlspecialchars($kecamatan['nama']) ?></h1>
                    <p class="kec-sub">Daftar kos tersedia di wilayah ini</p>
                </div>
                <div class="kec-stats">
                    <div class="stat-pill"><strong><?= $totalKos ?></strong> Lokasi Kos</div>
                </div>
            </div>
        </div>

        <div class="search-wrap">
            <div class="search-inner">
                <span class="search-icon">
                    <svg width="17" height="17" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="11" cy="11" r="8"/><path d="m21 21-4.35-4.35"/></svg>
                </span>
                <input type="text" id="searchInput" placeholder="Cari nama kos, fasilitas, tipe…" oninput="searchFn()">
            </div>
        </div>

        <p class="section-label">Menampilkan <?= $totalKos ?> Kos</p>

        <div class="kos-list" id="kosList">
            <?php if (empty($kosList)): ?>
                <div class="empty-state">
                    <h3>🏠 Belum Ada Data Kos</h3>
                    <p>Data kos untuk kecamatan ini belum tersedia.</p>
                </div>
            <?php else: ?>
                <?php foreach ($kosList as $i => $kos): 
                    $photos = array_filter([$kos['foto_1'], $kos['foto_2'], $kos['foto_3'], $kos['foto_4'] ?? null, $kos['foto_5'] ?? null, $kos['foto_6'] ?? null]);
                    $photoCount = count($photos);
                    $fasilitas = $kos['fasilitas_list'] ? explode('||', $kos['fasilitas_list']) : [];
                    $tipeLabel = ucfirst($kos['tipe']);
                    $waNumber = $kos['whatsapp'] ?: preg_replace('/^0/', '62', $kos['telepon']);
                    $waText = urlencode("Halo, saya tertarik dengan {$kos['nama']}. Apakah masih tersedia?");
                ?>
                <div class="kos-card" style="--ki:<?= $i ?>" data-search="<?= strtolower(htmlspecialchars($kos['nama'] . ' ' . $kos['alamat'] . ' ' . $kos['tipe'] . ' ' . ($kos['fasilitas_list'] ?? ''))) ?>">
                    <div class="kos-carousel" data-slide="0">
                        <div class="kos-carousel-track">
                            <?php foreach ($photos as $pi => $foto): ?>
                            <img class="kos-carousel-img" src="<?= htmlspecialchars(getImageSrc($foto)) ?>" alt="Foto kamar" loading="lazy" onclick="openLightbox(this, event)" style="cursor:zoom-in">
                            <?php endforeach; ?>
                        </div>
                        <div class="carousel-overlay"></div>
                        <span class="kos-price-badge"><?= formatRupiah($kos['harga']) ?>/bulan</span>
                        <span class="kos-status <?= $kos['status'] ?>"><?= ucfirst($kos['status']) ?></span>
                        <?php if ($photoCount > 1): ?>
                        <button class="car-nav car-prev" onclick="slideCarousel(this,-1,event)">
                            <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path d="M15 18l-6-6 6-6"/></svg>
                        </button>
                        <button class="car-nav car-next" onclick="slideCarousel(this,1,event)">
                            <svg width="12" height="12" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path d="M9 18l6-6-6-6"/></svg>
                        </button>
                        <div class="carousel-dots">
                            <?php for ($d = 0; $d < $photoCount; $d++): ?>
                            <span class="cdot<?= $d === 0 ? ' active' : '' ?>" onclick="gotoSlide(this,<?= $d ?>,event)"></span>
                            <?php endfor; ?>
                        </div>
                        <?php endif; ?>
                    </div>
                    <div class="kos-info">
                        <div style="display:flex;align-items:center;justify-content:space-between;margin-bottom:8px">
                            <div class="kos-name" style="margin-bottom:0"><?= htmlspecialchars($kos['nama']) ?></div>
                            <span style="display:inline-flex;align-items:center;gap:4px;background:rgba(255,255,255,.08);border:1px solid rgba(255,255,255,.12);border-radius:100px;padding:4px 12px;font-size:.82rem;font-weight:700;color:#fbbf24;white-space:nowrap;">⭐ <?= number_format($kos['rating'] ?? 4.5, 1) ?></span>
                        </div>
                        <div class="kos-address">
                            <svg width="13" height="13" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 1 1 18 0z"/><circle cx="12" cy="10" r="3"/></svg>
                            <?= htmlspecialchars($kos['alamat']) ?>
                        </div>
                        <?php if (!empty($fasilitas)): ?>
                        <div class="kos-fac-label">Fasilitas</div>
                        <div class="kos-facilities">
                            <?php foreach ($fasilitas as $fas): 
                                $parts = explode(' ', trim($fas), 2);
                                $icon = $parts[0] ?? '';
                                $name = $parts[1] ?? $fas;
                            ?>
                            <div class="fac-chip"><span class="fac-icon"><?= $icon ?></span> <?= htmlspecialchars($name) ?></div>
                            <?php endforeach; ?>
                        </div>
                        <?php endif; ?>
                        <div class="kos-divider"></div>
                        <div class="kos-bottom">
                            <div class="kos-price-text">
                                <div class="price-main"><?= formatRupiah($kos['harga']) ?>/bulan</div>
                                <div class="price-period">Tipe Kos: <?= $tipeLabel ?></div>
                            </div>
                            <div class="kos-actions">
                                <?php if ($kos['telepon']): ?>
                                <a href="tel:<?= htmlspecialchars($kos['telepon']) ?>" class="kos-tel-btn">
                                    <svg width="14" height="14" fill="none" stroke="currentColor" stroke-width="2.2" viewBox="0 0 24 24"><path d="M22 16.92v3a2 2 0 0 1-2.18 2A19.79 19.79 0 0 1 11.77 19a19.5 19.5 0 0 1-6-6A19.79 19.79 0 0 1 3.08 4.18 2 2 0 0 1 5.07 2h3a2 2 0 0 1 2 1.72c.127.96.361 1.903.7 2.81a2 2 0 0 1-.45 2.11L9.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45c.907.339 1.85.573 2.81.7A2 2 0 0 1 23 17z"/></svg>
                                    Telepon
                                </a>
                                <?php endif; ?>
                                <a href="https://wa.me/<?= htmlspecialchars($waNumber) ?>?text=<?= $waText ?>" target="_blank" class="kos-wa-btn">
                                    <svg width="15" height="15" viewBox="0 0 24 24" fill="currentColor"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 0 1-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 0 1-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 0 1 2.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0 0 12.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 0 0 5.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 0 0-3.48-8.413Z"/></svg>
                                    WhatsApp
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <?php endforeach; ?>
            <?php endif; ?>
        </div>

        <div id="noResults" class="no-results">🔍 Kos tidak ditemukan.<br>Coba kata kunci lain.</div>

        <footer>© <?= date('Y') ?> <span>Kost Tulungagung.com</span> — Kecamatan <?= htmlspecialchars($kecamatan['nama']) ?></footer>
    </div>

    <!-- Lightbox Modal -->
    <div class="lightbox" id="lightbox" onclick="closeLightbox(event)">
        <button class="lightbox-close" onclick="closeLightbox(event)">&times;</button>
        <button class="lightbox-nav lb-prev" onclick="navLightbox(-1,event)">
            <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path d="M15 18l-6-6 6-6"/></svg>
        </button>
        <img class="lightbox-img" id="lbImg" src="" alt="Preview">
        <button class="lightbox-nav lb-next" onclick="navLightbox(1,event)">
            <svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2.5" viewBox="0 0 24 24"><path d="M9 18l6-6-6-6"/></svg>
        </button>
        <div class="lightbox-counter" id="lbCounter"></div>
    </div>

    <script>
    function slideCarousel(btn, dir, e) {
        if(e) e.stopPropagation();
        const c = btn.closest('.kos-carousel');
        const track = c.querySelector('.kos-carousel-track');
        const imgs = c.querySelectorAll('.kos-carousel-img');
        const dots = c.querySelectorAll('.cdot');
        let cur = parseInt(c.dataset.slide) || 0;
        cur = (cur + dir + imgs.length) % imgs.length;
        c.dataset.slide = cur;
        track.style.transform = `translateX(-${cur * 100}%)`;
        dots.forEach((d,i) => d.classList.toggle('active', i===cur));
    }
    function gotoSlide(dot, idx, e) {
        if(e) e.stopPropagation();
        const c = dot.closest('.kos-carousel');
        const track = c.querySelector('.kos-carousel-track');
        const dots = c.querySelectorAll('.cdot');
        c.dataset.slide = idx;
        track.style.transform = `translateX(-${idx * 100}%)`;
        dots.forEach((d,i) => d.classList.toggle('active', i===idx));
    }
    function searchFn() {
        const q = document.getElementById('searchInput').value.toLowerCase();
        const cards = document.querySelectorAll('.kos-card');
        const noRes = document.getElementById('noResults');
        let found = false;
        cards.forEach(c => {
            const txt = c.getAttribute('data-search');
            const show = txt.includes(q);
            c.style.display = show ? '' : 'none';
            if(show) found = true;
        });
        noRes.style.display = found ? 'none' : 'block';
    }
    // === LIGHTBOX ===
    let lbImages = [];
    let lbIndex = 0;

    function openLightbox(img, e) {
        if(e) e.stopPropagation();
        const card = img.closest('.kos-card');
        const allImgs = card.querySelectorAll('.kos-carousel-img');
        lbImages = Array.from(allImgs).map(i => i.src);
        lbIndex = lbImages.indexOf(img.src);
        if(lbIndex < 0) lbIndex = 0;
        showLbImage();
        document.getElementById('lightbox').classList.add('active');
        document.body.style.overflow = 'hidden';
    }

    function closeLightbox(e) {
        if(e && e.target !== e.currentTarget && !e.target.closest('.lightbox-close')) return;
        document.getElementById('lightbox').classList.remove('active');
        document.body.style.overflow = '';
    }

    function navLightbox(dir, e) {
        if(e) e.stopPropagation();
        lbIndex = (lbIndex + dir + lbImages.length) % lbImages.length;
        showLbImage();
    }

    function showLbImage() {
        document.getElementById('lbImg').src = lbImages[lbIndex];
        document.getElementById('lbCounter').textContent = (lbIndex + 1) + ' / ' + lbImages.length;
    }

    // Keyboard navigation
    document.addEventListener('keydown', function(e) {
        const lb = document.getElementById('lightbox');
        if(!lb.classList.contains('active')) return;
        if(e.key === 'Escape') closeLightbox({target: lb, currentTarget: lb});
        if(e.key === 'ArrowLeft') navLightbox(-1);
        if(e.key === 'ArrowRight') navLightbox(1);
    });
    </script>
</body>
</html>
