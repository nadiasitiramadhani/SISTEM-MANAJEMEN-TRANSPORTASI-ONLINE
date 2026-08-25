-- DDL --

CREATE DATABASE sistem_manajemen_transportasi_online;
USE sistem_manajemen_transportasi_online;

CREATE TABLE pengguna (
    id_pengguna VARCHAR(10) PRIMARY KEY,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE,
    nomor_telepon VARCHAR(20) NOT NULL UNIQUE,
    peran VARCHAR(20) NOT NULL
);

CREATE TABLE pengemudi (
    id_pengemudi VARCHAR(10) PRIMARY KEY,
    id_pengguna VARCHAR(10) NOT NULL UNIQUE,
    nomor_sim VARCHAR(20) NOT NULL,
    plat_nomor VARCHAR(15) NOT NULL,
    jenis_kendaraan VARCHAR(15) NOT NULL,
    status_aktif VARCHAR(10) NOT NULL,

    CONSTRAINT fk_pengemudi_pengguna
        FOREIGN KEY (id_pengguna)
        REFERENCES pengguna(id_pengguna)
);

CREATE TABLE penumpang (
    id_penumpang VARCHAR(10) PRIMARY KEY,
    id_pengguna VARCHAR(10) NOT NULL UNIQUE,
    saldo DECIMAL(12,2) NOT NULL DEFAULT 0,

    CONSTRAINT fk_penumpang_pengguna
        FOREIGN KEY (id_pengguna)
        REFERENCES pengguna(id_pengguna)
);

CREATE TABLE tarif (
    id_tarif VARCHAR(10) PRIMARY KEY,
    jenis_kendaraan VARCHAR(15) NOT NULL,
    harga_per_km DECIMAL(10,2) NOT NULL,
    biaya_dasar DECIMAL(10,2) NOT NULL
);

CREATE TABLE promo (
    id_promo VARCHAR(10) PRIMARY KEY,
    kode_promo VARCHAR(10) NOT NULL UNIQUE,
    diskon_persen DECIMAL(5,2) NOT NULL,
    batas_penggunaan INT NOT NULL,
    tanggal_berlaku DATE NOT NULL,
    tanggal_berakhir DATE NOT NULL
);

CREATE TABLE pesanan (
    id_pesanan VARCHAR(10) PRIMARY KEY,
    id_penumpang VARCHAR(10) NOT NULL,
    id_pengemudi VARCHAR(10) NOT NULL,
    id_promo VARCHAR(10) NULL,
    id_tarif VARCHAR(10) NOT NULL,
    
    waktu_pesan DATETIME NOT NULL,
    lokasi_jemput VARCHAR(100) NOT NULL,
    lokasi_tujuan VARCHAR(100) NOT NULL,
    
    status_pesanan VARCHAR(20) NOT NULL,
    jarak_km DECIMAL(8,2) NOT NULL,

    CONSTRAINT fk_pesanan_penumpang
        FOREIGN KEY (id_penumpang) REFERENCES penumpang(id_penumpang),
    CONSTRAINT fk_pesanan_pengemudi
        FOREIGN KEY (id_pengemudi) REFERENCES pengemudi(id_pengemudi),
    CONSTRAINT fk_pesanan_promo
        FOREIGN KEY (id_promo) REFERENCES promo(id_promo),
    CONSTRAINT fk_pesanan_tarif
        FOREIGN KEY (id_tarif) REFERENCES tarif(id_tarif),
        
    CONSTRAINT check_jarak_km CHECK (jarak_km > 0),
        
    CONSTRAINT check_status_pesanan
        CHECK (
            status_pesanan IN
            ('Menunggu', 'Diproses', 'Selesai', 'Dibatalkan')
        )
);

CREATE TABLE pembayaran (
    id_pembayaran VARCHAR(10) PRIMARY KEY,
    id_pesanan VARCHAR(10) NOT NULL,
    metode_pembayaran VARCHAR(30) NOT NULL,
    jumlah DECIMAL(12,2) NOT NULL,
    waktu_bayar DATETIME NULL,
    status_pembayaran VARCHAR(20) NOT NULL,

    CONSTRAINT fk_pembayaran_pesanan FOREIGN KEY (id_pesanan) REFERENCES pesanan(id_pesanan)
);

CREATE TABLE ulasan (
    id_ulasan VARCHAR(10) PRIMARY KEY,
    id_pesanan VARCHAR(10) NOT NULL,
    id_pengguna VARCHAR(10) NOT NULL,
    nilai_ulasan INT NOT NULL,
    komentar_ulasan TEXT,
    tanggal_ulasan DATE NULL,

    CONSTRAINT fk_ulasan_pesanan
        FOREIGN KEY (id_pesanan)
        REFERENCES pesanan(id_pesanan),

    CONSTRAINT fk_ulasan_pengguna
        FOREIGN KEY (id_pengguna)
        REFERENCES pengguna(id_pengguna),

    CONSTRAINT check_nilai_ulasan
        CHECK (nilai_ulasan BETWEEN 1 AND 5)
);

SHOW TABLES;
DESCRIBE Pesanan;

SELECT
    TABLE_NAME,
    COLUMN_NAME,
    REFERENCED_TABLE_NAME,
    REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE REFERENCED_TABLE_SCHEMA = DATABASE();

-- DML --

INSERT INTO pengguna VALUES
('B001','Aziza','zah@email.com','081234567890','Penumpang'),
('B002','Raka Firmansyah','raka@email.com','081234567891','Penumpang'),
('B003','Nadia Siti','nadia@email.com','081234567892','Penumpang'),
('B004','Readini Fatrah','readini@email.com','081234567893','Penumpang'),
('B005','Andi Kurniawan','andi@email.com','081234567894','Penumpang'),
('B006','Putri Varila','putri@email.com','081234567896','Penumpang'),
('B007','Bagas Satryo','bagas@email.com','081234567897','Penumpang'),
('B008','Sinta Dewi','sinta@gmail.com','081234567895','Penumpang'),
('B009','Ferdi Santoso','ferdi@email.com','081111111111','Pengemudi'),
('B010','Fajar Nugroho','fajar@email.com','081111111114','Pengemudi'),
('B011','Dani Wijaya','dani@email.com','081111111112','Pengemudi'),
('B012','Eko Prasetyo','eko@email.com','081111111113','Pengemudi'),
('B013','Galih Saputra','galih@email.com','081111111115','Pengemudi'),
('B014','Hendra Kusuma','hendra@email.com','081111111116','Pengemudi');

INSERT INTO penumpang VALUES
('D001','B001',475000),
('D002','B002',515000),
('D003','B003',532000),
('D004','B004',235000),
('D005','B005',252000),
('D008','B008',314000);
SELECT id_penumpang
FROM penumpang;
INSERT INTO pengemudi VALUES
('C001','B009','SIM-001','B1234XX','Motor','Aktif'),
('C002','B010','SIM-004','L1111AA','Motor','Aktif'),
('C003','B011','SIM-002','B5678YY','Motor','Aktif'),
('C004','B012','SIM-003','L2222BB','Mobil','Aktif'),
('C005','B013','SIM-005','L3333CC','Motor','Aktif');

INSERT INTO promo VALUES
('L001','DISKON10',10,500,'2024-01-01','2024-03-31'),
('L002','GRATIS5KM',100,50,'2024-01-01','2024-01-31'),
('L003','SEHAT20',20,200,'2024-01-01','2024-02-28'),
('L004','WEEKEND15',15,300,'2024-01-01','2024-03-31'),
('L005','HEMAT25',25,150,'2024-01-01','2024-01-07');

INSERT INTO tarif VALUES
('E001','Motor',2000,5000),
('E002','Mobil',5000,7500);

INSERT INTO pesanan VALUES
('P001','D001','C001','L001','E001',
'2024-01-05 08:10:00',
'Jl. Rungkut No.5','UPN Veteran Jawa Timur',
'Selesai',3.2),

('P002','D002','C003',NULL,'E001',
'2024-01-18 09:00:00',
'Jl. Gubeng No.12','Stasiun Gubeng',
'Selesai',1.5),

('P003','D003','C004','L002','E002',
'2024-01-06 07:45:00',
'Jl. Darmo No.3','Mall Tunjungan Plaza',
'Selesai',5.0),

('P004','D004','C001',NULL,'E001',
'2024-01-06 10:30:00',
'Jl. Semolowaru No.7','Apotek Kimia Farma',
'Selesai',2.1),

('P005','D001','C002',NULL,'E001',
'2024-01-07 13:15:00',
'Kampus UPN','Warung Makan Bu Sri',
'Selesai',1.8),

('P009','D004','C001','L001','E001',
'2024-01-09 14:00:00',
'Jl. Nginden No.2','Pasar Wonokromo',
'Dibatalkan',6.1),

('P021','D005','C003',NULL,'E001',
'2024-01-15 13:00:00',
'Jl. Siwalankerto No.3','Universitas Kristen Petra',
'Dibatalkan',3.3),

('P022','D008','C001',NULL,'E001',
'2024-01-16 08:00:00',
'Jl. Tenggilis Mejoyo','Kantor Samsat Surabaya',
'Selesai',4.7);
SELECT * FROM pesanan;
INSERT INTO pembayaran VALUES
('F001','P001','GoPay','11400','2024-01-05 08:35:00','Berhasil'),
('F004','P003','Transfer','32500','2024-01-06 08:15:00','Berhasil'),
('F011','P009','GoPay','0',NULL,'Gagal'),
('F026','P022','Dana','32500','2024-01-16 08:25:00','Berhasil'),
('F025','P021','GoPay','0',NULL,'Gagal');

INSERT INTO ulasan (id_ulasan, id_pesanan, id_pengguna, nilai_ulasan, komentar_ulasan, tanggal_ulasan) VALUES 
('G001', 'P001', 'B001', 5, 'Pengemudi ramah dan tepat waktu.', '2024-01-05'), 
('G002', 'P002', 'B002', 4, 'Rute agak muter.', '2024-01-05'), 
('G003', 'P003', 'B003', 5, 'Mobil bersih dan nyaman', '2024-01-07'), 
('G004', 'P004', 'B004', 4, 'Oke', '2024-01-07'), 
('G005', 'P005', 'B001', 5, 'Cepat sampai', '2024-01-07');

SELECT
    p.id_pesanan,
    p.waktu_pesan,
    p.lokasi_jemput,
    p.lokasi_tujuan,
    pb.jumlah AS biaya
FROM pesanan p
JOIN pembayaran pb
    ON p.id_pesanan = pb.id_pesanan
WHERE p.id_penumpang IN ('D001','D002','D003','D004','D005')
AND pb.status_pembayaran = 'Berhasil';

SELECT
    p.id_penumpang,
    SUM(pb.jumlah) AS total_biaya
FROM penumpang p
JOIN pesanan ps
    ON p.id_penumpang = ps.id_penumpang
JOIN pembayaran pb
    ON ps.id_pesanan = pb.id_pesanan
WHERE p.id_penumpang IN ('D001','D002','D003','D004','D005')
AND pb.status_pembayaran = 'Berhasil'
GROUP BY p.id_penumpang;

UPDATE pesanan
SET status_pesanan = 'Selesai'
WHERE id_pesanan IN ('P001','P003');
SELECT * FROM pesanan WHERE id_pesanan IN ('P001','P003'); 

UPDATE penumpang pn
JOIN pesanan ps
    ON pn.id_penumpang = ps.id_penumpang
JOIN pembayaran pb
    ON ps.id_pesanan = pb.id_pesanan
SET pn.saldo = pn.saldo - pb.jumlah
WHERE ps.id_pesanan IN ('P001','P002','P003')
AND pb.status_pembayaran = 'Berhasil';

SELECT * FROM penumpang WHERE id_penumpang IN ('D001','D002','D003');

DELETE FROM pembayaran
WHERE id_pesanan IN ('P009','P021');

DELETE FROM pesanan
WHERE status_pesanan = 'Dibatalkan'
AND waktu_pesan < DATE_SUB('2024-01-25', INTERVAL 7 DAY);

-- DCL --

CREATE USER 'admin_platform'@'localhost' IDENTIFIED BY 'AdminPass123!';
CREATE USER 'pengemudi_user'@'localhost' IDENTIFIED BY 'DriverPass456!';
CREATE USER 'penumpang_user'@'localhost' IDENTIFIED BY 'PassengerPass789!';

GRANT ALL PRIVILEGES ON sistem_manajemen_transportasi_online.* TO 'admin_platform'@'localhost';

GRANT SELECT ON sistem_manajemen_transportasi_online.pesanan TO 'pengemudi_user'@'localhost';
GRANT UPDATE (status_pesanan) ON sistem_manajemen_transportasi_online.pesanan TO 'pengemudi_user'@'localhost';
GRANT SELECT, INSERT ON sistem_manajemen_transportasi_online.ulasan TO 'pengemudi_user'@'localhost';

GRANT DELETE ON sistem_manajemen_transportasi_online.Pesanan TO 'pengemudi_user'@'localhost';
GRANT DELETE ON sistem_manajemen_transportasi_online.Ulasan TO 'pengemudi_user'@'localhost';
GRANT DELETE ON sistem_manajemen_transportasi_online.Pengguna TO 'pengemudi_user'@'localhost';
GRANT DELETE ON sistem_manajemen_transportasi_online.Penumpang TO 'pengemudi_user'@'localhost';
GRANT DELETE ON sistem_manajemen_transportasi_online.Pengemudi TO 'pengemudi_user'@'localhost';
GRANT DELETE ON sistem_manajemen_transportasi_online.Tarif TO 'pengemudi_user'@'localhost';
GRANT DELETE ON sistem_manajemen_transportasi_online.Pembayaran TO 'pengemudi_user'@'localhost';
GRANT DELETE ON sistem_manajemen_transportasi_online.Promo TO 'pengemudi_user'@'localhost';

REVOKE DELETE ON sistem_manajemen_transportasi_online.Pesanan FROM 'pengemudi_user'@'localhost';
REVOKE DELETE ON sistem_manajemen_transportasi_online.Ulasan FROM 'pengemudi_user'@'localhost';
REVOKE DELETE ON sistem_manajemen_transportasi_online.Pengguna FROM 'pengemudi_user'@'localhost';
REVOKE DELETE ON sistem_manajemen_transportasi_online.Penumpang FROM 'pengemudi_user'@'localhost';
REVOKE DELETE ON sistem_manajemen_transportasi_online.Pengemudi FROM 'pengemudi_user'@'localhost';
REVOKE DELETE ON sistem_manajemen_transportasi_online.Tarif FROM 'pengemudi_user'@'localhost';
REVOKE DELETE ON sistem_manajemen_transportasi_online.Pembayaran FROM 'pengemudi_user'@'localhost';
REVOKE DELETE ON sistem_manajemen_transportasi_online.Promo FROM 'pengemudi_user'@'localhost';

GRANT SELECT ON sistem_manajemen_transportasi_online.Tarif TO 'penumpang_user'@'localhost';
GRANT SELECT ON sistem_manajemen_transportasi_online.Promo TO 'penumpang_user'@'localhost';
GRANT SELECT, INSERT ON sistem_manajemen_transportasi_online.Pesanan TO 'penumpang_user'@'localhost';
GRANT SELECT, INSERT ON sistem_manajemen_transportasi_online.Ulasan TO 'penumpang_user'@'localhost';

GRANT INSERT, UPDATE, DELETE ON sistem_manajemen_transportasi_online.Tarif TO 'penumpang_user'@'localhost';
GRANT INSERT, UPDATE, DELETE ON sistem_manajemen_transportasi_online.Pengemudi TO 'penumpang_user'@'localhost';

REVOKE INSERT, UPDATE, DELETE ON sistem_manajemen_transportasi_online.Tarif FROM 'penumpang_user'@'localhost';
REVOKE INSERT, UPDATE, DELETE ON sistem_manajemen_transportasi_online.Pengemudi FROM 'penumpang_user'@'localhost';

SHOW GRANTS FOR 'pengemudi_user'@'localhost';
SHOW GRANTS FOR 'admin_platform'@'localhost';
SHOW GRANTS FOR 'penumpang_user'@'localhost';