-- =============================================
-- 07. INDEXES
-- =============================================

-- Composite Index via CREATE INDEX
CREATE INDEX idx_tipe_status ON kamar(id_tipe, status_kamar);

-- Composite Index via ALTER TABLE Constraint
ALTER TABLE reservasi ADD CONSTRAINT unique_tamu_checkin UNIQUE (id_tamu, tgl_checkin);