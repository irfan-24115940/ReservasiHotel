-- Pembuatan User
CREATE USER IF NOT EXISTS 'user_admin'@'localhost' IDENTIFIED BY 'AdminPass123!';
CREATE USER IF NOT EXISTS 'user_resepsionis'@'localhost' IDENTIFIED BY 'ResepsionisPass123!';
CREATE USER IF NOT EXISTS 'user_analis'@'localhost' IDENTIFIED BY 'AnalisPass123!';

-- Pembuatan Role
CREATE ROLE IF NOT EXISTS role_admin;
CREATE ROLE IF NOT EXISTS role_resepsionis;
CREATE ROLE IF NOT EXISTS role_analis;

-- =====================================================
-- Privilege Tabel
-- =====================================================

GRANT ALL PRIVILEGES
ON sistem_reservasi_hotel.*
TO role_admin;

GRANT SELECT, INSERT, UPDATE
ON sistem_reservasi_hotel.reservasi
TO role_resepsionis;

GRANT SELECT
ON sistem_reservasi_hotel.kamar
TO role_analis;

-- =====================================================
-- Privilege View
-- =====================================================

GRANT SELECT
ON sistem_reservasi_hotel.v_reservasi_selesai
TO role_admin;

GRANT SELECT
ON sistem_reservasi_hotel.v_kontak_tamu
TO role_resepsionis;

GRANT SELECT
ON sistem_reservasi_hotel.v_reservasi_selesai
TO role_analis;

-- =====================================================
-- Privilege Procedure
-- =====================================================

GRANT EXECUTE
ON PROCEDURE sistem_reservasi_hotel.sp_audit_kamar_pemeliharaan
TO role_admin;

GRANT EXECUTE
ON PROCEDURE sistem_reservasi_hotel.sp_hitung_total_reservasi_tamu
TO role_resepsionis;

GRANT EXECUTE
ON PROCEDURE sistem_reservasi_hotel.sp_audit_kamar_pemeliharaan
TO role_analis;

-- =====================================================
-- Privilege Function
-- =====================================================

GRANT EXECUTE
ON FUNCTION sistem_reservasi_hotel.fn_total_kamar_tersedia
TO role_resepsionis;

GRANT EXECUTE
ON FUNCTION sistem_reservasi_hotel.fn_hitung_biaya_menginap
TO role_analis;

-- =====================================================
-- Inisialisasi Role ke User
-- =====================================================

GRANT role_admin TO 'user_admin'@'localhost';
GRANT role_resepsionis TO 'user_resepsionis'@'localhost';
GRANT role_analis TO 'user_analis'@'localhost';