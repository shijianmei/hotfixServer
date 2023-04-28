/*
 Navicat Premium Data Transfer

 Source Server         : hotfixServer
 Source Server Type    : MySQL
 Source Server Version : 80032
 Source Host           : localhost:3306
 Source Schema         : aiway-ios-tool

 Target Server Type    : MySQL
 Target Server Version : 80032
 File Encoding         : 65001

 Date: 28/04/2023 11:16:06
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for hotFix
-- ----------------------------
DROP TABLE IF EXISTS `hotFix`;
CREATE TABLE `hotFix` (
  `id` int NOT NULL AUTO_INCREMENT,
  `package` varchar(64) DEFAULT NULL,
  `type` varchar(32) DEFAULT NULL,
  `platform` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `desc` varchar(300) DEFAULT NULL,
  `resource_name` varchar(64) DEFAULT NULL,
  `version` varchar(64) DEFAULT NULL,
  `path` varchar(64) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `updated_at` datetime NOT NULL,
  `deleted_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of hotFix
-- ----------------------------
BEGIN;
INSERT INTO `hotFix` (`id`, `package`, `type`, `platform`, `status`, `desc`, `resource_name`, `version`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (1, '333.txt', 'txt', 0, 0, '描述', NULL, '1.0.0.1', NULL, '2023-02-03 18:02:41', '2023-02-06 10:35:41', NULL);
INSERT INTO `hotFix` (`id`, `package`, `type`, `platform`, `status`, `desc`, `resource_name`, `version`, `path`, `created_at`, `updated_at`, `deleted_at`) VALUES (2, 'hotfix111txt.txt', 'txt', 0, 1, 'fix bug', NULL, '1.0.0.1', '2023/02/02/bab74d36-5a35-4c28-b56d-342876044df1.txt', '2023-02-03 18:26:55', '2023-04-28 10:43:07', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lin_file
-- ----------------------------
DROP TABLE IF EXISTS `lin_file`;
CREATE TABLE `lin_file` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `path` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `type` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'LOCAL' COMMENT 'LOCAL 本地，REMOTE 远程',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `extension` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `size` int DEFAULT NULL,
  `md5` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT 'md5值，防止上传重复文件',
  `create_time` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `update_time` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `delete_time` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `md5_del` (`md5`,`delete_time`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of lin_file
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for lin_group
-- ----------------------------
DROP TABLE IF EXISTS `lin_group`;
CREATE TABLE `lin_group` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '分组名称，例如：搬砖者',
  `info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '分组信息：例如：搬砖的人',
  `level` tinyint NOT NULL DEFAULT '3' COMMENT '分组级别 1：root 2：guest 3：user（root、guest分组只能存在一个)',
  `create_time` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `update_time` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `delete_time` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_del` (`name`,`delete_time`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of lin_group
-- ----------------------------
BEGIN;
INSERT INTO `lin_group` (`id`, `name`, `info`, `level`, `create_time`, `update_time`, `delete_time`) VALUES (1, 'root', '超级用户组', 1, '2023-01-19 10:16:16.824', '2023-01-19 10:16:16.824', NULL);
INSERT INTO `lin_group` (`id`, `name`, `info`, `level`, `create_time`, `update_time`, `delete_time`) VALUES (2, 'guest', '游客组', 2, '2023-01-19 10:16:16.825', '2023-01-19 10:16:16.825', NULL);
INSERT INTO `lin_group` (`id`, `name`, `info`, `level`, `create_time`, `update_time`, `delete_time`) VALUES (4, '热修复管理', NULL, 3, '2023-01-29 16:21:24.000', '2023-01-29 16:21:24.000', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lin_group_permission
-- ----------------------------
DROP TABLE IF EXISTS `lin_group_permission`;
CREATE TABLE `lin_group_permission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `group_id` int unsigned NOT NULL COMMENT '分组id',
  `permission_id` int unsigned NOT NULL COMMENT '权限id',
  PRIMARY KEY (`id`),
  KEY `group_id_permission_id` (`group_id`,`permission_id`) USING BTREE COMMENT '联合索引'
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of lin_group_permission
-- ----------------------------
BEGIN;
INSERT INTO `lin_group_permission` (`id`, `group_id`, `permission_id`) VALUES (10, 4, 13);
INSERT INTO `lin_group_permission` (`id`, `group_id`, `permission_id`) VALUES (12, 4, 17);
INSERT INTO `lin_group_permission` (`id`, `group_id`, `permission_id`) VALUES (13, 4, 18);
COMMIT;

-- ----------------------------
-- Table structure for lin_log
-- ----------------------------
DROP TABLE IF EXISTS `lin_log`;
CREATE TABLE `lin_log` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `message` varchar(450) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `user_id` int unsigned NOT NULL,
  `username` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `status_code` int DEFAULT NULL,
  `method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `path` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `permission` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `update_time` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `delete_time` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of lin_log
-- ----------------------------
BEGIN;
INSERT INTO `lin_log` (`id`, `message`, `user_id`, `username`, `status_code`, `method`, `path`, `permission`, `create_time`, `update_time`, `delete_time`) VALUES (1, 'root新增了期刊内容', 1, 'root', 201, 'POST', '/v1/content', '添加期刊内容', '2023-01-19 18:21:16.000', '2023-01-19 18:21:16.000', NULL);
INSERT INTO `lin_log` (`id`, `message`, `user_id`, `username`, `status_code`, `method`, `path`, `permission`, `create_time`, `update_time`, `delete_time`) VALUES (2, '管理员新建了一个用户', 1, 'root', 201, 'POST', '/cms/user/register', '', '2023-01-29 15:07:21.000', '2023-01-29 15:07:21.000', NULL);
INSERT INTO `lin_log` (`id`, `message`, `user_id`, `username`, `status_code`, `method`, `path`, `permission`, `create_time`, `update_time`, `delete_time`) VALUES (35, 'root新增了最新patch包', 1, 'root', 201, 'POST', '/v1/hotFix', '新增热修复包', '2023-04-03 10:12:39.000', '2023-04-03 10:12:39.000', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lin_permission
-- ----------------------------
DROP TABLE IF EXISTS `lin_permission`;
CREATE TABLE `lin_permission` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(60) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '权限名称，例如：访问首页',
  `module` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '权限所属模块，例如：人员管理',
  `mount` tinyint(1) NOT NULL DEFAULT '1' COMMENT '0：关闭 1：开启',
  `create_time` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `update_time` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `delete_time` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of lin_permission
-- ----------------------------
BEGIN;
INSERT INTO `lin_permission` (`id`, `name`, `module`, `mount`, `create_time`, `update_time`, `delete_time`) VALUES (1, '查询所有日志', '日志', 1, '2023-01-19 10:21:09.000', '2023-01-19 10:21:09.000', NULL);
INSERT INTO `lin_permission` (`id`, `name`, `module`, `mount`, `create_time`, `update_time`, `delete_time`) VALUES (2, '搜索日志', '日志', 1, '2023-01-19 10:21:09.000', '2023-01-19 10:21:09.000', NULL);
INSERT INTO `lin_permission` (`id`, `name`, `module`, `mount`, `create_time`, `update_time`, `delete_time`) VALUES (3, '查询日志记录的用户', '日志', 1, '2023-01-19 10:21:09.000', '2023-01-19 10:21:09.000', NULL);
INSERT INTO `lin_permission` (`id`, `name`, `module`, `mount`, `create_time`, `update_time`, `delete_time`) VALUES (4, '测试日志记录', '信息', 1, '2023-01-19 10:21:09.000', '2023-01-19 10:21:09.000', NULL);
INSERT INTO `lin_permission` (`id`, `name`, `module`, `mount`, `create_time`, `update_time`, `delete_time`) VALUES (5, '查看lin的信息', '信息', 1, '2023-01-19 10:21:09.000', '2023-01-19 10:21:09.000', NULL);
INSERT INTO `lin_permission` (`id`, `name`, `module`, `mount`, `create_time`, `update_time`, `delete_time`) VALUES (13, '新增热修复包', '热修复管理', 1, '2023-01-19 14:14:44.000', '2023-01-19 14:14:44.000', NULL);
INSERT INTO `lin_permission` (`id`, `name`, `module`, `mount`, `create_time`, `update_time`, `delete_time`) VALUES (14, '暂停热修复', '热修复管理', 0, '2023-01-29 14:42:44.000', '2023-01-29 18:18:22.000', NULL);
INSERT INTO `lin_permission` (`id`, `name`, `module`, `mount`, `create_time`, `update_time`, `delete_time`) VALUES (17, '更新热修复包状态', '热修复管理', 1, '2023-01-29 18:18:22.000', '2023-01-29 18:18:22.000', NULL);
INSERT INTO `lin_permission` (`id`, `name`, `module`, `mount`, `create_time`, `update_time`, `delete_time`) VALUES (18, '查询热修复包', '热修复管理', 1, '2023-01-29 18:30:01.000', '2023-01-29 18:30:01.000', NULL);
INSERT INTO `lin_permission` (`id`, `name`, `module`, `mount`, `create_time`, `update_time`, `delete_time`) VALUES (19, '查询有效热修复包', '热修复管理', 1, '2023-02-03 17:25:37.000', '2023-02-03 17:25:37.000', NULL);
INSERT INTO `lin_permission` (`id`, `name`, `module`, `mount`, `create_time`, `update_time`, `delete_time`) VALUES (20, '查询会否存在有效热修复包', '热修复管理', 1, '2023-02-28 10:02:02.000', '2023-02-28 10:02:02.000', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lin_user
-- ----------------------------
DROP TABLE IF EXISTS `lin_user`;
CREATE TABLE `lin_user` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户名，唯一',
  `nickname` varchar(24) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '用户昵称',
  `avatar` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '头像url',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL COMMENT '邮箱',
  `create_time` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `update_time` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `delete_time` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username_del` (`username`,`delete_time`),
  UNIQUE KEY `email_del` (`email`,`delete_time`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of lin_user
-- ----------------------------
BEGIN;
INSERT INTO `lin_user` (`id`, `username`, `nickname`, `avatar`, `email`, `create_time`, `update_time`, `delete_time`) VALUES (1, 'root', 'root', '2023/04/03/398c6795-1b4d-4560-8495-c0cd539664c2.jpg', NULL, '2023-01-19 10:16:16.819', '2023-04-03 10:13:13.000', NULL);
INSERT INTO `lin_user` (`id`, `username`, `nickname`, `avatar`, `email`, `create_time`, `update_time`, `delete_time`) VALUES (3, 'hotfix', '管理员', '2023/02/03/534ab44a-6feb-4e8a-998d-300bf1f29c26.jpg', 'hotfix@qq.com', '2023-01-29 16:22:03.000', '2023-02-03 11:24:30.000', NULL);
COMMIT;

-- ----------------------------
-- Table structure for lin_user_group
-- ----------------------------
DROP TABLE IF EXISTS `lin_user_group`;
CREATE TABLE `lin_user_group` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL COMMENT '用户id',
  `group_id` int unsigned NOT NULL COMMENT '分组id',
  PRIMARY KEY (`id`),
  KEY `user_id_group_id` (`user_id`,`group_id`) USING BTREE COMMENT '联合索引'
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of lin_user_group
-- ----------------------------
BEGIN;
INSERT INTO `lin_user_group` (`id`, `user_id`, `group_id`) VALUES (1, 1, 1);
INSERT INTO `lin_user_group` (`id`, `user_id`, `group_id`) VALUES (4, 3, 4);
COMMIT;

-- ----------------------------
-- Table structure for lin_user_identity
-- ----------------------------
DROP TABLE IF EXISTS `lin_user_identity`;
CREATE TABLE `lin_user_identity` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int unsigned NOT NULL COMMENT '用户id',
  `identity_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `identifier` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `credential` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci DEFAULT NULL,
  `create_time` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
  `update_time` datetime(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3) ON UPDATE CURRENT_TIMESTAMP(3),
  `delete_time` datetime(3) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- ----------------------------
-- Records of lin_user_identity
-- ----------------------------
BEGIN;
INSERT INTO `lin_user_identity` (`id`, `user_id`, `identity_type`, `identifier`, `credential`, `create_time`, `update_time`, `delete_time`) VALUES (1, 1, 'USERNAME_PASSWORD', 'root', 'sha1$c419e500$1$84869e5560ebf3de26b6690386484929456d6c07', '2023-01-19 10:16:16.822', '2023-01-19 10:16:16.822', NULL);
INSERT INTO `lin_user_identity` (`id`, `user_id`, `identity_type`, `identifier`, `credential`, `create_time`, `update_time`, `delete_time`) VALUES (3, 3, 'USERNAME_PASSWORD', 'hotfix', 'sha1$b87b6db8$1$e3471aa64ed3453ca4d4e9ea693229aa09ecd4af', '2023-01-29 16:22:03.000', '2023-01-29 16:22:03.000', NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
