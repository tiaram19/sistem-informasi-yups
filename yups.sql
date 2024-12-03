/*
 Navicat Premium Data Transfer

 Source Server         : mysql-local
 Source Server Type    : MySQL
 Source Server Version : 100432 (10.4.32-MariaDB-log)
 Source Host           : localhost:3306
 Source Schema         : yups

 Target Server Type    : MySQL
 Target Server Version : 100432 (10.4.32-MariaDB-log)
 File Encoding         : 65001

 Date: 25/10/2024 18:49:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for acara
-- ----------------------------
DROP TABLE IF EXISTS `acara`;
CREATE TABLE `acara`  (
  `ID_Acara` int NOT NULL AUTO_INCREMENT,
  `Nama_Acara` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Tanggal_Acara` date NOT NULL,
  `Lokasi` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Tujuan_Acara` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `Jumlah_Peserta` int NULL DEFAULT NULL,
  `Status_Acara` enum('Terjadwal','Selesai') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Terjadwal',
  PRIMARY KEY (`ID_Acara`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for donasi
-- ----------------------------
DROP TABLE IF EXISTS `donasi`;
CREATE TABLE `donasi`  (
  `ID_Donasi` int NOT NULL AUTO_INCREMENT,
  `ID_Donatur` int NULL DEFAULT NULL,
  `ID_Kampanye` int NULL DEFAULT NULL,
  `Tanggal_Donasi` date NOT NULL,
  `Jumlah_Donasi` decimal(15, 2) NOT NULL,
  `Metode_Pembayaran` enum('Transfer','Kartu Kredit','Cash') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Status_Donasi` enum('Berhasil','Tertunda') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Tertunda',
  PRIMARY KEY (`ID_Donasi`) USING BTREE,
  INDEX `ID_Donatur`(`ID_Donatur` ASC) USING BTREE,
  INDEX `ID_Kampanye`(`ID_Kampanye` ASC) USING BTREE,
  CONSTRAINT `donasi_ibfk_1` FOREIGN KEY (`ID_Donatur`) REFERENCES `donatur` (`ID_Donatur`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `donasi_ibfk_2` FOREIGN KEY (`ID_Kampanye`) REFERENCES `kampanye_penggalangan_dana` (`ID_Kampanye`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for donatur
-- ----------------------------
DROP TABLE IF EXISTS `donatur`;
CREATE TABLE `donatur`  (
  `ID_Donatur` int NOT NULL AUTO_INCREMENT,
  `Nama_Donatur` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `no_telp` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `no_wa` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Alamat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `Tipe_Donatur` enum('Individu','Perusahaan') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Status_Keanggotaan` enum('Tetap','Satu_Kali') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Satu_Kali',
  `Tgl_gabung` date NULL DEFAULT NULL,
  `Tgl_lahir` date NULL DEFAULT NULL,
  `Kota_lahir` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Kelurahan` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Kecamatan` varchar(25) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Kode_pos` varchar(5) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Propinsi` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`ID_Donatur`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kampanye_penggalangan_dana
-- ----------------------------
DROP TABLE IF EXISTS `kampanye_penggalangan_dana`;
CREATE TABLE `kampanye_penggalangan_dana`  (
  `ID_Kampanye` int NOT NULL AUTO_INCREMENT,
  `Nama_Kampanye` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Tanggal_Mulai` date NULL DEFAULT NULL,
  `Tanggal_Selesai` date NULL DEFAULT NULL,
  `Target_Dana` decimal(15, 2) NOT NULL,
  `Deskripsi_Kampanye` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `Status_Kampanye` enum('Aktif','Nonaktif') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Aktif',
  PRIMARY KEY (`ID_Kampanye`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for kegiatan
-- ----------------------------
DROP TABLE IF EXISTS `kegiatan`;
CREATE TABLE `kegiatan`  (
  `id_kegiatan` int NOT NULL,
  `Nama_kegiatan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Keterangan` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_kegiatan`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for laporan_keuangan
-- ----------------------------
DROP TABLE IF EXISTS `laporan_keuangan`;
CREATE TABLE `laporan_keuangan`  (
  `ID_Laporan` int NOT NULL AUTO_INCREMENT,
  `Periode_Laporan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Total_Pemasukan` decimal(15, 2) NOT NULL,
  `Total_Pengeluaran` decimal(15, 2) NOT NULL,
  `Saldo_Akhir` decimal(15, 2) NOT NULL,
  `Keterangan_Laporan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`ID_Laporan`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for penerima_manfaat
-- ----------------------------
DROP TABLE IF EXISTS `penerima_manfaat`;
CREATE TABLE `penerima_manfaat`  (
  `ID_Penerima` int NOT NULL AUTO_INCREMENT,
  `Nama_Penerima` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Kontak_Penerima` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Jenis_Bantuan` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Tanggal_Terima` date NULL DEFAULT NULL,
  `Keterangan_Bantuan` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`ID_Penerima`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for proyek
-- ----------------------------
DROP TABLE IF EXISTS `proyek`;
CREATE TABLE `proyek`  (
  `ID_Proyek` int NOT NULL AUTO_INCREMENT,
  `Nama_Proyek` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Tanggal_Mulai_Proyek` date NULL DEFAULT NULL,
  `Tanggal_Selesai_Proyek` date NULL DEFAULT NULL,
  `Anggaran_Proyek` decimal(15, 2) NOT NULL,
  `Status_Proyek` enum('Dalam_Progress','Selesai') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Dalam_Progress',
  `Deskripsi_Proyek` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  PRIMARY KEY (`ID_Proyek`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for relawan
-- ----------------------------
DROP TABLE IF EXISTS `relawan`;
CREATE TABLE `relawan`  (
  `ID_Donatur` int NOT NULL AUTO_INCREMENT,
  `Nama_Donatur` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Kontak_Donatur` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `Alamat` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL,
  `Tipe_Donatur` enum('Individu','Perusahaan') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `Status_Keanggotaan` enum('Tetap','Satu_Kali') CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT 'Satu_Kali',
  PRIMARY KEY (`ID_Donatur`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
