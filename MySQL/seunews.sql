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

 Date: 12/05/2025 09:08:00
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article_categories
-- ----------------------------
DROP TABLE IF EXISTS `article_categories`;
CREATE TABLE `article_categories`  (
  `article_id` int(0) NOT NULL COMMENT '文章ID',
  `category_id` int(0) NOT NULL COMMENT '标签ID',
  PRIMARY KEY (`article_id`, `category_id`) USING BTREE,
  INDEX `fk_category`(`category_id`) USING BTREE,
  CONSTRAINT `fk_article` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_category` FOREIGN KEY (`category_id`) REFERENCES `categories` (`CategoryID`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for article_coins
-- ----------------------------
DROP TABLE IF EXISTS `article_coins`;
CREATE TABLE `article_coins`  (
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `article_id` int(0) NOT NULL COMMENT '文章ID',
  `coin_count` int(0) NOT NULL DEFAULT 1 COMMENT '投币数量',
  `coin_date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '投币时间',
  PRIMARY KEY (`user_id`, `article_id`) USING BTREE,
  INDEX `article_id`(`article_id`) USING BTREE,
  CONSTRAINT `article_coins_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `article_coins_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for article_favorites
-- ----------------------------
DROP TABLE IF EXISTS `article_favorites`;
CREATE TABLE `article_favorites`  (
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `article_id` int(0) NOT NULL COMMENT '文章ID',
  `favorite_date` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '收藏时间',
  PRIMARY KEY (`user_id`, `article_id`) USING BTREE,
  UNIQUE INDEX `unique_favorite`(`user_id`, `article_id`) USING BTREE,
  INDEX `article_id`(`article_id`) USING BTREE,
  CONSTRAINT `article_favorites_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `article_favorites_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for article_likes
-- ----------------------------
DROP TABLE IF EXISTS `article_likes`;
CREATE TABLE `article_likes`  (
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `article_id` int(0) NOT NULL COMMENT '文章ID',
  `like_date` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '点赞时间',
  PRIMARY KEY (`user_id`, `article_id`) USING BTREE,
  UNIQUE INDEX `unique_like`(`user_id`, `article_id`) USING BTREE,
  INDEX `article_id`(`article_id`) USING BTREE,
  CONSTRAINT `article_likes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `article_likes_ibfk_2` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

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

-- ----------------------------
-- Table structure for article_versions
-- ----------------------------
DROP TABLE IF EXISTS `article_versions`;
CREATE TABLE `article_versions`  (
  `version_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '版本ID',
  `article_id` int(0) NOT NULL COMMENT '文章ID',
  `author_id` int(0) NOT NULL COMMENT '作者ID',
  `version_number` int(0) NOT NULL COMMENT '版本次数',
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '正文',
  `create_date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `option_type` enum('DELETE','RESTORE','UPDATE_TITLE','UPDATE_CONTENT','UPDATE_BOTH','NONE') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'NONE' COMMENT '操作类型',
  `operator_id` int(0) NOT NULL COMMENT '操作者ID',
  PRIMARY KEY (`version_id`, `author_id`, `operator_id`) USING BTREE,
  INDEX `idx_article_id`(`article_id`) USING BTREE,
  INDEX `fk_article_versions_author_id`(`author_id`) USING BTREE,
  INDEX `idx_article_version`(`article_id`, `version_number`) USING BTREE,
  INDEX `fk_article_version_operator_id`(`operator_id`) USING BTREE,
  CONSTRAINT `fk_article_version_article_id` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_article_version_operator_id` FOREIGN KEY (`operator_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for articles
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles`  (
  `article_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '正文内容',
  `publish_date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '发布时间',
  `update_date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `author_id` int(0) NOT NULL COMMENT '作者ID',
  `status` enum('DRAFT','PUBLISHED') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'PUBLISHED' COMMENT '文章状态',
  `is_deleted` int(0) NULL DEFAULT NULL COMMENT '删除标记',
  `last_operator_id` int(0) NOT NULL DEFAULT 0 COMMENT '最后操作者ID',
  `like_num` bigint(0) NOT NULL DEFAULT 0 COMMENT '点赞数',
  `coin_num` bigint(0) NOT NULL DEFAULT 0 COMMENT '投币数',
  `favorit_num` bigint(0) NOT NULL DEFAULT 0 COMMENT '收藏数',
  `share_num` bigint(0) NOT NULL DEFAULT 0 COMMENT '分享数',
  `head_image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面地址',
  PRIMARY KEY (`article_id`) USING BTREE,
  INDEX `fk_author_id`(`author_id`) USING BTREE,
  CONSTRAINT `fk_author_id` FOREIGN KEY (`author_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `CategoryID` int(0) NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签名',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签描述',
  PRIMARY KEY (`CategoryID`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for chat_records
-- ----------------------------
DROP TABLE IF EXISTS `chat_records`;
CREATE TABLE `chat_records`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '咨询内容',
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色',
  `session_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会话ID',
  `timestamp` datetime(6) NULL DEFAULT NULL COMMENT '时间戳',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_chat_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `FK_chat_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments`  (
  `comment_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '评论ID',
  `article_id` int(0) NULL DEFAULT NULL COMMENT '文章ID',
  `user_id` int(0) NULL DEFAULT NULL COMMENT '用户ID',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文本',
  `publish_date` datetime(6) NULL DEFAULT NULL COMMENT '发布时间',
  `ip` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'IP地址',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `fk_article_comment`(`article_id`) USING BTREE,
  INDEX `fk_user_comment`(`user_id`) USING BTREE,
  CONSTRAINT `fk_article_comment` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_comment` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 24 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for data_operation_logs
-- ----------------------------
DROP TABLE IF EXISTS `data_operation_logs`;
CREATE TABLE `data_operation_logs`  (
  `log_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '日志ID',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `table_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表名',
  `operation_type` enum('INSERT','UPDATE','DELETE') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作类型',
  `operation_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '操作时间',
  `operation_detail` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '操作详情',
  PRIMARY KEY (`log_id`) USING BTREE,
  INDEX `user_id`(`user_id`) USING BTREE,
  CONSTRAINT `data_operation_logs_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for orders
-- ----------------------------
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders`  (
  `id` bigint(0) NOT NULL AUTO_INCREMENT COMMENT '订单号',
  `uid` int(0) NOT NULL COMMENT '用户ID',
  `out_trade_no` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '传输编号',
  `total_amount` decimal(38, 2) NULL DEFAULT NULL COMMENT '总数',
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '提交体',
  `body` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '响应体',
  `order_status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单状态',
  `payment_time` datetime(6) NULL DEFAULT NULL COMMENT '支付时间',
  `create_time` datetime(6) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(6) NULL DEFAULT NULL COMMENT '更新时间',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单状态',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_orders_uid`(`uid`) USING BTREE,
  CONSTRAINT `fk_orders_uid` FOREIGN KEY (`uid`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags`  (
  `tag_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `label` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '板块',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由',
  PRIMARY KEY (`tag_id`) USING BTREE,
  UNIQUE INDEX `Name`(`label`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_role_relations
-- ----------------------------
DROP TABLE IF EXISTS `user_role_relations`;
CREATE TABLE `user_role_relations`  (
  `relation_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '关系ID',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  `role_id` int(0) NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`relation_id`) USING BTREE,
  UNIQUE INDEX `unique_user_role`(`user_id`, `role_id`) USING BTREE,
  INDEX `role_id`(`role_id`) USING BTREE,
  CONSTRAINT `user_role_relations_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_role_relations_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `user_roles` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_roles
-- ----------------------------
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles`  (
  `role_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色名',
  `role_description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限描述',
  PRIMARY KEY (`role_id`) USING BTREE,
  UNIQUE INDEX `unique_role_name`(`role_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user_vip_relations
-- ----------------------------
DROP TABLE IF EXISTS `user_vip_relations`;
CREATE TABLE `user_vip_relations`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '索引ID',
  `uid` int(0) NOT NULL COMMENT '用户ID',
  `vip_id` int(0) NOT NULL COMMENT '会员ID',
  PRIMARY KEY (`id`, `uid`, `vip_id`) USING BTREE,
  INDEX `fk_user_vip_relation_uid`(`uid`) USING BTREE,
  INDEX `fk_user_vip_relation_vip_id`(`vip_id`) USING BTREE,
  CONSTRAINT `fk_user_vip_relation_uid` FOREIGN KEY (`uid`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_vip_relation_vip_id` FOREIGN KEY (`vip_id`) REFERENCES `vip` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `user_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `register_date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '注册时间',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像',
  `is_author` enum('TRUE','FALSE') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'FALSE' COMMENT '作者标识',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `birthday` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生日',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `Username`(`user_name`) USING BTREE,
  UNIQUE INDEX `Email`(`email`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 28 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for vip
-- ----------------------------
DROP TABLE IF EXISTS `vip`;
CREATE TABLE `vip`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '会员ID',
  `type` enum('VIP1','VIP2','VIP3','VIP4','VIP5','VIP6','VIP7','VIP8','VIP9','VIP10','SVIP1','SVIP2','SVIP3','SVIP4','SVIP5','SVIP6','SVIP7','SVIP8','SVIP9','SVIP10','SVIP+') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'VIP1' COMMENT '会员类型',
  `durations` enum('1个月','3个月','6个月','12个月','24个月','48个月') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1个月' COMMENT '剩余时间',
  `durationsValue` int(0) NULL DEFAULT NULL COMMENT '时长',
  `price` decimal(10, 2) NULL DEFAULT NULL COMMENT '价格',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `PK_viptype_id`(`type`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Procedure structure for sp_delete_article
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_delete_article`;
delimiter ;;
CREATE PROCEDURE `sp_delete_article`(IN p_article_id INT,
  IN p_operator_id INT)
BEGIN
  -- 开启事务
  START TRANSACTION;
  
  -- 执行软删除并记录操作者
  UPDATE articles 
  SET 
    is_deleted = 1,
    author_id = p_operator_id
  WHERE article_id = p_article_id;
  
  -- 提交事务
  COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table article_coins
-- ----------------------------
DROP TRIGGER IF EXISTS `update_coin_num`;
delimiter ;;
CREATE TRIGGER `update_coin_num` AFTER INSERT ON `article_coins` FOR EACH ROW BEGIN
    UPDATE articles
    SET coin_num = coin_num + NEW.coin_count
    WHERE article_id = NEW.article_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table article_coins
-- ----------------------------
DROP TRIGGER IF EXISTS `increase_coin_num`;
delimiter ;;
CREATE TRIGGER `increase_coin_num` AFTER UPDATE ON `article_coins` FOR EACH ROW BEGIN
    UPDATE articles
    SET coin_num = NEW.coin_count
    WHERE article_id = NEW.article_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table article_favorites
-- ----------------------------
DROP TRIGGER IF EXISTS `increase_favorites_num`;
delimiter ;;
CREATE TRIGGER `increase_favorites_num` AFTER INSERT ON `article_favorites` FOR EACH ROW BEGIN
		UPDATE articles
		SET favorit_num = favorit_num + 1
		WHERE article_id = NEW.article_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table article_favorites
-- ----------------------------
DROP TRIGGER IF EXISTS `decrease_favorites_num`;
delimiter ;;
CREATE TRIGGER `decrease_favorites_num` AFTER DELETE ON `article_favorites` FOR EACH ROW BEGIN
		UPDATE articles
		SET favorit_num = favorit_num - 1
		WHERE article_id = OLD.article_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table article_likes
-- ----------------------------
DROP TRIGGER IF EXISTS `increase_like_num`;
delimiter ;;
CREATE TRIGGER `increase_like_num` AFTER INSERT ON `article_likes` FOR EACH ROW BEGIN
		UPDATE articles
		SET like_num = like_num + 1
		WHERE article_id = NEW.article_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table article_likes
-- ----------------------------
DROP TRIGGER IF EXISTS `decrease_like_num`;
delimiter ;;
CREATE TRIGGER `decrease_like_num` AFTER DELETE ON `article_likes` FOR EACH ROW BEGIN
		UPDATE articles
		SET like_num = like_num - 1
		WHERE article_id = OLD.article_id;
END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table articles
-- ----------------------------
DROP TRIGGER IF EXISTS `tf_articles_version`;
delimiter ;;
CREATE TRIGGER `tf_articles_version` BEFORE UPDATE ON `articles` FOR EACH ROW BEGIN
  DECLARE next_ver INT;
  DECLARE operation_type VARCHAR(20);

  -- 获取下一个版本号（使用行锁保证一致性）
  SELECT IFNULL(MAX(version_number), 0) + 1 
  INTO next_ver
  FROM article_versions 
  WHERE article_id = OLD.article_id
  LOCK IN SHARE MODE;

  -- 自动识别操作类型
  SET operation_type = CASE
    -- 删除操作优先判断
    WHEN NEW.is_deleted = 1 AND OLD.is_deleted = 0 THEN 'DELETE'
    -- 恢复操作（从删除状态恢复）
    WHEN OLD.is_deleted = 1 AND NEW.is_deleted = 0 THEN 'RESTORE'
    -- 多条件变更判断
    WHEN OLD.title != NEW.title AND OLD.content != NEW.content THEN 'UPDATE_BOTH'
    WHEN OLD.title != NEW.title THEN 'UPDATE_TITLE'
    WHEN OLD.content != NEW.content THEN 'UPDATE_CONTENT'
    -- 其他未知变更
    ELSE 'NONE'
  END;

  -- 需要记录版本的情况（排除无意义更新）
  IF operation_type != 'NONE' THEN
    INSERT INTO article_versions (
      article_id,
      author_id,
      version_number,
      content,
      option_type,
			operator_id
    ) VALUES (
      OLD.article_id,
      OLD.author_id,
      next_ver,
      OLD.content,  -- 记录变更前内容
      operation_type,
			NEW.last_operator_id
    );
  END IF;
END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
