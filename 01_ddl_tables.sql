CREATE DATABASE IF NOT EXISTS sistem_reservasi_hotel;
USE sistem_reservasi_hotel;

-- 1. Tabel Master Tamu
CREATE TABLE IF NOT EXISTS tamu (
    id_tamu INT AUTO_INCREMENT PRIMARY KEY,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    status_member VARCHAR(20) DEFAULT 'Reguler' CHECK (status_member IN ('Reguler', 'VIP'))
);

-- 2. Tabel Profil Tamu (Relasi 1:1)
CREATE TABLE IF NOT EXISTS profil_tamu (
    id_tamu INT PRIMARY KEY,
    no_nik VARCHAR(20) UNIQUE NOT NULL,
    no_telepon VARCHAR(15) NOT NULL,
    alamat TEXT NOT NULL,
    FOREIGN KEY (id_tamu) REFERENCES tamu (id_tamu) ON DELETE CASCADE
);

-- 3. Tabel Tipe Kamar
CREATE TABLE IF NOT EXISTS tipe_kamar (
    id_tipe INT AUTO_INCREMENT PRIMARY KEY,
    nama_tipe VARCHAR(50) NOT NULL,
    harga_per_malam NUMERIC(12,2) NOT NULL
);

-- 4. Tabel Kamar (Relasi 1:N)
CREATE TABLE IF NOT EXISTS kamar (
    id_kamar INT AUTO_INCREMENT PRIMARY KEY,
    id_tipe INT NOT NULL,
    nomor_kamar VARCHAR(10) NOT NULL,
    status_kamar VARCHAR(20) DEFAULT 'Tersedia' CHECK (status_kamar IN ('Tersedia', 'Terisi', 'Pemeliharaan')),
    FOREIGN KEY (id_tipe) REFERENCES tipe_kamar (id_tipe) ON DELETE CASCADE
);

-- 5. Tabel Reservasi (Relasi 1:N)
CREATE TABLE IF NOT EXISTS reservasi (
    id_reservasi INT AUTO_INCREMENT PRIMARY KEY,
    id_tamu INT NOT NULL,
    id_kamar INT NOT NULL,
    tgl_checkin DATE NOT NULL,
    tgl_checkout DATE NOT NULL,
    total_biaya NUMERIC(12,2) DEFAULT 0,
    status_reservasi VARCHAR(20) DEFAULT 'Pending' CHECK (status_reservasi IN ('Pending', 'Confirmed', 'Checked In', 'Completed', 'Cancelled')),
    FOREIGN KEY (id_tamu) REFERENCES tamu (id_tamu) ON DELETE CASCADE,
    FOREIGN KEY (id_kamar) REFERENCES kamar (id_kamar) ON DELETE CASCADE
);

-- 6. Tabel Layanan Master
CREATE TABLE IF NOT EXISTS layanan (
    id_layanan INT AUTO_INCREMENT PRIMARY KEY,
    nama_layanan VARCHAR(100) NOT NULL,
    harga NUMERIC(12,2) NOT NULL
);

-- 7. Tabel Detail Layanan (Relasi N:M Composite Key)
CREATE TABLE IF NOT EXISTS detail_layanan_reservasi (
    id_reservasi INT NOT NULL,
    id_layanan INT NOT NULL,
    jumlah INT NOT NULL,
    subtotal NUMERIC(12,2) NOT NULL,
    PRIMARY KEY (id_reservasi, id_layanan),
    FOREIGN KEY (id_reservasi) REFERENCES reservasi (id_reservasi) ON DELETE CASCADE,
    FOREIGN KEY (id_layanan) REFERENCES layanan (id_layanan) ON DELETE CASCADE
);

-- 8. Tabel Log Aktivitas (Audit Log)
CREATE TABLE IF NOT EXISTS log_aktivitas (
    id_log INT AUTO_INCREMENT PRIMARY KEY,
    aktivitas VARCHAR(255) NOT NULL,
    waktu TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);