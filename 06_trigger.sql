-- =============================================
-- 06. TRIGGERS
-- =============================================

-- TRIGGER 1: AFTER INSERT (Otomatis update status kamar)
CREATE OR REPLACE FUNCTION fn_trg_update_status_kamar() 
RETURNS TRIGGER LANGUAGE plpgsql AS $$ 
BEGIN 
    UPDATE kamar SET status_kamar = 'Terisi' WHERE id_kamar = NEW.id_kamar; 
    RETURN NEW; 
END; 
$$; 

CREATE TRIGGER trg_update_status_kamar_after_reservasi 
AFTER INSERT ON reservasi 
FOR EACH ROW EXECUTE FUNCTION fn_trg_update_status_kamar();

-- TRIGGER 2: BEFORE UPDATE (Log perubahan email tamu)
CREATE OR REPLACE FUNCTION fn_trg_log_email_tamu() 
RETURNS TRIGGER LANGUAGE plpgsql AS $$ 
BEGIN 
    IF OLD.email <> NEW.email THEN 
        INSERT INTO log_aktivitas(aktivitas) 
        VALUES ('Tamu ID ' || OLD.id_tamu || ' merubah email dari ' || OLD.email || ' ke ' || NEW.email); 
    END IF; 
    RETURN NEW; 
END; 
$$;

CREATE TRIGGER trg_log_perubahan_email_tamu 
BEFORE UPDATE ON tamu 
FOR EACH ROW EXECUTE FUNCTION fn_trg_log_email_tamu();