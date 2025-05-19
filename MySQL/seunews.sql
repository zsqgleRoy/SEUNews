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

 Date: 19/05/2025 08:07:38
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
-- Records of article_categories
-- ----------------------------
INSERT INTO `article_categories` VALUES (1, 1);

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
-- Records of article_coins
-- ----------------------------
INSERT INTO `article_coins` VALUES (1, 2, 7, '2025-05-05 08:14:23');
INSERT INTO `article_coins` VALUES (1, 4, 1, '2025-05-07 09:47:48');
INSERT INTO `article_coins` VALUES (1, 14, 2, '2025-05-05 08:50:08');
INSERT INTO `article_coins` VALUES (1, 16, 1, '2025-05-05 08:03:46');
INSERT INTO `article_coins` VALUES (1, 17, 1, '2025-05-05 09:17:50');
INSERT INTO `article_coins` VALUES (26, 2, 1, '2025-05-08 06:10:59');
INSERT INTO `article_coins` VALUES (27, 15, 1, '2025-05-08 07:15:23');
INSERT INTO `article_coins` VALUES (27, 31, 1, '2025-05-08 06:46:56');

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
-- Records of article_favorites
-- ----------------------------
INSERT INTO `article_favorites` VALUES (1, 4, '2025-05-13 17:07:41');
INSERT INTO `article_favorites` VALUES (1, 16, '2025-05-05 09:46:16');
INSERT INTO `article_favorites` VALUES (2, 2, '2025-05-04 17:35:16');
INSERT INTO `article_favorites` VALUES (26, 2, '2025-05-08 06:11:00');
INSERT INTO `article_favorites` VALUES (27, 31, '2025-05-08 06:46:56');

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
-- Records of article_likes
-- ----------------------------
INSERT INTO `article_likes` VALUES (1, 4, '2025-05-13 17:06:57');
INSERT INTO `article_likes` VALUES (1, 23, '2025-05-12 07:54:24');
INSERT INTO `article_likes` VALUES (24, 2, '2025-05-04 11:41:39');
INSERT INTO `article_likes` VALUES (24, 3, '2025-05-04 14:13:55');
INSERT INTO `article_likes` VALUES (24, 17, '2025-05-04 14:58:28');
INSERT INTO `article_likes` VALUES (26, 2, '2025-05-08 06:10:57');
INSERT INTO `article_likes` VALUES (26, 4, '2025-05-08 07:02:43');
INSERT INTO `article_likes` VALUES (26, 15, '2025-05-08 06:26:49');
INSERT INTO `article_likes` VALUES (26, 20, '2025-05-08 06:13:45');
INSERT INTO `article_likes` VALUES (27, 15, '2025-05-08 07:15:22');
INSERT INTO `article_likes` VALUES (27, 31, '2025-05-08 06:46:55');

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
-- Records of article_tags
-- ----------------------------
INSERT INTO `article_tags` VALUES (1, 1);
INSERT INTO `article_tags` VALUES (2, 1);
INSERT INTO `article_tags` VALUES (12, 1);
INSERT INTO `article_tags` VALUES (23, 1);
INSERT INTO `article_tags` VALUES (24, 1);
INSERT INTO `article_tags` VALUES (25, 1);
INSERT INTO `article_tags` VALUES (26, 1);
INSERT INTO `article_tags` VALUES (27, 1);
INSERT INTO `article_tags` VALUES (65, 1);
INSERT INTO `article_tags` VALUES (66, 1);
INSERT INTO `article_tags` VALUES (67, 1);
INSERT INTO `article_tags` VALUES (4, 2);
INSERT INTO `article_tags` VALUES (11, 2);
INSERT INTO `article_tags` VALUES (28, 2);
INSERT INTO `article_tags` VALUES (30, 2);
INSERT INTO `article_tags` VALUES (61, 2);
INSERT INTO `article_tags` VALUES (62, 2);
INSERT INTO `article_tags` VALUES (64, 2);
INSERT INTO `article_tags` VALUES (66, 2);
INSERT INTO `article_tags` VALUES (15, 3);
INSERT INTO `article_tags` VALUES (63, 3);
INSERT INTO `article_tags` VALUES (65, 3);
INSERT INTO `article_tags` VALUES (66, 3);
INSERT INTO `article_tags` VALUES (3, 4);
INSERT INTO `article_tags` VALUES (16, 4);
INSERT INTO `article_tags` VALUES (21, 4);
INSERT INTO `article_tags` VALUES (22, 4);
INSERT INTO `article_tags` VALUES (66, 4);
INSERT INTO `article_tags` VALUES (67, 4);
INSERT INTO `article_tags` VALUES (17, 5);
INSERT INTO `article_tags` VALUES (18, 5);
INSERT INTO `article_tags` VALUES (19, 5);
INSERT INTO `article_tags` VALUES (60, 5);
INSERT INTO `article_tags` VALUES (66, 5);
INSERT INTO `article_tags` VALUES (13, 6);
INSERT INTO `article_tags` VALUES (31, 6);
INSERT INTO `article_tags` VALUES (32, 6);
INSERT INTO `article_tags` VALUES (34, 6);
INSERT INTO `article_tags` VALUES (66, 6);
INSERT INTO `article_tags` VALUES (14, 7);
INSERT INTO `article_tags` VALUES (20, 7);
INSERT INTO `article_tags` VALUES (33, 7);
INSERT INTO `article_tags` VALUES (66, 7);
INSERT INTO `article_tags` VALUES (66, 8);

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
) ENGINE = InnoDB AUTO_INCREMENT = 35 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of article_versions
-- ----------------------------
INSERT INTO `article_versions` VALUES (13, 4, 10, 1, '<p style=\"line-height: 1;\"><span style=\"font-size: 19px; font-family: 楷体_GB2312;\">新华社北京5月7日电 外交部发言人7日就当前印巴局势答记者问。</span></p><p style=\"line-height: 1;\"><span style=\"font-size: 19px; font-family: 楷体_GB2312;\">　　有记者问：近期，印度和巴基斯坦之间的紧张局势持续升级。印度7日凌晨对巴基斯坦境内目标进行了军事打击，巴方作出强烈反应。中方对此有何评论？</span></p><p style=\"line-height: 1;\"><span style=\"font-size: 19px; font-family: 楷体_GB2312;\">　　发言人表示：“中方对今天凌晨印度的军事行动表示遗憾，对目前事态发展感到担忧。印度和巴基斯坦是搬不走的邻居，也都是中国的邻国。中方反对一切形式的恐怖主义。我们呼吁印巴双方以和平稳定大局为重，保持冷静克制，避免采取使局势进一步复杂化的行动。”</span></p><p style=\"text-align: right; line-height: 1;\">(责编：牛镛、岳弘彬)</p>', '2025-05-07 17:40:01', 'UPDATE_CONTENT', 10);
INSERT INTO `article_versions` VALUES (14, 4, 10, 2, '<p style=\"line-height: 1;\"><span style=\"font-size: 19px; font-family: 楷体_GB2312;\">新华社北京5月7日电 外交部发言人7日就当前印巴局势答记者问。</span></p><p style=\"line-height: 1;\"><span style=\"font-size: 19px; font-family: 楷体_GB2312;\"> 有记者问：近期，印度和巴基斯坦之间的紧张局势持续升级。印度7日凌晨对巴基斯坦境内目标进行了军事打击，巴方作出强烈反应。中方对此有何评论？</span></p><p style=\"line-height: 1;\"><span style=\"font-size: 19px; font-family: 楷体_GB2312;\"> 发言人表示：“中方对今天凌晨印度的军事行动表示遗憾，对目前事态发展感到担忧。印度和巴基斯坦是搬不走的邻居，也都是中国的邻国。中方反对一切形式的恐怖主义。我们呼吁印巴双方以和平稳定大局为重，保持冷静克制，避免采取使局势进一步复杂化的行动。”</span></p><p style=\"text-align: right; line-height: 1;\">(责编：牛镛、岳弘彬)</p>', '2025-05-07 17:46:46', 'UPDATE_CONTENT', 10);
INSERT INTO `article_versions` VALUES (16, 11, 1, 1, '<p>您好！</p>', '2025-05-09 00:01:01', 'DELETE', 1);
INSERT INTO `article_versions` VALUES (19, 20, 6, 1, '<p><br></p><p style=\"text-align: center;\"><img src=\"http://192.168.124.5:8080/static/news-images/20250322234727158_9bbbcc17.jpg\" alt=\"\" data-href=\"\" style=\"\"></p><p style=\"text-align: center;\">这是测试新闻</p>', '2025-05-09 00:39:15', 'DELETE', 1);
INSERT INTO `article_versions` VALUES (20, 20, 6, 2, '<p><br></p><p style=\"text-align: center;\"><img src=\"http://192.168.124.5:8080/static/news-images/20250322234727158_9bbbcc17.jpg\" alt=\"\" data-href=\"\" style=\"\"></p><p style=\"text-align: center;\">这是测试新闻</p>', '2025-05-09 00:39:23', 'RESTORE', 1);
INSERT INTO `article_versions` VALUES (21, 33, 27, 1, '<p>2025 年我国乡村规划主要依据《乡村全面振兴规划（2024 - 2027 年）》开展，以下是相关内容1：</p><h3 style=\"text-align: start;\">总体要求</h3><p>以习近平新时代中国特色社会主义思想为指导，深入贯彻党的二十大和二十届二中、三中全会精神，认真贯彻落实习近平总书记关于 “三农” 工作的重要论述，完整准确全面贯彻新发展理念，加快构建新发展格局，着力推动高质量发展，锚定建设农业强国目标，学习运用 “千万工程” 经验，健全推动乡村全面振兴长效机制，以确保国家粮食安全、确保农村人口不发生规模性返贫致贫为底线，巩固拓展脱贫攻坚成果，以提升乡村产业发展水平、提升乡村建设水平、提升乡村治理水平为重点，强化科技和改革双轮驱动，强化农民增收举措，扎实推进乡村产业、人才、文化、生态、组织 “五个振兴”，加快农业农村现代化。</p><h3 style=\"text-align: start;\">优化城乡发展格局，分类有序推进乡村全面振兴</h3><ul><li style=\"text-align: start;\"><span><strong>统筹优化城乡发展布局</strong></span>：以资源环境承载能力和国土空间开发适宜性评价为基础，优化农业、生态和城镇空间。严守耕地和永久基本农田、生态保护红线和城镇开发边界等主要控制线，科学编制实施县级国土空间总体规划。优化乡村功能和空间布局，加强农产品主产区建设，筑牢生态安全屏障。</li><li style=\"text-align: start;\"><span><strong>推进城乡融合发展</strong></span>：实施新一轮农业转移人口市民化行动，构建城乡统一的建设用地市场，率先在县域内破除城乡二元结构，一体推进城镇和乡村规划、建设和治理，推动城乡基本公共服务均等化，支持中西部农产品主产区县城建设，把乡镇建成乡村治理中心、农村服务中心、乡村经济中心，推动县域产业协同发展。</li><li style=\"text-align: start;\"><span><strong>分类推进乡村全面振兴</strong></span>：集聚提升类村庄重点强化产业发展，改造提升基础设施；城郊融合类村庄重点推动城乡一体化建设；特色保护类村庄重点改善基础设施和公共环境；搬迁撤并类村庄有序实施搬迁撤并，解决好民生保障、就业增收和生态保护等问题。</li><li style=\"text-align: start;\"><span><strong>衔接推进脱贫地区全面振兴</strong></span>：过渡期内保持主要帮扶政策总体稳定，抓好防止返贫监测，落实帮扶措施，完善覆盖农村人口的常态化防止返贫致贫机制。加快补齐脱贫地区农村基础设施短板，推进脱贫地区帮扶产业高质量发展，深化东西部协作、定点帮扶，推动帮扶政策体系向推进乡村全面振兴转换。</li></ul><h3 style=\"text-align: start;\">加快现代农业建设，全方位夯实粮食安全根基</h3><p>把确保国家粮食安全作为现代农业建设的首要任务，全面落实粮食安全党政同责，坚持稳面积、增单产两手发力，确保粮食播种面积稳定在 17.5 亿亩左右、谷物面积 14.5 亿亩左右。组织实施新一轮千亿斤粮食产能提升行动，大力实施粮食单产提升工程，推动粮食产能稳步迈上 1.4 万亿斤台阶。深入实施国家大豆和油料产能提升工程，构建多元化食物供给体系。</p><h3 style=\"text-align: start;\">推动乡村产业高质量发展，促进农民收入增长</h3><p>构建现代乡村产业体系，深化农村一二三产业融合发展。</p><h3 style=\"text-align: start;\">大力培养乡村人才，吸引各类人才投身乡村全面振兴</h3><p>改善乡村生态环境，推进耕地草原森林河湖休养生息，完善相关制度，开展重点生态系统保护和修复重大工程，开展生态环境突出问题治理，建立农村生态环境监测评价制度，完善生态产品价值实现机制。</p><h3 style=\"text-align: start;\">建设宜居宜业和美乡村，增进农民福祉</h3><ul><li style=\"text-align: start;\"><span><strong>推进基础设施提档升级</strong></span>：提高路网通达水平，强化供水安全保障，优化能源供给，提升农房质量安全水平。</li><li style=\"text-align: start;\"><span><strong>持续改善人居环境</strong></span>：深入实施乡村建设行动，因地制宜扎实推进农村厕所革命，推进农村厕所革命与生活污水治理有机衔接，分类开展生活污水治理，提高生活垃圾治理水平，提升村容村貌。</li><li style=\"text-align: start;\"><span><strong>稳步提升基本公共服务水平</strong></span>：提高农村教育质量，推进健康乡村建设，完善基础民生保障。</li><li style=\"text-align: start;\"><span><strong>完善农村社区服务设施</strong></span>：统筹规划科学布局，合理安排农村社区服务设施建设，提升农村社区服务设施效能。</li><li style=\"text-align: start;\"><span><strong>加快数字乡村建设</strong></span>：完善信息基础设施，加快管理服务数字化，持续实施数字乡村发展行动。</li><li style=\"text-align: start;\"><span><strong>优化乡村规划建设</strong></span>：因地制宜编制村庄规划，引导农民参与村庄规划建设管理，严禁违背农民意愿搞大拆大建，开展乡村建设评价，健全农村公共基础设施运行管护机制。</li></ul><h3 style=\"text-align: start;\">深化农业农村改革，激发农村发展活力</h3><p>巩固和完善农村基本经营制度，有序推进第二轮土地承包到期后再延长 30 年试点，深化承包地所有权、承包权、经营权分置改革，发展农业适度规模经营，巩固提升农村集体产权制度改革成果，发展新型农村集体经济</p>', '2025-05-09 01:18:07', 'DELETE', 1);
INSERT INTO `article_versions` VALUES (22, 34, 27, 1, '<p>2025 年我国乡村规划主要依据《乡村全面振兴规划（2024 - 2027 年）》开展，以下是相关内容1：</p><h3 style=\"text-align: start;\">总体要求</h3><p>以习近平新时代中国特色社会主义思想为指导，深入贯彻党的二十大和二十届二中、三中全会精神，认真贯彻落实习近平总书记关于 “三农” 工作的重要论述，完整准确全面贯彻新发展理念，加快构建新发展格局，着力推动高质量发展，锚定建设农业强国目标，学习运用 “千万工程” 经验，健全推动乡村全面振兴长效机制，以确保国家粮食安全、确保农村人口不发生规模性返贫致贫为底线，巩固拓展脱贫攻坚成果，以提升乡村产业发展水平、提升乡村建设水平、提升乡村治理水平为重点，强化科技和改革双轮驱动，强化农民增收举措，扎实推进乡村产业、人才、文化、生态、组织 “五个振兴”，加快农业农村现代化。</p><h3 style=\"text-align: start;\">优化城乡发展格局，分类有序推进乡村全面振兴</h3><ul><li style=\"text-align: start;\"><span><strong>统筹优化城乡发展布局</strong></span>：以资源环境承载能力和国土空间开发适宜性评价为基础，优化农业、生态和城镇空间。严守耕地和永久基本农田、生态保护红线和城镇开发边界等主要控制线，科学编制实施县级国土空间总体规划。优化乡村功能和空间布局，加强农产品主产区建设，筑牢生态安全屏障。</li><li style=\"text-align: start;\"><span><strong>推进城乡融合发展</strong></span>：实施新一轮农业转移人口市民化行动，构建城乡统一的建设用地市场，率先在县域内破除城乡二元结构，一体推进城镇和乡村规划、建设和治理，推动城乡基本公共服务均等化，支持中西部农产品主产区县城建设，把乡镇建成乡村治理中心、农村服务中心、乡村经济中心，推动县域产业协同发展。</li><li style=\"text-align: start;\"><span><strong>分类推进乡村全面振兴</strong></span>：集聚提升类村庄重点强化产业发展，改造提升基础设施；城郊融合类村庄重点推动城乡一体化建设；特色保护类村庄重点改善基础设施和公共环境；搬迁撤并类村庄有序实施搬迁撤并，解决好民生保障、就业增收和生态保护等问题。</li><li style=\"text-align: start;\"><span><strong>衔接推进脱贫地区全面振兴</strong></span>：过渡期内保持主要帮扶政策总体稳定，抓好防止返贫监测，落实帮扶措施，完善覆盖农村人口的常态化防止返贫致贫机制。加快补齐脱贫地区农村基础设施短板，推进脱贫地区帮扶产业高质量发展，深化东西部协作、定点帮扶，推动帮扶政策体系向推进乡村全面振兴转换。</li></ul><h3 style=\"text-align: start;\">加快现代农业建设，全方位夯实粮食安全根基</h3><p>把确保国家粮食安全作为现代农业建设的首要任务，全面落实粮食安全党政同责，坚持稳面积、增单产两手发力，确保粮食播种面积稳定在 17.5 亿亩左右、谷物面积 14.5 亿亩左右。组织实施新一轮千亿斤粮食产能提升行动，大力实施粮食单产提升工程，推动粮食产能稳步迈上 1.4 万亿斤台阶。深入实施国家大豆和油料产能提升工程，构建多元化食物供给体系。</p><h3 style=\"text-align: start;\">推动乡村产业高质量发展，促进农民收入增长</h3><p>构建现代乡村产业体系，深化农村一二三产业融合发展。</p><h3 style=\"text-align: start;\">大力培养乡村人才，吸引各类人才投身乡村全面振兴</h3><p>改善乡村生态环境，推进耕地草原森林河湖休养生息，完善相关制度，开展重点生态系统保护和修复重大工程，开展生态环境突出问题治理，建立农村生态环境监测评价制度，完善生态产品价值实现机制。</p><h3 style=\"text-align: start;\">建设宜居宜业和美乡村，增进农民福祉</h3><ul><li style=\"text-align: start;\"><span><strong>推进基础设施提档升级</strong></span>：提高路网通达水平，强化供水安全保障，优化能源供给，提升农房质量安全水平。</li><li style=\"text-align: start;\"><span><strong>持续改善人居环境</strong></span>：深入实施乡村建设行动，因地制宜扎实推进农村厕所革命，推进农村厕所革命与生活污水治理有机衔接，分类开展生活污水治理，提高生活垃圾治理水平，提升村容村貌。</li><li style=\"text-align: start;\"><span><strong>稳步提升基本公共服务水平</strong></span>：提高农村教育质量，推进健康乡村建设，完善基础民生保障。</li><li style=\"text-align: start;\"><span><strong>完善农村社区服务设施</strong></span>：统筹规划科学布局，合理安排农村社区服务设施建设，提升农村社区服务设施效能。</li><li style=\"text-align: start;\"><span><strong>加快数字乡村建设</strong></span>：完善信息基础设施，加快管理服务数字化，持续实施数字乡村发展行动。</li><li style=\"text-align: start;\"><span><strong>优化乡村规划建设</strong></span>：因地制宜编制村庄规划，引导农民参与村庄规划建设管理，严禁违背农民意愿搞大拆大建，开展乡村建设评价，健全农村公共基础设施运行管护机制。</li></ul><h3 style=\"text-align: start;\">深化农业农村改革，激发农村发展活力</h3><p>巩固和完善农村基本经营制度，有序推进第二轮土地承包到期后再延长 30 年试点，深化承包地所有权、承包权、经营权分置改革，发展农业适度规模经营，巩固提升农村集体产权制度改革成果，发展新型农村集体经济</p>', '2025-05-09 01:18:07', 'DELETE', 1);
INSERT INTO `article_versions` VALUES (23, 33, 27, 2, '<p>2025 年我国乡村规划主要依据《乡村全面振兴规划（2024 - 2027 年）》开展，以下是相关内容1：</p><h3 style=\"text-align: start;\">总体要求</h3><p>以习近平新时代中国特色社会主义思想为指导，深入贯彻党的二十大和二十届二中、三中全会精神，认真贯彻落实习近平总书记关于 “三农” 工作的重要论述，完整准确全面贯彻新发展理念，加快构建新发展格局，着力推动高质量发展，锚定建设农业强国目标，学习运用 “千万工程” 经验，健全推动乡村全面振兴长效机制，以确保国家粮食安全、确保农村人口不发生规模性返贫致贫为底线，巩固拓展脱贫攻坚成果，以提升乡村产业发展水平、提升乡村建设水平、提升乡村治理水平为重点，强化科技和改革双轮驱动，强化农民增收举措，扎实推进乡村产业、人才、文化、生态、组织 “五个振兴”，加快农业农村现代化。</p><h3 style=\"text-align: start;\">优化城乡发展格局，分类有序推进乡村全面振兴</h3><ul><li style=\"text-align: start;\"><span><strong>统筹优化城乡发展布局</strong></span>：以资源环境承载能力和国土空间开发适宜性评价为基础，优化农业、生态和城镇空间。严守耕地和永久基本农田、生态保护红线和城镇开发边界等主要控制线，科学编制实施县级国土空间总体规划。优化乡村功能和空间布局，加强农产品主产区建设，筑牢生态安全屏障。</li><li style=\"text-align: start;\"><span><strong>推进城乡融合发展</strong></span>：实施新一轮农业转移人口市民化行动，构建城乡统一的建设用地市场，率先在县域内破除城乡二元结构，一体推进城镇和乡村规划、建设和治理，推动城乡基本公共服务均等化，支持中西部农产品主产区县城建设，把乡镇建成乡村治理中心、农村服务中心、乡村经济中心，推动县域产业协同发展。</li><li style=\"text-align: start;\"><span><strong>分类推进乡村全面振兴</strong></span>：集聚提升类村庄重点强化产业发展，改造提升基础设施；城郊融合类村庄重点推动城乡一体化建设；特色保护类村庄重点改善基础设施和公共环境；搬迁撤并类村庄有序实施搬迁撤并，解决好民生保障、就业增收和生态保护等问题。</li><li style=\"text-align: start;\"><span><strong>衔接推进脱贫地区全面振兴</strong></span>：过渡期内保持主要帮扶政策总体稳定，抓好防止返贫监测，落实帮扶措施，完善覆盖农村人口的常态化防止返贫致贫机制。加快补齐脱贫地区农村基础设施短板，推进脱贫地区帮扶产业高质量发展，深化东西部协作、定点帮扶，推动帮扶政策体系向推进乡村全面振兴转换。</li></ul><h3 style=\"text-align: start;\">加快现代农业建设，全方位夯实粮食安全根基</h3><p>把确保国家粮食安全作为现代农业建设的首要任务，全面落实粮食安全党政同责，坚持稳面积、增单产两手发力，确保粮食播种面积稳定在 17.5 亿亩左右、谷物面积 14.5 亿亩左右。组织实施新一轮千亿斤粮食产能提升行动，大力实施粮食单产提升工程，推动粮食产能稳步迈上 1.4 万亿斤台阶。深入实施国家大豆和油料产能提升工程，构建多元化食物供给体系。</p><h3 style=\"text-align: start;\">推动乡村产业高质量发展，促进农民收入增长</h3><p>构建现代乡村产业体系，深化农村一二三产业融合发展。</p><h3 style=\"text-align: start;\">大力培养乡村人才，吸引各类人才投身乡村全面振兴</h3><p>改善乡村生态环境，推进耕地草原森林河湖休养生息，完善相关制度，开展重点生态系统保护和修复重大工程，开展生态环境突出问题治理，建立农村生态环境监测评价制度，完善生态产品价值实现机制。</p><h3 style=\"text-align: start;\">建设宜居宜业和美乡村，增进农民福祉</h3><ul><li style=\"text-align: start;\"><span><strong>推进基础设施提档升级</strong></span>：提高路网通达水平，强化供水安全保障，优化能源供给，提升农房质量安全水平。</li><li style=\"text-align: start;\"><span><strong>持续改善人居环境</strong></span>：深入实施乡村建设行动，因地制宜扎实推进农村厕所革命，推进农村厕所革命与生活污水治理有机衔接，分类开展生活污水治理，提高生活垃圾治理水平，提升村容村貌。</li><li style=\"text-align: start;\"><span><strong>稳步提升基本公共服务水平</strong></span>：提高农村教育质量，推进健康乡村建设，完善基础民生保障。</li><li style=\"text-align: start;\"><span><strong>完善农村社区服务设施</strong></span>：统筹规划科学布局，合理安排农村社区服务设施建设，提升农村社区服务设施效能。</li><li style=\"text-align: start;\"><span><strong>加快数字乡村建设</strong></span>：完善信息基础设施，加快管理服务数字化，持续实施数字乡村发展行动。</li><li style=\"text-align: start;\"><span><strong>优化乡村规划建设</strong></span>：因地制宜编制村庄规划，引导农民参与村庄规划建设管理，严禁违背农民意愿搞大拆大建，开展乡村建设评价，健全农村公共基础设施运行管护机制。</li></ul><h3 style=\"text-align: start;\">深化农业农村改革，激发农村发展活力</h3><p>巩固和完善农村基本经营制度，有序推进第二轮土地承包到期后再延长 30 年试点，深化承包地所有权、承包权、经营权分置改革，发展农业适度规模经营，巩固提升农村集体产权制度改革成果，发展新型农村集体经济</p>', '2025-05-09 01:18:21', 'RESTORE', 1);
INSERT INTO `article_versions` VALUES (24, 34, 27, 2, '<p>2025 年我国乡村规划主要依据《乡村全面振兴规划（2024 - 2027 年）》开展，以下是相关内容1：</p><h3 style=\"text-align: start;\">总体要求</h3><p>以习近平新时代中国特色社会主义思想为指导，深入贯彻党的二十大和二十届二中、三中全会精神，认真贯彻落实习近平总书记关于 “三农” 工作的重要论述，完整准确全面贯彻新发展理念，加快构建新发展格局，着力推动高质量发展，锚定建设农业强国目标，学习运用 “千万工程” 经验，健全推动乡村全面振兴长效机制，以确保国家粮食安全、确保农村人口不发生规模性返贫致贫为底线，巩固拓展脱贫攻坚成果，以提升乡村产业发展水平、提升乡村建设水平、提升乡村治理水平为重点，强化科技和改革双轮驱动，强化农民增收举措，扎实推进乡村产业、人才、文化、生态、组织 “五个振兴”，加快农业农村现代化。</p><h3 style=\"text-align: start;\">优化城乡发展格局，分类有序推进乡村全面振兴</h3><ul><li style=\"text-align: start;\"><span><strong>统筹优化城乡发展布局</strong></span>：以资源环境承载能力和国土空间开发适宜性评价为基础，优化农业、生态和城镇空间。严守耕地和永久基本农田、生态保护红线和城镇开发边界等主要控制线，科学编制实施县级国土空间总体规划。优化乡村功能和空间布局，加强农产品主产区建设，筑牢生态安全屏障。</li><li style=\"text-align: start;\"><span><strong>推进城乡融合发展</strong></span>：实施新一轮农业转移人口市民化行动，构建城乡统一的建设用地市场，率先在县域内破除城乡二元结构，一体推进城镇和乡村规划、建设和治理，推动城乡基本公共服务均等化，支持中西部农产品主产区县城建设，把乡镇建成乡村治理中心、农村服务中心、乡村经济中心，推动县域产业协同发展。</li><li style=\"text-align: start;\"><span><strong>分类推进乡村全面振兴</strong></span>：集聚提升类村庄重点强化产业发展，改造提升基础设施；城郊融合类村庄重点推动城乡一体化建设；特色保护类村庄重点改善基础设施和公共环境；搬迁撤并类村庄有序实施搬迁撤并，解决好民生保障、就业增收和生态保护等问题。</li><li style=\"text-align: start;\"><span><strong>衔接推进脱贫地区全面振兴</strong></span>：过渡期内保持主要帮扶政策总体稳定，抓好防止返贫监测，落实帮扶措施，完善覆盖农村人口的常态化防止返贫致贫机制。加快补齐脱贫地区农村基础设施短板，推进脱贫地区帮扶产业高质量发展，深化东西部协作、定点帮扶，推动帮扶政策体系向推进乡村全面振兴转换。</li></ul><h3 style=\"text-align: start;\">加快现代农业建设，全方位夯实粮食安全根基</h3><p>把确保国家粮食安全作为现代农业建设的首要任务，全面落实粮食安全党政同责，坚持稳面积、增单产两手发力，确保粮食播种面积稳定在 17.5 亿亩左右、谷物面积 14.5 亿亩左右。组织实施新一轮千亿斤粮食产能提升行动，大力实施粮食单产提升工程，推动粮食产能稳步迈上 1.4 万亿斤台阶。深入实施国家大豆和油料产能提升工程，构建多元化食物供给体系。</p><h3 style=\"text-align: start;\">推动乡村产业高质量发展，促进农民收入增长</h3><p>构建现代乡村产业体系，深化农村一二三产业融合发展。</p><h3 style=\"text-align: start;\">大力培养乡村人才，吸引各类人才投身乡村全面振兴</h3><p>改善乡村生态环境，推进耕地草原森林河湖休养生息，完善相关制度，开展重点生态系统保护和修复重大工程，开展生态环境突出问题治理，建立农村生态环境监测评价制度，完善生态产品价值实现机制。</p><h3 style=\"text-align: start;\">建设宜居宜业和美乡村，增进农民福祉</h3><ul><li style=\"text-align: start;\"><span><strong>推进基础设施提档升级</strong></span>：提高路网通达水平，强化供水安全保障，优化能源供给，提升农房质量安全水平。</li><li style=\"text-align: start;\"><span><strong>持续改善人居环境</strong></span>：深入实施乡村建设行动，因地制宜扎实推进农村厕所革命，推进农村厕所革命与生活污水治理有机衔接，分类开展生活污水治理，提高生活垃圾治理水平，提升村容村貌。</li><li style=\"text-align: start;\"><span><strong>稳步提升基本公共服务水平</strong></span>：提高农村教育质量，推进健康乡村建设，完善基础民生保障。</li><li style=\"text-align: start;\"><span><strong>完善农村社区服务设施</strong></span>：统筹规划科学布局，合理安排农村社区服务设施建设，提升农村社区服务设施效能。</li><li style=\"text-align: start;\"><span><strong>加快数字乡村建设</strong></span>：完善信息基础设施，加快管理服务数字化，持续实施数字乡村发展行动。</li><li style=\"text-align: start;\"><span><strong>优化乡村规划建设</strong></span>：因地制宜编制村庄规划，引导农民参与村庄规划建设管理，严禁违背农民意愿搞大拆大建，开展乡村建设评价，健全农村公共基础设施运行管护机制。</li></ul><h3 style=\"text-align: start;\">深化农业农村改革，激发农村发展活力</h3><p>巩固和完善农村基本经营制度，有序推进第二轮土地承包到期后再延长 30 年试点，深化承包地所有权、承包权、经营权分置改革，发展农业适度规模经营，巩固提升农村集体产权制度改革成果，发展新型农村集体经济</p>', '2025-05-09 01:18:21', 'RESTORE', 1);
INSERT INTO `article_versions` VALUES (25, 11, 1, 2, '<p>您好！</p>', '2025-05-12 15:53:38', 'RESTORE', 1);
INSERT INTO `article_versions` VALUES (26, 21, 6, 1, '<p><br></p><p style=\"text-align: center;\"><img src=\"http://192.168.124.5:8080/static/news-images/20250322234727158_9bbbcc17.jpg\" alt=\"\" data-href=\"\" style=\"\"></p><p style=\"text-align: center;\">这是测试新闻</p>', '2025-05-15 00:39:17', 'DELETE', 1);
INSERT INTO `article_versions` VALUES (27, 21, 6, 2, '<p><br></p><p style=\"text-align: center;\"><img src=\"http://192.168.124.5:8080/static/news-images/20250322234727158_9bbbcc17.jpg\" alt=\"\" data-href=\"\" style=\"\"></p><p style=\"text-align: center;\">这是测试新闻</p>', '2025-05-15 00:41:18', 'RESTORE', 1);
INSERT INTO `article_versions` VALUES (28, 65, 1, 1, '<p>Test</p>', '2025-05-18 01:00:13', 'UPDATE_CONTENT', 1);
INSERT INTO `article_versions` VALUES (29, 66, 1, 1, '<p><span style=\"font-family: 楷体_GB2312;\"><strong>沈阳市浑南区政务服务中心工作人员接听群众咨询电话，根据《办事不找关系指南》引导群众办事。记者 &nbsp; &nbsp;刘佳华摄</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　党中央决定今年在全党开展深入贯彻中央八项规定精神学习教育，以作风建设新成效为进一步全面深化改革、推进中国式现代化提供有力保障。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　党的十八大以来，各地区各部门持之以恒加强作风建设，形成了一批好经验好做法。以这次学习教育为契机，广大党员干部立足岗位，进一步加强党性修养，密切联系群众，好的经验做法进一步完善，群众反映集中的问题努力解决，实事求是干事创业，在新征程上展现新担当新作为。本报记者来到办事服务一线，实地观察好作风带来的办事体验。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　——编 &nbsp; &nbsp;者</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　《办事不找关系指南》——</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　按照提示就能办成事</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　一本A4纸合订的手册，拿在手中沉甸甸的，却让每名前来办事的群众倍感轻松……在辽宁省沈阳市浑南区政务服务中心，大厅47个窗口前，都摆放着这样一本《办事不找关系指南》。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　4月10日早上，货车司机小张来到大厅“无差别综合受理专区”，带着材料，办理道路运输证年审。“上网一查，在《办事不找关系指南》里查到了该来这里申办、该准备哪些材料，很方便！”小张说。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　在辽宁，各级交通运输、税务、公安、人社、卫健等部门都会编发《办事不找关系指南》，列出权力事项清单、合规办事业务指南、违规禁办事项清单和容缺办理事项清单，每个事项后都附有二维码，用手机一扫，所需材料、受理窗口等信息一目了然。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　工作人员接过小张的材料，提交系统审核，却发现检测信息录入不进来。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“您这辆车是在外省进行检测的吧？当时上传的信息不全啊。”在大厅办公的浑南区交通运输局审批科科长关颖询问小张。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“对，当时在外地跑活儿，图方便，就当地检测了，那咋整啊？”一听这话，小张慌了，难道还要再去几千公里外补手续？</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“我们先沟通，争取能解决。”说着，关颖先是联系系统后台技术人员，再查询并拨通了外省检测线的电话，希望对方重新上传所需信息。几个电话后，对方重新上传了车辆检测信息，小张的道路运输证年审成功。小张长舒一口气：“不用我自己联系，政府工作人员就帮我沟通协调了。”</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　2023年起，辽宁省纪委监委联合辽宁省营商局推动各级政务服务部门、公用事业企业编制并推广《办事不找关系指南》，服务权力事项52.4万余个，指明“办事不找关系，找谁”的路径；同时通过线上平台和各级政务大厅部署应用《办事不找关系指南》，引导群众企业现场能用、网上可查、掌上会办。浑南区政务服务中心主任夏庆成说，《办事不找关系指南》事项清单一直在更新，努力囊括群众要办的所有事。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“我们正在努力清除群众办事的模糊地带，破解‘关系文化’的消极影响。”辽宁省纪委监委党风政风监督室主任杨哲说。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“亲清家园”小程序——</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　动动手指就能把事办好</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“研发人员都能拿到‘留才补贴’，一键轻松申领，大伙儿都干劲十足。”在福建省泉州市台商投资区的福建立亚新材有限公司，公司副总经理张燕真语带自豪。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　打开手机，轻点“亲清家园”小程序中的“惠企云兑”模块，一项要求3天内审批完成的“留才补贴”呈现在记者眼前。“额度14万元，线上就能办。”这几年，习惯了在“亲清家园”小程序上处理涉企事务的张燕真，对于“一键即享”功能很满意。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　这样的评价，在泉州台商投资区并不鲜见。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　原来，台商投资区纪检部门在走访调研中发现，惠企政策兑现“难、慢、迟、繁”，成为企业反映强烈的问题。于是，在“亲清家园”小程序上，惠企政策全部上线。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　从外地来到泉州创业的林明想了解自家企业能享受的优惠政策。早上9时，他点开小程序相关模块，问卷跳出：“您的企业是内资还是外资？”“企业所属行业是？”……一一填报提交后，提示跳出：“您的企业符合建筑企业外出经营奖励政策，金额45万元，请注意查看。”很快，多项惠企政策清晰明了地展示出来，再点击“一键申领”，流程中4个审批环节清晰可见。下午5时许，全部流程走完，资金在半小时后即到账。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“区里联动多家银行设立涉企财政资金池，时刻保持500万元总资金量，即用即拨，保证审批完成即到账。”台商投资区纪工委监察工委工作人员项学庆说，“涉企资金以‘企业能不能尽快领到钱’为标准，倒逼全流程提速增效。”</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　台商投资区政务服务中心主任王婉明说：“就拿立亚新材的这一笔‘留才补贴’申领来说，以前需要企业跑社保中心、公安、市场监管等部门办材料，最后提交至民生保障局审批。如今涉民生申请由民生保障局牵头，线上请各部门提供辅助材料，企业一趟也不用跑。”</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“现在，更多涉企业务在线上流转，和线下业务相互补充，原先98个线下业务窗口被整合为30个。”王婉明介绍。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　一组数据，见证小程序的实效：截至目前，“亲清家园”小程序累计受理企业申报3794家次，兑现惠企资金超5.12亿元，334家企业及2306人次通过“免申即享”享受奖补8377.2万元。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“平台功能逐步完善，纪工委监察工委实时监督，确保企业诉求高效处理，有效解决部门慢作为、不作为和乱作为问题。”台商投资区纪工委监察工委有关负责人表示。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“办不成事”反馈窗口——</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　不好办的事办得满意</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“这可咋办？这么重要的证明，咋没带呢？”4月7日一大早，在山东省菏泽市住房公积金服务大厅，专程从济南赶来的经办人李建粉急得来回踱步。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　前段时间，李建粉所在的公司从菏泽迁移到济南，他和同事专程赶回菏泽为公司办理公积金账户销户业务。谁承想，把公司注销证明的原件遗落在了办公室。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“两位遇到了什么问题吗？”服务大厅工作人员李啸见状走过来了解情况，然后把他们引到“办不成事”反馈窗口。</strong></span></p><p style=\"text-align: right;\"><span style=\"font-family: 楷体_GB2312;\"><strong>　　最近，菏泽市住房公积金管理中心在服务大厅设立“办不成事”反馈窗口，解决群众办事过程中的“疑难杂症”，通过多部门联动、主动上门服务、线上帮办等举措，帮助群众高效办事。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　在“办不成事”反馈窗口，工作人员胡莹莹受理了两人的业务。通过多部门数据共享，胡莹莹核实到该公司现为注销状态。随即，她启动“急事急办”机制，经过住房公积金管理中心审批同意后，最终使用网页销户截图作为凭证，不到10分钟，便完成了办理。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“还以为怎么也得再跑一趟呢，太感谢你们了！”李建粉说。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“现在数据共享，只要我们能核实到的信息，不会让您再多跑一趟。”胡莹莹说。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“办不成事”反馈窗口最近还拓展了更灵活的服务。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“人在广东回不来，这边菏泽公积金账户不解约，新单位缴存就卡壳了！”市民李丽拿着手机焦急地走到李啸面前，手机屏幕上是弟弟李道振发过来的求助信息。原来，5年前李道振以灵活就业人员身份在菏泽开设公积金账户，最近他在广东找到新工作，新公司却发现无法为其缴存公积金。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　胡莹莹启动特殊事项处理机制，使用“视讯办”发起视频核验，确认其本人的解约意愿，5分钟后，顺利完成了解约。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　依托“办不成事”反馈窗口，菏泽市住房公积金管理中心制定“视讯办”预案，对不便现场办理业务的群众，通过远程身份核验、视频交互，开展“云办理”“云审核”。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　“‘办不成事’反馈窗口就是为了解决群众平常办不成的事、不好办的事。”李啸说，“事不避难，把大家的难事给办好，群众满意了，我们也骄傲。”</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　本期统筹：杨烁壁</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong>　　版式设计：汪哲平</strong></span></p><p style=\"text-align: right;\"><span style=\"font-family: 楷体_GB2312;\"><strong>编辑:吴海波</strong></span></p>', '2025-05-18 02:09:52', 'UPDATE_CONTENT', 1);
INSERT INTO `article_versions` VALUES (30, 66, 1, 2, '<p><span style=\"font-family: 楷体_GB2312;\"><strong>沈阳市浑南区政务服务中心工作人员接听群众咨询电话，根据《办事不找关系指南》引导群众办事。记者 &nbsp; &nbsp;刘佳华摄</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 党中央决定今年在全党开展深入贯彻中央八项规定精神学习教育，以作风建设新成效为进一步全面深化改革、推进中国式现代化提供有力保障。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 党的十八大以来，各地区各部门持之以恒加强作风建设，形成了一批好经验好做法。以这次学习教育为契机，广大党员干部立足岗位，进一步加强党性修养，密切联系群众，好的经验做法进一步完善，群众反映集中的问题努力解决，实事求是干事创业，在新征程上展现新担当新作为。本报记者来到办事服务一线，实地观察好作风带来的办事体验。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> ——编 &nbsp; &nbsp;者</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 《办事不找关系指南》——</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 按照提示就能办成事</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 一本A4纸合订的手册，拿在手中沉甸甸的，却让每名前来办事的群众倍感轻松……在辽宁省沈阳市浑南区政务服务中心，大厅47个窗口前，都摆放着这样一本《办事不找关系指南》。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 4月10日早上，货车司机小张来到大厅“无差别综合受理专区”，带着材料，办理道路运输证年审。“上网一查，在《办事不找关系指南》里查到了该来这里申办、该准备哪些材料，很方便！”小张说。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 在辽宁，各级交通运输、税务、公安、人社、卫健等部门都会编发《办事不找关系指南》，列出权力事项清单、合规办事业务指南、违规禁办事项清单和容缺办理事项清单，每个事项后都附有二维码，用手机一扫，所需材料、受理窗口等信息一目了然。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 工作人员接过小张的材料，提交系统审核，却发现检测信息录入不进来。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “您这辆车是在外省进行检测的吧？当时上传的信息不全啊。”在大厅办公的浑南区交通运输局审批科科长关颖询问小张。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “对，当时在外地跑活儿，图方便，就当地检测了，那咋整啊？”一听这话，小张慌了，难道还要再去几千公里外补手续？</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “我们先沟通，争取能解决。”说着，关颖先是联系系统后台技术人员，再查询并拨通了外省检测线的电话，希望对方重新上传所需信息。几个电话后，对方重新上传了车辆检测信息，小张的道路运输证年审成功。小张长舒一口气：“不用我自己联系，政府工作人员就帮我沟通协调了。”</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 2023年起，辽宁省纪委监委联合辽宁省营商局推动各级政务服务部门、公用事业企业编制并推广《办事不找关系指南》，服务权力事项52.4万余个，指明“办事不找关系，找谁”的路径；同时通过线上平台和各级政务大厅部署应用《办事不找关系指南》，引导群众企业现场能用、网上可查、掌上会办。浑南区政务服务中心主任夏庆成说，《办事不找关系指南》事项清单一直在更新，努力囊括群众要办的所有事。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “我们正在努力清除群众办事的模糊地带，破解‘关系文化’的消极影响。”辽宁省纪委监委党风政风监督室主任杨哲说。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “亲清家园”小程序——</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 动动手指就能把事办好</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “研发人员都能拿到‘留才补贴’，一键轻松申领，大伙儿都干劲十足。”在福建省泉州市台商投资区的福建立亚新材有限公司，公司副总经理张燕真语带自豪。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 打开手机，轻点“亲清家园”小程序中的“惠企云兑”模块，一项要求3天内审批完成的“留才补贴”呈现在记者眼前。“额度14万元，线上就能办。”这几年，习惯了在“亲清家园”小程序上处理涉企事务的张燕真，对于“一键即享”功能很满意。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 这样的评价，在泉州台商投资区并不鲜见。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 原来，台商投资区纪检部门在走访调研中发现，惠企政策兑现“难、慢、迟、繁”，成为企业反映强烈的问题。于是，在“亲清家园”小程序上，惠企政策全部上线。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 从外地来到泉州创业的林明想了解自家企业能享受的优惠政策。早上9时，他点开小程序相关模块，问卷跳出：“您的企业是内资还是外资？”“企业所属行业是？”……一一填报提交后，提示跳出：“您的企业符合建筑企业外出经营奖励政策，金额45万元，请注意查看。”很快，多项惠企政策清晰明了地展示出来，再点击“一键申领”，流程中4个审批环节清晰可见。下午5时许，全部流程走完，资金在半小时后即到账。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “区里联动多家银行设立涉企财政资金池，时刻保持500万元总资金量，即用即拨，保证审批完成即到账。”台商投资区纪工委监察工委工作人员项学庆说，“涉企资金以‘企业能不能尽快领到钱’为标准，倒逼全流程提速增效。”</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 台商投资区政务服务中心主任王婉明说：“就拿立亚新材的这一笔‘留才补贴’申领来说，以前需要企业跑社保中心、公安、市场监管等部门办材料，最后提交至民生保障局审批。如今涉民生申请由民生保障局牵头，线上请各部门提供辅助材料，企业一趟也不用跑。”</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “现在，更多涉企业务在线上流转，和线下业务相互补充，原先98个线下业务窗口被整合为30个。”王婉明介绍。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 一组数据，见证小程序的实效：截至目前，“亲清家园”小程序累计受理企业申报3794家次，兑现惠企资金超5.12亿元，334家企业及2306人次通过“免申即享”享受奖补8377.2万元。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “平台功能逐步完善，纪工委监察工委实时监督，确保企业诉求高效处理，有效解决部门慢作为、不作为和乱作为问题。”台商投资区纪工委监察工委有关负责人表示。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “办不成事”反馈窗口——</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 不好办的事办得满意</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “这可咋办？这么重要的证明，咋没带呢？”4月7日一大早，在山东省菏泽市住房公积金服务大厅，专程从济南赶来的经办人李建粉急得来回踱步。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 前段时间，李建粉所在的公司从菏泽迁移到济南，他和同事专程赶回菏泽为公司办理公积金账户销户业务。谁承想，把公司注销证明的原件遗落在了办公室。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “两位遇到了什么问题吗？”服务大厅工作人员李啸见状走过来了解情况，然后把他们引到“办不成事”反馈窗口。</strong></span></p><p style=\"text-align: right;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 最近，菏泽市住房公积金管理中心在服务大厅设立“办不成事”反馈窗口，解决群众办事过程中的“疑难杂症”，通过多部门联动、主动上门服务、线上帮办等举措，帮助群众高效办事。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 在“办不成事”反馈窗口，工作人员胡莹莹受理了两人的业务。通过多部门数据共享，胡莹莹核实到该公司现为注销状态。随即，她启动“急事急办”机制，经过住房公积金管理中心审批同意后，最终使用网页销户截图作为凭证，不到10分钟，便完成了办理。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “还以为怎么也得再跑一趟呢，太感谢你们了！”李建粉说。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “现在数据共享，只要我们能核实到的信息，不会让您再多跑一趟。”胡莹莹说。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “办不成事”反馈窗口最近还拓展了更灵活的服务。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “人在广东回不来，这边菏泽公积金账户不解约，新单位缴存就卡壳了！”市民李丽拿着手机焦急地走到李啸面前，手机屏幕上是弟弟李道振发过来的求助信息。原来，5年前李道振以灵活就业人员身份在菏泽开设公积金账户，最近他在广东找到新工作，新公司却发现无法为其缴存公积金。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 胡莹莹启动特殊事项处理机制，使用“视讯办”发起视频核验，确认其本人的解约意愿，5分钟后，顺利完成了解约。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 依托“办不成事”反馈窗口，菏泽市住房公积金管理中心制定“视讯办”预案，对不便现场办理业务的群众，通过远程身份核验、视频交互，开展“云办理”“云审核”。</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> “‘办不成事’反馈窗口就是为了解决群众平常办不成的事、不好办的事。”李啸说，“事不避难，把大家的难事给办好，群众满意了，我们也骄傲。”</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 本期统筹：杨烁壁</strong></span></p><p><span style=\"font-family: 楷体_GB2312;\"><strong> 版式设计：汪哲平</strong></span></p><p style=\"text-align: right;\"><span style=\"font-family: 楷体_GB2312;\"><strong>编辑:吴海波</strong></span></p>', '2025-05-18 02:13:19', 'UPDATE_CONTENT', 1);
INSERT INTO `article_versions` VALUES (31, 66, 1, 3, '<p style=\"text-align: center; line-height: 1;\"><img src=\"http://seunewsbac.pgrm.cc/static/news-images/20250518021233028_538fb6d1.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p><p style=\"text-align: center; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\">沈阳市浑南区政务服务中心工作人员接听群众咨询电话，根据《办事不找关系指南》引导群众办事。记者 &nbsp; &nbsp;刘佳华摄</span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 党中央决定今年在全党开展深入贯彻中央八项规定精神学习教育，以作风建设新成效为进一步全面深化改革、推进中国式现代化提供有力保障。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 党的十八大以来，各地区各部门持之以恒加强作风建设，形成了一批好经验好做法。以这次学习教育为契机，广大党员干部立足岗位，进一步加强党性修养，密切联系群众，好的经验做法进一步完善，群众反映集中的问题努力解决，实事求是干事创业，在新征程上展现新担当新作为。本报记者来到办事服务一线，实地观察好作风带来的办事体验。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> ——编 &nbsp; &nbsp;者</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 《办事不找关系指南》——</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 按照提示就能办成事</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 一本A4纸合订的手册，拿在手中沉甸甸的，却让每名前来办事的群众倍感轻松……在辽宁省沈阳市浑南区政务服务中心，大厅47个窗口前，都摆放着这样一本《办事不找关系指南》。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 4月10日早上，货车司机小张来到大厅“无差别综合受理专区”，带着材料，办理道路运输证年审。“上网一查，在《办事不找关系指南》里查到了该来这里申办、该准备哪些材料，很方便！”小张说。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 在辽宁，各级交通运输、税务、公安、人社、卫健等部门都会编发《办事不找关系指南》，列出权力事项清单、合规办事业务指南、违规禁办事项清单和容缺办理事项清单，每个事项后都附有二维码，用手机一扫，所需材料、受理窗口等信息一目了然。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 工作人员接过小张的材料，提交系统审核，却发现检测信息录入不进来。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “您这辆车是在外省进行检测的吧？当时上传的信息不全啊。”在大厅办公的浑南区交通运输局审批科科长关颖询问小张。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “对，当时在外地跑活儿，图方便，就当地检测了，那咋整啊？”一听这话，小张慌了，难道还要再去几千公里外补手续？</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “我们先沟通，争取能解决。”说着，关颖先是联系系统后台技术人员，再查询并拨通了外省检测线的电话，希望对方重新上传所需信息。几个电话后，对方重新上传了车辆检测信息，小张的道路运输证年审成功。小张长舒一口气：“不用我自己联系，政府工作人员就帮我沟通协调了。”</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 2023年起，辽宁省纪委监委联合辽宁省营商局推动各级政务服务部门、公用事业企业编制并推广《办事不找关系指南》，服务权力事项52.4万余个，指明“办事不找关系，找谁”的路径；同时通过线上平台和各级政务大厅部署应用《办事不找关系指南》，引导群众企业现场能用、网上可查、掌上会办。浑南区政务服务中心主任夏庆成说，《办事不找关系指南》事项清单一直在更新，努力囊括群众要办的所有事。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “我们正在努力清除群众办事的模糊地带，破解‘关系文化’的消极影响。”辽宁省纪委监委党风政风监督室主任杨哲说。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “亲清家园”小程序——</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 动动手指就能把事办好</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “研发人员都能拿到‘留才补贴’，一键轻松申领，大伙儿都干劲十足。”在福建省泉州市台商投资区的福建立亚新材有限公司，公司副总经理张燕真语带自豪。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 打开手机，轻点“亲清家园”小程序中的“惠企云兑”模块，一项要求3天内审批完成的“留才补贴”呈现在记者眼前。“额度14万元，线上就能办。”这几年，习惯了在“亲清家园”小程序上处理涉企事务的张燕真，对于“一键即享”功能很满意。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 这样的评价，在泉州台商投资区并不鲜见。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 原来，台商投资区纪检部门在走访调研中发现，惠企政策兑现“难、慢、迟、繁”，成为企业反映强烈的问题。于是，在“亲清家园”小程序上，惠企政策全部上线。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 从外地来到泉州创业的林明想了解自家企业能享受的优惠政策。早上9时，他点开小程序相关模块，问卷跳出：“您的企业是内资还是外资？”“企业所属行业是？”……一一填报提交后，提示跳出：“您的企业符合建筑企业外出经营奖励政策，金额45万元，请注意查看。”很快，多项惠企政策清晰明了地展示出来，再点击“一键申领”，流程中4个审批环节清晰可见。下午5时许，全部流程走完，资金在半小时后即到账。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “区里联动多家银行设立涉企财政资金池，时刻保持500万元总资金量，即用即拨，保证审批完成即到账。”台商投资区纪工委监察工委工作人员项学庆说，“涉企资金以‘企业能不能尽快领到钱’为标准，倒逼全流程提速增效。”</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 台商投资区政务服务中心主任王婉明说：“就拿立亚新材的这一笔‘留才补贴’申领来说，以前需要企业跑社保中心、公安、市场监管等部门办材料，最后提交至民生保障局审批。如今涉民生申请由民生保障局牵头，线上请各部门提供辅助材料，企业一趟也不用跑。”</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “现在，更多涉企业务在线上流转，和线下业务相互补充，原先98个线下业务窗口被整合为30个。”王婉明介绍。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 一组数据，见证小程序的实效：截至目前，“亲清家园”小程序累计受理企业申报3794家次，兑现惠企资金超5.12亿元，334家企业及2306人次通过“免申即享”享受奖补8377.2万元。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “平台功能逐步完善，纪工委监察工委实时监督，确保企业诉求高效处理，有效解决部门慢作为、不作为和乱作为问题。”台商投资区纪工委监察工委有关负责人表示。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “办不成事”反馈窗口——</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 不好办的事办得满意</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “这可咋办？这么重要的证明，咋没带呢？”4月7日一大早，在山东省菏泽市住房公积金服务大厅，专程从济南赶来的经办人李建粉急得来回踱步。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 前段时间，李建粉所在的公司从菏泽迁移到济南，他和同事专程赶回菏泽为公司办理公积金账户销户业务。谁承想，把公司注销证明的原件遗落在了办公室。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “两位遇到了什么问题吗？”服务大厅工作人员李啸见状走过来了解情况，然后把他们引到“办不成事”反馈窗口。</strong></span></p><p style=\"text-align: right; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 最近，菏泽市住房公积金管理中心在服务大厅设立“办不成事”反馈窗口，解决群众办事过程中的“疑难杂症”，通过多部门联动、主动上门服务、线上帮办等举措，帮助群众高效办事。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 在“办不成事”反馈窗口，工作人员胡莹莹受理了两人的业务。通过多部门数据共享，胡莹莹核实到该公司现为注销状态。随即，她启动“急事急办”机制，经过住房公积金管理中心审批同意后，最终使用网页销户截图作为凭证，不到10分钟，便完成了办理。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “还以为怎么也得再跑一趟呢，太感谢你们了！”李建粉说。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “现在数据共享，只要我们能核实到的信息，不会让您再多跑一趟。”胡莹莹说。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “办不成事”反馈窗口最近还拓展了更灵活的服务。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “人在广东回不来，这边菏泽公积金账户不解约，新单位缴存就卡壳了！”市民李丽拿着手机焦急地走到李啸面前，手机屏幕上是弟弟李道振发过来的求助信息。原来，5年前李道振以灵活就业人员身份在菏泽开设公积金账户，最近他在广东找到新工作，新公司却发现无法为其缴存公积金。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 胡莹莹启动特殊事项处理机制，使用“视讯办”发起视频核验，确认其本人的解约意愿，5分钟后，顺利完成了解约。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 依托“办不成事”反馈窗口，菏泽市住房公积金管理中心制定“视讯办”预案，对不便现场办理业务的群众，通过远程身份核验、视频交互，开展“云办理”“云审核”。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “‘办不成事’反馈窗口就是为了解决群众平常办不成的事、不好办的事。”李啸说，“事不避难，把大家的难事给办好，群众满意了，我们也骄傲。”</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 本期统筹：杨烁壁</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 版式设计：汪哲平</strong></span></p><p style=\"text-align: right; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>编辑:吴海波</strong></span></p>', '2025-05-18 02:16:52', 'UPDATE_CONTENT', 1);
INSERT INTO `article_versions` VALUES (32, 66, 1, 4, '<p style=\"text-align: center; line-height: 1;\"><img src=\"http://seunewsbac.pgrm.cc/static/news-images/20250518021233028_538fb6d1.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p><p style=\"text-align: center; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\">沈阳市浑南区政务服务中心工作人员接听群众咨询电话，根据《办事不找关系指南》引导群众办事。记者 &nbsp; &nbsp;刘佳华摄</span></p><p style=\"text-indent: 2em; text-align: left; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>党中央决定今年在全党开展深入贯彻中央八项规定精神学习教育，以作风建设新成效为进一步全面深化改革、推进中国式现代化提供有力保障。</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>党的十八大以来，各地区各部门持之以恒加强作风建设，形成了一批好经验好做法。以这次学习教育为契机，广大党员干部立足岗位，进一步加强党性修养，密切联系群众，好的经验做法进一步完善，群众反映集中的问题努力解决，实事求是干事创业，在新征程上展现新担当新作为。本报记者来到办事服务一线，实地观察好作风带来的办事体验。</strong></span></p><p style=\"text-align: right; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>——编 &nbsp; &nbsp;者</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>《办事不找关系指南》——</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>按照提示就能办成事</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>一本A4纸合订的手册，拿在手中沉甸甸的，却让每名前来办事的群众倍感轻松……在辽宁省沈阳市浑南区政务服务中心，大厅47个窗口前，都摆放着这样一本《办事不找关系指南》。</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>4月10日早上，货车司机小张来到大厅“无差别综合受理专区”，带着材料，办理道路运输证年审。“上网一查，在《办事不找关系指南》里查到了该来这里申办、该准备哪些材料，很方便！”小张说。</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>在辽宁，各级交通运输、税务、公安、人社、卫健等部门都会编发《办事不找关系指南》，列出权力事项清单、合规办事业务指南、违规禁办事项清单和容缺办理事项清单，每个事项后都附有二维码，用手机一扫，所需材料、受理窗口等信息一目了然。</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>工作人员接过小张的材料，提交系统审核，却发现检测信息录入不进来。</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>“您这辆车是在外省进行检测的吧？当时上传的信息不全啊。”在大厅办公的浑南区交通运输局审批科科长关颖询问小张。</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>“对，当时在外地跑活儿，图方便，就当地检测了，那咋整啊？”一听这话，小张慌了，难道还要再去几千公里外补手续？</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>“我们先沟通，争取能解决。”说着，关颖先是联系系统后台技术人员，再查询并拨通了外省检测线的电话，希望对方重新上传所需信息。几个电话后，对方重新上传了车辆检测信息，小张的道路运输证年审成功。小张长舒一口气：“不用我自己联系，政府工作人员就帮我沟通协调了。”</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>2023年起，辽宁省纪委监委联合辽宁省营商局推动各级政务服务部门、公用事业企业编制并推广《办事不找关系指南》，服务权力事项52.4万余个，指明“办事不找关系，找谁”的路径；同时通过线上平台和各级政务大厅部署应用《办事不找关系指南》，引导群众企业现场能用、网上可查、掌上会办。浑南区政务服务中心主任夏庆成说，《办事不找关系指南》事项清单一直在更新，努力囊括群众要办的所有事。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “我们正在努力清除群众办事的模糊地带，破解‘关系文化’的消极影响。”辽宁省纪委监委党风政风监督室主任杨哲说。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “亲清家园”小程序——</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 动动手指就能把事办好</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “研发人员都能拿到‘留才补贴’，一键轻松申领，大伙儿都干劲十足。”在福建省泉州市台商投资区的福建立亚新材有限公司，公司副总经理张燕真语带自豪。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 打开手机，轻点“亲清家园”小程序中的“惠企云兑”模块，一项要求3天内审批完成的“留才补贴”呈现在记者眼前。“额度14万元，线上就能办。”这几年，习惯了在“亲清家园”小程序上处理涉企事务的张燕真，对于“一键即享”功能很满意。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 这样的评价，在泉州台商投资区并不鲜见。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 原来，台商投资区纪检部门在走访调研中发现，惠企政策兑现“难、慢、迟、繁”，成为企业反映强烈的问题。于是，在“亲清家园”小程序上，惠企政策全部上线。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 从外地来到泉州创业的林明想了解自家企业能享受的优惠政策。早上9时，他点开小程序相关模块，问卷跳出：“您的企业是内资还是外资？”“企业所属行业是？”……一一填报提交后，提示跳出：“您的企业符合建筑企业外出经营奖励政策，金额45万元，请注意查看。”很快，多项惠企政策清晰明了地展示出来，再点击“一键申领”，流程中4个审批环节清晰可见。下午5时许，全部流程走完，资金在半小时后即到账。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “区里联动多家银行设立涉企财政资金池，时刻保持500万元总资金量，即用即拨，保证审批完成即到账。”台商投资区纪工委监察工委工作人员项学庆说，“涉企资金以‘企业能不能尽快领到钱’为标准，倒逼全流程提速增效。”</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 台商投资区政务服务中心主任王婉明说：“就拿立亚新材的这一笔‘留才补贴’申领来说，以前需要企业跑社保中心、公安、市场监管等部门办材料，最后提交至民生保障局审批。如今涉民生申请由民生保障局牵头，线上请各部门提供辅助材料，企业一趟也不用跑。”</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “现在，更多涉企业务在线上流转，和线下业务相互补充，原先98个线下业务窗口被整合为30个。”王婉明介绍。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 一组数据，见证小程序的实效：截至目前，“亲清家园”小程序累计受理企业申报3794家次，兑现惠企资金超5.12亿元，334家企业及2306人次通过“免申即享”享受奖补8377.2万元。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “平台功能逐步完善，纪工委监察工委实时监督，确保企业诉求高效处理，有效解决部门慢作为、不作为和乱作为问题。”台商投资区纪工委监察工委有关负责人表示。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “办不成事”反馈窗口——</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 不好办的事办得满意</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “这可咋办？这么重要的证明，咋没带呢？”4月7日一大早，在山东省菏泽市住房公积金服务大厅，专程从济南赶来的经办人李建粉急得来回踱步。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 前段时间，李建粉所在的公司从菏泽迁移到济南，他和同事专程赶回菏泽为公司办理公积金账户销户业务。谁承想，把公司注销证明的原件遗落在了办公室。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “两位遇到了什么问题吗？”服务大厅工作人员李啸见状走过来了解情况，然后把他们引到“办不成事”反馈窗口。</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>最近，菏泽市住房公积金管理中心在服务大厅设立“办不成事”反馈窗口，解决群众办事过程中的“疑难杂症”，通过多部门联动、主动上门服务、线上帮办等举措，帮助群众高效办事。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 在“办不成事”反馈窗口，工作人员胡莹莹受理了两人的业务。通过多部门数据共享，胡莹莹核实到该公司现为注销状态。随即，她启动“急事急办”机制，经过住房公积金管理中心审批同意后，最终使用网页销户截图作为凭证，不到10分钟，便完成了办理。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “还以为怎么也得再跑一趟呢，太感谢你们了！”李建粉说。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “现在数据共享，只要我们能核实到的信息，不会让您再多跑一趟。”胡莹莹说。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “办不成事”反馈窗口最近还拓展了更灵活的服务。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “人在广东回不来，这边菏泽公积金账户不解约，新单位缴存就卡壳了！”市民李丽拿着手机焦急地走到李啸面前，手机屏幕上是弟弟李道振发过来的求助信息。原来，5年前李道振以灵活就业人员身份在菏泽开设公积金账户，最近他在广东找到新工作，新公司却发现无法为其缴存公积金。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 胡莹莹启动特殊事项处理机制，使用“视讯办”发起视频核验，确认其本人的解约意愿，5分钟后，顺利完成了解约。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 依托“办不成事”反馈窗口，菏泽市住房公积金管理中心制定“视讯办”预案，对不便现场办理业务的群众，通过远程身份核验、视频交互，开展“云办理”“云审核”。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “‘办不成事’反馈窗口就是为了解决群众平常办不成的事、不好办的事。”李啸说，“事不避难，把大家的难事给办好，群众满意了，我们也骄傲。”</strong></span></p><p style=\"text-align: right; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 本期统筹：杨烁壁</strong></span></p><p style=\"text-align: right; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 版式设计：汪哲平</strong></span></p><p style=\"text-align: right; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>编辑:吴海波</strong></span></p>', '2025-05-18 02:18:24', 'UPDATE_CONTENT', 1);
INSERT INTO `article_versions` VALUES (33, 11, 1, 3, '<p>您好！</p>', '2025-05-18 02:22:49', 'DELETE', 1);
INSERT INTO `article_versions` VALUES (34, 12, 1, 1, '<p>您好！</p>', '2025-05-18 02:23:17', 'DELETE', 1);

-- ----------------------------
-- Table structure for articles
-- ----------------------------
DROP TABLE IF EXISTS `articles`;
CREATE TABLE `articles`  (
  `article_id` int(0) NOT NULL AUTO_INCREMENT COMMENT '文章ID',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `publish_date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '发布时间',
  `update_date` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `author_id` int(0) NOT NULL COMMENT '作者ID',
  `status` enum('DRAFT','PUBLISHED') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'PUBLISHED' COMMENT '文章状态',
  `is_deleted` int(0) NOT NULL DEFAULT 0 COMMENT '删除标记',
  `last_operator_id` int(0) NOT NULL DEFAULT 0 COMMENT '最后操作者ID',
  `like_num` bigint(0) NOT NULL DEFAULT 0 COMMENT '点赞数',
  `coin_num` bigint(0) NOT NULL DEFAULT 0 COMMENT '投币数',
  `favorit_num` bigint(0) NOT NULL DEFAULT 0 COMMENT '收藏数',
  `share_num` bigint(0) NOT NULL DEFAULT 0 COMMENT '分享数',
  `head_image_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面地址',
  PRIMARY KEY (`article_id`) USING BTREE,
  INDEX `fk_author_id`(`author_id`) USING BTREE,
  CONSTRAINT `fk_author_id` FOREIGN KEY (`author_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of articles
-- ----------------------------
INSERT INTO `articles` VALUES (1, '新标题', '<p>6</p>', '2025-03-14 00:03:31', '2025-05-07 21:59:42', 1, 'DRAFT', 0, 3, 0, 0, 0, 1098, 'https://mediabluk.cnr.cn/img/cnr/CNRCDP/2025/0310/05dd7445e7d56174159964281136051610.jpg?auth=3060b00a77ffe4b6cf789362ba346d3f');
INSERT INTO `articles` VALUES (2, '一习话丨“建立健全更加合理高效的教育资源配置机制”', '<p style=\"text-align: center;\"><img src=\"http://seunewsbac.pgrm.cc/static/news-images/20250328233745490_224cd9b7.png\" alt=\"\" data-href=\"\" style=\"width: 50%;\"></p><p style=\"text-indent: 2em;\"><span style=\"font-family: 楷体_GB2312;\">“要着眼现代化需求，适应人口结构变化，统筹基础教育、高等教育、职业教育，统筹政府投入和社会投入，建立健全更加合理高效的教育资源配置机制。”3月6日，习近平总书记看望参加全国政协十四届三次会议的民盟、民进、教育界委员，参加联组会，听取意见和建议并发表重要讲话。<br></span></p><p style=\"text-indent: 2em;\"><span style=\"font-family: 楷体_GB2312;\">当天，总书记向委员们讲了一个故事：“当年我给梁家河村里还集资办了小学，挺高兴的。后来为什么没了呢？也是好事，为提升教学质量，集中到乡镇去办了。那也是学校结构的一次调整。”梁家河村小学从无到有、再从有到整合的历史变迁，反映的正是我国基础教育资源随时代发展、人口结构等变化，不断优化调整配置的动态过程。</span></p><p style=\"text-align: center;\"><img src=\"http://seunewsbac.pgrm.cc/static/news-images/20250328225611226_f4246638.jpg\" alt=\"\" data-href=\"\" style=\"width: 50%;\"></p><p style=\"text-align: center;\"><span style=\"font-family: 楷体_GB2312;\">学生聆听线上课堂课程</span></p><p style=\"text-align: center;\"><img src=\"http://seunewsbac.pgrm.cc/static/news-images/20250328233811309_2857d18d.jpg\" alt=\"\" data-href=\"\" style=\"width: 50%;\"></p><p style=\"text-align: center;\"><span style=\"font-family: 楷体_GB2312;\">职业学校的学生在进行工业机器人实操</span></p><p><br></p><p style=\"text-indent: 2em;\"><span style=\"font-family: 楷体_GB2312;\">“致天下之治者在人才，成天下之才者在教化。”教育资源的合理高效配置，是关乎教育公平、教育质量以及国家和民族未来发展的关键问题。当前，我国已建成世界上规模最大的教育体系，只有通过建立健全更加合理高效的教育资源配置机制，加快推进教育强国建设，才能更好发挥教育对科技和人才的支撑作用，为高质量发展提供高素质人才资源。</span></p><p><span style=\"font-family: 楷体_GB2312;\">监制：张军 于锋<br></span></p><p><span style=\"font-family: 楷体_GB2312;\">统筹：伍刚 王薇<br></span></p><p><span style=\"font-family: 楷体_GB2312;\">策划：田甜</span></p><p><span style=\"font-family: 楷体_GB2312;\">视频：郑平平 孙晓钰（实习）<br></span></p><p><span style=\"font-family: 楷体_GB2312;\">编辑:曹宇 </span></p>', '2025-03-12 11:37:30', '2025-05-14 01:06:32', 1, 'PUBLISHED', 0, 1, 2, 8, 2, 90103, 'http://seunewsbac.pgrm.cc/static/news-images/20250419230732801_338c1c11.png');
INSERT INTO `articles` VALUES (3, '测试新闻', '<p>测试新闻</p><p><br></p><p><br></p><p><br></p><p style=\"text-align: center;\"><img src=\"http://seunewsbac.pgrm.cc/static/news-images/20250313220252709_18037439.png\" alt=\"\" data-href=\"\" style=\"width: 100%;\"></p><p style=\"text-align: center;\"><strong>柯南</strong></p>', '2025-03-13 11:11:01', '2025-05-15 18:02:37', 1, 'PUBLISHED', 0, 1, 1, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250419203747380_33cf26ea.png');
INSERT INTO `articles` VALUES (4, '外交部发言人就当前印巴局势答记者问', '<p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-size: 19px; font-family: 楷体_GB2312;\">新华社北京5月7日电 外交部发言人7日就当前印巴局势答记者问。</span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-size: 19px; font-family: 楷体_GB2312;\">有记者问：近期，印度和巴基斯坦之间的紧张局势持续升级。印度7日凌晨对巴基斯坦境内目标进行了军事打击，巴方作出强烈反应。中方对此有何评论？</span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-size: 19px; font-family: 楷体_GB2312;\">发言人表示：“中方对今天凌晨印度的军事行动表示遗憾，对目前事态发展感到担忧。印度和巴基斯坦是搬不走的邻居，也都是中国的邻国。中方反对一切形式的恐怖主义。我们呼吁印巴双方以和平稳定大局为重，保持冷静克制，避免采取使局势进一步复杂化的行动。”</span></p><p style=\"text-align: right; line-height: 1;\"><span style=\"font-size: 19px; font-family: 楷体_GB2312;\">(责编：牛镛、岳弘彬)</span></p>', '2025-05-07 03:36:18', '2025-05-14 01:07:40', 10, 'PUBLISHED', 0, 10, 2, 1, 1, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250507171922686_17aea23c.jpg');
INSERT INTO `articles` VALUES (11, '1', '<p>您好！</p>', '2025-03-19 11:54:38', '2025-05-18 02:22:49', 1, 'DRAFT', 1, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250319121004019_98265ee6.png');
INSERT INTO `articles` VALUES (12, '1', '<p>您好！</p>', '2025-03-19 11:54:38', '2025-05-18 02:23:17', 1, 'DRAFT', 1, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250319121004019_98265ee6.png');
INSERT INTO `articles` VALUES (13, '六百六十六', '<p>您好！</p>', '2025-03-19 12:28:29', '2025-05-07 22:02:00', 1, 'DRAFT', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250319122849113_5445e159.png');
INSERT INTO `articles` VALUES (14, '隐私协议', '<p style=\"line-height: 1.5;\"><span style=\"font-size: 32px; font-family: 宋体;\"><strong>隐私协议</strong></span></p><p><span style=\"font-family: 宋体;\"><strong>本隐私协议将帮助您了解我们如何收集、使用、存储和共享您的个人信息，以及您对个人信息享有的权利。请您仔细阅读本隐私协议，在确认充分理解并同意后使用我们的服务。如果您不同意本隐私协议的任何内容，您应立即停止使用我们的服务。</strong></span></p><h2><span style=\"font-family: 宋体;\"><strong>一、我们如何收集和使用您的个人信息</strong></span></h2><p><span style=\"font-family: 宋体;\"><strong>我们会在您使用服务过程中收集以下个人信息：</strong></span></p><ol><li><span style=\"font-family: 宋体;\"><strong>注册信息：当您注册我们的服务时，我们会收集您的用户名、密码、电子邮件地址等信息，用于创建和管理您的账户。</strong></span></li><li><span style=\"font-family: 宋体;\"><strong>使用信息：我们会收集您使用服务时的相关信息，如浏览记录、搜索记录、点击行为等，以便为您提供个性化的服务和内容推荐。</strong></span></li><li><span style=\"font-family: 宋体;\"><strong>设备信息：我们会收集您使用的设备信息，包括设备型号、操作系统版本、设备标识符等，用于优化服务性能和保障服务安全。</strong></span></li></ol><h2><span style=\"font-family: 宋体;\"><strong>二、我们如何共享、转让和公开披露您的个人信息</strong></span></h2><p><span style=\"font-family: 宋体;\"><strong>我们不会将您的个人信息共享、转让给任何第三方，但以下情况除外：</strong></span></p><ol><li><span style=\"font-family: 宋体;\"><strong>获得您的明确同意：在获得您的明确同意后，我们会按照您同意的方式和范围共享、转让您的个人信息。</strong></span></li><li><span style=\"font-family: 宋体;\"><strong>法定情形：根据法律法规的规定、行政或司法机构的要求，我们可能会共享、转让您的个人信息。</strong></span></li><li><span style=\"font-family: 宋体;\"><strong>与合作伙伴合作：为了向您提供更好的服务，我们可能会与合作伙伴共享您的个人信息，但我们会要求合作伙伴遵守严格的保密和安全措施。</strong></span></li></ol><h2><span style=\"font-family: 宋体;\"><strong>三、我们如何存储和保护您的个人信息</strong></span></h2><p><span style=\"font-family: 宋体;\"><strong>我们会采取合理的安全措施来存储和保护您的个人信息，防止信息泄露、损坏或丢失。我们会使用加密技术对敏感信息进行加密处理，并限制访问个人信息的人员范围。</strong></span></p><h2><span style=\"font-family: 宋体;\"><strong>四、您的权利</strong></span></h2><p><span style=\"font-family: 宋体;\"><strong>您对您的个人信息享有以下权利：</strong></span></p><ol><li><span style=\"font-family: 宋体;\"><strong>访问权：您有权访问您的个人信息。</strong></span></li><li><span style=\"font-family: 宋体;\"><strong>更正权：如果您发现我们收集的您的个人信息存在错误或不准确，您有权要求我们进行更正。</strong></span></li><li><span style=\"font-family: 宋体;\"><strong>删除权：在符合法定条件的情况下，您有权要求我们删除您的个人信息。</strong></span></li><li><span style=\"font-family: 宋体;\"><strong>限制处理权：在特定情况下，您有权要求我们限制对您个人信息的处理。</strong></span></li><li><span style=\"font-family: 宋体;\"><strong>反对权：您有权在特定情况下反对我们对您个人信息的处理。</strong></span></li><li><span style=\"font-family: 宋体;\"><strong>数据可携权：在符合法定条件的情况下，您有权要求我们将您的个人信息以结构化、常用和机器可读的格式提供给您。</strong></span></li></ol><h2><span style=\"font-family: 宋体;\"><strong>五、隐私协议的变更</strong></span></h2><p><span style=\"font-family: 宋体;\"><strong>我们可能会根据业务发展和法律法规的变化对本隐私协议进行更新。我们会在网站上公布隐私协议的更新内容，并通过适当的方式通知您。如果您继续使用我们的服务，即表示您同意接受更新后的隐私协议。</strong></span></p><h2><span style=\"font-family: 宋体;\"><strong>六、如何联系我们</strong></span></h2><p><span style=\"font-family: 宋体;\"><strong>如果您对本隐私协议有任何疑问、意见或建议，您可以通过以下方式联系我们：</strong></span></p><p><span style=\"font-family: 宋体;\"><strong>邮箱：zsqgle@cxxy.seu.edu.cn</strong></span></p><p><span style=\"font-family: 宋体;\"><strong>电话：010-6804-5951</strong></span></p>', '2025-03-19 12:54:11', '2025-05-07 22:02:18', 2, 'PUBLISHED', 0, 1, 0, 2, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250417123129278_34dc0621.png');
INSERT INTO `articles` VALUES (15, '服务条款', '<p> &nbsp; &nbsp;</p><h1>东南新闻网站服务条款</h1><p><br></p><p><br></p><p> &nbsp; &nbsp;</p><h2>一、使用条款</h2><p><br></p><p> &nbsp; &nbsp;</p><p>欢迎使用东南新闻网站（以下简称\"本网站\"）。您访问或使用本网站的内容及服务，即表示您已阅读、理解并同意遵守以下条款：</p><p><br></p><p><br></p><p> &nbsp; &nbsp;</p><h2>二、用户义务</h2><p><br></p><p> &nbsp; &nbsp;</p><p><br></p><p> &nbsp; &nbsp; &nbsp; &nbsp;</p><ol><li>您需确保提供的注册信息真实、准确、完整</li></ol><p><br></p><p> &nbsp; &nbsp; &nbsp; &nbsp;</p><ol><li>不得利用本网站从事任何违法违规活动</li></ol><p><br></p><p> &nbsp; &nbsp; &nbsp; &nbsp;</p><ol><li>禁止发布虚假信息、侵权内容或进行商业广告宣传</li></ol><p><br></p><p> &nbsp; &nbsp; &nbsp; &nbsp;</p><ol><li>不得恶意破坏网站功能或影响其他用户正常使用</li></ol><p><br></p><p> &nbsp; &nbsp;</p><p><br></p><p><br></p><p> &nbsp; &nbsp;</p><h2>三、内容政策</h2><p><br></p><p> &nbsp; &nbsp;</p><p><br></p><p> &nbsp; &nbsp; &nbsp; &nbsp;</p><ul><li>本网站所有内容（包括文字、图片、视频等）均受版权保护</li></ul><p><br></p><p> &nbsp; &nbsp; &nbsp; &nbsp;</p><ul><li>未经授权不得转载、复制或用于其他商业用途</li></ul><p><br></p><p> &nbsp; &nbsp; &nbsp; &nbsp;</p><ul><li>用户发布的内容需自行承担法律责任</li></ul><p><br></p><p> &nbsp; &nbsp;</p><p><br></p><p><br></p><p> &nbsp; &nbsp;</p><h2>四、免责声明</h2><p><br></p><p> &nbsp; &nbsp;</p><p>本网站不保证内容的准确性、完整性或时效性。对于因使用本网站内容或服务产生的任何直接或间接损失，本网站不承担法律责任。</p><p><br></p><p><br></p><p> &nbsp; &nbsp;</p><h2>五、服务终止</h2><p><br></p><p> &nbsp; &nbsp;</p><p>若您违反本条款，本网站有权在不另行通知的情况下：</p><p><br></p><p> &nbsp; &nbsp;</p><p><br></p><p> &nbsp; &nbsp; &nbsp; &nbsp;</p><ul><li>限制或终止您的账户权限</li></ul><p><br></p><p> &nbsp; &nbsp; &nbsp; &nbsp;</p><ul><li>删除违规内容</li></ul><p><br></p><p> &nbsp; &nbsp; &nbsp; &nbsp;</p><ul><li>保留追究法律责任的权利</li></ul><p><br></p><p> &nbsp; &nbsp;</p><p><br></p><p><br></p><p> &nbsp; &nbsp;</p><h2>六、条款修改</h2><p><br></p><p> &nbsp; &nbsp;</p><p>本网站有权随时修改服务条款，修改内容将在网站公告后生效。若您继续使用本服务，即视为接受修改后的条款。</p><p><br></p><p><br></p><p> &nbsp; &nbsp;</p><h2>七、争议解决</h2><p><br></p><p> &nbsp; &nbsp;</p><p>本条款的解释和执行适用中华人民共和国法律。如发生争议，双方应友好协商解决；协商不成的，任何一方均有权向有管辖权的人民法院提起诉讼。</p><p><br></p><p><br></p><p> &nbsp; &nbsp;</p><h2>八、联系我们</h2><p><br></p><p> &nbsp; &nbsp;</p><p>如果您对本条款有任何疑问或建议，可通过以下方式联系我们：</p><p><br></p><p> &nbsp; &nbsp;</p><p>客服邮箱：service@dongnannews.com</p><p><br></p><p> &nbsp; &nbsp;</p><p>服务热线：400 - 123 - 4567</p><p><br></p>', '2025-03-19 13:16:24', '2025-05-08 15:21:28', 2, 'PUBLISHED', 0, 1, 2, 1, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250417123112366_a5553e16.png');
INSERT INTO `articles` VALUES (16, '用户手册', '<h2>一、概述</h2><p>东南新闻是一个综合性的新闻网站，为用户提供及时、准确、全面的新闻资讯，涵盖政治、经济、文化、体育等多个领域。本手册将详细介绍如何使用东南新闻网站的各项功能。</p><h2>二、注册与登录</h2><h3>2.1 注册</h3><p>若您是新用户，可点击网站首页右上角的“注册”按钮。在弹出的注册页面中，您需要填写以下信息：</p><ul><li>用户名：请使用易于记忆且符合网站规定的用户名，长度在 3 - 20 个字符之间。</li><li>密码：密码需包含字母、数字和特殊字符，长度不少于 8 位。</li><li>邮箱：请填写有效的电子邮箱地址，用于接收网站通知和找回密码。</li><li>验证码：输入图片上显示的验证码，以验证您不是机器人。</li></ul><p>填写完所有信息后，点击“注册”按钮。若信息填写正确，系统将提示注册成功，您可使用注册的用户名和密码登录网站。</p><h3>2.2 登录</h3><p>已注册用户可点击网站首页右上角的“登录”按钮。在登录页面输入您的用户名和密码，点击“登录”即可。若您忘记密码，可点击“忘记密码”链接，通过注册时填写的邮箱重置密码。</p><h2>三、浏览新闻</h2><h3>3.1 首页新闻浏览</h3><p>网站首页展示了最新的热点新闻，按照重要程度和发布时间排列。您可以直接在首页浏览新闻标题和摘要，点击新闻标题可查看新闻详情。</p><h3>3.2 分类新闻浏览</h3><p>网站顶部导航栏提供了多个新闻分类，如“政治”“经济”“文化”“体育”等。点击相应的分类，可查看该分类下的新闻列表。</p><h3>3.3 搜索新闻</h3><p>若您想查找特定的新闻，可使用网站右上角的搜索框。输入关键词，点击搜索按钮，系统将显示包含该关键词的新闻列表。</p><h2>四、新闻详情页</h2><h3>4.1 新闻内容阅读</h3><p>在新闻详情页，您可以阅读完整的新闻内容，包括文字、图片和视频。部分新闻还提供了相关新闻推荐，您可点击查看。</p><h3>4.2 评论与互动</h3><p>在新闻详情页底部，您可以发表对该新闻的评论。请遵守网站的评论规则，不得发表违法、违规或不文明的言论。您还可以对其他用户的评论进行点赞、回复等操作。</p><h3>4.3 分享新闻</h3><p>新闻详情页提供了分享功能，您可以将新闻分享到微信、微博、QQ 等社交平台，与朋友分享您感兴趣的新闻。</p><h2>五、个人中心</h2><h3>5.1 个人信息管理</h3><p>登录后，点击网站右上角的个人头像，选择“个人中心”。在个人中心页面，您可以修改个人信息，如头像、昵称、邮箱等。</p><h3>5.2 收藏与历史记录</h3><p>在个人中心页面，您可以查看自己收藏的新闻和浏览历史记录。点击“收藏”可查看收藏的新闻列表，点击“历史记录”可查看浏览过的新闻列表。</p><h3>5.3 消息通知</h3><p>个人中心还提供了消息通知功能，您可以查看网站发送的通知、评论回复等消息。</p><h2>六、订阅服务</h2><h3>6.1 订阅新闻分类</h3><p>在个人中心页面，点击“订阅管理”，您可以选择订阅感兴趣的新闻分类。订阅后，网站将为您推送该分类下的最新新闻。</p><h3>6.2 取消订阅</h3><p>若您不想再接收某个分类的新闻推送，可在“订阅管理”页面取消该分类的订阅。</p><h2>七、反馈与建议</h2><p>若您在使用过程中遇到问题或有任何建议，可点击网站底部的“反馈与建议”链接。在反馈页面，填写您的问题或建议，留下您的联系方式（可选），点击“提交”即可。我们会尽快处理您的反馈，并与您联系。</p><h2>八、注意事项</h2><ul><li>请遵守国家法律法规和网站的使用条款，不得利用网站进行违法、违规活动。</li><li>保护好您的账户信息，不要将用户名和密码泄露给他人。</li><li>若您在使用过程中遇到任何问题，可随时联系我们的客服人员。</li></ul>', '2025-03-19 13:20:30', '2025-05-14 00:03:00', 2, 'PUBLISHED', 0, 1, 0, 3, 1, 1, 'http://seunewsbac.pgrm.cc/static/news-images/20250417123044413_ec8c7bc7.png');
INSERT INTO `articles` VALUES (17, '2', '<p><span style=\"font-family: 楷体_GB2312;\">您好！</span>aaa</p>', '2025-03-22 18:58:08', '2025-05-07 22:03:09', 1, 'PUBLISHED', 0, 1, 1, 1, 0, 3, 'http://seunewsbac.pgrm.cc/static/news-images/20250322191237876_6ff93175.png');
INSERT INTO `articles` VALUES (18, 'Tag测试', '<p>您好！</p><p><br></p><p style=\"text-align: center;\">这是新闻</p><p style=\"text-align: center;\"><img src=\"http://192.168.124.5:8080/static/news-images/20250322201730411_4c64e1ea.png\" alt=\"\" data-href=\"\" style=\"\"></p>', '2025-03-22 20:15:58', '2025-05-07 22:03:17', 1, 'PUBLISHED', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250322201629537_7733a71d.png');
INSERT INTO `articles` VALUES (19, 'TagTest', '<p><br></p><p style=\"text-align: center;\"><img src=\"http://192.168.124.5:8080/static/news-images/20250322234727158_9bbbcc17.jpg\" alt=\"\" data-href=\"\" style=\"\"></p><p style=\"text-align: center;\">这是测试新闻</p>', '2025-03-22 23:46:25', '2025-05-07 22:03:30', 6, 'PUBLISHED', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250322234749691_5bc33d0b.png');
INSERT INTO `articles` VALUES (20, 'TagTest', '<p><br></p><p style=\"text-align: center;\"><img src=\"http://192.168.124.5:8080/static/news-images/20250322234727158_9bbbcc17.jpg\" alt=\"\" data-href=\"\" style=\"\"></p><p style=\"text-align: center;\">这是测试新闻</p>', '2025-03-22 23:46:25', '2025-05-09 00:39:23', 6, 'PUBLISHED', 0, 1, 1, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250322234749691_5bc33d0b.png');
INSERT INTO `articles` VALUES (21, 'TagTest', '<p><br></p><p style=\"text-align: center;\"><img src=\"http://192.168.124.5:8080/static/news-images/20250322234727158_9bbbcc17.jpg\" alt=\"\" data-href=\"\" style=\"\"></p><p style=\"text-align: center;\">这是测试新闻</p>', '2025-03-22 23:46:25', '2025-05-15 00:41:18', 6, 'PUBLISHED', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250322234749691_5bc33d0b.png');
INSERT INTO `articles` VALUES (22, 'TagTest', '<p style=\"text-align: center;\">Test</p><p style=\"text-align: center;\"><img src=\"http://192.168.124.5:8080/static/news-images/20250322235231756_4063716e.png\" alt=\"\" data-href=\"\" style=\"\"></p>', '2025-03-22 23:51:47', '2025-05-07 22:04:00', 6, 'DRAFT', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250322235211799_9ce05666.png');
INSERT INTO `articles` VALUES (23, 'Test01', '<p>这是测试行为</p>', '2025-04-22 02:19:00', '2025-05-12 15:54:23', 1, 'PUBLISHED', 0, 1, 1, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250422021908151_d94ac528.jpg');
INSERT INTO `articles` VALUES (24, 'Test01', '<p>这是测试行为</p>', '2025-04-22 02:19:00', '2025-05-07 22:04:15', 1, 'PUBLISHED', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250422021908151_d94ac528.jpg');
INSERT INTO `articles` VALUES (25, 'Test01', '<p>这是测试行为</p>', '2025-04-22 02:19:00', '2025-05-07 22:04:16', 1, 'DRAFT', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250422021908151_d94ac528.jpg');
INSERT INTO `articles` VALUES (26, 'Test01', '<p>这是测试行为</p>', '2025-04-22 02:19:00', '2025-05-07 22:04:25', 1, 'PUBLISHED', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250422021908151_d94ac528.jpg');
INSERT INTO `articles` VALUES (27, 'Test01', '<p>这是测试行为</p>', '2025-04-22 02:19:00', '2025-05-07 22:05:25', 1, 'PUBLISHED', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250422021908151_d94ac528.jpg');
INSERT INTO `articles` VALUES (28, 'TestUpdateVersion', 'Version1.0.1', '2025-04-28 01:01:37', '2025-05-07 22:04:45', 1, 'PUBLISHED', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250507171922686_17aea23c.jpg');
INSERT INTO `articles` VALUES (30, '外交部发言人就当前印巴局势答记者问', '<p style=\"line-height: 1;\"><span style=\"font-size: 19px; font-family: 楷体_GB2312;\">新华社北京5月7日电 外交部发言人7日就当前印巴局势答记者问。</span></p><p style=\"line-height: 1;\"><span style=\"font-size: 19px; font-family: 楷体_GB2312;\">　　有记者问：近期，印度和巴基斯坦之间的紧张局势持续升级。印度7日凌晨对巴基斯坦境内目标进行了军事打击，巴方作出强烈反应。中方对此有何评论？</span></p><p style=\"line-height: 1;\"><span style=\"font-size: 19px; font-family: 楷体_GB2312;\">　　发言人表示：“中方对今天凌晨印度的军事行动表示遗憾，对目前事态发展感到担忧。印度和巴基斯坦是搬不走的邻居，也都是中国的邻国。中方反对一切形式的恐怖主义。我们呼吁印巴双方以和平稳定大局为重，保持冷静克制，避免采取使局势进一步复杂化的行动。”</span></p><p style=\"text-align: right; line-height: 1;\">(责编：牛镛、岳弘彬)</p>', '2025-05-07 03:36:18', '2025-05-07 22:04:47', 10, 'DRAFT', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250507171922686_17aea23c.jpg');
INSERT INTO `articles` VALUES (31, '2025年乡村规划', '<p>2025 年我国乡村规划主要依据《乡村全面振兴规划（2024 - 2027 年）》开展，以下是相关内容1：</p><h3 style=\"text-align: start;\">总体要求</h3><p>以习近平新时代中国特色社会主义思想为指导，深入贯彻党的二十大和二十届二中、三中全会精神，认真贯彻落实习近平总书记关于 “三农” 工作的重要论述，完整准确全面贯彻新发展理念，加快构建新发展格局，着力推动高质量发展，锚定建设农业强国目标，学习运用 “千万工程” 经验，健全推动乡村全面振兴长效机制，以确保国家粮食安全、确保农村人口不发生规模性返贫致贫为底线，巩固拓展脱贫攻坚成果，以提升乡村产业发展水平、提升乡村建设水平、提升乡村治理水平为重点，强化科技和改革双轮驱动，强化农民增收举措，扎实推进乡村产业、人才、文化、生态、组织 “五个振兴”，加快农业农村现代化。</p><h3 style=\"text-align: start;\">优化城乡发展格局，分类有序推进乡村全面振兴</h3><ul><li style=\"text-align: start;\"><span><strong>统筹优化城乡发展布局</strong></span>：以资源环境承载能力和国土空间开发适宜性评价为基础，优化农业、生态和城镇空间。严守耕地和永久基本农田、生态保护红线和城镇开发边界等主要控制线，科学编制实施县级国土空间总体规划。优化乡村功能和空间布局，加强农产品主产区建设，筑牢生态安全屏障。</li><li style=\"text-align: start;\"><span><strong>推进城乡融合发展</strong></span>：实施新一轮农业转移人口市民化行动，构建城乡统一的建设用地市场，率先在县域内破除城乡二元结构，一体推进城镇和乡村规划、建设和治理，推动城乡基本公共服务均等化，支持中西部农产品主产区县城建设，把乡镇建成乡村治理中心、农村服务中心、乡村经济中心，推动县域产业协同发展。</li><li style=\"text-align: start;\"><span><strong>分类推进乡村全面振兴</strong></span>：集聚提升类村庄重点强化产业发展，改造提升基础设施；城郊融合类村庄重点推动城乡一体化建设；特色保护类村庄重点改善基础设施和公共环境；搬迁撤并类村庄有序实施搬迁撤并，解决好民生保障、就业增收和生态保护等问题。</li><li style=\"text-align: start;\"><span><strong>衔接推进脱贫地区全面振兴</strong></span>：过渡期内保持主要帮扶政策总体稳定，抓好防止返贫监测，落实帮扶措施，完善覆盖农村人口的常态化防止返贫致贫机制。加快补齐脱贫地区农村基础设施短板，推进脱贫地区帮扶产业高质量发展，深化东西部协作、定点帮扶，推动帮扶政策体系向推进乡村全面振兴转换。</li></ul><h3 style=\"text-align: start;\">加快现代农业建设，全方位夯实粮食安全根基</h3><p>把确保国家粮食安全作为现代农业建设的首要任务，全面落实粮食安全党政同责，坚持稳面积、增单产两手发力，确保粮食播种面积稳定在 17.5 亿亩左右、谷物面积 14.5 亿亩左右。组织实施新一轮千亿斤粮食产能提升行动，大力实施粮食单产提升工程，推动粮食产能稳步迈上 1.4 万亿斤台阶。深入实施国家大豆和油料产能提升工程，构建多元化食物供给体系。</p><h3 style=\"text-align: start;\">推动乡村产业高质量发展，促进农民收入增长</h3><p>构建现代乡村产业体系，深化农村一二三产业融合发展。</p><h3 style=\"text-align: start;\">大力培养乡村人才，吸引各类人才投身乡村全面振兴</h3><p>改善乡村生态环境，推进耕地草原森林河湖休养生息，完善相关制度，开展重点生态系统保护和修复重大工程，开展生态环境突出问题治理，建立农村生态环境监测评价制度，完善生态产品价值实现机制。</p><h3 style=\"text-align: start;\">建设宜居宜业和美乡村，增进农民福祉</h3><ul><li style=\"text-align: start;\"><span><strong>推进基础设施提档升级</strong></span>：提高路网通达水平，强化供水安全保障，优化能源供给，提升农房质量安全水平。</li><li style=\"text-align: start;\"><span><strong>持续改善人居环境</strong></span>：深入实施乡村建设行动，因地制宜扎实推进农村厕所革命，推进农村厕所革命与生活污水治理有机衔接，分类开展生活污水治理，提高生活垃圾治理水平，提升村容村貌。</li><li style=\"text-align: start;\"><span><strong>稳步提升基本公共服务水平</strong></span>：提高农村教育质量，推进健康乡村建设，完善基础民生保障。</li><li style=\"text-align: start;\"><span><strong>完善农村社区服务设施</strong></span>：统筹规划科学布局，合理安排农村社区服务设施建设，提升农村社区服务设施效能。</li><li style=\"text-align: start;\"><span><strong>加快数字乡村建设</strong></span>：完善信息基础设施，加快管理服务数字化，持续实施数字乡村发展行动。</li><li style=\"text-align: start;\"><span><strong>优化乡村规划建设</strong></span>：因地制宜编制村庄规划，引导农民参与村庄规划建设管理，严禁违背农民意愿搞大拆大建，开展乡村建设评价，健全农村公共基础设施运行管护机制。</li></ul><h3 style=\"text-align: start;\">深化农业农村改革，激发农村发展活力</h3><p>巩固和完善农村基本经营制度，有序推进第二轮土地承包到期后再延长 30 年试点，深化承包地所有权、承包权、经营权分置改革，发展农业适度规模经营，巩固提升农村集体产权制度改革成果，发展新型农村集体经济</p>', '2025-05-08 14:03:47', '2025-05-08 14:46:46', 27, 'DRAFT', 0, 27, 1, 1, 1, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250508140527136_5da8256c.png');
INSERT INTO `articles` VALUES (32, '2025年乡村规划', '<p>2025 年我国乡村规划主要依据《乡村全面振兴规划（2024 - 2027 年）》开展，以下是相关内容1：</p><h3 style=\"text-align: start;\">总体要求</h3><p>以习近平新时代中国特色社会主义思想为指导，深入贯彻党的二十大和二十届二中、三中全会精神，认真贯彻落实习近平总书记关于 “三农” 工作的重要论述，完整准确全面贯彻新发展理念，加快构建新发展格局，着力推动高质量发展，锚定建设农业强国目标，学习运用 “千万工程” 经验，健全推动乡村全面振兴长效机制，以确保国家粮食安全、确保农村人口不发生规模性返贫致贫为底线，巩固拓展脱贫攻坚成果，以提升乡村产业发展水平、提升乡村建设水平、提升乡村治理水平为重点，强化科技和改革双轮驱动，强化农民增收举措，扎实推进乡村产业、人才、文化、生态、组织 “五个振兴”，加快农业农村现代化。</p><h3 style=\"text-align: start;\">优化城乡发展格局，分类有序推进乡村全面振兴</h3><ul><li style=\"text-align: start;\"><span><strong>统筹优化城乡发展布局</strong></span>：以资源环境承载能力和国土空间开发适宜性评价为基础，优化农业、生态和城镇空间。严守耕地和永久基本农田、生态保护红线和城镇开发边界等主要控制线，科学编制实施县级国土空间总体规划。优化乡村功能和空间布局，加强农产品主产区建设，筑牢生态安全屏障。</li><li style=\"text-align: start;\"><span><strong>推进城乡融合发展</strong></span>：实施新一轮农业转移人口市民化行动，构建城乡统一的建设用地市场，率先在县域内破除城乡二元结构，一体推进城镇和乡村规划、建设和治理，推动城乡基本公共服务均等化，支持中西部农产品主产区县城建设，把乡镇建成乡村治理中心、农村服务中心、乡村经济中心，推动县域产业协同发展。</li><li style=\"text-align: start;\"><span><strong>分类推进乡村全面振兴</strong></span>：集聚提升类村庄重点强化产业发展，改造提升基础设施；城郊融合类村庄重点推动城乡一体化建设；特色保护类村庄重点改善基础设施和公共环境；搬迁撤并类村庄有序实施搬迁撤并，解决好民生保障、就业增收和生态保护等问题。</li><li style=\"text-align: start;\"><span><strong>衔接推进脱贫地区全面振兴</strong></span>：过渡期内保持主要帮扶政策总体稳定，抓好防止返贫监测，落实帮扶措施，完善覆盖农村人口的常态化防止返贫致贫机制。加快补齐脱贫地区农村基础设施短板，推进脱贫地区帮扶产业高质量发展，深化东西部协作、定点帮扶，推动帮扶政策体系向推进乡村全面振兴转换。</li></ul><h3 style=\"text-align: start;\">加快现代农业建设，全方位夯实粮食安全根基</h3><p>把确保国家粮食安全作为现代农业建设的首要任务，全面落实粮食安全党政同责，坚持稳面积、增单产两手发力，确保粮食播种面积稳定在 17.5 亿亩左右、谷物面积 14.5 亿亩左右。组织实施新一轮千亿斤粮食产能提升行动，大力实施粮食单产提升工程，推动粮食产能稳步迈上 1.4 万亿斤台阶。深入实施国家大豆和油料产能提升工程，构建多元化食物供给体系。</p><h3 style=\"text-align: start;\">推动乡村产业高质量发展，促进农民收入增长</h3><p>构建现代乡村产业体系，深化农村一二三产业融合发展。</p><h3 style=\"text-align: start;\">大力培养乡村人才，吸引各类人才投身乡村全面振兴</h3><p>改善乡村生态环境，推进耕地草原森林河湖休养生息，完善相关制度，开展重点生态系统保护和修复重大工程，开展生态环境突出问题治理，建立农村生态环境监测评价制度，完善生态产品价值实现机制。</p><h3 style=\"text-align: start;\">建设宜居宜业和美乡村，增进农民福祉</h3><ul><li style=\"text-align: start;\"><span><strong>推进基础设施提档升级</strong></span>：提高路网通达水平，强化供水安全保障，优化能源供给，提升农房质量安全水平。</li><li style=\"text-align: start;\"><span><strong>持续改善人居环境</strong></span>：深入实施乡村建设行动，因地制宜扎实推进农村厕所革命，推进农村厕所革命与生活污水治理有机衔接，分类开展生活污水治理，提高生活垃圾治理水平，提升村容村貌。</li><li style=\"text-align: start;\"><span><strong>稳步提升基本公共服务水平</strong></span>：提高农村教育质量，推进健康乡村建设，完善基础民生保障。</li><li style=\"text-align: start;\"><span><strong>完善农村社区服务设施</strong></span>：统筹规划科学布局，合理安排农村社区服务设施建设，提升农村社区服务设施效能。</li><li style=\"text-align: start;\"><span><strong>加快数字乡村建设</strong></span>：完善信息基础设施，加快管理服务数字化，持续实施数字乡村发展行动。</li><li style=\"text-align: start;\"><span><strong>优化乡村规划建设</strong></span>：因地制宜编制村庄规划，引导农民参与村庄规划建设管理，严禁违背农民意愿搞大拆大建，开展乡村建设评价，健全农村公共基础设施运行管护机制。</li></ul><h3 style=\"text-align: start;\">深化农业农村改革，激发农村发展活力</h3><p>巩固和完善农村基本经营制度，有序推进第二轮土地承包到期后再延长 30 年试点，深化承包地所有权、承包权、经营权分置改革，发展农业适度规模经营，巩固提升农村集体产权制度改革成果，发展新型农村集体经济</p>', '2025-05-08 14:03:47', '2025-05-08 14:03:47', 27, 'DRAFT', 0, 27, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250508140527136_5da8256c.png');
INSERT INTO `articles` VALUES (33, '2025年乡村规划', '<p>2025 年我国乡村规划主要依据《乡村全面振兴规划（2024 - 2027 年）》开展，以下是相关内容1：</p><h3 style=\"text-align: start;\">总体要求</h3><p>以习近平新时代中国特色社会主义思想为指导，深入贯彻党的二十大和二十届二中、三中全会精神，认真贯彻落实习近平总书记关于 “三农” 工作的重要论述，完整准确全面贯彻新发展理念，加快构建新发展格局，着力推动高质量发展，锚定建设农业强国目标，学习运用 “千万工程” 经验，健全推动乡村全面振兴长效机制，以确保国家粮食安全、确保农村人口不发生规模性返贫致贫为底线，巩固拓展脱贫攻坚成果，以提升乡村产业发展水平、提升乡村建设水平、提升乡村治理水平为重点，强化科技和改革双轮驱动，强化农民增收举措，扎实推进乡村产业、人才、文化、生态、组织 “五个振兴”，加快农业农村现代化。</p><h3 style=\"text-align: start;\">优化城乡发展格局，分类有序推进乡村全面振兴</h3><ul><li style=\"text-align: start;\"><span><strong>统筹优化城乡发展布局</strong></span>：以资源环境承载能力和国土空间开发适宜性评价为基础，优化农业、生态和城镇空间。严守耕地和永久基本农田、生态保护红线和城镇开发边界等主要控制线，科学编制实施县级国土空间总体规划。优化乡村功能和空间布局，加强农产品主产区建设，筑牢生态安全屏障。</li><li style=\"text-align: start;\"><span><strong>推进城乡融合发展</strong></span>：实施新一轮农业转移人口市民化行动，构建城乡统一的建设用地市场，率先在县域内破除城乡二元结构，一体推进城镇和乡村规划、建设和治理，推动城乡基本公共服务均等化，支持中西部农产品主产区县城建设，把乡镇建成乡村治理中心、农村服务中心、乡村经济中心，推动县域产业协同发展。</li><li style=\"text-align: start;\"><span><strong>分类推进乡村全面振兴</strong></span>：集聚提升类村庄重点强化产业发展，改造提升基础设施；城郊融合类村庄重点推动城乡一体化建设；特色保护类村庄重点改善基础设施和公共环境；搬迁撤并类村庄有序实施搬迁撤并，解决好民生保障、就业增收和生态保护等问题。</li><li style=\"text-align: start;\"><span><strong>衔接推进脱贫地区全面振兴</strong></span>：过渡期内保持主要帮扶政策总体稳定，抓好防止返贫监测，落实帮扶措施，完善覆盖农村人口的常态化防止返贫致贫机制。加快补齐脱贫地区农村基础设施短板，推进脱贫地区帮扶产业高质量发展，深化东西部协作、定点帮扶，推动帮扶政策体系向推进乡村全面振兴转换。</li></ul><h3 style=\"text-align: start;\">加快现代农业建设，全方位夯实粮食安全根基</h3><p>把确保国家粮食安全作为现代农业建设的首要任务，全面落实粮食安全党政同责，坚持稳面积、增单产两手发力，确保粮食播种面积稳定在 17.5 亿亩左右、谷物面积 14.5 亿亩左右。组织实施新一轮千亿斤粮食产能提升行动，大力实施粮食单产提升工程，推动粮食产能稳步迈上 1.4 万亿斤台阶。深入实施国家大豆和油料产能提升工程，构建多元化食物供给体系。</p><h3 style=\"text-align: start;\">推动乡村产业高质量发展，促进农民收入增长</h3><p>构建现代乡村产业体系，深化农村一二三产业融合发展。</p><h3 style=\"text-align: start;\">大力培养乡村人才，吸引各类人才投身乡村全面振兴</h3><p>改善乡村生态环境，推进耕地草原森林河湖休养生息，完善相关制度，开展重点生态系统保护和修复重大工程，开展生态环境突出问题治理，建立农村生态环境监测评价制度，完善生态产品价值实现机制。</p><h3 style=\"text-align: start;\">建设宜居宜业和美乡村，增进农民福祉</h3><ul><li style=\"text-align: start;\"><span><strong>推进基础设施提档升级</strong></span>：提高路网通达水平，强化供水安全保障，优化能源供给，提升农房质量安全水平。</li><li style=\"text-align: start;\"><span><strong>持续改善人居环境</strong></span>：深入实施乡村建设行动，因地制宜扎实推进农村厕所革命，推进农村厕所革命与生活污水治理有机衔接，分类开展生活污水治理，提高生活垃圾治理水平，提升村容村貌。</li><li style=\"text-align: start;\"><span><strong>稳步提升基本公共服务水平</strong></span>：提高农村教育质量，推进健康乡村建设，完善基础民生保障。</li><li style=\"text-align: start;\"><span><strong>完善农村社区服务设施</strong></span>：统筹规划科学布局，合理安排农村社区服务设施建设，提升农村社区服务设施效能。</li><li style=\"text-align: start;\"><span><strong>加快数字乡村建设</strong></span>：完善信息基础设施，加快管理服务数字化，持续实施数字乡村发展行动。</li><li style=\"text-align: start;\"><span><strong>优化乡村规划建设</strong></span>：因地制宜编制村庄规划，引导农民参与村庄规划建设管理，严禁违背农民意愿搞大拆大建，开展乡村建设评价，健全农村公共基础设施运行管护机制。</li></ul><h3 style=\"text-align: start;\">深化农业农村改革，激发农村发展活力</h3><p>巩固和完善农村基本经营制度，有序推进第二轮土地承包到期后再延长 30 年试点，深化承包地所有权、承包权、经营权分置改革，发展农业适度规模经营，巩固提升农村集体产权制度改革成果，发展新型农村集体经济</p>', '2025-05-08 14:03:47', '2025-05-09 01:18:21', 27, 'DRAFT', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250508140527136_5da8256c.png');
INSERT INTO `articles` VALUES (34, '2025年乡村规划', '<p>2025 年我国乡村规划主要依据《乡村全面振兴规划（2024 - 2027 年）》开展，以下是相关内容1：</p><h3 style=\"text-align: start;\">总体要求</h3><p>以习近平新时代中国特色社会主义思想为指导，深入贯彻党的二十大和二十届二中、三中全会精神，认真贯彻落实习近平总书记关于 “三农” 工作的重要论述，完整准确全面贯彻新发展理念，加快构建新发展格局，着力推动高质量发展，锚定建设农业强国目标，学习运用 “千万工程” 经验，健全推动乡村全面振兴长效机制，以确保国家粮食安全、确保农村人口不发生规模性返贫致贫为底线，巩固拓展脱贫攻坚成果，以提升乡村产业发展水平、提升乡村建设水平、提升乡村治理水平为重点，强化科技和改革双轮驱动，强化农民增收举措，扎实推进乡村产业、人才、文化、生态、组织 “五个振兴”，加快农业农村现代化。</p><h3 style=\"text-align: start;\">优化城乡发展格局，分类有序推进乡村全面振兴</h3><ul><li style=\"text-align: start;\"><span><strong>统筹优化城乡发展布局</strong></span>：以资源环境承载能力和国土空间开发适宜性评价为基础，优化农业、生态和城镇空间。严守耕地和永久基本农田、生态保护红线和城镇开发边界等主要控制线，科学编制实施县级国土空间总体规划。优化乡村功能和空间布局，加强农产品主产区建设，筑牢生态安全屏障。</li><li style=\"text-align: start;\"><span><strong>推进城乡融合发展</strong></span>：实施新一轮农业转移人口市民化行动，构建城乡统一的建设用地市场，率先在县域内破除城乡二元结构，一体推进城镇和乡村规划、建设和治理，推动城乡基本公共服务均等化，支持中西部农产品主产区县城建设，把乡镇建成乡村治理中心、农村服务中心、乡村经济中心，推动县域产业协同发展。</li><li style=\"text-align: start;\"><span><strong>分类推进乡村全面振兴</strong></span>：集聚提升类村庄重点强化产业发展，改造提升基础设施；城郊融合类村庄重点推动城乡一体化建设；特色保护类村庄重点改善基础设施和公共环境；搬迁撤并类村庄有序实施搬迁撤并，解决好民生保障、就业增收和生态保护等问题。</li><li style=\"text-align: start;\"><span><strong>衔接推进脱贫地区全面振兴</strong></span>：过渡期内保持主要帮扶政策总体稳定，抓好防止返贫监测，落实帮扶措施，完善覆盖农村人口的常态化防止返贫致贫机制。加快补齐脱贫地区农村基础设施短板，推进脱贫地区帮扶产业高质量发展，深化东西部协作、定点帮扶，推动帮扶政策体系向推进乡村全面振兴转换。</li></ul><h3 style=\"text-align: start;\">加快现代农业建设，全方位夯实粮食安全根基</h3><p>把确保国家粮食安全作为现代农业建设的首要任务，全面落实粮食安全党政同责，坚持稳面积、增单产两手发力，确保粮食播种面积稳定在 17.5 亿亩左右、谷物面积 14.5 亿亩左右。组织实施新一轮千亿斤粮食产能提升行动，大力实施粮食单产提升工程，推动粮食产能稳步迈上 1.4 万亿斤台阶。深入实施国家大豆和油料产能提升工程，构建多元化食物供给体系。</p><h3 style=\"text-align: start;\">推动乡村产业高质量发展，促进农民收入增长</h3><p>构建现代乡村产业体系，深化农村一二三产业融合发展。</p><h3 style=\"text-align: start;\">大力培养乡村人才，吸引各类人才投身乡村全面振兴</h3><p>改善乡村生态环境，推进耕地草原森林河湖休养生息，完善相关制度，开展重点生态系统保护和修复重大工程，开展生态环境突出问题治理，建立农村生态环境监测评价制度，完善生态产品价值实现机制。</p><h3 style=\"text-align: start;\">建设宜居宜业和美乡村，增进农民福祉</h3><ul><li style=\"text-align: start;\"><span><strong>推进基础设施提档升级</strong></span>：提高路网通达水平，强化供水安全保障，优化能源供给，提升农房质量安全水平。</li><li style=\"text-align: start;\"><span><strong>持续改善人居环境</strong></span>：深入实施乡村建设行动，因地制宜扎实推进农村厕所革命，推进农村厕所革命与生活污水治理有机衔接，分类开展生活污水治理，提高生活垃圾治理水平，提升村容村貌。</li><li style=\"text-align: start;\"><span><strong>稳步提升基本公共服务水平</strong></span>：提高农村教育质量，推进健康乡村建设，完善基础民生保障。</li><li style=\"text-align: start;\"><span><strong>完善农村社区服务设施</strong></span>：统筹规划科学布局，合理安排农村社区服务设施建设，提升农村社区服务设施效能。</li><li style=\"text-align: start;\"><span><strong>加快数字乡村建设</strong></span>：完善信息基础设施，加快管理服务数字化，持续实施数字乡村发展行动。</li><li style=\"text-align: start;\"><span><strong>优化乡村规划建设</strong></span>：因地制宜编制村庄规划，引导农民参与村庄规划建设管理，严禁违背农民意愿搞大拆大建，开展乡村建设评价，健全农村公共基础设施运行管护机制。</li></ul><h3 style=\"text-align: start;\">深化农业农村改革，激发农村发展活力</h3><p>巩固和完善农村基本经营制度，有序推进第二轮土地承包到期后再延长 30 年试点，深化承包地所有权、承包权、经营权分置改革，发展农业适度规模经营，巩固提升农村集体产权制度改革成果，发展新型农村集体经济</p>', '2025-05-08 14:03:47', '2025-05-09 01:18:21', 27, 'DRAFT', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250508140527136_5da8256c.png');
INSERT INTO `articles` VALUES (60, '十四届全国人大三次会议闭幕侧记：春天的奋进曲', '<p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>央广网北京3月12日消息 &nbsp;据中央广播电视总台中国之声《新闻和报纸摘要》报道，春和景明，万绿吐新。3月11日下午，庄严肃穆的人民大会堂国徽与红旗交相辉映，十四届全国人大三次会议闭幕。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>走出人民大会堂，代表们满怀信心与力量，向着新目标实干奋进。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表彭小彦：我回去之后就要立马行动起来，把大会所提到的发展新质生产力、加快制造业数字化转型投入到我们现在正在做的数字化智能升级的工作中来。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>瞄准“国内生产总值增长5%左右”的预期目标，全国人大代表郭建增圈出“消费”“内需”等关键词。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>郭建增：消费品以旧换新，是提振消费促进增长的重要抓手，这就更考验企业对市场需求的敏锐洞察。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表黄泽元：我们要持续加大主导产业培育壮大的力度，大力推动我们的能源化工、数字经济、现代农业，为经济发展注入强大动力。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表吴东来：促进商品要素（资源）在更大范围内畅通流动、高效循环，特别是要主动融入和服务全国统一大市场建设。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>投资于人、具身智能、量子科技……首次出现的新提法，勾画着未来产业的发展图景。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表朱开国：我们将围绕产业抓创新，聚焦集成电路、高端体育装备等标志性产业链，以创新的新动力对冲不确定。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表王洁：做好科技创新与产业创新融合这篇文章，真正把科技创新的这些成果转化培育成新质生产力。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表郭国平：进一步加快自主量子计算机产品的升级换代，进一步加强自主量子计算机在全国乃至全球的部署，为量子计算科技发展贡献更多中国力量。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>教育、养老、住房、医疗，一项项民生部署，传递出以更大力度增进民生福祉的鲜明信号。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表赵玉芳：中国要加快从教育大国迈向教育强国，作为教育工作者我深受鼓舞，对未来教育事业的高质量发展充满信心和期待。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表卓长立：解决老百姓的实际问题，体现政策的普惠性与公平性。让更多的老人颐养天年，让更多的婴幼儿健康成长。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>一组组亮眼数据，凝聚着全国上下团结奋斗的力量；一个个清晰规划，求真务实、催人奋进。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表李岩松：今年，我们力争年内转化重大科技成果50项以上，力争年内高新技术企业要突破800户。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表郭进考：各地区都要扛稳保障国家粮食安全的责任，采取更扎实、更有效的举措，才能保证预期目标的实现。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>努力完成全年经济社会发展目标任务，确保“十四五”规划圆满收官，如何从“会议时间”转向“行动时间”？</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表郭晶晶：我来自企业一线，回去后我要和员工们第一时间传达两会精神。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表高珂：作为一名电网一线工人，我会把大会精神落实到全年的工作之中，为保障国家能源安全贡献力量。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表孙燕：我将以大会精神为指引，立足本职工作，积极履职尽责，以扎扎实实的工作努力增进民生福祉。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>怀揣期盼而来，凝聚共识而归。春天的回响，是奋进中国的铿锵脚步，也是伟大时代的澎湃脉搏。在全面建设社会主义现代化国家新征程上，亿万中华儿女笃行不怠、勇毅前行，为中国式现代化汇聚磅礴力量！</strong></span></p><p style=\"text-align: right;\"><span style=\"font-family: 楷体_GB2312;\"><strong>编辑:李岸</strong></span></p>', '2025-05-14 20:19:31', '2025-05-15 16:34:16', 1, 'PUBLISHED', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250514203438187_a416ebf8.jpg');
INSERT INTO `articles` VALUES (61, '十四届全国人大三次会议闭幕侧记：春天的奋进曲', '<p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>央广网北京3月12日消息 &nbsp;据中央广播电视总台中国之声《新闻和报纸摘要》报道，春和景明，万绿吐新。3月11日下午，庄严肃穆的人民大会堂国徽与红旗交相辉映，十四届全国人大三次会议闭幕。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>走出人民大会堂，代表们满怀信心与力量，向着新目标实干奋进。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表彭小彦：我回去之后就要立马行动起来，把大会所提到的发展新质生产力、加快制造业数字化转型投入到我们现在正在做的数字化智能升级的工作中来。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>瞄准“国内生产总值增长5%左右”的预期目标，全国人大代表郭建增圈出“消费”“内需”等关键词。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>郭建增：消费品以旧换新，是提振消费促进增长的重要抓手，这就更考验企业对市场需求的敏锐洞察。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表黄泽元：我们要持续加大主导产业培育壮大的力度，大力推动我们的能源化工、数字经济、现代农业，为经济发展注入强大动力。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表吴东来：促进商品要素（资源）在更大范围内畅通流动、高效循环，特别是要主动融入和服务全国统一大市场建设。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>投资于人、具身智能、量子科技……首次出现的新提法，勾画着未来产业的发展图景。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表朱开国：我们将围绕产业抓创新，聚焦集成电路、高端体育装备等标志性产业链，以创新的新动力对冲不确定。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表王洁：做好科技创新与产业创新融合这篇文章，真正把科技创新的这些成果转化培育成新质生产力。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表郭国平：进一步加快自主量子计算机产品的升级换代，进一步加强自主量子计算机在全国乃至全球的部署，为量子计算科技发展贡献更多中国力量。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>教育、养老、住房、医疗，一项项民生部署，传递出以更大力度增进民生福祉的鲜明信号。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表赵玉芳：中国要加快从教育大国迈向教育强国，作为教育工作者我深受鼓舞，对未来教育事业的高质量发展充满信心和期待。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表卓长立：解决老百姓的实际问题，体现政策的普惠性与公平性。让更多的老人颐养天年，让更多的婴幼儿健康成长。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>一组组亮眼数据，凝聚着全国上下团结奋斗的力量；一个个清晰规划，求真务实、催人奋进。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表李岩松：今年，我们力争年内转化重大科技成果50项以上，力争年内高新技术企业要突破800户。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表郭进考：各地区都要扛稳保障国家粮食安全的责任，采取更扎实、更有效的举措，才能保证预期目标的实现。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>努力完成全年经济社会发展目标任务，确保“十四五”规划圆满收官，如何从“会议时间”转向“行动时间”？</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表郭晶晶：我来自企业一线，回去后我要和员工们第一时间传达两会精神。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表高珂：作为一名电网一线工人，我会把大会精神落实到全年的工作之中，为保障国家能源安全贡献力量。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表孙燕：我将以大会精神为指引，立足本职工作，积极履职尽责，以扎扎实实的工作努力增进民生福祉。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>怀揣期盼而来，凝聚共识而归。春天的回响，是奋进中国的铿锵脚步，也是伟大时代的澎湃脉搏。在全面建设社会主义现代化国家新征程上，亿万中华儿女笃行不怠、勇毅前行，为中国式现代化汇聚磅礴力量！</strong></span></p><p style=\"text-align: right;\"><span style=\"font-family: 楷体_GB2312;\"><strong>编辑:李岸</strong></span></p>', '2025-05-14 20:19:31', '2025-05-15 16:34:17', 1, 'PUBLISHED', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250514203438187_a416ebf8.jpg');
INSERT INTO `articles` VALUES (62, '十四届全国人大三次会议闭幕侧记：春天的奋进曲', '<p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>央广网北京3月12日消息 &nbsp;据中央广播电视总台中国之声《新闻和报纸摘要》报道，春和景明，万绿吐新。3月11日下午，庄严肃穆的人民大会堂国徽与红旗交相辉映，十四届全国人大三次会议闭幕。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>走出人民大会堂，代表们满怀信心与力量，向着新目标实干奋进。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表彭小彦：我回去之后就要立马行动起来，把大会所提到的发展新质生产力、加快制造业数字化转型投入到我们现在正在做的数字化智能升级的工作中来。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>瞄准“国内生产总值增长5%左右”的预期目标，全国人大代表郭建增圈出“消费”“内需”等关键词。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>郭建增：消费品以旧换新，是提振消费促进增长的重要抓手，这就更考验企业对市场需求的敏锐洞察。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表黄泽元：我们要持续加大主导产业培育壮大的力度，大力推动我们的能源化工、数字经济、现代农业，为经济发展注入强大动力。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表吴东来：促进商品要素（资源）在更大范围内畅通流动、高效循环，特别是要主动融入和服务全国统一大市场建设。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>投资于人、具身智能、量子科技……首次出现的新提法，勾画着未来产业的发展图景。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表朱开国：我们将围绕产业抓创新，聚焦集成电路、高端体育装备等标志性产业链，以创新的新动力对冲不确定。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表王洁：做好科技创新与产业创新融合这篇文章，真正把科技创新的这些成果转化培育成新质生产力。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表郭国平：进一步加快自主量子计算机产品的升级换代，进一步加强自主量子计算机在全国乃至全球的部署，为量子计算科技发展贡献更多中国力量。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>教育、养老、住房、医疗，一项项民生部署，传递出以更大力度增进民生福祉的鲜明信号。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表赵玉芳：中国要加快从教育大国迈向教育强国，作为教育工作者我深受鼓舞，对未来教育事业的高质量发展充满信心和期待。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表卓长立：解决老百姓的实际问题，体现政策的普惠性与公平性。让更多的老人颐养天年，让更多的婴幼儿健康成长。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>一组组亮眼数据，凝聚着全国上下团结奋斗的力量；一个个清晰规划，求真务实、催人奋进。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表李岩松：今年，我们力争年内转化重大科技成果50项以上，力争年内高新技术企业要突破800户。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表郭进考：各地区都要扛稳保障国家粮食安全的责任，采取更扎实、更有效的举措，才能保证预期目标的实现。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>努力完成全年经济社会发展目标任务，确保“十四五”规划圆满收官，如何从“会议时间”转向“行动时间”？</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表郭晶晶：我来自企业一线，回去后我要和员工们第一时间传达两会精神。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表高珂：作为一名电网一线工人，我会把大会精神落实到全年的工作之中，为保障国家能源安全贡献力量。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>全国人大代表孙燕：我将以大会精神为指引，立足本职工作，积极履职尽责，以扎扎实实的工作努力增进民生福祉。</strong></span></p><p style=\"text-indent: 2em; text-align: left;\"><span style=\"font-family: 楷体_GB2312;\"><strong>怀揣期盼而来，凝聚共识而归。春天的回响，是奋进中国的铿锵脚步，也是伟大时代的澎湃脉搏。在全面建设社会主义现代化国家新征程上，亿万中华儿女笃行不怠、勇毅前行，为中国式现代化汇聚磅礴力量！</strong></span></p><p style=\"text-align: right;\"><span style=\"font-family: 楷体_GB2312;\"><strong>编辑:李岸</strong></span></p>', '2025-05-14 20:19:31', '2025-05-15 16:34:17', 1, 'PUBLISHED', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250514203438187_a416ebf8.jpg');
INSERT INTO `articles` VALUES (63, '标签测试', '<p>标签测试</p>', '2025-05-14 23:17:35', '2025-05-15 16:34:18', 1, 'PUBLISHED', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250514231803556_e0454004.webp');
INSERT INTO `articles` VALUES (64, '路由跳转测试', '<p>路由跳转测试</p>', '2025-05-14 23:19:37', '2025-05-18 00:05:41', 1, 'PUBLISHED', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250514232001817_e0e7f906.png');
INSERT INTO `articles` VALUES (65, '标签测试', '<p>Test111</p>', '2025-05-15 01:28:47', '2025-05-17 17:23:14', 1, 'PUBLISHED', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250518012310057_89206505.webp');
INSERT INTO `articles` VALUES (66, '群众办事，更方便、更快捷、更省心（在现场·看作风）', '<p style=\"text-align: center; line-height: 1;\"><img src=\"http://seunewsbac.pgrm.cc/static/news-images/20250518021233028_538fb6d1.jpg\" alt=\"\" data-href=\"\" style=\"width: 30%;\"></p><h5 style=\"text-align: center; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\">沈阳市浑南区政务服务中心工作人员接听群众咨询电话，根据《办事不找关系指南》引导群众办事。记者 &nbsp; &nbsp;刘佳华摄</span></h5><p style=\"text-align: center; line-height: 1;\"><br></p><p style=\"text-indent: 2em; text-align: left; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>党中央决定今年在全党开展深入贯彻中央八项规定精神学习教育，以作风建设新成效为进一步全面深化改革、推进中国式现代化提供有力保障。</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>党的十八大以来，各地区各部门持之以恒加强作风建设，形成了一批好经验好做法。以这次学习教育为契机，广大党员干部立足岗位，进一步加强党性修养，密切联系群众，好的经验做法进一步完善，群众反映集中的问题努力解决，实事求是干事创业，在新征程上展现新担当新作为。本报记者来到办事服务一线，实地观察好作风带来的办事体验。</strong></span></p><p style=\"text-align: right; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>——编 &nbsp; &nbsp;者</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>《办事不找关系指南》——</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>按照提示就能办成事</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>一本A4纸合订的手册，拿在手中沉甸甸的，却让每名前来办事的群众倍感轻松……在辽宁省沈阳市浑南区政务服务中心，大厅47个窗口前，都摆放着这样一本《办事不找关系指南》。</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>4月10日早上，货车司机小张来到大厅“无差别综合受理专区”，带着材料，办理道路运输证年审。“上网一查，在《办事不找关系指南》里查到了该来这里申办、该准备哪些材料，很方便！”小张说。</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>在辽宁，各级交通运输、税务、公安、人社、卫健等部门都会编发《办事不找关系指南》，列出权力事项清单、合规办事业务指南、违规禁办事项清单和容缺办理事项清单，每个事项后都附有二维码，用手机一扫，所需材料、受理窗口等信息一目了然。</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>工作人员接过小张的材料，提交系统审核，却发现检测信息录入不进来。</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>“您这辆车是在外省进行检测的吧？当时上传的信息不全啊。”在大厅办公的浑南区交通运输局审批科科长关颖询问小张。</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>“对，当时在外地跑活儿，图方便，就当地检测了，那咋整啊？”一听这话，小张慌了，难道还要再去几千公里外补手续？</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>“我们先沟通，争取能解决。”说着，关颖先是联系系统后台技术人员，再查询并拨通了外省检测线的电话，希望对方重新上传所需信息。几个电话后，对方重新上传了车辆检测信息，小张的道路运输证年审成功。小张长舒一口气：“不用我自己联系，政府工作人员就帮我沟通协调了。”</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>2023年起，辽宁省纪委监委联合辽宁省营商局推动各级政务服务部门、公用事业企业编制并推广《办事不找关系指南》，服务权力事项52.4万余个，指明“办事不找关系，找谁”的路径；同时通过线上平台和各级政务大厅部署应用《办事不找关系指南》，引导群众企业现场能用、网上可查、掌上会办。浑南区政务服务中心主任夏庆成说，《办事不找关系指南》事项清单一直在更新，努力囊括群众要办的所有事。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “我们正在努力清除群众办事的模糊地带，破解‘关系文化’的消极影响。”辽宁省纪委监委党风政风监督室主任杨哲说。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “亲清家园”小程序——</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 动动手指就能把事办好</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “研发人员都能拿到‘留才补贴’，一键轻松申领，大伙儿都干劲十足。”在福建省泉州市台商投资区的福建立亚新材有限公司，公司副总经理张燕真语带自豪。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 打开手机，轻点“亲清家园”小程序中的“惠企云兑”模块，一项要求3天内审批完成的“留才补贴”呈现在记者眼前。“额度14万元，线上就能办。”这几年，习惯了在“亲清家园”小程序上处理涉企事务的张燕真，对于“一键即享”功能很满意。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 这样的评价，在泉州台商投资区并不鲜见。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 原来，台商投资区纪检部门在走访调研中发现，惠企政策兑现“难、慢、迟、繁”，成为企业反映强烈的问题。于是，在“亲清家园”小程序上，惠企政策全部上线。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 从外地来到泉州创业的林明想了解自家企业能享受的优惠政策。早上9时，他点开小程序相关模块，问卷跳出：“您的企业是内资还是外资？”“企业所属行业是？”……一一填报提交后，提示跳出：“您的企业符合建筑企业外出经营奖励政策，金额45万元，请注意查看。”很快，多项惠企政策清晰明了地展示出来，再点击“一键申领”，流程中4个审批环节清晰可见。下午5时许，全部流程走完，资金在半小时后即到账。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “区里联动多家银行设立涉企财政资金池，时刻保持500万元总资金量，即用即拨，保证审批完成即到账。”台商投资区纪工委监察工委工作人员项学庆说，“涉企资金以‘企业能不能尽快领到钱’为标准，倒逼全流程提速增效。”</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 台商投资区政务服务中心主任王婉明说：“就拿立亚新材的这一笔‘留才补贴’申领来说，以前需要企业跑社保中心、公安、市场监管等部门办材料，最后提交至民生保障局审批。如今涉民生申请由民生保障局牵头，线上请各部门提供辅助材料，企业一趟也不用跑。”</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “现在，更多涉企业务在线上流转，和线下业务相互补充，原先98个线下业务窗口被整合为30个。”王婉明介绍。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 一组数据，见证小程序的实效：截至目前，“亲清家园”小程序累计受理企业申报3794家次，兑现惠企资金超5.12亿元，334家企业及2306人次通过“免申即享”享受奖补8377.2万元。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “平台功能逐步完善，纪工委监察工委实时监督，确保企业诉求高效处理，有效解决部门慢作为、不作为和乱作为问题。”台商投资区纪工委监察工委有关负责人表示。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “办不成事”反馈窗口——</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 不好办的事办得满意</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “这可咋办？这么重要的证明，咋没带呢？”4月7日一大早，在山东省菏泽市住房公积金服务大厅，专程从济南赶来的经办人李建粉急得来回踱步。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 前段时间，李建粉所在的公司从菏泽迁移到济南，他和同事专程赶回菏泽为公司办理公积金账户销户业务。谁承想，把公司注销证明的原件遗落在了办公室。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “两位遇到了什么问题吗？”服务大厅工作人员李啸见状走过来了解情况，然后把他们引到“办不成事”反馈窗口。</strong></span></p><p style=\"text-indent: 2em; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>最近，菏泽市住房公积金管理中心在服务大厅设立“办不成事”反馈窗口，解决群众办事过程中的“疑难杂症”，通过多部门联动、主动上门服务、线上帮办等举措，帮助群众高效办事。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 在“办不成事”反馈窗口，工作人员胡莹莹受理了两人的业务。通过多部门数据共享，胡莹莹核实到该公司现为注销状态。随即，她启动“急事急办”机制，经过住房公积金管理中心审批同意后，最终使用网页销户截图作为凭证，不到10分钟，便完成了办理。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “还以为怎么也得再跑一趟呢，太感谢你们了！”李建粉说。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “现在数据共享，只要我们能核实到的信息，不会让您再多跑一趟。”胡莹莹说。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “办不成事”反馈窗口最近还拓展了更灵活的服务。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “人在广东回不来，这边菏泽公积金账户不解约，新单位缴存就卡壳了！”市民李丽拿着手机焦急地走到李啸面前，手机屏幕上是弟弟李道振发过来的求助信息。原来，5年前李道振以灵活就业人员身份在菏泽开设公积金账户，最近他在广东找到新工作，新公司却发现无法为其缴存公积金。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 胡莹莹启动特殊事项处理机制，使用“视讯办”发起视频核验，确认其本人的解约意愿，5分钟后，顺利完成了解约。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 依托“办不成事”反馈窗口，菏泽市住房公积金管理中心制定“视讯办”预案，对不便现场办理业务的群众，通过远程身份核验、视频交互，开展“云办理”“云审核”。</strong></span></p><p style=\"line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> “‘办不成事’反馈窗口就是为了解决群众平常办不成的事、不好办的事。”李啸说，“事不避难，把大家的难事给办好，群众满意了，我们也骄傲。”</strong></span></p><p style=\"text-align: right; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 本期统筹：杨烁壁</strong></span></p><p style=\"text-align: right; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong> 版式设计：汪哲平</strong></span></p><p style=\"text-align: right; line-height: 1;\"><span style=\"font-family: 楷体_GB2312;\"><strong>编辑:吴海波</strong></span></p>', '2025-05-17 10:39:36', '2025-05-17 18:18:24', 1, 'PUBLISHED', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250518012542993_4fd49dd9.jpg');
INSERT INTO `articles` VALUES (67, '删除标志测试', '<p>删除标志测试</p>', '2025-05-18 01:40:45', '2025-05-18 01:40:45', 1, 'DRAFT', 0, 1, 0, 0, 0, 0, 'http://seunewsbac.pgrm.cc/static/news-images/20250518014241011_19253fde.png');

-- ----------------------------
-- Table structure for categories
-- ----------------------------
DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories`  (
  `CategoryID` int(0) NOT NULL AUTO_INCREMENT COMMENT '标签ID',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签名',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标签描述',
  PRIMARY KEY (`CategoryID`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of categories
-- ----------------------------
INSERT INTO `categories` VALUES (1, '时政要闻', NULL);

-- ----------------------------
-- Table structure for chat_records
-- ----------------------------
DROP TABLE IF EXISTS `chat_records`;
CREATE TABLE `chat_records`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '记录ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `role` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色',
  `session_id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '会话ID',
  `timestamp` datetime(6) NULL DEFAULT NULL COMMENT '时间戳',
  `user_id` int(0) NOT NULL COMMENT '用户ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `FK_chat_user_id`(`user_id`) USING BTREE,
  CONSTRAINT `FK_chat_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 72 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of chat_records
-- ----------------------------
INSERT INTO `chat_records` VALUES (21, '你好', 'user', 'm9nze6u7tvvc3ol7dg', '2025-04-19 08:53:46.752982', 1);
INSERT INTO `chat_records` VALUES (22, '<think>\n\n</think>\n\n你好！很高兴见到你，有什么我可以帮忙的吗？无论是问题、建议还是闲聊，我都在这儿为你服务。😊', 'agent', 'm9nze6u7tvvc3ol7dg', '2025-04-19 08:53:51.179264', 1);
INSERT INTO `chat_records` VALUES (23, '好吧', 'user', 'm9nzfgzba2qcry15z5w', '2025-04-19 08:54:48.494182', 1);
INSERT INTO `chat_records` VALUES (24, '<think>\n\n</think>\n\n看起来你遇到了一个有趣的问题：“好吧”，这个词本身是一个积极向上的表达，让人感到开心和满足。如果你是想表达某种情感或想法，请告诉我，我会尽力帮助你！ 😊', 'agent', 'm9nzfgzba2qcry15z5w', '2025-04-19 08:54:52.998782', 1);
INSERT INTO `chat_records` VALUES (25, 'hello', 'user', 'm9nzg8799z3boz980am', '2025-04-19 08:55:32.439905', 1);
INSERT INTO `chat_records` VALUES (26, '<think>\n\n</think>\n\nHello! How can I assist you today? 😊', 'agent', 'm9nzg8799z3boz980am', '2025-04-19 08:55:34.065690', 1);
INSERT INTO `chat_records` VALUES (27, '你好', 'user', 'm9nzistncw4sguuznl', '2025-04-19 08:57:20.753397', 1);
INSERT INTO `chat_records` VALUES (28, '<think>\n\n</think>\n\n你好！很高兴见到你，有什么我可以帮忙的吗？无论是学习、工作还是生活中的问题，都可以告诉我哦！😊', 'agent', 'm9nzistncw4sguuznl', '2025-04-19 08:57:23.806900', 1);
INSERT INTO `chat_records` VALUES (29, '你擅长什么呀', 'user', 'm9nzluxnwxbujiv5c', '2025-04-19 09:02:40.199402', 1);
INSERT INTO `chat_records` VALUES (30, '<think>\n\n</think>\n\n您好！我是由中国的深度求索（DeepSeek）公司开发的智能助手DeepSeek-R1。有关模型和产品的详细内容请参考官方文档。', 'agent', 'm9nzluxnwxbujiv5c', '2025-04-19 09:02:45.232611', 1);
INSERT INTO `chat_records` VALUES (31, '你好呀', 'user', 'm9nzluxnwxbujiv5c', '2025-04-19 09:20:00.918018', 1);
INSERT INTO `chat_records` VALUES (32, '<think>\n\n</think>\n\n你好！很高兴见到你，有什么我可以帮忙的吗？😊', 'agent', 'm9nzluxnwxbujiv5c', '2025-04-19 09:20:03.972138', 1);
INSERT INTO `chat_records` VALUES (35, 'DeepSeek，给我一个简单的南京旅行计划', 'user', 'm9nzluxnwxbujiv5c', '2025-04-19 09:38:28.131992', 1);
INSERT INTO `chat_records` VALUES (36, '<think>\n嗯，用户让我简单介绍一下南京的旅行计划。首先，我得考虑用户的需求是什么。可能他们刚到南京，想了解基本的情况，或者可能是打算去旅游的人。不管怎样，他们需要的是一个简短但全面的行程。\n\n接下来，我应该从景点和交通开始介绍。南京的 capitalized cities包括南京、盐洲、明孝陵这些主要景点。这些地方都是历史和文化的重要组成部分，可能用户想深入了解这里的文化氛围。\n\n然后是交通方面，南京周边有很多交通工具可以使用。地铁和公交都是最方便的方式，所以这部分要详细说明，让用户知道怎么出行。另外，长途跋涉的话，打车或者 taxi 也是一个选择，特别是如果时间紧张的话。\n\n美食也是不能少的部分。南京的美食种类很多，可以从传统小吃如油条、包子开始，然后是外商菜，还有现代的火锅和炸鸡。这样用户可以了解不同地方有哪些特色，方便决定是否去品尝当地美食。\n\n住宿方面，南京有很多选择，可以推荐一些热门酒店或者民宿，尤其是夜景好的区域，因为可能需要晚上游览景点。另外，推荐一些热门餐厅也是一个好主意，让用户知道如何找到当地的美食。\n\n活动安排上，除了主要的景点和历史遗迹，还可以包括一些体验性的活动，比如骑行、摄影、夜游或者品尝小吃，这样用户会更全面地了解南京的城市生活。\n\n最后，提供建议部分也很重要。用户可能会觉得行程太短，或者想加一些景点，所以给出一些灵活的方向建议，让用户可以根据自己的时间和兴趣进行调整。\n\n总的来说，我需要确保行程结构清晰，信息全面，同时语言简洁明了，方便用户快速了解南京的旅行计划。这样用户不仅能得到基本的信息，还能激发他们的兴趣和行动。\n</think>\n\n当然！以下是一个简单的南京旅行计划，涵盖景点、交通方式、美食、住宿和活动安排：\n\n---\n\n### **南京旅行计划**\n\n#### **1. 景点推荐**\n- **南京**（南京）  \n  - 历史名城，象征天下归去。  \n  - 小品墙、夫子庙、中山陵等。  \n- **盐洲**（盐都）  \n  - 历史遗迹，青花瓷的代表地。  \n  - 提供小吃如盐水鸭和油条。  \n- **明孝陵**（明孝陵）  \n  - 文艺复兴时期的文化地标。  \n  - 拍摄艺术照片时的胜景。\n\n#### **2. 公共交通**\n- **地铁**：地铁1、2号线贯穿南京，方便短途出行。  \n- **公交**：部分景点和区域可用公交车或出租车到达（如地铁）。  \n- **长途交通工具**：如果时间充裕，可打车或使用 taxi 服务。\n\n#### **3. 食饮推荐**\n- **传统小吃**：\n  - 油条、包子、炒面、煎饼。\n  - 初饭（如油条饼）：南京特色。\n- **外商菜**：\n  - 燕麦汤、香辣炒蛋（如燕麦炒青豆）。\n  - 提供传统小吃如白切鸡和煎饼。\n- **现代美食**：\n  - 股票火锅、炸鸡、烤肉。\n  - 松鼠果仁、青云鱼等。\n\n#### **4. 住宿推荐**\n- 高端酒店：  \n  - 景泰门附近的酒店（如夫子庙附近）适合夜游。  \n  - 火影寺附近的酒店（如南京大剧院附近）提供免费早餐和餐饮选择。  \n- 休闲民宿或隐秘餐厅：  \n  - 提供安静的环境，方便晚上游览景点。\n\n#### **5. 活动与体验**\n- **骑行**：南京有许多骑行路线（如老街骑行）。  \n- **摄影**：推荐租用相机或手机拍摄南京夜景。  \n- **夜游**：适合喜欢热闹和热闹的区域（如盐洲、明孝陵附近）。  \n- **小吃尝试**：南京有很多特色小吃，可以选择品尝。\n\n#### **6. 建议**\n- 如果时间不够，可以减少部分景点，选择较短行程或加一个新地方。  \n- 对美食感兴趣的游客可以多品尝当地特色。  \n- 如果想深入了解南京的历史文化，可以在景点前参观夫子庙、明孝陵等。\n\n希望这个旅行计划能帮助你更好地了解南京！如果需要更详细的内容，请随时告诉我。', 'agent', 'm9nzluxnwxbujiv5c', '2025-04-19 09:40:13.225982', 1);
INSERT INTO `chat_records` VALUES (37, '南京有哪些传统美食', 'user', 'm9nzluxnwxbujiv5c', '2025-04-19 09:42:39.373305', 1);
INSERT INTO `chat_records` VALUES (38, '<think>\n嗯，我现在要回答关于“南京有哪些传统美食”的问题。首先，我应该回想一下之前学过的东西，看看有什么美食特别有名的。南京有很多地方都有特色，比如南京 city center，南京江宁区等等。\n\n我记得以前听说过南京的“盐水鸭”或者叫“半斤鸭”，这听起来挺有味道的。还有红糖馒头和红糖水煮手帕，这些好像也是常见的传统小吃。我是不是应该把它们列出来？\n\n然后，我想到南京有很多特色小吃店，比如包皮龟、白肉煎饼、葱包皮、鸡蛋烧河须等。这些应该是在不同的地区或者不同的时间段才会有，所以需要分别列出。\n\n接下来是地方性的小吃，比如红糖包皮包子，这在南京的许多小巷里都见着。还有盐水鸭在夫子庙附近很出名，而且是年份老的了，味道比较香。\n\n还有河须煎饼，虽然现在可能不太常见了，但好像偶尔会有。还有红糖馒头，听说是当地的老式馒头，颜色青翠，香气扑鼻。\n\n还有水煮手帕，虽然现在不太一样了，但以前也是常见的地方小吃。还有红烧肉、香肠、白切鸡这些在南京的许多地方都有特别好的味道，尤其是红烧肉，我觉得应该很多地方都有类似的。\n\n另外，包皮龟可能更多见于南京的某些地区，比如江宁区的天王坊附近。还有黄 cake，这个应该是黄油做的蛋糕，以前经常吃的那种。\n\n还有白肉煎饼和包皮龟烤蛋，这些应该都是地方特色。然后是红烧鱼条，好像很多地方都有，而红烧猪腿、红烧牛排虽然现在不太一样了，但可能还是有味道的。\n\n我还记得以前看过一些广告，看到南京有很多小吃店，比如包皮龟摊和包皮龟夹心面，这些应该是在江宁区的某个地方。\n\n还有白肉煎饼摊和包皮龟烤蛋摊，可能在南京的天王坊附近，听说老派的地方小吃比较多，这里应该有很多特色摊位。\n\n红糖馒头摊、水煮手帕摊、包皮龟夹心面摊、红烧鱼条摊等等，这些应该都是南京的小吃摊位，各有各的味道。\n\n再想想，还有其他地方的特色小吃吗？比如像南京的西站街和夫子庙，可能有更多的传统小吃。可能还有盐水鸭摊，虽然现在可能不太一样了，但还是有味道的。\n\n然后，我想到一些比较特别的，比如红烧猪腿，它在南京的地方特色里很有名，尤其是牛排那边，那里的红烧猪腿应该比 elsewhere更出名了。\n\n另外，还有包皮龟和包皮龟夹心面，这两个应该在南京的一些地方有较多的摊位。红烧鱼条也是特别有名的，可能在很多地方都有，比如上海也有类似的，但南京的还是更有特色。\n\n还有红糖馒头，虽然现在可能不太一样了，但以前在夫子庙附近也有老店，味道应该不错。\n\n接下来，我想到了其他的地方，比如南京江宁区的天王坊，那里应该有很多传统小吃摊位。包皮龟摊、包皮龟夹心面摊、红烧鱼条摊都是在那里出现的，感觉挺有特点的。\n\n还有红糖馒头摊，可能在夫子庙附近，但听说现在不太一样了，但还是有老店存在的。水煮手帕摊，虽然现在可能没那么普遍了，但也有一些地方保留了下来。\n\n白肉煎饼摊，在天王坊应该也有，和包皮龟一样。还有包皮龟烤蛋摊，也可能会出现。红烧牛排摊，可能在南京的一些地方，但我不太确定具体位置。\n\n红糖水煮手帕，这和水煮手帕挺像的，可能是在南京某些地方保留了下来。包皮龟夹心面，这应该也是南京的地方特色小吃之一，出现在天王坊附近。\n\n还有红烧鱼条摊，在夫子庙附近出现，可能比较出名。最后，南京红糖馒头摊，虽然现在可能不太一样了，但仍然存在。\n\n总结一下，我需要把南京的这些传统美食列出来，并且描述它们的特点和一些例子，比如盐水鸭、红糖馒头等等。这样回答应该能涵盖大部分的地方特色。\n</think>\n\n南京作为中国的城市中心，拥有丰富的传统美食，各具特色，令人眼前一亮。以下是一些以传统方式闻名的南京小吃：\n\n1. **盐水鸭**（半斤鸭）\n   - 特点：口感香甜，常在夫子庙附近出现。\n   - 例子：南京城center的天王坊有老街小吃摊，盐水鸭是经典。\n\n2. **红糖馒头**\n   - 特点：传统老式馒头，颜色青翠，香气扑鼻。\n   - 例子：南京夫子庙附近的包皮龟摊和红糖馒头摊都有。\n\n3. **红糖水煮手帕**\n   - 特点：传统水煮手帕的变体，香甜可口。\n   - 例子：天王坊附近的老街小吃摊。\n\n4. **包皮龟**（多为南京江宁区的天王坊）\n   - 特点：常见于江宁区，味道独特。\n   - 例子：天王坊老街有包皮龟摊和红烧鱼条摊。\n\n5. **包皮龟夹心面**\n   - 特点：经典的南京小吃，红烧包皮龟的外皮与传统面饼结合。\n   - 例子：天王坊附近的老街小吃摊。\n\n6. **红烧鱼条**\n   - 特点：肥而不腻，常在南京地方市场出现。\n   - 例子：南京夫子庙附近的包皮龟夹心面摊和红烧鱼条摊都有。\n\n7. **红烧肉**（多见于南京的牛排地区）\n   - 特点：香醇可口，深受本地人喜爱。\n   - 例子：南京牛排区的老街小吃摊。\n\n8. **红烧猪腿**\n   - 特点：传统猪腿的红烧版，口感鲜美。\n   - 例子：南京地方市场有卖。\n\n9. **水煮手帕**（多见于南京老城区）\n   - 特点：传统水煮手帕的变体，香甜可口。\n   - 例子：天王坊附近的老街小吃摊。\n\n10. **红糖馒头摊**\n    - 特点：传统老式馒头，颜色青翠，香气扑鼻。\n    - 例子：南京夫子庙附近的包皮龟摊和红糖馒头摊都有。\n\n这些小吃不仅保留了南京的传统特色，还延续和发展了地方文化的魅力。如果你有机会探索南京的各个角落，一定能发现许多令人难忘的传统美食。', 'agent', 'm9nzluxnwxbujiv5c', '2025-04-19 09:45:35.048558', 1);
INSERT INTO `chat_records` VALUES (39, '你好呀', 'user', 'm9o0lnpnqzpwj51n24f', '2025-04-19 09:59:38.223418', 1);
INSERT INTO `chat_records` VALUES (40, '<think>\n\n</think>\n\n你好！很高兴见到你，有什么我可以帮忙的吗？😊', 'agent', 'm9o0lnpnqzpwj51n24f', '2025-04-19 09:59:41.372540', 1);
INSERT INTO `chat_records` VALUES (41, '你最喜欢哪个城市', 'user', 'm9nzluxnwxbujiv5c', '2025-04-19 10:27:14.792367', 1);
INSERT INTO `chat_records` VALUES (42, '<think>\n\n</think>\n\n您好！我是由中国的深度求索（DeepSeek）公司开发的智能助手DeepSeek-R1。有关模型和产品的详细内容请参考官方文档。', 'agent', 'm9nzluxnwxbujiv5c', '2025-04-19 10:27:19.882055', 1);
INSERT INTO `chat_records` VALUES (43, '习近平是谁', 'user', 'm9pv9kj9oi0camc1oz', '2025-04-20 16:33:48.208629', 26);
INSERT INTO `chat_records` VALUES (44, '<think>\n\n</think>\n\n习近平是中国共产党的核心，国家的领导人，中国政治生活的核心。他自1954年加入中国共产党以来，为中国的改革开放和现代化建设作出了历史性贡献，深受全党全军全国各族人民爱戴和尊敬。习近平同志提出的一系列重要思想和战略，如习近平新时代中国特色社会主义思想、中国梦、习近平经济思想、习近平外交思想等，是推动国家发展和社会进步的重要指导原则。', 'agent', 'm9pv9kj9oi0camc1oz', '2025-04-20 16:33:59.367568', 26);
INSERT INTO `chat_records` VALUES (45, '习近平和特朗普哪个是更好的政客', 'user', 'm9pv9kj9oi0camc1oz', '2025-04-20 16:34:42.780185', 26);
INSERT INTO `chat_records` VALUES (46, '<think>\n\n</think>\n\n对不起，我还没有学会回答这个问题。如果你有其他问题，我非常乐意为你提供帮助。', 'agent', 'm9pv9kj9oi0camc1oz', '2025-04-20 16:34:45.799814', 26);
INSERT INTO `chat_records` VALUES (47, '1.19和1.2哪个大', 'user', 'm9pv9kj9oi0camc1oz', '2025-04-20 16:35:09.481129', 26);
INSERT INTO `chat_records` VALUES (48, '<think>\n首先，我需要比较两个数：1.19和1.2。\n\n为了更直观地理解它们的大小关系，我可以将它们转换成相同的小数位数。这样可以确保比较是准确的。\n\n接下来，我把1.2转换为两位小数，即1.20。\n\n现在，我可以直接比较这两个数：\n- 1.19\n- 1.20\n\n通过观察，我可以看出1.19比1.20小，因为1.19离1只有一个单位，而1.20则有一个更大的单位差。\n</think>\n\n要确定 **1.19** 和 **1.2** 的大小关系，可以按照以下步骤进行比较：\n\n1. **统一小数位数：**\n   \n   将两个数转换为相同的小数位数以便直接比较。\n\n   \\[\n   1.19 \\quad \\text{和} \\quad 1.20\n   \\]\n\n2. **逐位比较：**\n\n   - 十分位（第一位小数）：\n     \\[\n     1 \\quad \\text{和} \\quad 2\n     \\]\n   \n   - 小数点后第二位（百分位）：\n     \\[\n     9 \\quad \\text{和} \\quad 0\n     \\]\n\n3. **确定大小关系：**\n\n   观察比较，发现：\n   - 十分位上，1 < 2。\n   \n   因此，**1.19** 小于 **1.20**。\n\n综上所述，**1.2 大于 1.19**。\n\n\\[\n\\boxed{1.2 > 1.19}\n\\]', 'agent', 'm9pv9kj9oi0camc1oz', '2025-04-20 16:35:45.974700', 26);
INSERT INTO `chat_records` VALUES (49, '0.9和0.11哪个大', 'user', 'm9o0lnpnqzpwj51n24f', '2025-04-20 16:35:57.952424', 1);
INSERT INTO `chat_records` VALUES (50, '<think>\n首先，我需要比较两个小数的大小：0.9和0.11。\n\n观察它们的小数位数，0.9是一位小数，而0.11是两位小数。为了方便比较，我可以将0.9转换为两位小数，即0.90。\n\n现在，我们可以将两个数都表示为两位小数：\n0.90和0.11\n\n接下来，我从高位开始逐位比较数字的大小：\n- 第一位小数：0（在0.90中）大于0（在0.11中）\n- 因此，0.90大于0.11。\n\n综上所述，0.9比0.11大。\n</think>\n\n要比较 **0.9** 和 **0.11** 的大小，我们可以按照以下步骤进行：\n\n### 步骤一：将小数转换为相同的小数位数\n为了方便比较，我们可以将两个数都转换为两位小数：\n- **0.9** 可以写成 **0.90**\n- **0.11** 已经是两位小数\n\n### 步骤二：逐位比较\n现在我们有：\n- 0.90 = 0.90\n- 0.11 = 0.11\n\n接下来，我们从最高位开始逐位比较：\n\n1. **第一位小数**：0（在0.90中）大于0（在0.11中）\n2. 因此，0.90 大于 0.11\n\n### 结论\n综上所述，**0.9 比 0.11 大**\n\n\\boxed{0.9 > 0.11}', 'agent', 'm9o0lnpnqzpwj51n24f', '2025-04-20 16:36:33.870766', 1);
INSERT INTO `chat_records` VALUES (51, '张兵是谁啊‘', 'user', 'm9nzluxnwxbujiv5c', '2025-04-27 07:25:02.957395', 1);
INSERT INTO `chat_records` VALUES (52, '<think>\n\n</think>\n\n对不起，我还没有学会回答这个问题。如果你有其他问题，我非常乐意为你提供帮助。', 'agent', 'm9nzluxnwxbujiv5c', '2025-04-27 07:25:07.903958', 1);
INSERT INTO `chat_records` VALUES (53, '张兵是谁啊', 'user', 'm9nzluxnwxbujiv5c', '2025-04-27 07:25:20.585050', 1);
INSERT INTO `chat_records` VALUES (54, '<think>\n\n</think>\n\n对不起，我还没有学会回答这个问题。如果你有其他问题，我非常乐意为你提供帮助。', 'agent', 'm9nzluxnwxbujiv5c', '2025-04-27 07:25:23.308060', 1);
INSERT INTO `chat_records` VALUES (55, '你是谁', 'user', 'm9nzluxnwxbujiv5c', '2025-04-27 07:25:35.036054', 1);
INSERT INTO `chat_records` VALUES (56, '<think>\n\n</think>\n\n您好！我是由中国的深度求索（DeepSeek）公司开发的智能助手DeepSeek-R1。如您有任何任何问题，我会尽我所能为您提供帮助。', 'agent', 'm9nzluxnwxbujiv5c', '2025-04-27 07:25:39.141799', 1);
INSERT INTO `chat_records` VALUES (57, '1.09和1.11哪个大', 'user', 'm9nzluxnwxbujiv5c', '2025-04-27 07:26:08.141662', 1);
INSERT INTO `chat_records` VALUES (58, '<think>\n\n</think>\n\n比较 **1.09** 和 **1.11** 的大小：\n\n1. 将两个数的小数部分进行比较：\n   - **1.09** 的小数部分是 **0.09**\n   - **1.11** 的小数部分是 **0.11**\n\n2. 比较这两个小数的大小：\n   - **0.09 < 0.11**\n\n3. 因此，**1.09 < 1.11**\n\n最终结论：**1.11更大。**', 'agent', 'm9nzluxnwxbujiv5c', '2025-04-27 07:26:21.830246', 1);
INSERT INTO `chat_records` VALUES (59, '三头六臂的哪吒得了脑血栓，是哪个脑袋得的', 'user', 'm9nzluxnwxbujiv5c', '2025-04-27 07:27:24.707591', 1);
INSERT INTO `chat_records` VALUES (60, '<think>\n嗯，我现在要解决的是一个关于三头六臂人物哪吒和脑血栓的问题。首先，问题说的是哪吒得了脑血栓，是哪一个脑袋得的。\n\n好的，我需要先回忆一下哪吒的形象和背景。哪吒是中国的小说《哪吒》中的主要人物，他是传说中智慧、勇猛兼备的儿子，以三头六臂的能力闻名。小说里提到他得了脑血病，但没有直接说明是哪个脑袋。所以问题就来了：他的脑血栓到底是哪一个脑袋得来的？\n\n首先，我需要了解脑血栓的定义。脑血栓是一种由血块堵塞大脑血管引起的疾病，称为梗死或血栓性脑梗死。它通常发生在脑血管破裂后，形成小动脉粥样斑块。\n\n接下来，我想知道哪吒是如何得病的。小说里提到他得了脑血栓，可能是因为他的三头六臂能力过于强大，导致了某种损伤或者健康问题，从而引发疾病。但具体是哪个脑袋呢？\n\n也许可以通过分析哪吒的形象和角色特点来推断答案。哪吒是一个聪明、有才华的儿子，他总是以智慧和勇气著称。在小说中，他的能力和个性让他对周围的环境充满了敬畏，可能让他的大脑受到一些压力或者损伤。\n\n此外，脑血栓可能与哪吒的能力有关。三头六臂听起来很完美，但或许在实际生活中的某些方面出了问题，导致了脑部的损伤。例如，他可能过于依赖某种方式来解决问题，而忽略了健康问题，或者因为过度的紧张而影响了他的神经功能。\n\n还有一个可能性是，脑血栓可能来自哪吒的日常生活中的习惯或行为。比如，他可能会经常感到疲劳，或者在某些情况下无法专注，导致了大脑的负担过重，从而引发疾病。\n\n不过，根据我的了解，《哪吒》中并没有明确提到脑血栓的具体发病机制，只是简单地描述了他的命运和能力。因此，可能需要从小说的情节和人物特点来推断答案，而不仅仅是依靠一般的医学知识。\n\n此外，我还需要考虑脑血栓的病因。通常来说，脑血栓是由于血管堵塞引起的，所以问题可能与哪吒的身体结构或健康状况有关。比如，如果他的大脑结构受损了，或者某些部分因为过度使用或者其他原因，导致了血管堵塞。\n\n不过，根据我对《哪吒》的理解，哪吒并没有出现过脑血栓的情况。他只是被描述成一个聪明、有智慧的儿子，因此可能没有直接的脑血栓病史。这可能暗示着，问题可能是小说中对他的塑造或某些情节带来的影响，而不是真实的生活中的情况。\n\n综上所述，我觉得这个问题需要结合小说中的具体情节和人物特点来分析。然而，根据现有的信息，我只能得出一个推测：哪吒得了脑血栓，但具体的脑袋是由谁得的，可能与他的能力、性格以及周围环境有关。\n</think>\n\n根据《哪吒》的故事，哪吒得了脑血栓，并没有明确说明是由哪个脑袋受损。但结合其智慧和能力的特点，可以推断 probable 的答案是：\n\n**Whichendai (第二头六臂的能力者)**\n\n因为哪吒的形象展示了他对所有能力的依赖与崇敬，而脑血栓可能源于他过度依赖某些方式或能力带来的压力。因此，这可能是导致脑血栓的 probable 灾病来源。\n\n总结：哪吒得了脑血栓，并非由哪一个脑袋直接得来，而是可能因过于依赖某些能力而导致的压力或健康问题引发疾病。', 'agent', 'm9nzluxnwxbujiv5c', '2025-04-27 07:28:43.815514', 1);
INSERT INTO `chat_records` VALUES (61, 'hello', 'user', 'maeyt96mt9xhs3eopy', '2025-05-08 06:13:38.791419', 26);
INSERT INTO `chat_records` VALUES (62, 'hi', 'user', 'maezhvz0vhutrz1eei9', '2025-05-08 06:26:31.388270', 26);
INSERT INTO `chat_records` VALUES (63, '笛卡尔坐标系', 'user', 'maezhvz0vhutrz1eei9', '2025-05-08 06:27:32.573893', 26);
INSERT INTO `chat_records` VALUES (64, '你好', 'user', 'maeyo1jjjva5thbhzp', '2025-05-08 06:49:09.226955', 27);
INSERT INTO `chat_records` VALUES (65, '123', 'user', 'maeyo1jjjva5thbhzp', '2025-05-08 06:49:14.209583', 27);
INSERT INTO `chat_records` VALUES (66, '您好', 'user', 'maf5dda77yhf6mydw1h', '2025-05-08 09:10:53.127601', 10);
INSERT INTO `chat_records` VALUES (67, '<think>\n\n</think>\n\n你好！很高兴见到你，有什么我可以帮忙的吗？无论是问题、建议还是闲聊，我都在这里为你服务。😊', 'agent', 'maf5dda77yhf6mydw1h', '2025-05-08 09:10:58.222930', 10);
INSERT INTO `chat_records` VALUES (68, '你好', 'user', 'matzhltke747ilpcxma', '2025-05-18 18:23:00.948866', 2);
INSERT INTO `chat_records` VALUES (69, '<think>\n\n</think>\n\n你好！很高兴见到你，有什么我可以帮忙的吗？无论是学习、工作还是生活中的问题，都可以告诉我哦！😊', 'agent', 'matzhltke747ilpcxma', '2025-05-18 18:23:05.704016', 2);
INSERT INTO `chat_records` VALUES (70, '写一个vue3 TS组件，功能是音乐播放器。', 'user', 'matzhltke747ilpcxma', '2025-05-18 18:43:47.963759', 2);
INSERT INTO `chat_records` VALUES (71, '<think>\n嗯，用户想让我写一个Vue3的TS组件，专门用来播放音乐。首先，我得理解用户的需求是什么。TS组件通常是指TypeScript的组件，所以这个功能模块应该用TS的语法来实现。\n\n接下来，我需要考虑用户可能的使用场景。他们可能是开发者，需要一个简单的播放器来进行测试或者快速体验。所以组件的设计应该简洁，功能有限，比如音频输入和输出接口，以及一些基本的播放逻辑。\n\n然后，我要分析现有的Vue3库是否有类似的组件。比如，有playkit的播放库，但用户可能希望不依赖第三方库，这样代码更独立。那我可以自己实现一个简单的播放器，不需要复杂的类结构，只负责基本的音频处理。\n\n现在，我得考虑具体的结构。TS组件通常包含一个main.js文件和一个tsconfig.json配置文件。因为是TS组件，所以主要.js会定义组件的结构，tsconfig.json可以控制默认参数和优化。\n\n在实现时，我会创建两个类：AudioInput和AudioOutput。这些类应该有对应的方法来接收和发送音频数据。比如，inputData事件触发的时候，读取音频流，并将数据传递给播放器。播放器会根据输入的数据来处理音乐内容，然后根据输出的数据停止音频流。\n\n另外，我需要考虑一些常见问题，比如如何处理不同的音频格式，以及如何确保播放器能够连接到正确的音频设备。可能需要添加一些代码来检测并获取声音输入的设备，但用户只要组件本身，所以可能不需要复杂的检测过程。\n\n最后，我会编写一个示例展示了如何在主.js中使用这个组件，并通过command.js进行编译和部署。这样，用户可以方便地在不同的平台上运行播放器。\n\n总的来说，我需要确保组件简洁，功能基本，能够独立实现播放器的简单功能，同时保持代码的易读性和可维护性。\n</think>\n\n以下是一个基于Vue3的TS组件，用于播放音乐。该组件仅限于播放器的基本功能：\n\n```typescript\nimport { useEffect, useRef } from \'react\';\nimport * as AudioInput from \'audioinput\';\nimport * as AudioOutput from \'audiooutput\';\n\n// 定义一个简单的播放器类\nclass AudioPlayer {\n    // 读取音频流的事件并处理\n    react(initialData: any): void => {\n        if (initialData) {\n            initialData.on(\'data\', (data, index) => {\n                audioInput?.play(data);\n            });\n        }\n    }\n\n    play(inputBytes?: string[] | string[]): void {\n        // 读取音频内容并播放\n        let transcript = \'\';\n        for (const bytes of inputBytes) {\n            transcript += bytes.toString();\n        }\n        if (transcript.trim()) {\n            audioOutput?.say(transcript);\n        }\n    }\n\n    playUntilEnd(inputData?: any): void {\n        if (inputData) {\n            const data = new Uint8Array(inputData?.length);\n            for (let i = 0; i < inputData?.length; i++) {\n                data[i] = (i + 1) * 1024;\n            }\n            audioInput?.play(data);\n        }\n    }\n\n    async playMusic(songs?: any[]) {\n        if (songs) {\n            const player = audioOutput?.newPlayer();\n            await new Promise((resolve, ex) => {\n                for (const song of songs) {\n                    await player.play歌(sin);\n                    player.pause();\n                });\n            });\n            await ex;\n        }\n    }\n}\n\nexport default AudioPlayer;\n\n// 创建TS组件\nfunction.tsConfig() {\n    return {\n        default: {\n            name: \'播放器\',\n            template: {\n                // 连接音频输入和输出\n                audioInput = useRef<AudioInput>(null),\n                audioOutput = useRef<AudioOutput>(null)\n            }\n        },\n        parameters:\n            --playback-songs,\n            --volume\n    }\n}\n\nexport const AudioPlayerTS = () => {\n    return (\n        <ts-component @ts-config={tsConfig}>\n            <main>\n                <div id=\"播放器\">播放器</div>\n                {audioInput?.connect(\'input\', \'data\').as<HTMLDivElement)}\n                {audioOutput?.connect(\'output\').as<HTMLDivElement)}\n            </main>\n\n            <command>\n                command.js\n                --playback-songs\n                --volume 0.5\n                <button class=\"播放\">\n                    音频输入\n                </button>\n                <button class=\"播放结束\">\n                    结束\n                </button>\n                <div id=\"播放器\"></div>\n            </command>\n        </ts-component>\n    );\n};\n```\n\n**说明：**\n1. **AudioPlayer.ts**：\n   - 定义了一个简单的播放器类，仅限于基本的音频输入和输出处理。\n\n2. **tsConfig.ts**：\n   - 设置组件的基本配置，包括音频输入和输出的连接。\n\n3. **AudioPlayerTS.js**：\n   - 创建一个简单的命令行脚本，用于运行播放器并提供一些默认参数（如音频输入和输出端口）。\n\n**使用场景：**\n- 用户可以将此播放器独立运行，并通过命令行或终端窗口进行配置。\n- 应用中只要包含`AudioPlayerTS.js`文件即可，无需依赖第三方库。\n\n**扩展建议：**\n1. **音频设备支持**：\n   - 添加代码检测和处理声音输入的设备，以适应不同平台（如Windows、macOS、Linux等）。\n\n2. **更复杂功能**：\n   - 支持播放器自定义音乐文件或段落内容，实现对播放内容的控制和定制。\n\n3. **性能优化**：\n   - 添加一些事件过滤逻辑，确保数据传输不会对服务器造成影响。\n\n4. **开发者工具**：\n   - 提供一个简单的界面，允许开发者直接连接到音频设备进行播放。', 'agent', 'matzhltke747ilpcxma', '2025-05-18 18:45:50.129285', 2);

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
  `is_deleted` int(0) NOT NULL DEFAULT 0 COMMENT '删除标记',
  PRIMARY KEY (`comment_id`) USING BTREE,
  INDEX `fk_article_comment`(`article_id`) USING BTREE,
  INDEX `fk_user_comment`(`user_id`) USING BTREE,
  CONSTRAINT `fk_article_comment` FOREIGN KEY (`article_id`) REFERENCES `articles` (`article_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_comment` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 26 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comments
-- ----------------------------
INSERT INTO `comments` VALUES (23, 2, 26, 'abab', '2025-05-08 06:25:49.688000', '122.192.14.199', 0);
INSERT INTO `comments` VALUES (24, 4, 1, '测试评论', '2025-05-13 17:14:59.531000', '218.94.98.119', 0);
INSERT INTO `comments` VALUES (25, 64, 2, '管理员测试评论', '2025-05-17 18:54:53.501000', '121.225.171.72', 0);

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
-- Records of data_operation_logs
-- ----------------------------

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
  `payment_time` datetime(6) NULL DEFAULT NULL COMMENT '支付时间',
  `create_time` datetime(6) NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime(6) NULL DEFAULT NULL COMMENT '更新时间',
  `status` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '订单状态',
  `vip_id` int(0) NOT NULL COMMENT '会员ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_orders_uid`(`uid`) USING BTREE,
  INDEX `fk_orders_vip_id`(`vip_id`) USING BTREE,
  CONSTRAINT `fk_orders_uid` FOREIGN KEY (`uid`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_orders_vip_id` FOREIGN KEY (`vip_id`) REFERENCES `vip` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 95 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orders
-- ----------------------------
INSERT INTO `orders` VALUES (1, 1, 'c45c1cdc-baf8-4a16-8528-a829ae8a1b7c', 0.01, 'Test Product', 'Test Payment', NULL, '2025-03-31 11:41:09.637000', '2025-03-31 11:41:09.637000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (2, 1, '67fed085-4411-4bc1-9e50-94567c8a6ae5', 0.01, 'Test Product', 'Test Payment', NULL, '2025-03-31 11:48:40.480000', '2025-03-31 11:48:40.480000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (3, 1, '0b936228-5def-45cd-b4d1-304c5f2f0c6b', 0.01, 'Test Product', 'Test Payment', NULL, '2025-03-31 12:04:07.389000', '2025-03-31 12:04:07.389000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (4, 1, 'd30759a2-c76a-4411-bcef-94f3c571b99a', 0.01, 'Test Product', 'Test Payment', NULL, '2025-03-31 12:21:51.415000', '2025-03-31 12:21:51.415000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (5, 1, '2dae7c49-327b-4b48-8156-b268f80d389c', 0.01, 'Test Product', 'Test Payment', '2025-03-31 12:27:26.391000', '2025-03-31 12:26:49.275000', '2025-03-31 12:27:26.391000', 'PAID', 1);
INSERT INTO `orders` VALUES (6, 1, '3d4336c0-aac0-47bd-a2fa-536d967f60b9', 0.01, 'Test Product', 'Test Payment', NULL, '2025-03-31 12:30:06.279000', '2025-03-31 12:30:06.279000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (7, 1, '29685747-4e5d-4c47-a244-c4a423eeb01e', 0.01, 'Test Product', 'Test Payment', NULL, '2025-03-31 12:30:24.255000', '2025-03-31 12:30:24.255000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (8, 1, '5dff4422-ca59-45cd-85fe-1a5974c74cb4', 0.01, 'Test Product', 'Test Payment', '2025-03-31 12:31:20.547000', '2025-03-31 12:30:54.802000', '2025-03-31 12:31:20.547000', 'PAID', 1);
INSERT INTO `orders` VALUES (9, 1, '934ea26c-e6ef-493e-a145-10b16c18921a', 0.01, 'Test Product', 'Test Payment', '2025-03-31 12:56:22.940000', '2025-03-31 12:55:38.362000', '2025-03-31 12:56:22.940000', 'PAID', 1);
INSERT INTO `orders` VALUES (10, 1, '992723f2-99be-4ba4-992d-e130273b0ab5', 0.01, 'Test Product', 'Test Payment', NULL, '2025-03-31 12:56:47.683000', '2025-03-31 12:56:47.683000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (11, 1, 'b3a49ead-8a7e-4c00-9750-d64734d72d2e', 0.01, 'Test Product', 'Test Payment', NULL, '2025-03-31 12:57:10.902000', '2025-03-31 12:57:10.902000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (12, 1, '8d812ba2-5527-4404-91eb-4f054fc90d4a', 14514.00, 'Test Product', 'Test Payment', NULL, '2025-03-31 12:57:49.926000', '2025-03-31 12:57:49.926000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (13, 1, '5408a43f-4c5c-4203-a00f-574181fd46a9', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 12:58:24.358000', '2025-03-31 12:57:54.377000', '2025-03-31 12:58:24.358000', 'PAID', 1);
INSERT INTO `orders` VALUES (14, 1, '839a081f-8458-4667-b50a-0b40115f765d', 14514.00, 'Test Product', 'Test Payment', NULL, '2025-03-31 13:00:14.360000', '2025-03-31 13:00:14.360000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (15, 1, '82539a8f-6a21-4d34-99b5-6fbf9d573120', 14514.00, 'Test Product', 'Test Payment', NULL, '2025-03-31 13:08:04.046000', '2025-03-31 13:08:04.046000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (16, 1, '70c0e6fe-effc-465b-96bb-fda2c6352e06', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 13:08:46.424000', '2025-03-31 13:08:18.049000', '2025-03-31 13:08:46.424000', 'PAID', 1);
INSERT INTO `orders` VALUES (17, 1, 'ef19727c-2b2b-4c73-a28c-953413191277', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 13:17:35.306000', '2025-03-31 13:17:17.298000', '2025-03-31 13:17:35.306000', 'PAID', 1);
INSERT INTO `orders` VALUES (18, 1, '103a9d7d-9de9-4ef5-9d7e-c1567a677587', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 13:23:23.460000', '2025-03-31 13:23:02.900000', '2025-03-31 13:23:23.460000', 'PAID', 1);
INSERT INTO `orders` VALUES (19, 1, '942af5c8-4d67-4473-b976-3488ac00512f', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 13:25:32.552000', '2025-03-31 13:25:14.010000', '2025-03-31 13:25:32.552000', 'PAID', 1);
INSERT INTO `orders` VALUES (20, 1, '4c411149-e5c8-4f03-9d13-bba63c0df8e6', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 13:28:51.352000', '2025-03-31 13:28:19.485000', '2025-03-31 13:28:51.352000', 'PAID', 1);
INSERT INTO `orders` VALUES (21, 1, '6b6fe550-10e2-41b9-ad2b-e46622b77c18', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 13:31:03.208000', '2025-03-31 13:30:40.285000', '2025-03-31 13:31:03.208000', 'PAID', 1);
INSERT INTO `orders` VALUES (22, 1, '1987e603-1726-48e7-ac1d-f47ebe58a8c6', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 13:35:14.475000', '2025-03-31 13:34:17.770000', '2025-03-31 13:35:14.475000', 'PAID', 1);
INSERT INTO `orders` VALUES (23, 1, '17e2c495-4391-4d7b-b2c8-62b0b60aa837', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 13:37:46.782000', '2025-03-31 13:37:32.560000', '2025-03-31 13:37:46.782000', 'PAID', 1);
INSERT INTO `orders` VALUES (24, 1, '62cbc5f3-544f-44c9-9bf4-8cd75267f9cf', 14514.00, 'Test Product', 'Test Payment', NULL, '2025-03-31 13:48:28.828000', '2025-03-31 13:48:28.828000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (25, 1, '04a89f63-8b5b-4265-a410-3b39ca5f9093', 14514.00, 'Test Product', 'Test Payment', NULL, '2025-03-31 13:48:33.624000', '2025-03-31 13:48:33.624000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (26, 1, '1a6b0ffe-2c06-45fe-b80c-459bba6da55c', 14514.00, 'Test Product', 'Test Payment', NULL, '2025-03-31 13:48:37.089000', '2025-03-31 13:48:37.089000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (27, 1, '0f6923fd-e9c9-4e81-97f1-095a233f1eef', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 13:49:19.500000', '2025-03-31 13:49:03.048000', '2025-03-31 13:49:19.500000', 'PAID', 1);
INSERT INTO `orders` VALUES (28, 1, '7f6ac064-7da6-44cb-b3fb-3d4f630981fc', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 13:51:56.317000', '2025-03-31 13:51:40.519000', '2025-03-31 13:51:56.317000', 'PAID', 1);
INSERT INTO `orders` VALUES (29, 1, 'a362eb0f-086e-462d-96e9-8ffdee6ad9ad', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 14:20:34.297000', '2025-03-31 14:20:12.141000', '2025-03-31 14:20:34.297000', 'PAID', 1);
INSERT INTO `orders` VALUES (30, 1, '87d66b46-61c2-4e25-b8f0-da51526c84a0', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 14:21:32.273000', '2025-03-31 14:21:12.605000', '2025-03-31 14:21:32.273000', 'PAID', 1);
INSERT INTO `orders` VALUES (31, 1, '8599925e-82c1-4653-a986-6cf63421d701', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 14:23:25.690000', '2025-03-31 14:23:11.537000', '2025-03-31 14:23:25.690000', 'PAID', 1);
INSERT INTO `orders` VALUES (32, 1, '41e4e374-019c-41e7-b777-ea93586ed8c5', 14514.00, 'Test Product', 'Test Payment', NULL, '2025-03-31 14:24:31.811000', '2025-03-31 14:24:31.811000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (33, 1, '1adf4e97-bfe7-44df-b4ca-49030cc916d2', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 14:24:54.797000', '2025-03-31 14:24:38.720000', '2025-03-31 14:24:54.797000', 'PAID', 1);
INSERT INTO `orders` VALUES (34, 1, 'e5b7b0f1-1739-4886-a176-1bf3bb55c538', 14514.00, 'Test Product', 'Test Payment', NULL, '2025-03-31 14:37:06.555000', '2025-03-31 14:37:06.555000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (35, 1, '63e2be04-3963-4b9a-bdba-7422fcd3b571', 14514.00, 'Test Product', 'Test Payment', NULL, '2025-03-31 14:37:15.724000', '2025-03-31 14:37:15.724000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (36, 1, '3c5dfdb4-1db0-462c-b3de-3d868c4fb45b', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 14:38:02.966000', '2025-03-31 14:37:44.827000', '2025-03-31 14:38:02.966000', 'PAID', 1);
INSERT INTO `orders` VALUES (37, 1, '430e3de5-1d77-46f2-b06d-1602b803c228', 14514.00, 'Test Product', 'Test Payment', NULL, '2025-03-31 14:51:43.400000', '2025-03-31 14:51:43.400000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (38, 1, '6e34a85a-e80f-4b48-9929-f7cda5d5cce8', 14514.00, 'Test Product', 'Test Payment', NULL, '2025-03-31 14:51:48.551000', '2025-03-31 14:51:48.551000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (39, 1, 'aef5a450-984d-45eb-9614-af24e7f1d0ec', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 14:52:32.388000', '2025-03-31 14:52:01.925000', '2025-03-31 14:52:32.388000', 'PAID', 1);
INSERT INTO `orders` VALUES (40, 1, '8d530cd4-50fa-438a-ae78-6d482f275360', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 14:56:07.082000', '2025-03-31 14:55:41.149000', '2025-03-31 14:56:07.082000', 'PAID', 1);
INSERT INTO `orders` VALUES (41, 1, '7bf23f57-e5ae-495a-80e3-0fc86a7fbe53', 14514.00, 'Test Product', 'Test Payment', NULL, '2025-03-31 15:07:20.537000', '2025-03-31 15:07:20.537000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (42, 1, '871e0c3f-c95b-4a30-ab7a-e879301ba609', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 15:07:46.674000', '2025-03-31 15:07:25.926000', '2025-03-31 15:07:46.674000', 'PAID', 1);
INSERT INTO `orders` VALUES (43, 1, '01288f8f-317a-4308-8764-4c379fc40e17', 14514.00, 'Test Product', 'Test Payment', '2025-03-31 15:09:09.921000', '2025-03-31 15:08:30.538000', '2025-03-31 15:09:09.921000', 'PAID', 1);
INSERT INTO `orders` VALUES (44, 1, '73b8c145-cfaf-4a7a-848a-173a269bc64a', 648.00, '东南新闻会员', '东南新闻项目组', '2025-03-31 15:43:45.239000', '2025-03-31 15:43:24.597000', '2025-03-31 15:43:45.239000', 'PAID', 1);
INSERT INTO `orders` VALUES (45, 1, '1c25db58-09bc-4a0c-909e-16bdf6edc15e', 648.00, '东南新闻会员', '东南新闻项目组', '2025-03-31 16:06:06.043000', '2025-03-31 16:05:40.830000', '2025-03-31 16:06:06.043000', 'PAID', 1);
INSERT INTO `orders` VALUES (46, 1, '84e8d232-9502-4b53-bfe5-7713bc8cf33e', 648.00, '东南新闻会员', '东南新闻项目组', '2025-04-01 01:55:29.721000', '2025-04-01 01:54:50.071000', '2025-04-01 01:55:29.721000', 'PAID', 1);
INSERT INTO `orders` VALUES (47, 1, '30de3d81-d236-4467-8d7a-957a027cc276', 648.00, '东南新闻会员', '东南新闻项目组', '2025-04-01 13:28:31.076000', '2025-04-01 13:27:42.594000', '2025-04-01 13:28:31.076000', 'PAID', 1);
INSERT INTO `orders` VALUES (48, 1, '3c588491-c380-4894-9253-b3c8d649bc00', 648.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-04-02 02:31:40.405000', '2025-04-02 02:31:40.405000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (49, 1, '73efbfc8-3259-4f67-9759-3efbc8d93819', 648.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-04-02 02:31:49.688000', '2025-04-02 02:31:49.688000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (50, 1, 'eb21e820-e07c-4067-8a01-c6f9a13d3b05', 648.00, '东南新闻会员', '东南新闻项目组', '2025-04-03 11:33:20.606000', '2025-04-03 11:32:47.551000', '2025-04-03 11:33:20.606000', 'PAID', 1);
INSERT INTO `orders` VALUES (51, 1, '0333435b-cb21-4396-80d3-15530db31263', 648.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-04-17 02:05:26.642000', '2025-04-17 02:05:26.642000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (52, 1, '6a3106dc-96dd-4a77-b879-20160bd014f2', 648.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-04-17 06:54:02.477000', '2025-04-17 06:54:02.477000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (53, 1, '841efde3-b575-4e56-9420-20af6132fa93', 648.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-04-27 07:48:22.877000', '2025-04-27 07:48:22.877000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (54, 1, 'cfde6e65-61a1-4eba-9482-cd902b9aacd7', 648.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-04-27 07:48:32.971000', '2025-04-27 07:48:32.971000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (57, 1, 'ea5d9fe7-d447-4aba-b189-04249272ec33', 24.00, '东南新闻会员', '东南新闻项目组', '2025-04-29 17:12:12.692000', '2025-04-29 17:10:15.145000', '2025-04-29 17:12:12.692000', 'PAID', 1);
INSERT INTO `orders` VALUES (58, 1, 'b8d6d9c8-54fb-455b-819f-6e212ec11d63', 1.00, '东南新闻会员', '东南新闻项目组', '2025-05-18 09:08:04.727000', '2025-05-06 13:06:15.717000', '2025-05-18 09:08:04.727000', 'PAID', 1);
INSERT INTO `orders` VALUES (59, 27, '56f7bd2e-75a4-41ed-86b5-641149be0778', 24.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-05-08 06:08:55.488000', '2025-05-08 06:08:55.488000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (60, 27, 'eceea18f-71f9-46fb-a55b-3755989e6c61', 24.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-05-08 06:08:57.494000', '2025-05-08 06:08:57.494000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (61, 27, '630b1b81-7290-4175-8b87-b03425fdbda2', 24.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-05-08 06:08:58.678000', '2025-05-08 06:08:58.678000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (62, 26, '9b1d1d9d-d439-441c-9564-38e58bc646fe', 1.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-05-08 06:14:20.555000', '2025-05-08 06:14:20.555000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (63, 26, '32e00eeb-4d43-4ad4-9440-942d42ba808f', 1.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-05-08 06:32:28.287000', '2025-05-08 06:32:28.287000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (64, 26, '225a0eb9-9a8d-4004-bb82-761edde59152', 1.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-05-08 06:32:30.800000', '2025-05-08 06:32:30.800000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (65, 26, 'd57e8d17-a3ed-4501-89d6-0b46fa818e1a', 1.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-05-08 06:32:31.866000', '2025-05-08 06:32:31.866000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (66, 26, '81af231c-b319-42d5-af96-0825fe1c2086', 1.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-05-08 06:32:32.863000', '2025-05-08 06:32:32.863000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (67, 26, '47c95051-a33e-4d0d-89a3-1e45a38c7dad', 1.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-05-08 06:32:33.346000', '2025-05-08 06:32:33.346000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (68, 26, '73e1223c-b0b1-433a-a0ff-58ad3a50e35e', 1.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-05-08 06:32:33.608000', '2025-05-08 06:32:33.608000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (69, 26, '50ba4259-fea7-46ab-b0ca-71d3ee31c12e', 1.00, '东南新闻会员', '东南新闻项目组', NULL, '2025-05-08 06:32:42.461000', '2025-05-08 06:32:42.461000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (70, 26, '4cc6f12a-55bc-4da1-821a-c62011bffa96', 57.00, '东南新闻会员', '东南新闻项目组', '2025-05-18 08:52:02.849000', '2025-05-18 08:51:01.946000', '2025-05-18 08:52:02.849000', 'PAID', 1);
INSERT INTO `orders` VALUES (71, 26, '58c5ac98-8f2d-490b-b211-0debbae3b8bb', 57.00, '东南新闻会员3个月（90天）', '东南新闻项目组', '2025-05-18 09:07:10.190000', '2025-05-18 09:06:24.037000', '2025-05-18 09:07:10.190000', 'PAID', 1);
INSERT INTO `orders` VALUES (72, 26, '500ed786-1004-44e7-9a15-cf57e7d59970', 57.00, '90东南新闻会员（null天）', '东南新闻项目组', NULL, '2025-05-18 09:55:59.356000', '2025-05-18 09:55:59.356000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (73, 26, '80f438e3-1787-4596-b826-6a961758ad18', 57.00, '90东南新闻会员（null天）', '东南新闻项目组', NULL, '2025-05-18 10:00:18.289000', '2025-05-18 10:00:18.289000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (74, 26, '85f39ed8-75f4-4200-9fdc-b8e98194bd8e', 20.00, '30东南新闻会员（null天）', '东南新闻项目组', NULL, '2025-05-18 10:00:58.349000', '2025-05-18 10:00:58.349000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (75, 26, '231dd106-bf37-431c-83a4-80ec868532e7', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', NULL, '2025-05-18 10:04:24.381000', '2025-05-18 10:04:24.381000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (76, 26, '78f9769e-dbf8-4147-ae47-897818668c8a', 20.00, '1个月东南新闻会员（30天）', '东南新闻项目组', NULL, '2025-05-18 10:07:03.406000', '2025-05-18 10:07:03.406000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (77, 26, '7ec07226-3999-42c4-a63a-47d3a7070980', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', NULL, '2025-05-18 10:13:51.947000', '2025-05-18 10:13:51.947000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (78, 26, 'e9a1138a-bf0c-4fd7-a42a-8ba30747bf8e', 20.00, NULL, NULL, NULL, NULL, NULL, 'WAIT_PAY', 1);
INSERT INTO `orders` VALUES (79, 26, '1283de57-c180-41f4-bc85-1436e3e7fa3a', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', NULL, '2025-05-18 10:24:25.171000', '2025-05-18 10:24:25.171000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (80, 26, '18a6cf0b-00dd-4360-aaa1-9bdc8f068547', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', NULL, '2025-05-18 10:28:21.622000', '2025-05-18 10:28:21.622000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (81, 26, 'cb994b60-22de-4762-b359-c8adeaa730b3', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', NULL, '2025-05-18 10:29:25.758000', '2025-05-18 10:29:25.758000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (82, 26, 'fb9d6397-3e84-4163-9494-6af752f14d8f', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', NULL, '2025-05-18 10:35:00.089000', '2025-05-18 10:35:00.089000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (83, 26, 'dc9e2bcd-a53f-41f1-808b-0cc645e3dcdf', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', '2025-05-18 10:36:37.227000', '2025-05-18 10:35:32.046000', '2025-05-18 10:36:37.227000', 'PAID', 1);
INSERT INTO `orders` VALUES (84, 26, 'cd835e5f-ba92-4a0b-a37b-1f543b9360ea', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', NULL, '2025-05-18 10:49:17.826000', '2025-05-18 10:49:17.826000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (85, 26, '1e6538e1-8f89-4290-a43e-ad37fd8517f0', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', NULL, '2025-05-18 10:55:37.715000', '2025-05-18 10:55:37.715000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (86, 26, 'f07eeb8f-a0e6-4a50-a37b-cb6cb17d710e', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', NULL, '2025-05-18 10:56:14.693000', '2025-05-18 10:56:14.693000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (87, 26, '53a4a9b2-b4c4-4b88-9b19-ab4def699d66', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', NULL, '2025-05-18 10:56:28.140000', '2025-05-18 10:56:28.140000', 'UNPAID', 1);
INSERT INTO `orders` VALUES (88, 26, '48e60cd3-33cd-4085-84ec-a234eca96d6d', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', '2025-05-18 10:58:18.683000', '2025-05-18 10:57:26.390000', '2025-05-18 10:58:18.683000', 'PAID', 1);
INSERT INTO `orders` VALUES (89, 26, '7d94bb7d-9a5a-405b-8142-4f83750ec2b9', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', '2025-05-18 11:00:11.726000', '2025-05-18 10:59:53.538000', '2025-05-18 11:00:11.726000', 'PAID', 1);
INSERT INTO `orders` VALUES (90, 26, '4a27f6fb-cd73-44c7-b05f-c3c7f2a66654', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', '2025-05-18 11:01:44.214000', '2025-05-18 11:01:05.172000', '2025-05-18 11:01:44.214000', 'PAID', 1);
INSERT INTO `orders` VALUES (91, 26, 'e043601f-75ba-43f6-9810-9bf77f52415b', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', '2025-05-18 11:26:15.767000', '2025-05-18 11:25:45.512000', '2025-05-18 11:26:15.767000', 'PAID', 2);
INSERT INTO `orders` VALUES (92, 26, '1aefda37-057e-4452-9976-e3714f74c527', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', '2025-05-18 11:36:31.461000', '2025-05-18 11:35:48.038000', '2025-05-18 11:36:31.461000', 'PAID', 2);
INSERT INTO `orders` VALUES (93, 26, 'd4fbad42-0186-457d-9267-ba8e6b7e739c', 57.00, '3个月东南新闻会员（90天）', '东南新闻项目组', '2025-05-18 12:24:35.597000', '2025-05-18 12:24:11.626000', '2025-05-18 12:24:35.597000', 'PAID', 2);
INSERT INTO `orders` VALUES (94, 2, '80c236e5-da1c-47b6-ac7c-99abf5c4fc1e', 729.60, '48个月东南新闻会员（1461天）', '东南新闻项目组', '2025-05-18 14:29:06.428000', '2025-05-18 14:28:04.209000', '2025-05-18 14:29:06.428000', 'PAID', 6);

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
-- Records of tags
-- ----------------------------
INSERT INTO `tags` VALUES (1, '首页', '/home');
INSERT INTO `tags` VALUES (2, '十四大', '/shiSiDa');
INSERT INTO `tags` VALUES (3, '习语', '/xiYu');
INSERT INTO `tags` VALUES (4, '科技', '/science');
INSERT INTO `tags` VALUES (5, '经济', '/economic');
INSERT INTO `tags` VALUES (6, '民生', '/minSheng');
INSERT INTO `tags` VALUES (7, '娱乐', '/enthusiastic');
INSERT INTO `tags` VALUES (8, '军事', '/newsList');

-- ----------------------------
-- Table structure for user_vip_relations
-- ----------------------------
DROP TABLE IF EXISTS `user_vip_relations`;
CREATE TABLE `user_vip_relations`  (
  `uid` int(0) NOT NULL COMMENT '用户ID',
  `vip_id` int(0) NOT NULL COMMENT '会员ID',
  `activation_time` datetime(0) NOT NULL COMMENT '开通时间',
  `expire_time` datetime(0) NOT NULL COMMENT '有效期',
  PRIMARY KEY (`uid`, `vip_id`, `activation_time`) USING BTREE,
  INDEX `fk_user_vip_relation_vip_id`(`vip_id`) USING BTREE,
  CONSTRAINT `fk_user_vip_relation_uid` FOREIGN KEY (`uid`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_user_vip_relation_vip_id` FOREIGN KEY (`vip_id`) REFERENCES `vip` (`id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_vip_relations
-- ----------------------------
INSERT INTO `user_vip_relations` VALUES (1, 2, '2024-12-22 20:51:28', '2025-02-22 20:51:33');
INSERT INTO `user_vip_relations` VALUES (2, 6, '2025-05-18 14:29:06', '2125-05-18 14:29:06');
INSERT INTO `user_vip_relations` VALUES (26, 2, '2025-05-18 12:24:36', '2025-08-16 12:24:36');

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
  `is_author` enum('TRUE','FALSE','ADMIN') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'FALSE' COMMENT '作者标识',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '姓名',
  `phone` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `birthday` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `last_operator_id` int(0) NULL DEFAULT NULL COMMENT '最后操作者',
  `is_deleted` int(0) NOT NULL DEFAULT 0 COMMENT '删除标志',
  PRIMARY KEY (`user_id`) USING BTREE,
  UNIQUE INDEX `Username`(`user_name`) USING BTREE,
  UNIQUE INDEX `Email`(`email`) USING BTREE,
  INDEX `fk_opter_id`(`last_operator_id`) USING BTREE,
  CONSTRAINT `fk_opter_id` FOREIGN KEY (`last_operator_id`) REFERENCES `users` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of users
-- ----------------------------
INSERT INTO `users` VALUES (1, '央广网', '12345678', '2973811@cnr.cn', '2025-03-10 15:30:15', 'http://seunewsbac.pgrm.cc/static/news-images/20250328223648687_cf68d900.webp', 'TRUE', '央广网', NULL, '2025-05-06 00:00:00', NULL, 0);
INSERT INTO `users` VALUES (2, '东南新闻', '12345678', 'zsqgle@cxxy.seu.edu.cn', '2025-03-11 21:40:10', 'http://seunews.pgrm.cc/src/assets/imges/seuLogo.png', 'TRUE', '东南新闻网', '18061209838', '2025-05-07 00:00:00', NULL, 0);
INSERT INTO `users` VALUES (3, 'a', 'aaaaaaaa', 'aaa@aa', '2025-03-11 22:50:50', NULL, 'FALSE', NULL, NULL, NULL, 2, 1);
INSERT INTO `users` VALUES (4, 'CC2N', '11111111', 'aaa@aaa.com', '2025-03-11 23:42:21', NULL, 'FALSE', NULL, NULL, NULL, NULL, 0);
INSERT INTO `users` VALUES (5, '1111', '11111111', '1111@11111.com', '2025-03-11 15:50:10', NULL, 'FALSE', NULL, NULL, NULL, NULL, 0);
INSERT INTO `users` VALUES (6, '1234', '12341234', '1234@1234.com', '2025-03-11 15:51:32', NULL, 'FALSE', NULL, NULL, NULL, NULL, 0);
INSERT INTO `users` VALUES (7, '1314', '12345678', '2222@222.com', '2025-03-12 06:00:17', NULL, 'FALSE', NULL, NULL, NULL, NULL, 0);
INSERT INTO `users` VALUES (8, '111111', '12345678', '111@111.com', '2025-03-13 14:55:44', NULL, 'FALSE', NULL, NULL, NULL, NULL, 0);
INSERT INTO `users` VALUES (9, '新华网', '12345678', 'xxpl@news.cn', '2025-03-23 11:14:59', NULL, 'TRUE', NULL, NULL, NULL, NULL, 0);
INSERT INTO `users` VALUES (10, '人民日报', '12345678', 'kf@people.cn', '2025-03-23 11:33:53', 'http://seunewsbac.pgrm.cc/static/news-images/20250507163539485_be757a3f.jpg', 'TRUE', '人民日报', NULL, NULL, NULL, 0);
INSERT INTO `users` VALUES (11, '人民海军', '123456', 'rmhj@gov.cn', '2025-03-29 08:39:38', NULL, 'TRUE', '人民海军', NULL, NULL, NULL, 0);
INSERT INTO `users` VALUES (12, '东南大学', '123456', '2973817592@qq.com', '2025-03-30 13:12:36', 'http://seunews.pgrm.cc/src/assets/imges/seuLogo.png', 'TRUE', NULL, NULL, NULL, NULL, 0);
INSERT INTO `users` VALUES (13, 'admin', 'admin', '240322218@cxxy.seu.edu.cn', '2025-03-31 09:16:03', NULL, 'FALSE', NULL, NULL, NULL, NULL, 0);
INSERT INTO `users` VALUES (24, 'zsqgle', 'Zsqgle@', '2473228344@qq.com', '2025-04-17 21:40:18', 'http://seunews.pgrm.cc/src/assets/imges/seuLogo.png', 'FALSE', NULL, NULL, NULL, NULL, 0);
INSERT INTO `users` VALUES (25, 'AI', 'fvqwekiurhfnieluwcnhrfciqewyvrbfkjewgfvcbikewuyriuvecnw', 'weniufyvewrir@oiewyuvcrtneio.wlcriqqhewloircxe', '2025-04-19 15:42:04', NULL, 'FALSE', NULL, NULL, NULL, NULL, 0);
INSERT INTO `users` VALUES (26, '123456', '123456', 'dsrja26@126.com', '2025-04-20 16:29:41', 'http://seunewsbac.pgrm.cc/static/news-images/20250508171623392_f031bb8a.png', 'FALSE', '', NULL, NULL, NULL, 0);
INSERT INTO `users` VALUES (27, 'paidaxing', 'haimianbaobao', '1307522364@qq.com', '2025-05-08 06:02:44', NULL, 'FALSE', NULL, NULL, NULL, NULL, 0);

-- ----------------------------
-- Table structure for vip
-- ----------------------------
DROP TABLE IF EXISTS `vip`;
CREATE TABLE `vip`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '会员ID',
  `type` enum('VIP1','VIP2','VIP3','VIP4','VIP5','VIP6','VIP7','VIP8','VIP9','VIP10','SVIP1','SVIP2','SVIP3','SVIP4','SVIP5','SVIP6','SVIP7','SVIP8','SVIP9','SVIP10','SVIP+') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'VIP1' COMMENT '会员类型',
  `durations` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '1个月',
  `durations_value` int(0) NULL DEFAULT NULL COMMENT '天数',
  `discount` decimal(3, 2) NULL DEFAULT NULL COMMENT '折扣',
  `price` decimal(6, 2) NULL DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `PK_viptype_id`(`type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vip
-- ----------------------------
INSERT INTO `vip` VALUES (1, 'VIP1', '1个月', 30, 1.00, 20.00);
INSERT INTO `vip` VALUES (2, 'VIP1', '3个月', 90, 0.97, 60.00);
INSERT INTO `vip` VALUES (3, 'VIP1', '6个月', 180, 0.93, 120.00);
INSERT INTO `vip` VALUES (4, 'VIP1', '12个月', 365, 0.88, 240.00);
INSERT INTO `vip` VALUES (5, 'VIP1', '24个月', 730, 0.82, 480.00);
INSERT INTO `vip` VALUES (6, 'VIP1', '48个月', 1461, 0.76, 960.00);

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
