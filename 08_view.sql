-- =============================================
-- 08. VIEWS
-- =============================================

-- Horizontal View
CREATE VIEW v_reservasi_selesai AS 
SELECT * FROM reservasi WHERE status_reservasi = 'Completed';

-- Vertical View
CREATE VIEW v_kontak_tamu AS 
SELECT id_tamu, nama_lengkap, email FROM tamu;

-- View Inside View (Nested) dengan WITH CASCADED CHECK OPTION
CREATE VIEW v_kamar_tersedia AS
SELECT * FROM kamar
WHERE status_kamar = 'Tersedia'
WITH CASCADED CHECK OPTION;

CREATE VIEW v_kamar_tersedia_lantai1 AS
SELECT * FROM v_kamar_tersedia
WHERE nomor_kamar LIKE 'K1%'
WITH CASCADED CHECK OPTION;