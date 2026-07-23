-- =============================================
-- 04. STORED FUNCTIONS
-- =============================================

-- Function 1: Tanpa Parameter
CREATE OR REPLACE FUNCTION fn_total_kamar_tersedia()
RETURNS INT 
LANGUAGE plpgsql AS $$
DECLARE 
    total INT;
BEGIN
    SELECT COUNT(*) INTO total FROM kamar WHERE status_kamar = 'Tersedia';
    RETURN total;
END;
$$;

-- Function 2: Dengan 2 Parameter (Harga & Durasi Huni)
DROP FUNCTION IF EXISTS fn_hitung_biaya_menginap(NUMERIC, INT);

CREATE FUNCTION fn_hitung_biaya_menginap( 
    p_harga NUMERIC, 
    p_malam INT 
) 
RETURNS NUMERIC 
LANGUAGE plpgsql AS $$ 
BEGIN 
    RETURN p_harga * p_malam; 
END; 
$$;