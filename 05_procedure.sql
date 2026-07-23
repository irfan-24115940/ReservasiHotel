-- =============================================
-- 05. STORED PROCEDURES
-- =============================================

-- Procedure 1: Memakai CURSOR & Control Flow IF
CREATE OR REPLACE PROCEDURE sp_audit_kamar_pemeliharaan() 
LANGUAGE plpgsql AS $$ 
DECLARE 
    v_nomor VARCHAR(10); 
    v_status VARCHAR(20); 
    cur_kamar CURSOR FOR SELECT nomor_kamar, status_kamar FROM kamar; 
BEGIN 
    OPEN cur_kamar; 
    LOOP 
        FETCH cur_kamar INTO v_nomor, v_status; 
        EXIT WHEN NOT FOUND; 
        IF v_status = 'Pemeliharaan' THEN 
            INSERT INTO log_aktivitas(aktivitas) 
            VALUES ('PERINGATAN: Kamar Nomor ' || v_nomor || ' butuh perbaikan teknis!'); 
        END IF; 
    END LOOP; 
    CLOSE cur_kamar; 
END; 
$$;

-- Procedure 2: Parameter INOUT, CURSOR & Control Flow CASE
CREATE OR REPLACE PROCEDURE sp_hitung_total_reservasi_tamu( 
    p_id_tamu INT, 
    INOUT p_total_akhir NUMERIC DEFAULT 0 
) 
LANGUAGE plpgsql AS $$ 
DECLARE 
    v_biaya NUMERIC; 
    v_total_sementara NUMERIC := 0; 
    v_status_member VARCHAR(20); 
    cur_reservasi CURSOR FOR 
        SELECT total_biaya FROM reservasi 
        WHERE id_tamu = p_id_tamu AND status_reservasi = 'Completed'; 
BEGIN 
    SELECT status_member INTO v_status_member FROM tamu WHERE id_tamu = p_id_tamu; 
    OPEN cur_reservasi; 
    LOOP 
        FETCH cur_reservasi INTO v_biaya; 
        EXIT WHEN NOT FOUND; 
        v_total_sementara := v_total_sementara + v_biaya; 
    END LOOP; 
    CLOSE cur_reservasi; 
    
    CASE v_status_member 
        WHEN 'VIP' THEN 
            p_total_akhir := v_total_sementara * 0.90; 
        ELSE 
            p_total_akhir := v_total_sementara; 
    END CASE; 
END; 
$$;