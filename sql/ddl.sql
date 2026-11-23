-- ============================================================================
-- File: sql/ddl.sql
-- Kelompok 3 - Data Warehouse Purchasing (AdventureWorks) - Star Schema V2
-- ============================================================================

CREATE DATABASE IF NOT EXISTS `dw_kelompok3`
  DEFAULT CHARACTER SET utf8mb4
  COLLATE utf8mb4_general_ci;

USE `dw_kelompok3`;

SET FOREIGN_KEY_CHECKS = 0;

DROP TABLE IF EXISTS `fact_purchasing`;
DROP TABLE IF EXISTS `dim_tanggal`;
DROP TABLE IF EXISTS `dim_karyawan`;
DROP TABLE IF EXISTS `dim_produk`;
DROP TABLE IF EXISTS `dim_vendor`;
DROP TABLE IF EXISTS `dim_geography`;
DROP TABLE IF EXISTS `dim_ship_method`;

-- ============================================================================
-- 1. TABEL DIMENSI TANGGAL (dim_tanggal)
-- ============================================================================
CREATE TABLE `dim_tanggal` (
  `tanggal_key` INT NOT NULL,
  `tanggal` DATE DEFAULT NULL,
  `tahun` INT DEFAULT NULL,
  `semester` INT DEFAULT NULL,
  `kuartal` INT DEFAULT NULL,
  `bulan` INT DEFAULT NULL,
  `nama_bulan` VARCHAR(15) DEFAULT NULL,
  `minggu_dalam_tahun` INT DEFAULT NULL,
  `tanggal_dalam_bulan` INT DEFAULT NULL,
  `hari_dalam_minggu` INT DEFAULT NULL,
  `nama_hari` VARCHAR(15) DEFAULT NULL,
  `is_akhir_pekan` TINYINT(1) DEFAULT NULL,
  PRIMARY KEY (`tanggal_key`),
  UNIQUE KEY `uk_dim_tanggal_tanggal` (`tanggal`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `dim_tanggal` (
  `tanggal_key`, `tanggal`, `tahun`, `semester`, `kuartal`, `bulan`, `nama_bulan`,
  `minggu_dalam_tahun`, `tanggal_dalam_bulan`, `hari_dalam_minggu`, `nama_hari`, `is_akhir_pekan`
) VALUES (
  -1, '1900-01-01', 1900, 1, 1, 1, 'Unknown', 1, 1, 1, 'Unknown', 0
);

-- ============================================================================
-- 2. TABEL DIMENSI KARYAWAN (dim_karyawan)
-- ============================================================================
CREATE TABLE `dim_karyawan` (
  `sk_karyawan` INT NOT NULL AUTO_INCREMENT,
  `karyawan_id` INT NOT NULL,
  `nama_lengkap` VARCHAR(150) DEFAULT NULL,
  `jabatan` VARCHAR(100) DEFAULT NULL,
  `jenis_kelamin` VARCHAR(10) DEFAULT NULL,
  `tanggal_rekrut` DATE DEFAULT NULL,
  `versi` INT DEFAULT 1,
  `berlaku_mulai` DATETIME DEFAULT NULL,
  `berlaku_sampai` DATETIME DEFAULT NULL,
  PRIMARY KEY (`sk_karyawan`),
  KEY `idx_dim_karyawan_bk` (`karyawan_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `dim_karyawan` (
  `sk_karyawan`, `karyawan_id`, `nama_lengkap`, `jabatan`, `jenis_kelamin`, `tanggal_rekrut`, `versi`, `berlaku_mulai`, `berlaku_sampai`
) VALUES (
  -1, -1, 'Unknown Employee', 'Unknown', '-', '1900-01-01', 1, '1900-01-01 00:00:00', '9999-12-31 23:59:59'
);

-- ============================================================================
-- 3. TABEL DIMENSI PRODUK (dim_produk) - SCD Tipe 2
-- ============================================================================
CREATE TABLE `dim_produk` (
  `sk_produk` INT NOT NULL AUTO_INCREMENT,
  `produk_id` INT NOT NULL,
  `nama_produk` VARCHAR(150) DEFAULT NULL,
  `kode_produk` VARCHAR(50) DEFAULT NULL,
  `warna` VARCHAR(30) DEFAULT NULL,
  `subkategori` VARCHAR(100) DEFAULT NULL,
  `kategori` VARCHAR(100) DEFAULT NULL,
  `biaya_standar` DECIMAL(19,4) DEFAULT NULL,
  `harga_jual` DECIMAL(19,4) DEFAULT NULL,
  `versi` INT DEFAULT 1,
  `berlaku_mulai` DATETIME DEFAULT NULL,
  `berlaku_sampai` DATETIME DEFAULT NULL,
  PRIMARY KEY (`sk_produk`),
  KEY `idx_dim_produk_bk` (`produk_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `dim_produk` (
  `sk_produk`, `produk_id`, `nama_produk`, `kode_produk`, `warna`, `subkategori`, `kategori`, `biaya_standar`, `harga_jual`, `versi`, `berlaku_mulai`, `berlaku_sampai`
) VALUES
  (-1, -1, 'Unknown Product', 'UNK-000', 'Unknown', 'Unknown', 'Unknown', 0.0000, 0.0000, 1, '1900-01-01 00:00:00', '9999-12-31 23:59:59'),
  (0, 0, 'Dummy Pentaho SCD2', 'DMY-000', 'Unknown', 'Unknown', 'Unknown', 0.0000, 0.0000, 1, '1900-01-01 00:00:00', '9999-12-31 23:59:59');

-- ============================================================================
-- 4. TABEL DIMENSI VENDOR (dim_vendor)
-- ============================================================================
CREATE TABLE `dim_vendor` (
  `sk_vendor` INT NOT NULL AUTO_INCREMENT,
  `vendor_id` INT NOT NULL,
  `nomor_akun` VARCHAR(50) DEFAULT NULL,
  `nama_vendor` VARCHAR(150) DEFAULT NULL,
  `peringkat_kredit` TINYINT DEFAULT NULL,
  `status_aktif` TINYINT(1) DEFAULT NULL,
  `versi` INT DEFAULT 1,
  `berlaku_mulai` DATETIME DEFAULT NULL,
  `berlaku_sampai` DATETIME DEFAULT NULL,
  PRIMARY KEY (`sk_vendor`),
  KEY `idx_dim_vendor_bk` (`vendor_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `dim_vendor` (
  `sk_vendor`, `vendor_id`, `nomor_akun`, `nama_vendor`, `peringkat_kredit`, `status_aktif`, `versi`, `berlaku_mulai`, `berlaku_sampai`
) VALUES (
  -1, -1, 'UNK-0000', 'Unknown Vendor', 0, 0, 1, '1900-01-01 00:00:00', '9999-12-31 23:59:59'
);

-- ============================================================================
-- 5. TABEL DIMENSI GEOGRAFI (dim_geography) - Tambahan Star Schema V2
-- ============================================================================
CREATE TABLE `dim_geography` (
  `sk_geography` INT NOT NULL AUTO_INCREMENT,
  `address_id` INT NOT NULL,
  `kota` VARCHAR(50) DEFAULT NULL,
  `kode_provinsi` VARCHAR(10) DEFAULT NULL,
  `nama_provinsi` VARCHAR(50) DEFAULT NULL,
  `kode_negara` VARCHAR(10) DEFAULT NULL,
  `nama_negara` VARCHAR(50) DEFAULT NULL,
  `versi` INT DEFAULT 1,
  `berlaku_mulai` DATETIME DEFAULT NULL,
  `berlaku_sampai` DATETIME DEFAULT NULL,
  PRIMARY KEY (`sk_geography`),
  KEY `idx_dim_geography_bk` (`address_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `dim_geography` (
  `sk_geography`, `address_id`, `kota`, `kode_provinsi`, `nama_provinsi`, `kode_negara`, `nama_negara`, `versi`, `berlaku_mulai`, `berlaku_sampai`
) VALUES (
  -1, -1, 'Unknown City', 'UNK', 'Unknown State/Province', 'UNK', 'Unknown Country', 1, '1900-01-01 00:00:00', '9999-12-31 23:59:59'
);

-- ============================================================================
-- 6. TABEL DIMENSI METODE PENGIRIMAN (dim_ship_method) - Tambahan Star Schema V2
-- ============================================================================
CREATE TABLE `dim_ship_method` (
  `sk_ship_method` INT NOT NULL AUTO_INCREMENT,
  `ship_method_id` INT NOT NULL,
  `nama_metode_kirim` VARCHAR(50) DEFAULT NULL,
  `tarif_dasar` DECIMAL(19,4) DEFAULT 0.0000,
  `tarif_per_unit` DECIMAL(19,4) DEFAULT 0.0000,
  `versi` INT DEFAULT 1,
  `berlaku_mulai` DATETIME DEFAULT NULL,
  `berlaku_sampai` DATETIME DEFAULT NULL,
  PRIMARY KEY (`sk_ship_method`),
  KEY `idx_dim_ship_method_bk` (`ship_method_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `dim_ship_method` (
  `sk_ship_method`, `ship_method_id`, `nama_metode_kirim`, `tarif_dasar`, `tarif_per_unit`, `versi`, `berlaku_mulai`, `berlaku_sampai`
) VALUES (
  -1, -1, 'Unknown Ship Method', 0.0000, 0.0000, 1, '1900-01-01 00:00:00', '9999-12-31 23:59:59'
);

-- ============================================================================
-- 7. TABEL FAKTA PURCHASING (fact_purchasing) - Star Schema V2
-- ============================================================================
CREATE TABLE `fact_purchasing` (
  `sk_purchasing` INT NOT NULL AUTO_INCREMENT,
  `po_id` INT NOT NULL,
  `po_detail_id` INT NOT NULL,
  `sk_tanggal` INT NOT NULL DEFAULT -1,
  `sk_karyawan` INT NOT NULL DEFAULT -1,
  `sk_produk` INT NOT NULL DEFAULT -1,
  `sk_vendor` INT NOT NULL DEFAULT -1,
  `sk_geography` INT NOT NULL DEFAULT -1,
  `sk_ship_method` INT NOT NULL DEFAULT -1,
  `qty_order` INT DEFAULT 0,
  `qty_diterima` DECIMAL(8,2) DEFAULT 0.00,
  `qty_ditolak` DECIMAL(8,2) DEFAULT 0.00,
  `qty_masuk_stok` DECIMAL(8,2) DEFAULT 0.00,
  `harga_satuan` DECIMAL(19,4) DEFAULT 0.0000,
  `total_harga_baris` DECIMAL(19,4) DEFAULT 0.0000,
  `subtotal_po` DECIMAL(19,4) DEFAULT 0.0000,
  `pajak_po` DECIMAL(19,4) DEFAULT 0.0000,
  `ongkir_po` DECIMAL(19,4) DEFAULT 0.0000,
  `total_tagihan_po` DECIMAL(19,4) DEFAULT 0.0000,
  PRIMARY KEY (`sk_purchasing`),
  UNIQUE KEY `uk_fact_purchasing_dd` (`po_id`, `po_detail_id`),
  CONSTRAINT `chk_fact_qty_order` CHECK (`qty_order` > 0),
  KEY `idx_fact_sk_tanggal` (`sk_tanggal`),
  KEY `idx_fact_sk_karyawan` (`sk_karyawan`),
  KEY `idx_fact_sk_produk` (`sk_produk`),
  KEY `idx_fact_sk_vendor` (`sk_vendor`),
  KEY `idx_fact_sk_geography` (`sk_geography`),
  KEY `idx_fact_sk_ship_method` (`sk_ship_method`),
  CONSTRAINT `fk_fact_purchasing_tanggal`
    FOREIGN KEY (`sk_tanggal`) REFERENCES `dim_tanggal` (`tanggal_key`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `fk_fact_purchasing_karyawan`
    FOREIGN KEY (`sk_karyawan`) REFERENCES `dim_karyawan` (`sk_karyawan`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `fk_fact_purchasing_produk`
    FOREIGN KEY (`sk_produk`) REFERENCES `dim_produk` (`sk_produk`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `fk_fact_purchasing_vendor`
    FOREIGN KEY (`sk_vendor`) REFERENCES `dim_vendor` (`sk_vendor`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `fk_fact_purchasing_geography`
    FOREIGN KEY (`sk_geography`) REFERENCES `dim_geography` (`sk_geography`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
  CONSTRAINT `fk_fact_purchasing_ship_method`
    FOREIGN KEY (`sk_ship_method`) REFERENCES `dim_ship_method` (`sk_ship_method`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET FOREIGN_KEY_CHECKS = 1;
