-- Metode 1: Composite Index via CREATE TABLE
CREATE TABLE log_index_demo (
    id_user INT,
    waktu_login DATETIME,
    aktivitas VARCHAR(100),
    PRIMARY KEY (id_user, waktu_login)
);

-- Metode 2: Composite Index via CREATE INDEX
CREATE INDEX idx_tipe_status
ON kamar (id_tipe, status_kamar);

-- Metode 3: Composite Index via ALTER TABLE
ALTER TABLE reservasi
ADD CONSTRAINT unique_tamu_checkin
UNIQUE (id_tamu, tgl_checkin);