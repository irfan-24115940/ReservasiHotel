-- Procedure 1: CURSOR & IF (Audit Kamar Pemeliharaan)
DELIMITER $$
CREATE PROCEDURE sp_audit_kamar_pemeliharaan()
BEGIN
    DECLARE selesai INT DEFAULT 0;
    DECLARE v_nomor VARCHAR(10);
    DECLARE v_status VARCHAR(20);
    DECLARE cur_kamar CURSOR FOR 
        SELECT nomor_kamar, status_kamar FROM kamar;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET selesai = 1;

    OPEN cur_kamar;
    baca_data: LOOP
        FETCH cur_kamar INTO v_nomor, v_status;
        IF selesai = 1 THEN
            LEAVE baca_data;
        END IF;
        IF v_status = 'Pemeliharaan' THEN
            INSERT INTO log_aktivitas (aktivitas)
            VALUES (CONCAT('PERINGATAN: Kamar Nomor ', v_nomor, ' butuh perbaikan teknis!'));
        END IF;
    END LOOP;
    CLOSE cur_kamar;
END$$
DELIMITER ;

-- Procedure 2: INOUT, CURSOR & CASE (Hitung Total Reservasi Tamu)
DELIMITER $$
CREATE PROCEDURE sp_hitung_total_reservasi_tamu(
    IN p_id_tamu INT,
    INOUT p_total_akhir DECIMAL(12,2)
)
BEGIN
    DECLARE selesai INT DEFAULT 0;
    DECLARE v_biaya DECIMAL(12,2);
    DECLARE v_total DECIMAL(12,2) DEFAULT 0;
    DECLARE v_status_member VARCHAR(20);
    DECLARE cur_reservasi CURSOR FOR
        SELECT total_biaya 
        FROM reservasi 
        WHERE id_tamu = p_id_tamu 
          AND status_reservasi = 'Completed';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET selesai = 1;

    SELECT status_member INTO v_status_member 
    FROM tamu 
    WHERE id_tamu = p_id_tamu;

    OPEN cur_reservasi;
    baca_data: LOOP
        FETCH cur_reservasi INTO v_biaya;
        IF selesai = 1 THEN
            LEAVE baca_data;
        END IF;
        SET v_total = v_total + v_biaya;
    END LOOP;
    CLOSE cur_reservasi;

    CASE
        WHEN v_status_member = 'VIP' THEN
            SET p_total_akhir = v_total * 0.9;
        ELSE
            SET p_total_akhir = v_total;
    END CASE;
END$$
DELIMITER ;