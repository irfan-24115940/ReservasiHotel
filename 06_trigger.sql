-- Trigger 1: AFTER INSERT (Update Status Kamar saat Reservasi)
DELIMITER $$
CREATE TRIGGER trg_update_status_kamar_after_reservasi
AFTER INSERT ON reservasi
FOR EACH ROW
BEGIN
    UPDATE kamar
    SET status_kamar = 'Terisi'
    WHERE id_kamar = NEW.id_kamar;
END$$
DELIMITER ;

-- Trigger 2: BEFORE UPDATE (Log Perubahan Email Tamu)
DELIMITER $$
CREATE TRIGGER trg_log_perubahan_email_tamu
BEFORE UPDATE ON tamu
FOR EACH ROW
BEGIN
    IF OLD.email <> NEW.email THEN
        INSERT INTO log_aktivitas (aktivitas)
        VALUES (
            CONCAT('Tamu ID ', OLD.id_tamu, ' mengubah email dari ', OLD.email, ' ke ', NEW.email)
        );
    END IF;
END$$
DELIMITER ;