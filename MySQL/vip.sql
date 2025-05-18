/*
 Navicat Premium Data Transfer

 Source Server         : JavaNews
 Source Server Type    : MySQL
 Source Server Version : 80037
 Source Host           : localhost:3306
 Source Schema         : seunews

 Target Server Type    : MySQL
 Target Server Version : 80037
 File Encoding         : 65001

 Date: 18/05/2025 14:29:30
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for vip
-- ----------------------------
DROP TABLE IF EXISTS `vip`;
CREATE TABLE `vip`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '会员ID',
  `type` enum('VIP1','VIP2','VIP3','VIP4','VIP5','VIP6','VIP7','VIP8','VIP9','VIP10','SVIP1','SVIP2','SVIP3','SVIP4','SVIP5','SVIP6','SVIP7','SVIP8','SVIP9','SVIP10','SVIP+') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'VIP1' COMMENT '会员类型',
  `durations` enum('1个月','3个月','6个月','12个月','24个月','48个月') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1个月' COMMENT '时长',
  `durations_value` int(0) NULL DEFAULT NULL COMMENT '天数',
  `discount` decimal(3, 2) NULL DEFAULT NULL COMMENT '折扣',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `PK_viptype_id`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
