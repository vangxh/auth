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

 Date: 25/01/2021 09:35:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for idm_auth_role
-- ----------------------------
DROP TABLE IF EXISTS `idm_auth_role`;
CREATE TABLE `idm_auth_role`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `module` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `rules` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `title` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `intro` char(120) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '分类[0默认,1系统,2一期系统]',
  `status` tinyint(1) UNSIGNED NOT NULL COMMENT '[0禁用,1启用]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
