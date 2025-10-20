-- Untuk hapus schema role jiaka sudah ada
DROP SCHEMA IF EXISTS SALAM CASCADE;
DROP ROLE IF EXISTS backend_dev;
DROP ROLE IF EXISTS bi_dev;
DROP ROLE IF EXISTS data_engineer;


CREATE SCHEMA SALAM;
SET search_path TO SALAM;

CREATE TABLE mahasiswas (
    id_mahasiswa BIGSERIAL PRIMARY KEY,
    nim VARCHAR(15) NOT NULL UNIQUE,
    nama_lengkap VARCHAR(100) NOT NULL
);

-- Buat View (untuk diuji oleh bi_dev)
CREATE VIEW v_nama_mahasiswa AS
SELECT nama_lengkap FROM mahasiswas;

-- Masukkan 1 data awal
INSERT INTO mahasiswas (nim, nama_lengkap) 
VALUES ('1237050023', 'Muhammad Rahardian Baihaqi');
INSERT INTO mahasiswas (nim, nama_lengkap) 
VALUES ('1237050020', 'Rahardian Baihaqi');
INSERT INTO mahasiswas (nim, nama_lengkap) 
VALUES ('1237050021', 'Nazwa Yulianti');
INSERT INTO mahasiswas (nim, nama_lengkap) 
VALUES ('1237050019', 'Louisa Yova');

RESET ROLE; -- untuk kembali ke SuperUser

-- 3 user dengan password
CREATE ROLE backend_dev WITH LOGIN PASSWORD 'pass123';
CREATE ROLE bi_dev WITH LOGIN PASSWORD 'pass123';
CREATE ROLE data_engineer WITH LOGIN PASSWORD 'pass123';

-- PEMBUATAN USER ROLE
-- (a) backend_dev
GRANT USAGE ON SCHEMA SALAM TO backend_dev;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA SALAM TO backend_dev;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA SALAM TO backend_dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM
    GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO backend_dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM
    GRANT USAGE, SELECT ON SEQUENCES TO backend_dev;

-- (b) bi_dev
GRANT USAGE ON SCHEMA SALAM TO bi_dev;
GRANT SELECT ON ALL TABLES IN SCHEMA SALAM TO bi_dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM
    GRANT SELECT ON TABLES TO bi_dev;

-- (c) data_engineer
GRANT USAGE, CREATE ON SCHEMA SALAM TO data_engineer;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA SALAM TO data_engineer;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA SALAM TO data_engineer;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM
    GRANT ALL PRIVILEGES ON TABLES TO data_engineer;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM
    GRANT ALL PRIVILEGES ON SEQUENCES TO data_engineer;

-- CEKK USER YANG SUDAH DIBUAT
SELECT rolname, rolcanlogin FROM pg_roles 
WHERE rolname IN ('backend_dev', 'bi_dev', 'data_engineer');


-- Pembuktian BI_DEV READ ONLY
SET ROLE bi_dev;
SELECT * FROM SALAM.mahasiswas;
-- Pembuktian BI_DEV TIDAK BISA INSERT
INSERT INTO SALAM.mahasiswas (nim, nama_lengkap) VALUES ('101', 'Gagal BI');
-- Pembuktian BI_DEV TIDAK BISA CREATE
CREATE TABLE SALAM.tabel_gagal_bi (id INT);


-- Pembuktian BACKEND_DEV CRUD
SET ROLE backend_dev;
-- Pembuktian BACKKEND_DEV INSERT
INSERT INTO SALAM.mahasiswas (nim, nama_lengkap) VALUES ('1227050023', 'Muhammad Rahardian Baihaqi');
-- Pembuktian BACKKEND_DEV UPDATE
UPDATE SALAM.mahasiswas SET nama_lengkap = 'Rahardian Baihaqi' WHERE nim = '1227050023';
-- Pembuktian BACKKEND_DEV DELETE
DELETE FROM SALAM.mahasiswas WHERE nim = '1227050023';
-- Pembuktian BACKKEND_DEV CREATE
CREATE TABLE SALAM.tabel_gagal_backend (id INT);

-- Pembuktian DATA_ENGINEER FULL CONTROL
SET ROLE data_engineer;
-- Pembuktian DATA_ENGINEER CREATE
CREATE TABLE SALAM.tabel_baru_de (info TEXT);
INSERT INTO SALAM.tabel_baru_de (info) VALUES ('Tabel Kerja Baru');
-- Pembuktian DATA_ENGINEER DROP TABLE
DROP TABLE SALAM.tabel_baru_de;


-- PEMBUKTIAN DARI 3 ROLE SECARA KESELURUHAN

-- A. DATA ENGINEER FULL CONTROL
SET ROLE data_engineer;
CREATE TABLE SALAM.tabel_masa_depan (id INT, catatan TEXT);
RESET ROLE;

-- B. BI DEV HANYA BISA SELECT
SET ROLE bi_dev;
SELECT * FROM SALAM.tabel_masa_depan;
-- INSERT HARUS GAGAL
INSERT INTO SALAM.tabel_masa_depan VALUES (2, 'Gagal BI');

-- C. BACKEND DEV HANYA BISA SELECT
SET ROLE backend_dev;
INSERT INTO SALAM.tabel_masa_depan VALUES (2, 'Sukses Backend');
-- DROP TABLE HARUS GAGAL
DROP TABLE SALAM.tabel_masa_depan;



