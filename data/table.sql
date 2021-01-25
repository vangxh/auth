/*
 Navicat Premium Data Transfer

 Source Server         : me-test
 Source Server Type    : MariaDB
 Source Server Version : 100413
 Source Host           : 127.0.0.1:3306
 Source Schema         : worker_dev

 Target Server Type    : MariaDB
 Target Server Version : 100413
 File Encoding         : 65001

 Date: 25/01/2021 09:58:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for x_auth_priv
-- ----------------------------
DROP TABLE IF EXISTS `x_auth_priv`;
CREATE TABLE `x_auth_priv`  (
  `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT,
  `module` char(10) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `name` char(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `pid` smallint(6) NOT NULL DEFAULT 0,
  `intro` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '' COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `name`(`name`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 14 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for x_auth_role
-- ----------------------------
DROP TABLE IF EXISTS `x_auth_role`;
CREATE TABLE `x_auth_role`  (
  `id` mediumint(8) UNSIGNED NOT NULL AUTO_INCREMENT,
  `module` char(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `rules` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `title` char(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `intro` char(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL DEFAULT '',
  `type` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '分类[0默认,1游客,2用户]',
  `status` tinyint(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '[0禁用,1启用]',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = MyISAM AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for x_auth_role_user
-- ----------------------------
DROP TABLE IF EXISTS `x_auth_role_user`;
CREATE TABLE `x_auth_role_user`  (
  `uid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `gid` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `rule` text CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  UNIQUE INDEX `uid_gid`(`uid`, `gid`) USING BTREE,
  INDEX `uid`(`uid`) USING BTREE,
  INDEX `gid`(`gid`) USING BTREE
) ENGINE = MyISAM CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
