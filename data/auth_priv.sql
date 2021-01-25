/*
 Navicat Premium Data Transfer

 Source Server         : teu-ali-base
 Source Server Type    : MariaDB
 Source Server Version : 100413
 Source Host           : 127.0.0.1:3306
 Source Schema         : idm_dev

 Target Server Type    : MariaDB
 Target Server Version : 100413
 File Encoding         : 65001

 Date: 25/01/2021 09:34:54
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for idm_auth_priv
-- ----------------------------
DROP TABLE IF EXISTS `idm_auth_priv`;
CREATE TABLE `idm_auth_priv`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `module` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name` char(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `pid` smallint(6) NOT NULL,
  `intro` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 283 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
