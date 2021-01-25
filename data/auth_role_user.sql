/*
 Navicat Premium Data Transfer

 Source Server         : teu-ali-base
 Source Server Type    : MariaDB
 Source Server Version : 100413
 Source Host           : 127.0.0.1:3306
 Source Schema         : erp_dev

 Target Server Type    : MariaDB
 Target Server Version : 100413
 File Encoding         : 65001

 Date: 25/01/2021 09:35:47
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for erp_auth_role_user
-- ----------------------------
DROP TABLE IF EXISTS `erp_auth_role_user`;
CREATE TABLE `erp_auth_role_user`  (
  `uid` int(10) UNSIGNED NOT NULL,
  `gid` int(10) UNSIGNED NOT NULL DEFAULT 2,
  `rule` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  UNIQUE INDEX `uid_gid`(`uid`, `gid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `gid`(`gid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
