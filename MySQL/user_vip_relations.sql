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

 Date: 18/05/2025 20:00:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for user_vip_relations
-- ----------------------------
DROP TABLE IF EXISTS `user_vip_relations`;
CREATE TABLE `user_vip_relations`  (
  `uid` int(0) NOT NULL COMMENT '用户ID',
  `vip_id` int(0) NOT NULL COMMENT '会员ID',
  `activation_time` datetime(0) NOT NULL COMMENT '开通时间',
  PRIMARY KEY (`uid`, `vip_id`, `activation_time`) USING BTREE,
  INDEX `fk_user_vip_relation_vip_id`(`vip_id`) USING BTREE,
  CONSTRAINT `fk_user_vip_relation_uid` FOREIGN KEY (`uid`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_vip_relation_vip_id` FOREIGN KEY (`vip_id`) REFERENCES `vip` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
