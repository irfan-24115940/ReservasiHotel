
DELIMITER $$
CREATE PROCEDURE generate_kamar()
BEGIN
    DECLARE i INT DEFAULT 1;
    WHILE i <= 5000 DO
        INSERT INTO kamar (id_tipe, nomor_kamar, status_kamar)
        VALUES (
            FLOOR(1 + RAND() * 10),
            CONCAT('KM-', i),
            CASE
                WHEN RAND() > 0.6 THEN 'Tersedia'
                WHEN RAND() > 0.3 THEN 'Terisi'
                ELSE 'Pemeliharaan'
            END
        );
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER ;

-- Eksekusi generator data kamar
CALL generate_kamar();