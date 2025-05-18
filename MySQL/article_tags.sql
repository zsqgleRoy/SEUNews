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

 Date: 15/05/2025 17:01:42
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article_tags
-- ----------------------------
DROP TABLE IF EXISTS `article_tags`;
CREATE TABLE `article_tags`  (
  `article_id` int(0) NOT NULL COMMENT '文章ID',
  `tag_id` int(0) NOT NULL COMMENT '板块ID',
  PRIMARY KEY (`article_id`, `tag_id`) USING BTREE,
  INDEX `fk_tag`(`tag_id`) USING BTREE,
  CONSTRAINT `fk_article_tag` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_tag` FOREIGN KEY (`tag_id`) REFERENCES `tags` (`tag_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

SET FOREIGN_KEY_CHECKS = 1;
