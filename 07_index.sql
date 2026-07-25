-- Index via CREATE INDEX (Composite Index)
CREATE INDEX idx_tipe_status ON kamar (id_tipe, status_kamar);

-- Index via ALTER TABLE Constraint
ALTER TABLE reservasi 
ADD CONSTRAINT unique_tamu_checkin UNIQUE (id_tamu, tgl_checkin);