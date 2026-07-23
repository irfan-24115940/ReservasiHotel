-- =============================================
-- 09. DATABASE SECURITY (ROLES & PRIVILEGES)
-- =============================================

-- 1. Buat Role Group
CREATE ROLE role_admin; 
CREATE ROLE role_resepsionis; 
CREATE ROLE role_analis; 

-- 2. Buat User Login
CREATE ROLE user_admin WITH LOGIN PASSWORD 'AdminPass123!'; 
CREATE ROLE user_resepsionis WITH LOGIN PASSWORD 'ResepsionisPass123!'; 
CREATE ROLE user_analis WITH LOGIN PASSWORD 'AnalisPass123!';

-- 3. Pembagian Hak Akses Tabel & View
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO role_admin; 
GRANT SELECT, INSERT, UPDATE ON TABLE reservasi TO role_resepsionis; 
GRANT SELECT ON TABLE v_reservasi_selesai TO role_analis;

-- 4. Pembagian Hak Akses Procedure & Function
GRANT EXECUTE ON PROCEDURE sp_audit_kamar_pemeliharaan TO role_admin;
GRANT EXECUTE ON PROCEDURE sp_hitung_total_reservasi_tamu TO role_resepsionis;
GRANT EXECUTE ON FUNCTION fn_total_kamar_tersedia TO role_resepsionis;
GRANT EXECUTE ON FUNCTION fn_hitung_biaya_menginap TO role_analis;

-- 5. Inisialisasi Role ke User
GRANT role_admin TO user_admin; 
GRANT role_resepsionis TO user_resepsionis; 
GRANT role_analis TO user_analis;