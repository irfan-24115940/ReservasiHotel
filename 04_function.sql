-- Function 1: Tanpa Parameter (Hitung Kamar Tersedia)
DELIMITER $$
CREATE FUNCTION fn_total_kamar_tersedia()
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE total INT;
    SELECT COUNT(*) INTO total
    FROM kamar
    WHERE status_kamar = 'Tersedia';
    RETURN total;
END$$
DELIMITER ;

-- Function 2: 2 Parameter (Estimasi Biaya Menginap)
DROP FUNCTION IF EXISTS fn_hitung_biaya_menginap;
DELIMITER $$
CREATE FUNCTION fn_hitung_biaya_menginap(
    p_harga DECIMAL(12,2),
    p_malam INT
)
RETURNS DECIMAL(12,2)
DETERMINISTIC
BEGIN
    RETURN p_harga * p_malam;
END$$
DELIMITER ;