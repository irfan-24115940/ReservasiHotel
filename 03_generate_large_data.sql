-- =============================================
-- 03. GENERATING DATA JUMLAH BESAR (UJI INDEXING)
-- =============================================

INSERT INTO kamar (id_tipe, nomor_kamar, status_kamar)
SELECT 
    t.id_tipe,
    'KM-' || gs,
    CASE 
        WHEN random() > 0.6 THEN 'Tersedia' 
        WHEN random() > 0.3 THEN 'Terisi' 
        ELSE 'Pemeliharaan' 
    END
FROM generate_series(1, 5000) AS gs
CROSS JOIN LATERAL (
    SELECT id_tipe FROM tipe_kamar ORDER BY random() LIMIT 1
) AS t;

-- Verifikasi Total Baris
SELECT COUNT(*) FROM kamar;