/*
 Navicat Premium Dump SQL

 Source Server         : 192.168.3.137
 Source Server Type    : MySQL
 Source Server Version : 80033 (8.0.33)
 Source Host           : 192.168.3.137:3306
 Source Schema         : auth_admin

 Target Server Type    : MySQL
 Target Server Version : 80033 (8.0.33)
 File Encoding         : 65001

 Date: 28/04/2025 18:39:40
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for log_quartz_execute
-- ----------------------------
DROP TABLE IF EXISTS `log_quartz_execute`;
CREATE TABLE `log_quartz_execute`  (
  `id` bigint NOT NULL COMMENT '主键',
  `job_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务分组',
  `job_class_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务类名',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '执行任务core表达式',
  `trigger_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '触发器名称',
  `execute_result` json NOT NULL COMMENT '执行结果',
  `duration` int NULL DEFAULT NULL COMMENT '执行时间',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改的时',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '文件是否被删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_job_name`(`job_name` ASC) USING BTREE COMMENT '索引执行任务名称',
  INDEX `idx_job_group`(`job_group` ASC) USING BTREE COMMENT '索引执行任务分组',
  INDEX `idx_job_class_name`(`job_class_name` ASC) USING BTREE COMMENT '索引执行任务类名',
  INDEX `idx_trigger_name`(`trigger_name` ASC) USING BTREE COMMENT '索引执行任务触发器名称',
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度任务执行日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of log_quartz_execute
-- ----------------------------
INSERT INTO `log_quartz_execute` VALUES (1904167628504399874, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:15\"}', NULL, '2025-03-24 21:45:15', '2025-03-24 21:45:15', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167628521177090, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:15\"}', 0, '2025-03-24 21:45:15', '2025-03-24 21:45:15', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167628550537217, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:15\"}', NULL, '2025-03-24 21:45:15', '2025-03-24 21:45:15', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167628563120130, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:15\"}', 0, '2025-03-24 21:45:15', '2025-03-24 21:45:15', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167632665149442, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:16\"}', NULL, '2025-03-24 21:45:16', '2025-03-24 21:45:16', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167632677732354, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:16\"}', 0, '2025-03-24 21:45:16', '2025-03-24 21:45:16', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167636867842050, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:17\"}', NULL, '2025-03-24 21:45:17', '2025-03-24 21:45:17', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167636880424962, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:17\"}', 0, '2025-03-24 21:45:17', '2025-03-24 21:45:17', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167641062146049, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:18\"}', NULL, '2025-03-24 21:45:18', '2025-03-24 21:45:18', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167641078923265, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:18\"}', 0, '2025-03-24 21:45:18', '2025-03-24 21:45:18', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167645252255745, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:19\"}', NULL, '2025-03-24 21:45:19', '2025-03-24 21:45:19', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167645260644354, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:19\"}', 0, '2025-03-24 21:45:19', '2025-03-24 21:45:19', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167649442365441, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:20\"}', NULL, '2025-03-24 21:45:20', '2025-03-24 21:45:20', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167649454948353, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:20\"}', 0, '2025-03-24 21:45:20', '2025-03-24 21:45:20', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167653636669442, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:21\"}', NULL, '2025-03-24 21:45:21', '2025-03-24 21:45:21', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167653649252354, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:21\"}', 0, '2025-03-24 21:45:21', '2025-03-24 21:45:21', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167657830973441, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:22\"}', NULL, '2025-03-24 21:45:22', '2025-03-24 21:45:22', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167657843556354, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:22\"}', 0, '2025-03-24 21:45:22', '2025-03-24 21:45:22', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167662021083137, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:23\"}', NULL, '2025-03-24 21:45:23', '2025-03-24 21:45:23', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167662033666049, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:23\"}', 0, '2025-03-24 21:45:23', '2025-03-24 21:45:23', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167666215387137, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:24\"}', NULL, '2025-03-24 21:45:24', '2025-03-24 21:45:24', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167666223775746, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:24\"}', 0, '2025-03-24 21:45:24', '2025-03-24 21:45:24', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167670418079746, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:25\"}', NULL, '2025-03-24 21:45:25', '2025-03-24 21:45:25', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167670426468354, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:25\"}', 0, '2025-03-24 21:45:25', '2025-03-24 21:45:25', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167674612383745, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:26\"}', NULL, '2025-03-24 21:45:26', '2025-03-24 21:45:26', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167674624966658, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:26\"}', 0, '2025-03-24 21:45:26', '2025-03-24 21:45:26', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167678798299138, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:27\"}', NULL, '2025-03-24 21:45:27', '2025-03-24 21:45:27', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167678806687745, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:27\"}', 0, '2025-03-24 21:45:27', '2025-03-24 21:45:27', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167683000991746, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:28\"}', NULL, '2025-03-24 21:45:28', '2025-03-24 21:45:28', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167683017768962, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:28\"}', 0, '2025-03-24 21:45:28', '2025-03-24 21:45:28', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167687191101442, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:29\"}', NULL, '2025-03-24 21:45:29', '2025-03-24 21:45:29', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167687199490049, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:29\"}', 0, '2025-03-24 21:45:29', '2025-03-24 21:45:29', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167691385405441, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:30\"}', NULL, '2025-03-24 21:45:30', '2025-03-24 21:45:30', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1904167691406376961, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-03-24 21:45:30\"}', 0, '2025-03-24 21:45:30', '2025-03-24 21:45:30', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1916802914677768193, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-04-28 18:33:21\"}', NULL, '2025-04-28 18:33:22', '2025-04-28 18:33:22', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1916802914677768194, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-04-28 18:33:22\"}', 0, '2025-04-28 18:33:22', '2025-04-28 18:33:22', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1916802914749071362, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-04-28 18:33:22\"}', NULL, '2025-04-28 18:33:22', '2025-04-28 18:33:22', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1916802914749071363, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-04-28 18:33:22\"}', 0, '2025-04-28 18:33:22', '2025-04-28 18:33:22', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1916802918905626625, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-04-28 18:33:23\"}', NULL, '2025-04-28 18:33:23', '2025-04-28 18:33:23', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1916802918905626626, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-04-28 18:33:23\"}', 0, '2025-04-28 18:33:23', '2025-04-28 18:33:23', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1916802923150262274, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-04-28 18:33:24\"}', NULL, '2025-04-28 18:33:24', '2025-04-28 18:33:24', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1916802923150262275, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-04-28 18:33:24\"}', 0, '2025-04-28 18:33:24', '2025-04-28 18:33:24', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1916802927357149185, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-04-28 18:33:25\"}', NULL, '2025-04-28 18:33:25', '2025-04-28 18:33:25', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1916802927357149186, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-04-28 18:33:25\"}', 0, '2025-04-28 18:33:25', '2025-04-28 18:33:25', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1916802931538870273, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"unfinished\", \"status\": \"running\", \"message\": \"正在运行\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-04-28 18:33:26\"}', NULL, '2025-04-28 18:33:26', '2025-04-28 18:33:26', NULL, NULL, 0);
INSERT INTO `log_quartz_execute` VALUES (1916802931538870274, 'test', 'hello分组', 'cn.bunny.services.quartz.JobHello', '0/1 * * * * ?', 'test', '{\"result\": \"finish\", \"status\": \"finish\", \"message\": \"完成\", \"executeParams\": {\"jobName\": \"test\", \"jobGroup\": \"hello分组\", \"triggerName\": \"test\", \"cronExpression\": \"0/1 * * * * ?\"}, \"operationTime\": \"2025-04-28 18:33:26\"}', 0, '2025-04-28 18:33:26', '2025-04-28 18:33:26', NULL, NULL, 0);

-- ----------------------------
-- Table structure for log_user_login
-- ----------------------------
DROP TABLE IF EXISTS `log_user_login`;
CREATE TABLE `log_user_login`  (
  `id` bigint NOT NULL COMMENT '主键',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户Id',
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户名',
  `token` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '登录token',
  `ip_address` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录Ip',
  `ip_region` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录Ip归属地',
  `user_agent` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录时代理',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作类型',
  `x_requested_with` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标识客户端是否是通过Ajax发送请求的',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否被删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_username`(`username` ASC) USING BTREE,
  INDEX `idx_ip_address`(`ip_address` ASC) USING BTREE,
  INDEX `idx_ip_region`(`ip_region` ASC) USING BTREE,
  INDEX `idx_type`(`type` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE,
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE,
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户登录日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of log_user_login
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '固定名称',
  `trigger_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器名称',
  `trigger_group` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器分组',
  `blob_data` blob NULL COMMENT '二进制时间',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `SCHED_NAME`(`sched_name` ASC, `trigger_name` ASC, `trigger_group` ASC) USING BTREE,
  CONSTRAINT `QRTZ_BLOB_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '二进制触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '固定名称',
  `calendar_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '日历',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '日历表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '固定名称',
  `trigger_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器名称',
  `trigger_group` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器分组',
  `cron_expression` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时区id',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_CRON_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'corn表达式触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------
INSERT INTO `qrtz_cron_triggers` VALUES ('quartzScheduler', 'test', 'hello分组', '0/1 * * * * ?', 'Asia/Shanghai');

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '固定名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '固定名称',
  `trigger_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '固定名称',
  `trigger_group` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '固定名称',
  `instance_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '固定名称',
  `fired_time` bigint NOT NULL COMMENT '固定名称',
  `sched_time` bigint NOT NULL COMMENT '固定名称',
  `priority` int NOT NULL COMMENT '固定名称',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '固定名称',
  `job_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '固定名称',
  `job_group` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '固定名称',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '固定名称',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '固定名称',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE,
  INDEX `IDX_QRTZ_FT_TRIG_INST_NAME`(`sched_name` ASC, `instance_name` ASC) USING BTREE,
  INDEX `IDX_QRTZ_FT_INST_JOB_REQ_RCVRY`(`sched_name` ASC, `instance_name` ASC, `requests_recovery` ASC) USING BTREE,
  INDEX `IDX_QRTZ_FT_J_G`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  INDEX `IDX_QRTZ_FT_JG`(`sched_name` ASC, `job_group` ASC) USING BTREE,
  INDEX `IDX_QRTZ_FT_T_G`(`sched_name` ASC, `trigger_name` ASC, `trigger_group` ASC) USING BTREE,
  INDEX `IDX_QRTZ_FT_TG`(`sched_name` ASC, `trigger_group` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '解除触发器' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器名称',
  `job_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名称',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务描述',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否非并发执行',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否请求恢复',
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE,
  INDEX `idx_qrtz_j_req_recovery`(`sched_name` ASC, `requests_recovery` ASC) USING BTREE,
  INDEX `idx_qrtz_j_grp`(`sched_name` ASC, `job_group` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务详情表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------
INSERT INTO `qrtz_job_details` VALUES ('quartzScheduler', 'test', 'hello分组', 'test', 'cn.bunny.services.quartz.JobHello', '0', '0', '0', '0', 0xACED0005737200156F72672E71756172747A2E4A6F62446174614D61709FB083E8BFA9B0CB020000787200266F72672E71756172747A2E7574696C732E537472696E674B65794469727479466C61674D61708208E8C3FBC55D280200015A0013616C6C6F77735472616E7369656E74446174617872001D6F72672E71756172747A2E7574696C732E4469727479466C61674D617013E62EAD28760ACE0200025A000564697274794C00036D617074000F4C6A6176612F7574696C2F4D61703B787001737200116A6176612E7574696C2E486173684D61700507DAC1C31660D103000246000A6C6F6164466163746F724900097468726573686F6C6478703F4000000000000C770800000010000000047400076A6F624E616D657400047465737474000E63726F6E45787072657373696F6E74000D302F31202A202A202A202A203F74000B747269676765724E616D6571007E00087400086A6F6247726F757074000B68656C6C6FE58886E7BB847800);

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'quartz锁' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------
INSERT INTO `qrtz_locks` VALUES ('quartzScheduler', 'TRIGGER_ACCESS');

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器名称',
  `trigger_group` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器组名',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '暂停触发器分组' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器名称',
  `instance_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '最后检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '调度器状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_schedulers_group
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_schedulers_group`;
CREATE TABLE `qrtz_schedulers_group`  (
  `id` bigint NOT NULL COMMENT '唯一id',
  `group_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分组名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分组详情',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_group_name`(`group_name` ASC) USING BTREE COMMENT '分组名称需要唯一',
  INDEX `idx_description`(`description` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务调度分组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_schedulers_group
-- ----------------------------
INSERT INTO `qrtz_schedulers_group` VALUES (1846167458097774594, 'hello分组', 'hello分组作为第一个测试', '2024-10-15 20:33:17', '2024-10-15 20:33:17', 1, 1, 0);

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器名称',
  `trigger_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器名称',
  `trigger_group` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器组',
  `repeat_count` bigint NOT NULL COMMENT '重复次数',
  `repeat_interval` bigint NOT NULL COMMENT '重复间隔',
  `times_triggered` bigint NOT NULL COMMENT '触发次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPLE_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '简单触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器名称',
  `trigger_group` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器组',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字符串属性',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字符串属性',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '字符串属性',
  `int_prop_1` int NULL DEFAULT NULL COMMENT '整型属性',
  `int_prop_2` int NULL DEFAULT NULL COMMENT '整型属性',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT '长整型属性',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT '长整型属性',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT '十进制属性',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT '十进制属性',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '布尔型属性',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '布尔型属性',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `QRTZ_SIMPROP_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '简单操作触发器' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器名称',
  `trigger_group` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器组',
  `job_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '作业名称',
  `job_group` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '作业组',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '触发时间',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '触发时间',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(190) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日历名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '错过触发指令',
  `job_data` blob NULL,
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `IDX_QRTZ_T_J`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_JG`(`sched_name` ASC, `job_group` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_C`(`sched_name` ASC, `calendar_name` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_G`(`sched_name` ASC, `trigger_group` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_STATE`(`sched_name` ASC, `trigger_state` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_N_STATE`(`sched_name` ASC, `trigger_name` ASC, `trigger_group` ASC, `trigger_state` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_N_G_STATE`(`sched_name` ASC, `trigger_group` ASC, `trigger_state` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_NEXT_FIRE_TIME`(`sched_name` ASC, `next_fire_time` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST`(`sched_name` ASC, `trigger_state` ASC, `next_fire_time` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_MISFIRE`(`sched_name` ASC, `misfire_instr` ASC, `next_fire_time` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE`(`sched_name` ASC, `misfire_instr` ASC, `next_fire_time` ASC, `trigger_state` ASC) USING BTREE,
  INDEX `IDX_QRTZ_T_NFT_ST_MISFIRE_GRP`(`sched_name` ASC, `misfire_instr` ASC, `next_fire_time` ASC, `trigger_group` ASC, `trigger_state` ASC) USING BTREE,
  CONSTRAINT `QRTZ_TRIGGERS_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '触发器' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------
INSERT INTO `qrtz_triggers` VALUES ('quartzScheduler', 'test', 'hello分组', 'test', 'hello分组', 'test', 1745836407000, 1745836406000, 5, 'PAUSED', 'CRON', 1742823914000, 0, NULL, 0, '');

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` bigint NOT NULL COMMENT '唯一id',
  `parent_id` bigint NOT NULL DEFAULT 0 COMMENT '父级id',
  `manager` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '管理者id',
  `dept_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '部门名称',
  `summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '部门简介',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_dept_name`(`dept_name` ASC) USING BTREE,
  INDEX `idx_summary`(`summary` ASC) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间',
  FULLTEXT INDEX `idx_manager`(`manager`)
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (1842844360640327682, 0, '梁子异,彭秀英,戴子韬,曾致远', '山东总公司', '山东总公司', '2024-10-06 16:28:29', '2024-11-04 01:44:05', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1842874908557541377, 1842844360640327682, 'bunny,史安琪,邱致远,秦詩涵', '深圳分公司', '深圳分公司', '2024-10-06 18:29:52', '2025-04-28 18:30:01', 1, 1849681227633758210, 0);
INSERT INTO `sys_dept` VALUES (1842877591473455106, 1842844360640327682, '程嘉伦,武嘉伦,孙震南', '郑州分公司', '郑州分公司', '2024-10-06 18:40:31', '2024-10-06 19:02:27', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1842883239493881857, 1842877591473455106, '于致远,曹致远,李璐,戴子韬', '研发部门', '研发部门', '2024-10-06 19:02:58', '2024-10-06 19:02:58', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1842885275601981441, 1842874908557541377, '宋宇宁,彭秀英,刘子韬', '市场部门', '市场部门', '2024-10-06 19:11:04', '2024-10-06 19:11:04', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1842885316358033409, 1842877591473455106, '宋宇宁,曾致远,刘子韬', '财务部门', '财务部门', '2024-10-06 19:11:13', '2024-10-09 10:38:35', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1842885375015374850, 1842877591473455106, '冯宇宁,刘子韬,曾致远', '测试部门', '测试部门', '2024-10-06 19:11:27', '2024-10-06 19:11:52', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1842885831187877890, 1842877591473455106, '龚岚,杜安琪,李子异,彭睿,宋宇宁,bunny', '运维部门', '运维部门', '2024-10-06 19:13:16', '2024-10-06 19:13:16', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1849676669473886209, 1842874908557541377, 'password,Administrator,bunny', '测试部门', '测试部门', '2024-10-25 12:57:38', '2024-10-25 12:57:46', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1849676767842897921, 1842874908557541377, 'Administrator', '研发部门', '研发部门', '2024-10-25 12:58:01', '2024-10-25 12:58:01', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1850077538510016514, 1842844360640327682, 'Administrator', '江阴分公司', '江阴分公司', '2024-10-26 15:30:33', '2024-10-28 10:18:02', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1850077710275153922, 1850077538510016514, 'Administrator,bunny', '运维部门', '运维部门', '2024-10-26 15:31:14', '2024-10-26 15:31:14', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1850077827405287425, 1842874908557541377, 'Administrator,bunny', '运维部门', '运维部门', '2024-10-26 15:31:41', '2024-10-26 15:31:41', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1850077890558922754, 1850077538510016514, 'Administrator,password,system', '测试部门', '测试部门', '2024-10-26 15:31:57', '2024-10-26 15:31:57', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1850078051901214722, 1850077538510016514, 'Administrator,bunny', '系统研发部', '系统研发部', '2024-10-26 15:32:35', '2024-10-26 15:32:35', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1850723783395688450, 1842844360640327682, 'Administrator', '淮安分公司', '淮安分公司', '2024-10-28 10:18:29', '2024-10-28 10:18:29', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1850723925309964289, 1850723783395688450, 'Administrator', '研发部门', '研发部门', '2024-10-28 10:19:03', '2024-10-28 10:19:03', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1850723973024366594, 1850723783395688450, 'Administrator', '测试部门', '测试部门', '2024-10-28 10:19:15', '2024-10-28 10:19:15', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1850724041672540161, 1850723783395688450, 'Administrator', '运维部门', '运维部门', '2024-10-28 10:19:31', '2024-10-28 10:19:31', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1850724090196443138, 1850723783395688450, 'Administrator', '采购部门', '采购部门', '2024-10-28 10:19:43', '2024-10-28 10:19:43', 1, 1, 0);
INSERT INTO `sys_dept` VALUES (1916802188127846402, 1842885275601981441, 'Administrator,bunny', '生产部门', '生产部门', '2025-04-28 18:30:29', '2025-04-28 18:30:29', 1849681227633758210, 1849681227633758210, 0);

-- ----------------------------
-- Table structure for sys_email_template
-- ----------------------------
DROP TABLE IF EXISTS `sys_email_template`;
CREATE TABLE `sys_email_template`  (
  `id` bigint NOT NULL COMMENT '唯一id',
  `template_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '模板名称',
  `email_user` bigint NULL DEFAULT NULL COMMENT '关联邮件用户配置',
  `subject` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '主题',
  `body` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮件内容',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮件类型',
  `is_default` tinyint(1) NULL DEFAULT 0 COMMENT '是否默认',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_template_name`(`template_name` ASC) USING BTREE COMMENT '模板名称不能重复',
  INDEX `idx_email_user`(`email_user` ASC) USING BTREE,
  INDEX `idx_subject`(`subject` ASC) USING BTREE,
  INDEX `idx_type`(`type` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '邮件模板表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_email_template
-- ----------------------------
INSERT INTO `sys_email_template` VALUES (1791870020197625858, 'email-1', 2, '邮箱验证码1s', '<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n    <meta charset=\"UTF-8\">\n    <meta content=\"IE=edge\" http-equiv=\"X-UA-Compatible\">\n    <meta content=\"width=device-width, initial-scale=1.0\" name=\"viewport\">\n    <title>Email Verification Code</title>\n</head>\n<body style=\"margin: 0; padding: 0; background-color: #f5f5f5;\">\n<div style=\"max-width: 600px; margin: 0 auto;\">\n    <table style=\"width: 100%; border-collapse: collapse; background-color: #ffffff; font-family: Arial, sans-serif;\">\n        <tr>\n            <th style=\"height: 60px; padding: 20px; background-color: #0074d3; border-radius: 5px 5px 0 0;\"\n                valign=\"middle\">\n                <h1 style=\"margin: 0; color: #ffffff; font-size: 24px;\">#title#邮箱验证码</h1>\n            </th>\n        </tr>\n        <tr>\n            <td style=\"padding: 20px;\">\n                <div style=\"background-color: #ffffff; padding: 25px;\">\n                    <h2 style=\"margin: 10px 0; font-size: 18px; color: #333333;\">\n                        尊敬的用户：\n                    </h2>\n                    <p style=\"margin: 10px 0; font-size: 16px; color: #333333;\">\n                        感谢您注册我们的产品. 您的账号正在进行电子邮件验证.\n                    </p>\n                    <p style=\"margin: 10px 0; font-size: 16px; color: #333333;\">\n                        验证码为: <span class=\"button\" style=\"color: #1100ff;\">#verifyCode#</span>\n                    </p>\n                    <p style=\"margin: 10px 0; font-size: 16px; color: #333333;\">\n                        验证码的有效期只有#expires#分钟，请抓紧时间进行验证吧！\n                    </p>\n                    <p style=\"margin: 10px 0; font-size: 16px; color: #dc1818;\">\n                        如果非本人操作,请忽略此邮件\n                    </p>\n                </div>\n            </td>\n        </tr>\n        <tr>\n            <td style=\"text-align: center; padding: 20px; background-color: #f5f5f5;\">\n                <p style=\"margin: 0; font-size: 12px; color: #747474;\">\n                    #title#邮箱验证码<br>\n                    Contact us: #sendEmailUser#\n                </p>\n                <p style=\"margin: 10px 0; font-size: 12px; color: #747474;\">\n                    This is an automated email, please do not reply.<br>\n                    © Company #companyName#\n                </p>\n            </td>\n        </tr>\n    </table>\n</div>\n</body>\n</html>', 'verification_code', 1, '2024-05-18 16:34:38', '2025-04-27 13:55:12', 0, 1, 0);

-- ----------------------------
-- Table structure for sys_email_users
-- ----------------------------
DROP TABLE IF EXISTS `sys_email_users`;
CREATE TABLE `sys_email_users`  (
  `id` bigint NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮箱',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `host` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'Host地址',
  `port` int NOT NULL COMMENT '端口号',
  `smtp_agreement` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱协议',
  `open_ssl` tinyint NOT NULL DEFAULT 1 COMMENT '是否启用ssl',
  `is_default` tinyint NULL DEFAULT NULL COMMENT '是否为默认邮件',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否被删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_email`(`email` ASC) USING BTREE COMMENT '邮箱不能重复',
  INDEX `idx_smtp_agreement`(`smtp_agreement` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '邮箱发送表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_email_users
-- ----------------------------
INSERT INTO `sys_email_users` VALUES (2, '3324855376@qq.com', 'fdehkkbmavalcjea', 'smtp.qq.com', 466, 'smtps', 0, 1, '2024-05-14 18:43:50', '2025-04-27 13:54:05', 0, 1, 0);

-- ----------------------------
-- Table structure for sys_files
-- ----------------------------
DROP TABLE IF EXISTS `sys_files`;
CREATE TABLE `sys_files`  (
  `id` bigint NOT NULL COMMENT '文件的唯一标识符，自动递增',
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件的名称',
  `filepath` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '文件在服务器上的存储路径',
  `file_size` int NOT NULL COMMENT '文件的大小，以字节为单位',
  `file_type` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件的MIME类型',
  `download_count` int NULL DEFAULT 0 COMMENT '下载数量',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录文件最后修改的时间戳',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '文件是否被删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_filename`(`filename` ASC) USING BTREE COMMENT '索引文件名',
  INDEX `idx_filepath`(`filepath` ASC) USING BTREE COMMENT '索引文件路径',
  INDEX `idx_file_type`(`file_type` ASC) USING BTREE COMMENT '索引文件类型',
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统文件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_files
-- ----------------------------
INSERT INTO `sys_files` VALUES (1850815395404636161, 'blob', '/auth-admin/avatar/2024/10-28/0aa0895b-c747-47d4-b36f-d6b6e924650b', 16491, 'image/png', 0, 1, 1, '2024-10-28 16:22:31', '2024-10-28 16:22:31', 0);
INSERT INTO `sys_files` VALUES (1850815469979361281, 'blob', '/auth-admin/avatar/2024/10-28/70b4202c-7c80-43bf-a9e4-9afa3e265143', 13918, 'image/png', 0, 1, 1, '2024-10-28 16:22:49', '2024-10-28 16:22:49', 0);
INSERT INTO `sys_files` VALUES (1850816635987517442, 'blob', '/auth-admin/avatar/2024/10-28/948354db-60bc-402a-b38b-025927125dd0', 13918, 'image/png', 0, 1, 1, '2024-10-28 16:27:27', '2024-10-28 16:27:27', 0);
INSERT INTO `sys_files` VALUES (1850817107108507650, 'blob', '/auth-admin/avatar/2024/10-28/bfba8645-21a1-4254-8f90-c47a36e4df83', 19542, 'image/png', 0, 1, 1, '2024-10-28 16:29:20', '2024-10-28 16:29:20', 0);
INSERT INTO `sys_files` VALUES (1850817540879233025, 'avatar', '/auth-admin/avatar/2024/10-28/d342d395-5218-49dd-bdeb-1af839e1c15e', 19517, 'application/octet-stream', 0, 1850075157831454722, 1850075157831454722, '2024-10-28 16:31:03', '2024-10-28 16:31:03', 0);
INSERT INTO `sys_files` VALUES (1850921103046279170, 'blob', '/auth-admin/avatar/2024/10-28/18514ddc-d656-4e3d-b83d-c01977eec5a3', 921652, 'image/png', 0, 1, 1, '2024-10-28 23:22:34', '2024-10-28 23:22:34', 0);
INSERT INTO `sys_files` VALUES (1850921159195426818, 'blob', '/auth-admin/avatar/2024/10-28/75410b4c-e065-4122-8797-07617f776443', 921652, 'image/png', 0, 1, 1, '2024-10-28 23:22:47', '2024-10-28 23:22:47', 0);
INSERT INTO `sys_files` VALUES (1850921187980935169, 'blob', '/auth-admin/avatar/2024/10-28/057cb028-dea3-4054-ae07-8321eaeceaf1', 921652, 'image/png', 0, 1, 1, '2024-10-28 23:22:54', '2024-10-28 23:22:54', 0);
INSERT INTO `sys_files` VALUES (1850921226761469954, 'blob', '/auth-admin/avatar/2024/10-28/6b9cbcd2-31af-4c91-b74e-2d66e5b0558a', 921652, 'image/png', 0, 1, 1, '2024-10-28 23:23:04', '2024-10-28 23:23:04', 0);
INSERT INTO `sys_files` VALUES (1850922736039821314, 'avatar', '/auth-admin/avatar/2024/10-28/71a8b92c-ef68-425c-9993-d95292613916', 921652, 'application/octet-stream', 0, 1850789068551200769, 1850789068551200769, '2024-10-28 23:29:03', '2024-10-28 23:29:03', 0);
INSERT INTO `sys_files` VALUES (1851866593595367425, 'image.png', '/auth-admin/message/2024/10-31/596f4ef1-ef8e-4023-a0d9-22272a7accec.png', 3699, 'image/png', 0, 1, 1, '2024-10-31 13:59:37', '2024-10-31 13:59:37', 0);
INSERT INTO `sys_files` VALUES (1851884050770960386, 'image.png', '/auth-admin/message/2024/10-31/91719046-4c16-4517-87a4-90a36cf484ed.png', 17673, 'image/png', 0, 1, 1, '2024-10-31 15:08:59', '2024-10-31 15:08:59', 0);
INSERT INTO `sys_files` VALUES (1851889894011146241, 'image.png', '/auth-admin/message/2024/10-31/605ff6ac-2b25-4a67-b96f-aabf0a6331b2.png', 4955, 'image/png', 0, 1, 1, '2024-10-31 15:32:12', '2024-10-31 15:32:12', 0);
INSERT INTO `sys_files` VALUES (1851890398367813633, 'image.png', '/auth-admin/message/2024/10-31/2ec4db46-4a9e-4f71-913a-9a086cf8942d.png', 16622, 'image/png', 0, 1, 1, '2024-10-31 15:34:12', '2024-10-31 15:34:12', 0);
INSERT INTO `sys_files` VALUES (1851890472363724801, 'image.png', '/auth-admin/message/2024/10-31/f6136f17-cbf4-4960-ba7c-a4de6cfddd0a.png', 9737, 'image/png', 0, 1, 1, '2024-10-31 15:34:30', '2024-10-31 15:34:30', 0);
INSERT INTO `sys_files` VALUES (1851892376443510785, 'image.png', '/auth-admin/message/2024/10-31/b4288ded-3c0b-4990-b76d-e7b8a8a009ff.png', 17331, 'image/png', 0, 1, 1, '2024-10-31 15:42:04', '2024-10-31 15:42:04', 0);
INSERT INTO `sys_files` VALUES (1851893454811680770, 'image.png', '/auth-admin/message/2024/10-31/47a20e8e-474a-41a9-b4a0-d4acd2ffd5fd.png', 4175, 'image/png', 0, 1, 1, '2024-10-31 15:46:21', '2024-10-31 15:46:21', 0);
INSERT INTO `sys_files` VALUES (1851893653344866306, 'image.png', '/auth-admin/message/2024/10-31/b9bd7ea4-ac41-4b22-9bba-dfd688673f16.png', 31431, 'image/png', 0, 1, 1, '2024-10-31 15:47:08', '2024-10-31 15:47:08', 0);
INSERT INTO `sys_files` VALUES (1851993590369955841, '003540AH4M7.jpg', '/auth-admin/message/2024/10-31/3ada7745-7d0f-475c-bbf0-480895802403.jpg', 1188970, 'image/jpeg', 0, 1, 1, '2024-10-31 22:24:15', '2024-10-31 22:24:15', 0);
INSERT INTO `sys_files` VALUES (1851994496016658434, 'f083c7e3-7959-43b3-b810-62ced61a3fc2.jpg', '/auth-admin/message/2024/10-31/8e4cf88f-9bfe-40c7-96cb-e54edbeefc72.jpg', 3338, 'image/jpeg', 0, 1, 1, '2024-10-31 22:27:51', '2024-10-31 22:27:51', 0);
INSERT INTO `sys_files` VALUES (1852167826831011841, 'vite.jpg', '/auth-admin/message/2024/11-01/f9c941aa-80d4-492e-84c9-b3bd387b569e.jpg', 6289, 'image/jpeg', 0, 1, 1, '2024-11-01 09:56:36', '2024-11-01 09:56:36', 0);
INSERT INTO `sys_files` VALUES (1852172073899339777, 'vite.jpg', '/auth-admin/message/2024/11-01/c22e0c4b-7da1-401e-82f5-b4aea91daab3.jpg', 6289, 'image/jpeg', 0, 1, 1, '2024-11-01 10:13:29', '2024-11-01 10:13:29', 0);
INSERT INTO `sys_files` VALUES (1852174116441501697, 'JetBrain.jpg', '/auth-admin/message/2024/11-01/bae5e587-3dd8-4d9f-bea3-9f6da2f9e059.jpg', 5630, 'image/jpeg', 0, 1, 1, '2024-11-01 10:21:36', '2024-11-01 10:21:36', 0);
INSERT INTO `sys_files` VALUES (1852209020512489474, 'Java.png', '/auth-admin/message/2024/11-01/e81a9957-ff51-4729-9484-f5b36288f834.png', 4281, 'image/png', 0, 1, 1, '2024-11-01 12:40:18', '2024-11-01 12:40:18', 0);
INSERT INTO `sys_files` VALUES (1852209912485761026, 'vue.png', '/auth-admin/message/2024/11-01/53fab545-6ad1-4413-8aaf-2d3f05a24f3e.png', 2469, 'image/png', 0, 1, 1, '2024-11-01 12:43:50', '2024-11-01 12:43:50', 0);
INSERT INTO `sys_files` VALUES (1852210362551357442, 'vue.png', '/auth-admin/message/2024/11-01/7ee0d886-4f77-48b3-a176-4ddae155d6d2.png', 2469, 'image/png', 0, 1, 1, '2024-11-01 12:45:37', '2024-11-01 12:45:37', 0);
INSERT INTO `sys_files` VALUES (1852231558231683073, 'kotlin.png', '/auth-admin/message/2024/11-01/fafce5ff-8e7c-4c2a-a409-705b998b3837.png', 2274, 'image/png', 0, 1, 1, '2024-11-01 14:09:51', '2024-11-01 14:09:51', 0);
INSERT INTO `sys_files` VALUES (1852233834287525889, 'JetBrain.jpg', '/auth-admin/message/2024/11-01/27c200fd-d3b6-46bf-9019-82442a29d638.jpg', 5630, 'image/jpeg', 0, 1, 1, '2024-11-01 14:18:54', '2024-11-01 14:18:54', 0);
INSERT INTO `sys_files` VALUES (1852233952118108162, 'kotlin.png', '/auth-admin/message/2024/11-01/73070169-4ae2-4fb6-a3b9-46155cd65125.png', 2274, 'image/png', 0, 1, 1, '2024-11-01 14:19:22', '2024-11-01 14:19:22', 0);
INSERT INTO `sys_files` VALUES (1852640844646711298, 'image.png', '/auth-admin/message/2024/11-02/34844b2b-aeaa-4316-ab8e-13114deaebc3.png', 90880, 'image/png', 0, 1849681227633758210, 1849681227633758210, '2024-11-02 17:16:12', '2024-11-02 17:16:12', 0);
INSERT INTO `sys_files` VALUES (1852641343936659457, 'Java.png', '/auth-admin/message/2024/11-02/97b20e8a-0794-40e9-b276-1ee7ed85665f.png', 4281, 'image/png', 0, 1849681227633758210, 1849681227633758210, '2024-11-02 17:18:11', '2024-11-02 17:18:11', 0);
INSERT INTO `sys_files` VALUES (1852641670505168897, 'image.png', '/auth-admin/message/2024/11-02/897e4d4c-d39d-413e-911d-7d075e0eb766.png', 8501, 'image/png', 0, 1, 1, '2024-11-02 17:19:29', '2024-11-02 17:19:29', 0);
INSERT INTO `sys_files` VALUES (1852762631627923458, 'f083c7e3-7959-43b3-b810-62ced61a3fc2.jpg', '/auth-admin/message/2024/11-03/2ea39384-51ca-4fbd-af0b-b909e69a24e7.jpg', 3338, 'image/jpeg', 0, 1, 1, '2024-11-03 01:20:09', '2024-11-03 01:20:09', 0);
INSERT INTO `sys_files` VALUES (1852766768964886530, '1.png', '/auth-admin/message/2024/11-03/ae2b9cb4-83a4-4190-b4f2-d5548f2635b9.png', 25782, 'image/png', 0, 1, 1, '2024-11-03 01:36:35', '2024-11-03 01:36:35', 0);
INSERT INTO `sys_files` VALUES (1852778544641200129, 'image.png', '/auth-admin/message/2024/11-03/f3a6f9ae-4804-4d28-a99a-3f84bc52037b.png', 64483, 'image/png', 0, 1, 1, '2024-11-03 02:23:23', '2024-11-03 02:23:23', 0);
INSERT INTO `sys_files` VALUES (1853080194035568642, '003540AH4M7.jpg', '/auth-admin/message/2024/11-03/f3f80696-b1ea-47c4-bbf3-13fc08bd21d0.jpg', 1188970, 'image/jpeg', 0, 1, 1, '2024-11-03 22:22:01', '2024-11-03 22:22:01', 0);
INSERT INTO `sys_files` VALUES (1853080248490217473, 'image.png', '/auth-admin/message/2024/11-03/fa9bab7c-fa08-40b7-a7fa-684df3dd7f79.png', 11837, 'image/png', 0, 1, 1, '2024-11-03 22:22:14', '2024-11-03 22:22:14', 0);
INSERT INTO `sys_files` VALUES (1853080597284347905, '003540AH4M7.jpg', '/auth-admin/message/2024/11-03/bbbe5c43-6afc-46d2-ae26-4267d32a9837.jpg', 1188970, 'image/jpeg', 0, 1, 1, '2024-11-03 22:23:38', '2024-11-03 22:23:38', 0);
INSERT INTO `sys_files` VALUES (1853123338194124802, 'f083c7e3-7959-43b3-b810-62ced61a3fc2.jpg', '/auth-admin/message/2024/11-04/c76bc462-3648-4f87-9a43-56e67930920a.jpg', 3338, 'image/jpeg', 0, 1, 1, '2024-11-04 01:13:28', '2024-11-04 01:13:28', 0);
INSERT INTO `sys_files` VALUES (1853172180298072066, 'image.png', '/auth-admin/message/2024/11-04/b3f236d0-fced-4482-8890-4c2d52648e08.png', 1954, 'image/png', 0, 1, 1, '2024-11-04 04:27:33', '2024-11-04 04:27:33', 0);
INSERT INTO `sys_files` VALUES (1853172694964338690, 'image.png', '/auth-admin/message/2024/11-04/bff3949c-2109-45ab-8138-9fd9aeb09893.png', 2706, 'image/png', 0, 1, 1, '2024-11-04 04:29:35', '2024-11-04 04:29:35', 0);
INSERT INTO `sys_files` VALUES (1853350619877556226, 'image.png', '/auth-admin/message/2024/11-04/9311c7e4-5585-4bd3-b65b-8f24cf9603b6.png', 3463, 'image/png', 0, 1, 1, '2024-11-04 16:16:36', '2024-11-04 16:16:36', 0);
INSERT INTO `sys_files` VALUES (1853360176951541761, '003540AH4M7.jpg', '/auth-admin/message/2024/11-04/643919a8-d5e0-4295-82c3-0cda69578420.jpg', 1188970, 'image/jpeg', 0, 1, 1, '2024-11-04 16:54:35', '2024-11-04 16:54:35', 0);
INSERT INTO `sys_files` VALUES (1853360488756101121, '003540AH4M7.jpg', '/auth-admin/message/2024/11-04/ed6c4a4e-c453-45d0-b250-2100260d259a.jpg', 1188970, 'image/jpeg', 0, 1, 1, '2024-11-04 16:55:49', '2024-11-04 16:55:49', 0);
INSERT INTO `sys_files` VALUES (1853360685720616962, 'f083c7e3-7959-43b3-b810-62ced61a3fc2.jpg', '/auth-admin/message/2024/11-04/7d63d2c7-d88c-4883-b669-71244a733b50.jpg', 3338, 'image/jpeg', 0, 1, 1, '2024-11-04 16:56:36', '2024-11-04 16:56:36', 0);
INSERT INTO `sys_files` VALUES (1853362259058573313, 'f083c7e3-7959-43b3-b810-62ced61a3fc2.jpg', '/auth-admin/message/2024/11-04/61a09577-9929-4f8f-b701-5c336510f6f2.jpg', 3338, 'image/jpeg', 0, 1, 1, '2024-11-04 17:02:51', '2024-11-04 17:02:51', 0);
INSERT INTO `sys_files` VALUES (1853496579492413441, 'blob', '/auth-admin/avatar/2024/11-05/56ea89bd-b894-4507-8e00-5ee2623ab65c', 921652, 'image/png', 0, 1853494274437152770, 1853494274437152770, '2024-11-05 01:56:36', '2024-11-05 01:56:36', 0);
INSERT INTO `sys_files` VALUES (1868249983507075073, 'avatar', '/auth-admin/avatar/2024/12-15/a2d44804-d081-4fdc-ac67-68e83e0eeb66', 133105, 'application/octet-stream', 0, 1849444494908125181, 1849444494908125181, '2024-12-15 19:01:21', '2024-12-15 19:01:21', 0);
INSERT INTO `sys_files` VALUES (1868249986585694210, 'avatar', '/auth-admin/avatar/2024/12-15/c847bce6-8b2f-4fe6-8fe8-85204af5253e', 133105, 'application/octet-stream', 0, 1849444494908125181, 1849444494908125181, '2024-12-15 19:01:22', '2024-12-15 19:01:22', 0);
INSERT INTO `sys_files` VALUES (1868541558913077249, 'avatar', '/auth-admin/avatar/2024/12-16/d317ea6a-5187-472b-be0c-f5f56e303bba', 123321, 'application/octet-stream', 0, 1849444494908125181, 1849444494908125181, '2024-12-16 14:19:58', '2024-12-16 14:19:58', 0);
INSERT INTO `sys_files` VALUES (1873378468298854402, '1.png', '/auth-admin/message/2024/12-29/6e6009cd-a4ec-4955-bb11-fa195e3d0d66.png', 25782, 'image/png', 0, 1, 1, '2024-12-29 22:40:07', '2024-12-29 22:40:07', 0);
INSERT INTO `sys_files` VALUES (1873379085503270913, '小兔子画面生成.png', '/auth-admin/message/2024/12-29/bda41b70-f306-42c1-86bf-c16dc3c62333.png', 1292505, 'image/png', 0, 1, 1, '2024-12-29 22:42:34', '2024-12-29 22:42:34', 0);
INSERT INTO `sys_files` VALUES (1876195579203260417, 'avatar', '/auth-admin/avatar/2025/01-06/a100c159-7f92-4cfe-ab88-fa59efdd1feb', 905454, 'application/octet-stream', 0, 1849444494908125181, 1849444494908125181, '2025-01-06 17:14:19', '2025-01-06 17:14:19', 0);
INSERT INTO `sys_files` VALUES (1877006481867509761, '003540AH4M72.jpg', '/auth-admin/message/2025/01-08/f4d2f8ff-6fce-4b6b-a87c-8fdb2140c09b.jpg', 99299, 'image/jpeg', 0, 1, 1, '2025-01-08 22:56:33', '2025-01-08 22:56:33', 0);
INSERT INTO `sys_files` VALUES (1877177102748454914, 'avatar', '/auth-admin/avatar/2025/01-09/aae24405-37fd-48ff-b694-ab2577d99150', 3938185, 'application/octet-stream', 0, 1849444494908125181, 1849444494908125181, '2025-01-09 10:14:32', '2025-01-09 10:14:32', 0);
INSERT INTO `sys_files` VALUES (1879030581758627842, 'avatar', '/auth-admin/avatar/2025/01-14/943b8a35-9248-4cd8-b109-4cec22cf4173', 4111, 'application/octet-stream', 0, 1849444494908125181, 1849444494908125181, '2025-01-14 12:59:36', '2025-01-14 12:59:36', 0);
INSERT INTO `sys_files` VALUES (1879032940643586050, 'avatar', '/auth-admin/avatar/2025/01-14/99c2e4ee-2a7f-429d-ae78-733f2594c1da', 54954, 'application/octet-stream', 0, 1849444494908125181, 1849444494908125181, '2025-01-14 13:08:58', '2025-01-14 13:08:58', 0);
INSERT INTO `sys_files` VALUES (1880188065768640514, 'avatar', '/auth-admin/avatar/2025/01-17/b3aba651-bfb1-45dd-a470-0bcaad26f6ef', 23017, 'application/octet-stream', 0, 1849444494908125181, 1849444494908125181, '2025-01-17 17:39:02', '2025-01-17 17:39:02', 0);
INSERT INTO `sys_files` VALUES (1880188237890293761, 'avatar', '/auth-admin/avatar/2025/01-17/c1988893-c06d-434c-a1df-d17795fbcf97', 12332, 'application/octet-stream', 0, 1849444494908125181, 1849444494908125181, '2025-01-17 17:39:43', '2025-01-17 17:39:43', 0);
INSERT INTO `sys_files` VALUES (1891405886364160002, 'avatar', '/auth-admin/avatar/2025/02-17/7d06b23c-1a2e-4a24-a0ee-ba8c28088937', 172243, 'application/octet-stream', 0, 1849444494908125181, 1849444494908125181, '2025-02-17 16:34:39', '2025-02-17 16:34:39', 0);
INSERT INTO `sys_files` VALUES (1893299510676656130, 'image.png', '/auth-admin/message/2025/02-22/6d2a4aaa-fd19-40a1-bece-289c2db22953.png', 7970, 'image/png', 0, 1849444494908125181, 1849444494908125181, '2025-02-22 21:59:14', '2025-02-22 21:59:14', 0);
INSERT INTO `sys_files` VALUES (1893300651330211841, 'image.png', '/auth-admin/message/2025/02-22/d20f5cc1-b497-4027-95f5-2ff465dc4d27.png', 8930, 'image/png', 0, 1849444494908125181, 1849444494908125181, '2025-02-22 22:03:46', '2025-02-22 22:03:46', 0);
INSERT INTO `sys_files` VALUES (1904168394166210561, 'avatar', '/auth-admin/avatar/2025/03-24/43bb03d4-e2a4-478b-901e-81dd5a69fe59', 49466, 'application/octet-stream', 0, 1, 1, '2025-03-24 21:48:18', '2025-03-24 21:48:18', 0);
INSERT INTO `sys_files` VALUES (1904171014897283074, 'blob', '/auth-admin/avatar/2025/03-24/151a11fa-1a11-40c5-9845-202ab0a7f830', 16758, 'image/png', 0, 1, 1, '2025-03-24 21:58:42', '2025-03-24 21:58:42', 0);

-- ----------------------------
-- Table structure for sys_i18n
-- ----------------------------
DROP TABLE IF EXISTS `sys_i18n`;
CREATE TABLE `sys_i18n`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `key_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '多语言key',
  `translation` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '多语言翻译名称',
  `type_name` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '多语言类型',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录文件最后修改的时间戳',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '文件是否被删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `key_name`(`key_name` ASC, `type_name` ASC) USING BTREE COMMENT '唯一不可以重复',
  INDEX `idx_key_name`(`key_name` ASC) USING BTREE,
  INDEX `idx_translation`(`translation` ASC) USING BTREE,
  INDEX `idx_type_name`(`type_name` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '多语言表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_i18n
-- ----------------------------
INSERT INTO `sys_i18n` VALUES (1915277454458331138, 'cancel', '取消', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454458331139, 'menus.pureVerify', '图形验证码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454458331140, 'buttons.pureTagsStyleCardTip', '卡片标签，高效浏览', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454458331141, 'buttons.pureTagsStyle', '页签风格', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454458331142, 'i18n.typeId', '类型id', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454458331143, 'menus.pureRole', '角色管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454458331144, 'login.purePhone', '手机号码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454458331145, 'search.purePlaceholder', '搜索菜单（支持拼音搜索）', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454458331146, 'readAlready', '已读', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454458331147, 'menus.pureCheckCard', '多选卡片', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454458331148, 'menus.pureTimePicker', '时间选择器', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454458331149, 'overallStyle', '应用程序的整体样式', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454458331150, 'menus.pureButton', '按钮动效', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454458331151, 'adminUser_phone', '手机号', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454458331152, 'path', '路由路径', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454458331153, 'receivedUserIdTip', '不填表示通知全部', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525442, 'schedulers', '调度任务', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525443, 'messageType', '消息类型', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525444, 'panel.pureThemeColor', '主题色', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525445, 'buttons.pureContentFullScreen', '内容区全屏', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525446, 'buttons.pureCloseText', '关', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525447, 'emailUsers_host', '主机地址', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525448, 'no_default', '不默认', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525449, 'returnToHomepage', '返回首页', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525450, 'cachingAsyncRoutes', '是否缓存异步路由', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525451, 'panel.pureOverallStyleSystem', '自动', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525452, 'panel.pureOverallStyle', '整体风格', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525453, 'multilingualManagement', '多语言管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525454, 'userLoginLog_secChUa', '品牌和版本', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525455, 'userLoginLog_ect', '有效连接类型', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525456, 'userLoginLog_secChUaBitness', 'CPU架构位数', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525457, 'version', '版本', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525458, 'menus.pureCascader', '区域级联选择器', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525459, 'isDefault', '是否默认', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525460, 'menus.purePermissionButtonLogin', '登录接口返回按钮权限', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525461, 'multiTagsCache', '是否缓存多个标签', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525462, 'menuNameTip', '菜单名称为必填项', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525463, 'table.createTime', '创建时间', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525464, 'menus.pureDatePicker', '日期选择器', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525465, 'receivedUserNickname', '收信人昵称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525466, 'role', '角色管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525467, 'panel.pureOverallStyleDark', '深色', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525468, 'delete_batches', '批量删除', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454462525469, 'buttons.pureCloseLeftTabs', '关闭左侧标签页', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719745, 'isRead', '是否已读', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719746, 'system_setting', '系统设置', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719747, 'buttons.pureBackTop', '回到顶部', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719748, 'appTitle', '网页title', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719749, 'menus.pureList', '列表页面', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719750, 'menus.pureTypeit', '打字机', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719751, 'search', '搜索', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719752, 'userLoginLog_deviceMemory', '内存', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719753, 'menus.pureEmbeddedDoc', '文档内嵌', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719754, 'drop_file_here', '拖拽文件到此处', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719755, 'delete_warning', '删除警告', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719756, 'nickname', '昵称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719757, 'dept_deptName', '部门名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719758, 'buttons.pureClickCollapse', '点击折叠', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719759, 'resume', '恢复', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719760, 'menus.pureSysManagement', '系统管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719761, 'userLoginLog_width', '视口宽度', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719762, 'inputRuleMustBeEnglish', '必须是英文', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719763, 'sex', '性别', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719764, 'allMarkAsRead', '全部标为已读', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719765, 'sorryServerError', '抱歉，服务器出错了', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719766, 'routerPath', '路由路径', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719767, 'menus.pureSegmented', '分段控制器', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719768, 'menus.pureLineTree', '树形连接线', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719769, 'menus.pureSwiper', 'Swiper插件', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719770, 'adminUser_username', '用户名', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719771, 'menus.pureDownload', '下载', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454466719772, 'required_fields', '填写必填项', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108354, 'i18n_summary', '多语言详情解释', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108355, 'adminUser_dept', '部门', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108356, 'menuSearchHistory', '菜单搜索历史', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108357, 'quartzExecuteLog_executeResult', '执行结果', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108358, 'click_to_upload', '点击上传文件', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108359, 'userLoginLog_token', '令牌', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108360, 'added', '已添加', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108361, 'assignBatchRolesToRouter', '批量分配角色', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108362, 'animationNotExist', '动画不存在', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108363, 'status.pureNoTodo', '暂无待办', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108364, 'menus.pureHome', '首页', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108365, 'confirmText', '确认文字', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108366, 'inputRequestUrlTip', '请求URL需要以 \'/\' 开头', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108367, 'menuName', '菜单名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108368, 'login.password', '密码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108369, 'fixedHeader', '固定头', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108370, 'power_parentId', '权限父级', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108371, 'menus.pureTableHigh', '高级用法', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108372, 'dept_remarks', '备注', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108373, 'warning', '警告', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108374, 'female', '女', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454475108375, 'schedulers_jobGroup', '任务分组', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454479302658, 'info', '信息', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454479302659, 'add', '添加', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454479302660, 'buttons.pureTagsStyleChromeTip', '谷歌风格，经典美观', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454479302661, 'status.pureNoNotify', '暂无通知', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454479302662, 'buttons.pureTagsStyleSmart', '灵动', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454479302663, 'quartzExecuteLog_triggerName', '触发器名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657729, 'emailUsers_isDefault', '是否默认', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657730, 'menus.pureEmpty', '无Layout页', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657731, 'menus.pureVideoFrame', '视频帧截取-wasm版', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657732, 'buttons.pureOpenText', '开', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657733, 'menus.pureRipple', '波纹(Ripple)', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657734, 'buttons.reset', '重置', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657735, 'adminUser_nickname', '昵称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657736, 'search.pureTotal', '共', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657737, 'login.purePassWordDifferentReg', '两次密码不一致!', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657738, 'success', '成功', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657739, 'login.pureDefinite', '确定', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657740, 'panel.pureOverallStyleLightTip', '清新启航，点亮舒适的工作界面', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657741, 'menus.pureText', '文本省略', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657742, 'messageName', '消息名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657743, 'sorryNoAccess', '抱歉，你无权访问该页面', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657744, 'menuArrowIconNoTransition', '菜单箭头图标是否没有过渡效果', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657745, 'assignBatchRolesToRouterTip', '批量分配角色，会清除已分配的角色并不会追加角色', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454659657746, 'notifyAll', '通知全部', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046338, 'for', '为', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046339, 'back', '返回', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046340, 'forced_offline', '强制下线', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046341, 'title', '标题', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046342, 'take_back', '收回', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046343, 'content', '内容', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046344, 'stretch', '是否拉伸', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046345, 'confirm_update_password', '确认修改密码吗', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046346, 'emailUsers_password', '密码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046347, 'pixel', '像素', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046348, 'menus.pureColorPicker', '颜色选择器', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046349, 'schedulers_cronExpression', 'cron表达式', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046350, 'menus.pureWatermark', '水印', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046351, 'monitor', '系统监控', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046352, 'userLoginLog_username', '用户名', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046353, 'power_powerName', '权限名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046354, 'message', '消息', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046355, 'confirmDelete', '是否确认删除', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046356, 'login.pureQRCodeLogin', '二维码登录', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046357, 'login.purePassWordSureReg', '请输入确认密码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046358, 'modify', '修改', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046359, 'clearAllRolesSelect', '清除选中所以角色', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046360, 'menus.pureMap', '地图', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454668046361, 'menus.pureOptimize', '防抖、截流、复制、长按指令', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240642, 'i18n.typeName', '类型名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240643, 'menus.pureAnimatecss', 'animate.css选择器', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240644, 'login.pureUsername', '账号', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240645, 'pleaseSelectAnimation', '请选择动画', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240646, 'no_server', '无服务', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240647, 'clearAllRolesSelectTip', '此操作会清除已经分配的菜单角色，如果确认此操作不可恢复，菜单下分配好的角色也将清除！！！', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240648, 'username', '用户名', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240649, 'copyright', '版权', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240650, 'menus.pureTableEdit', '可编辑用法', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240651, 'select', '选择', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240652, 'epThemeColor', '主题颜色', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240653, 'userLoginLog_type', '操作类型', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240654, 'sorryPageNotFound', '抱歉，你访问的页面不存在', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240655, 'login.pureVerifyCodeCorrectReg', '请输入正确的验证码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240656, 'select_icon', '选择图标', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240657, 'batchUpdates', '确认批量更新吗？', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240658, 'menus.pureTabs', '标签页操作', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240659, 'buttons.pureTagsStyleSmartTip', '灵动标签，添趣生辉', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240660, 'system_menu', '系统菜单', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240661, 'dept_parentId', '部门父级', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240662, 'i18n_type', '多语言类型', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240663, 'id', '主键', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240664, 'emailUsers_smtpAgreement', 'smtp 协议', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240665, 'status.pureNotify', '通知', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240666, 'power_setting', '权限设置', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240667, 'messageEditing', '消息编辑', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240668, 'modifyingConfiguration', '修改配置', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240669, 'download_batch', '批量下载', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240670, 'menus.purePermissionPage', '页面权限', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240671, 'login.pureGetVerifyCode', '获取验证码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240672, 'panel.pureCloseSystemSet', '关闭配置', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240673, 'element_plus', '饿了么UI', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240674, 'index', '序号', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240675, 'menus.pureCardList', '卡片列表页', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240676, 'menus.pureAbout', '关于', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240677, 'table.createUser', '创建用户', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240678, 'account_password', '账户密码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240679, 'panel.pureStretchCustomTip', '最小1280、最大1600', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454672240680, '404', '404', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629249, 'deleteBatches', '批量删除', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629250, 'menus.pureCheckButton', '可选按钮', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629251, 'menuType', '菜单类型', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629252, 'buttons.pureContentExitFullScreen', '内容区退出全屏', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629253, 'status', '状态', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629254, 'external_page', '外部页面', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629255, 'menus.pureVirtualList', '虚拟列表', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629256, 'login.pureRegister', '注册', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629257, 'buttons.pureInterfaceDisplay', '界面显示', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629258, 'userPassword', '用户的密码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629259, 'menuIcon_iconCode', '图标类名', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629260, 'quartzExecuteLog_endTime', '结束时间', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629261, 'login', '登录', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629262, 'menus.pureLoginLog', '登录日志', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629263, 'menus.pureExternalLink', 'vue-pure-admin', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629264, 'userLoginLog_rtt', '往返时间', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629265, 'schedulers_jobMethodName', '方法名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629266, 'menus.pureCountTo', '数字动画', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454680629267, 'tooltipEffect', '工具提示的效果', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955842, 'menus.pureStatistic', '统计组件', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955843, 'man', '男', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955844, 'addMultilingual', '添加多语言', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955845, 'login.purePassWordReg', '请输入密码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955846, 'view_user_info', '查看用户信息', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955847, 'schedulersGroup', '任务调度分组', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955848, 'avatar', '头像', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955849, 'deleteBatchTip', '输入 yes/YES/y/Y 来确认批量删除，此操作不可逆', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955850, 'menu', '菜单', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955851, 'file_size', '文件大小', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955852, 'menus.pureDebounce', '防抖节流', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955853, 'sendNickname', '发送人昵称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955854, 'disable', '禁用', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955855, 'userLoginLog_secChUaPlatformVersion', '操作系统版本', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955856, 'responsiveStorageNameSpace', '响应式存储的命名空间', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955857, 'panel.pureWeakModel', '色弱模式', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955858, 'panel.pureInterfaceDisplay', '界面显示', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955859, 'editorType', '编辑器类型', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955860, 'unfold_all', '展开全部', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955861, 'Searching_for_router', '搜索路由', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955862, 'panel.pureOverallStyleDarkTip', '月光序曲，沉醉于夜的静谧雅致', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955863, 'showLogo', '是否显示logo', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955864, 'menuIcon', '菜单图标', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955865, 'status.pureLoad', '加载中...', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955866, 'files_filepath', '文件存储路径', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955867, 'quartzExecuteLog_duration', '执行时间', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955868, 'swagger', 'swagger', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955869, 'format_error', '格式错误', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955870, 'Searching_for_roles', '搜索角色', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955871, 'menus.pureAbnormal', '异常页面', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955872, 'download', '下载', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955873, 'quartzExecuteLog_jobGroup', '任务分组', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955874, 'menus.pureChildMenuOverflow', '菜单超出显示Tooltip文字提示', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955875, 'previousMenu', '上级菜单', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955876, 'buttons.pureSwitch', '切换', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955877, 'menus.pureResult', '结果页面', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955878, 'login.loginSuccess', '登录成功', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955879, 'personDescription', '个人详情', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955880, 'all', '全部', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955881, 'table.updateTime', '更新时间', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955882, 'hideTabs', '是否隐藏选项卡', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955883, 'level', '消息等级', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955884, 'menus.pureSelector', '范围选择器', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955885, 'menus.pureMessage', '消息提示', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955886, 'sort', '排序', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955887, 'buttons.pureReload', '重新加载', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955888, 'viewTemplate', '查看模板', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955889, 'login.purePrivacyPolicy', '《隐私政策》', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454881955890, 'adminUser_password', '密码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150146, 'doubleCheck', '再次确认是否继续？！', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150147, 'menus.pureWaterfall', '瀑布流无限滚动', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150148, 'menus.pureBoard', '艺术画板', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150149, 'login.purePassWordUpdateReg', '修改密码成功', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150150, 'menus.purePermission', '权限管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150151, 'login.pureVerifyCodeReg', '请输入验证码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150152, 'emailUsers', '邮件用户配置', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150153, 'menus.pureWavesurfer', '音频可视化', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150154, 'login.pureTickPrivacy', '请勾选隐私政策', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150155, 'menus.pureElButton', '按钮', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150156, 'quartzExecuteLog_jobName', '任务名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150157, 'status.systemMessage', '系统消息', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150158, 'delete', '删除', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150159, 'role_description', '角色详情', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150160, 'formatError', '格式错误', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150161, 'total', '总数', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150162, 'routerPathTip', '路由路径为必填项且为\"/\"开头', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150163, 'buttons.pureAccountSettings', '账户设置', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150164, 'login.getCodeInfo', '秒后获取验证码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150165, 'extra', '消息简介', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150166, 'menus.pureSuccess', '成功页面', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150167, 'login.getEmailCode', '获取验证码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150168, 'status.pureTodo', '待办', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150169, 'menus.pureFourZeroFour', '404', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150171, 'menus.pureUser', '用户管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150174, 'buttons.pureClickExpand', '点击展开', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150175, 'user_status', '用户状态', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150176, 'menus.pureSchemaForm', '表单', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150177, 'buttons.accountSettings', '账户设置', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150178, 'buttons.pureCloseAllTabs', '关闭全部标签页', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150179, 'fold_all', '折叠全部', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150180, 'buttons.pureLogin', '登录', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150181, 'search.pureHistory', '搜索历史', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150182, 'markAsUnread', '标为未读', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150183, 'menus.pureOperationLog', '操作日志', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150184, 'panel.pureStretchCustom', '自定义', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150185, 'security_log', '安全日志', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150186, 'greyStyle', '是否启用灰色模式', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150187, 'system_file', '系统文件管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150188, 'menus.purePiniaDoc', 'pinia', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150189, 'bytes', '字节', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454886150190, 'schedulers_description', '调度器详情信息', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454894538754, 'iconCode', '图标类名', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454894538755, 'adminUser_status', '状态', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454894538756, 'darkMode', '暗色主题', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454894538757, 'menus.pureBarcode', '条形码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454894538758, 'knife4j', 'knife4j', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277454894538759, 'menus.pureUpload', '文件上传', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339394, 'schedulersGroup_description', '任务调度详情', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339395, 'user_details', '用户详情', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339396, 'op_time', '操作时间', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339397, 'menus.pureEditor', '编辑器', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339398, 'addNew', '新增', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339399, 'quartzExecuteLog', '任务执行日志', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339400, 'panel.pureOverallStyleLight', '浅色', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339401, 'danger', '危险', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339402, 'cover', '封面', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339403, 'userLoginLog_viewportWidth', '视口宽度', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339404, 'panel.pureGreyModel', '灰色模式', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339405, 'routerName', '路由名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339406, 'menus.pureCollapse', '折叠面板', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339407, 'menus.pureMenus', '多级菜单', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339408, 'panel.pureTagsStyle', '页签风格', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339409, 'upload_avatar', '上传头像', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339410, 'panel.pureHiddenFooter', '隐藏页脚', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339411, 'adminUser_summary', '简介', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339412, 'sidebarStatus', '侧边栏的状态', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339413, 'monitoring', '系统监控', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339414, 'menus.pureDept', '部门管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339415, 'i18n', '多语言管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339416, 'adminUser_avatar', '头像', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339417, 'userLoginLog_contentDpr', '设备像素比', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339418, 'input', '输入', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339419, 'menus.pureExcel', '导出Excel', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339420, 'login.purePhoneLogin', '手机登录', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339421, 'power_requestUrl', '请求URL', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339422, 'i18n.translation', '翻译', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339423, 'menuIcon_iconName', '图标名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339424, 'emailTemplate_type', '模板类型', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339425, 'update_information', '更新信息', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339426, 'userLoginLog_secChUaModel', '设备模型', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339427, 'menus.pureFlowChart', '流程图', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339428, 'unread', '未读', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339429, 'menus.pureSystemMenu', '菜单管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339430, 'menus.pureTag', '标签', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339431, 'userLoginLog_xRequestedWith', '请求方式', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339432, 'menus.pureTableBase', '基础用法', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339433, 'panel.pureTagsStyleCard', '卡片', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339434, 'files_fileType', '文件类型', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339435, 'iconify', 'iconify图标', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339436, 'lastLoginIp', 'IP地址', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339437, 'default', '默认', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339438, 'hiddenSideBar', '侧边栏是否隐藏', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339439, 'assign_roles', '分配角色', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339440, 'system_i18n', '多语言', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339441, 'menus.pureGuide', '引导页', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339442, 'markdown', 'Markdown', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339443, 'panel.pureTagsStyleChromeTip', '谷歌风格，经典美观', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339444, 'upload_success', '上传成功', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339445, 'menus.pureFourZeroOne', '403', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339446, 'userLoginLog_dpr', '设备像素比', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339447, 'menus.pureMenu2', '菜单二', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339448, 'email', '邮箱', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339449, 'menus.pureMenu1', '菜单1', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339450, 'role_roleCode', '角色码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339451, 'delete_success', '删除成功', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339452, 'keepAlive', '保持存活', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339453, 'image_size', '图像大小', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339454, 'messageReceivingManagement', '消息接收管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339455, 'login.pureSmsVerifyCode', '短信验证码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455041339456, 'menus.pureJsonEditor', 'JSON编辑器', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728001, 'login.purePhoneCorrectReg', '请输入正确的手机号码格式', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728002, 'buttons.pureTagsStyleCard', '卡片', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728003, 'cancel_delete', '取消删除', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728004, 'dept', '部门管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728005, 'login.pureSure', '确认密码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728006, 'login.login', '登录', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728007, 'search.pureEmpty', '暂无搜索结果', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728008, 'confirm', '确定', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728009, 'login.pureRememberInfo', '勾选并登录后，规定天数内无需输入用户名和密码会自动登入系统', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728010, 'menus.pureFormDesign', '表单设计器', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728011, 'menus.pureMenuTree', '菜单树结构', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728012, 'login.purePassWordRuleReg', '密码格式应为8-18位数字、字母、符号的任意两种组合', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728013, 'logManagement', '日志管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728014, 'i18n_typeName', '多语言类型名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728015, 'menus.pureExternalDoc', '文档外链', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728016, 'update_batches_parent', '批量更新父级', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728017, 'userLoginLog_ipRegion', 'IP归属地', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728018, 'panel.pureStretchFixedTip', '紧凑页面，轻松找到所需信息', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728019, 'menus.pureVxeTable', '虚拟滚动', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728020, 'login.pureBack', '返回', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728021, 'view', '查看', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728022, 'forcedOffline', '管理员强制下线', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728023, 'systemi18n', '多语言', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728024, 'quartzExecuteLog_jobClassName', '任务类名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728025, 'status.pureMessage', '消息', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728026, 'panel.pureTagsStyleSmart', '灵动', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728027, 'menus.pureProgress', '进度条', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728028, 'menus.pureInfiniteScroll', '表格无限滚动', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728029, 'login.pureWeChatLogin', '微信登录', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728030, 'schedulers_triggerState', '触发器状态', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728031, 'table.updateUser', '更新用户', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728032, 'menus.pureLogin', '登录', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728033, 'menus.pureComponents', '组件', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728034, 'iconName', '图标名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728035, 'menus.pureCropping', '图片裁剪', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728036, 'dept_manager', '管理员', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455049728037, 'no_data', '无数据', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455200722945, 'userLoginLog_userId', '用户ID', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455200722946, 'menus.home', '首页', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455200722947, 'menus.pureUiGradients', '渐变色', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455200722948, 'buttons.pureCloseCurrentTab', '关闭当前标签页', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455200722949, 'menus.purePrint', '打印', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455200722950, 'knife4j_Interface_documentation', 'knife4j接口文档', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455200722951, 'lastLoginIpAddress', '归属地', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455200722952, 'files_downloadCount', '下载量', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455200722953, 'emailTemplate_subject', '主题', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455200722954, 'buttons.pureConfirm', '确认', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455200722955, 'menus.pureFive', '500', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455200722956, 'menus.pureSysMonitor', '系统监控', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455200722957, 'userLoginLog_ipAddress', 'IP地址', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111553, 'hidden', '隐藏', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111554, 'submit', '提交', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111555, 'menus.pureMqtt', 'MQTT客户端(mqtt)', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111556, 'show', '显示', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111557, 'description', '详情', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111558, 'system_files', '后台文件管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111559, 'update', '更新', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111560, 'menus.pureFail', '失败页面', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111561, 'receivedUserIds', '接收用户', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111562, 'userLoginLog', '用户登录日志', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111563, 'contentTooShortTip', '内容不能少于30字', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111564, 'login.pureThirdLogin', '第三方登录', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111565, 'scheduler', '定时任务', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111566, 'login.pureInfo', '秒后重新获取', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111567, 'emailTemplate_templateName', '模板名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111568, 'account_management', '账户管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111569, 'continue_adding', '继续添加', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111570, 'adminUser_email', '邮箱', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111571, 'login.pureTip', '扫码后点击\"确认\"，即可完成登录', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111572, 'userinfo', '用户信息', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111573, 'systemCaches', '系统缓存', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111574, 'summary', '简介', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111575, 'normal', '正常', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111576, 'menus.purePermissionButton', '按钮权限', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111577, 'login.pureQQLogin', 'QQ登录', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111578, 'table.acceptanceTime', '接收时间', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111579, 'systemManagement', '系统管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111580, 'update_multilingual', '更新多语言', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111581, 'need_number', '需要数字', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111582, 'upload_user_avatar_tip', '上传头像成功不会自动保存', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111583, 'layout', '应用程序的布局', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111584, 'login.pureTest', '模拟测试', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111585, 'webConifg', 'web配置', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111586, 'adminUser', '后台用户', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111587, 'external_pages', '外部页面', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111588, 'appLocale', '本地语言', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111589, 'quartzExecuteLog_cronExpression', 'cron表达式', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111590, 'login.pureVerifyCodeSixReg', '请输入6位数字验证码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111591, 'menus.pureContextmenu', '右键菜单', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111592, 'panel.pureMixTip', '混合菜单，灵活多变', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111593, 'externalLink', '外链', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111594, 'panel.pureMultiTagsCache', '页签持久化', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111595, 'hideFooter', '是否隐藏页脚', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111596, 'markAsRead', '标为已读', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111597, 'login.username', '用户名', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111598, 'files_filename', '文件名', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111599, 'menus.pureQrcode', '二维码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111600, 'Interface_documentation', '接口文档', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455209111601, 'logout', '退出', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305857, 'menus.pureAble', '功能', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305858, 'menus.pureVideo', '视频', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305859, 'enable', '已启用', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305860, 'login.purePassword', '密码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305861, 'search.pureDragSort', '（可拖拽排序）', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305862, 'menus.pureSplitPane', '切割面板', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305863, 'menus.pureColorHuntDoc', '调色板', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305864, 'menus.pureGanttastic', '甘特图', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305865, 'menus.pureIconSelect', '图标选择器', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305866, 'buttons.pureTagsStyleChrome', '谷歌', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305867, 'login.pureWeiBoLogin', '微博登录', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305868, 'emailTemplate', '邮件模板', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305869, 'buttons.pureCloseRightTabs', '关闭右侧标签页', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305870, 'rest_password_tip', '忘记密码或重置密码，修改密码后会跳转到登录页重新登录', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305871, 'emailUsers_port', '端口', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305872, 'phone', '手机号', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305873, 'dept_summary', '部门简介', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305874, 'menus.pureDraggable', '拖拽', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305875, 'confirm_update_status', '确认修改状态吗', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305876, 'menus.purePinyin', '汉语拼音', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305877, 'primary', '默认', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305878, 'power_powerCode', '权限码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305879, 'userLoginLog_userAgent', '用户代理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305880, 'userLoginLog_secChUaMobile', '是否为手机设备', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305881, 'userLoginLog_downlink', '带宽', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305882, 'menus.pureSystemLog', '系统日志', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305883, 'login.emailCode', '输入验证码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305884, 'emailUsers_email', '邮箱', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305885, 'portion', '部分', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305886, 'login.pureReadAccept', '我已仔细阅读并接受', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305887, 'i18n.keyName', '多语言key', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305888, 'table.operation', '操作', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305889, 'external_chaining', '外链接', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305890, 'panel.pureHiddenTags', '隐藏标签页', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305891, 'login.pureVerifyCode', '验证码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305892, 'cropper_preview_tips', '温馨提示：右键上方裁剪区可开启功能菜单', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305893, 'weakStyle', '色弱模式', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455213305894, 'theme', '主题', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455368495105, 'menus.pureTimeline', '时间线', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455368495106, 'power', '权限管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455368495107, 'messageManagement', '消息管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455368495108, 'menus.purePdf', 'PDF预览', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455368495110, 'schedulers_triggerName', '触发器名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455368495111, 'menus.pureRouterDoc', 'vue-router', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455368495113, 'systemMenuIcon.officialWebsite', '菜单图标官网', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455368495114, 'login.pureRegisterSuccess', '注册成功', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455368495115, 'login.pureRemember', '天内免登录', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455368495116, 'panel.pureStretchFixed', '固定', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455368495117, 'menus.pureMenuOverflow', '目录超出显示Tooltip文字提示', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883714, 'not_added', '未添加', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883715, 'pure_admin', '后台管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883716, 'emailUsers_emailTemplate', '关联模板', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883717, 'login.pureAlipayLogin', '支付宝登录', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883718, 'menus.pureViteDoc', 'vite', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883719, 'componentPath', '组件路径', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883720, 'menus.pureMindMap', '思维导图', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883721, 'buttons.pureLoginOut', '退出系统', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883722, 'embedded_doc', '文档内嵌', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883723, 'menus.pureVueDoc', 'vue3', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883724, 'panel.pureOverallStyleSystemTip', '同步时光，界面随晨昏自然呼应', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883725, 'menus.pureOnlineUser', '在线用户', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883726, 'menus.pureDrawer', '函数式抽屉', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883727, 'buttons.pureOpenSystemSet', '打开系统配置', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883728, 'userLoginLog_secChUaPlatform', '操作系统/平台', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883729, 'panel.pureTagsStyleChrome', '谷歌', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883730, 'panel.pureStretch', '页宽', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883731, 'adminUser_sex', '性别', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883732, 'login.usernameRegex', '用户名格式错误', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883733, 'userLoginLog_secChUaArch', '平台架构', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883734, 'panel.pureClearCacheAndToLogin', '清空缓存并返回登录页', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883735, 'roleCode', '角色码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883736, 'emailTemplate_body', '模板内容', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883737, 'menus.purePermissionButtonRouter', '路由返回按钮权限', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883738, 'systemMaintenance', '系统维护', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883739, 'panel.pureVerticalTip', '左侧菜单，亲切熟悉', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883740, 'showModel', '要显示的模型', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883741, 'crop_and_upload_avatars', '裁剪、上传头像', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883742, 'visible', '隐藏', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883743, 'messageSendManagement', '消息发送管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883744, 'login.pureUsernameReg', '请输入账号', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883745, 'menus.pureSeamless', '无缝滚动', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883746, 'richText', '富文本', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883747, 'external_doc', '文档外链', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883748, 'pause', '暂停', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883749, 'panel.pureClearCache', '清空缓存', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883750, 'menus.pureExternalPage', '外部页面', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883751, 'menus.pureSensitive', '敏感词过滤', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883752, 'files', '文件', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883753, 'monitoring_server', '服务监控', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455376883754, 'schedulers_jobClassName', '任务类名', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078017, 'panel.pureTagsStyleSmartTip', '灵动标签，添趣生辉', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078018, 'admin_user', '用户管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078019, 'schedulersGroup_groupName', '分组名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078020, 'buttons.pureCloseOtherTabs', '关闭其他标签页', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078021, 'status.pureNoMessage', '暂无消息', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078022, 'confirmUpdateConfiguration', '确认修改配置吗？', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078023, 'configuration', '系统配置', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078024, 'update_success', '修改成功', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078025, 'schedulers_jobName', '任务名称', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078026, 'email_user_send_config', '邮件用户发送配置管理', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078027, 'routerNameTip', '路由名称为必填项', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078028, 'menus.pureUtilsLink', 'pure-admin-utils', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078029, 'menuIcon_preview', '图标预览', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078030, 'sendUserId', '发送用户', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078031, 'panel.pureTagsStyleCardTip', '卡片标签，高效浏览', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078032, 'menus.pureDateTimePicker', '日期时间选择器', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078033, 'confirm_forcedOffline', '确认强制此用户下线吗', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078034, 'menus.pureTailwindcssDoc', 'tailwindcss', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078035, 'menus.pureDanmaku', '弹幕', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078036, 'menus.pureDialog', '函数式弹框', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078037, 'menus.pureTable', '表格', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078038, 'confirm_update_sort', '是否确认更新排序', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078039, 'panel.pureLayoutModel', '导航模式', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078040, 'login.pureLoginSuccess', '登录成功', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078041, 'i18n_type_setting', '多语言类型', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078042, 'menus.pureEpDoc', 'element-plus', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078043, 'panel.pureSystemSet', '系统配置', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078044, 'login.pureLogin', '登录', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078045, 'panel.pureHorizontalTip', '顶部菜单，简洁概览', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078046, 'emailTemplate_emailUser', '邮件模板用户', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078047, 'login.pureForget', '忘记密码?', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078048, 'login.purePhoneReg', '请输入手机号码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078049, 'login.pureLoginFail', '登录失败', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078050, 'search.pureCollect', '收藏', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078051, 'buttons.pureClose', '关闭', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078052, 'deleteBatchPlaceholder', '输入 yes/YES/y/Y 来确认', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078053, 'download_configuration', '下载配置', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078054, 'download_json', '下载JSON', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078055, 'download_excel', '下载Excel', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078056, 'file_update', '文件更新', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078057, 'use_json_update', '使用JSON更新', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078058, 'use_excel_update', '使用Excel更新', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078059, 'update_tip', '更新时会完全替换当前所有内容（原有内容将被清除），请确保文件包含所有需要保留的数据。', 'zh', 1, 1, '2025-04-25 22:37:14', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915277455381078060, 'reset_passwords', '重置密码', 'zh', 1, 1, '2025-04-24 13:31:44', '2025-04-24 13:31:44', 0);
INSERT INTO `sys_i18n` VALUES (1915782227850801153, 'file_import', '文件导入', 'zh', 1, 1, '2025-04-25 22:57:31', '2025-04-25 22:57:31', 0);
INSERT INTO `sys_i18n` VALUES (1916059651612192770, 'requestMethod', '请求方法', 'zh', 1, 1, '2025-04-26 17:19:54', '2025-04-26 17:19:54', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607105, 'cancel', '取消', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607106, 'menus.pureVerify', '图形验证码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607107, 'buttons.pureTagsStyleCardTip', '卡片标签，高效浏览', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607108, 'buttons.pureTagsStyle', '页签风格', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607109, 'i18n.typeId', '类型id', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607110, 'menus.pureRole', '角色管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607111, 'login.purePhone', '手机号码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607112, 'search.purePlaceholder', '搜索菜单（支持拼音搜索）', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607113, 'readAlready', '已读', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607114, 'menus.pureCheckCard', '多选卡片', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607115, 'menus.pureTimePicker', '时间选择器', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607116, 'overallStyle', '应用程序的整体样式', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607117, 'menus.pureButton', '按钮动效', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607118, 'adminUser_phone', '手机号', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607119, 'path', '路由路径', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607120, 'receivedUserIdTip', '不填表示通知全部', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607121, 'schedulers', '调度任务', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607122, 'messageType', '消息类型', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607123, 'panel.pureThemeColor', '主题色', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607124, 'buttons.pureContentFullScreen', '内容区全屏', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607125, 'buttons.pureCloseText', '关', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607126, 'emailUsers_host', '主机地址', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607127, 'no_default', '不默认', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607128, 'returnToHomepage', '返回首页', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607129, 'cachingAsyncRoutes', '是否缓存异步路由', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607130, 'panel.pureOverallStyleSystem', '自动', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607131, 'panel.pureOverallStyle', '整体风格', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607132, 'multilingualManagement', '多语言管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607133, 'userLoginLog_secChUa', '品牌和版本', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607134, 'userLoginLog_ect', '有效连接类型', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607135, 'userLoginLog_secChUaBitness', 'CPU架构位数', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607136, 'version', '版本', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607137, 'menus.pureCascader', '区域级联选择器', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083815970607138, 'isDefault', '是否默认', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355842, 'menus.purePermissionButtonLogin', '登录接口返回按钮权限', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355843, 'multiTagsCache', '是否缓存多个标签', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355844, 'menuNameTip', '菜单名称为必填项', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355845, 'table.createTime', '创建时间', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355846, 'menus.pureDatePicker', '日期选择器', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355847, 'receivedUserNickname', '收信人昵称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355848, 'role', '角色管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355849, 'panel.pureOverallStyleDark', '深色', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355850, 'delete_batches', '批量删除', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355851, 'buttons.pureCloseLeftTabs', '关闭左侧标签页', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355852, 'isRead', '是否已读', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355853, 'system_setting', '系统设置', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355854, 'buttons.pureBackTop', '回到顶部', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355855, 'appTitle', '网页title', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355856, 'menus.pureList', '列表页面', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355857, 'menus.pureTypeit', '打字机', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355858, 'search', '搜索', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355859, 'userLoginLog_deviceMemory', '内存', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355860, 'menus.pureEmbeddedDoc', '文档内嵌', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355861, 'drop_file_here', '拖拽文件到此处', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355862, 'delete_warning', '删除警告', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355863, 'nickname', '昵称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355864, 'dept_deptName', '部门名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355865, 'buttons.pureClickCollapse', '点击折叠', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355866, 'resume', '恢复', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355867, 'menus.pureSysManagement', '系统管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355868, 'userLoginLog_width', '视口宽度', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355869, 'inputRuleMustBeEnglish', '必须是英文', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355870, 'sex', '性别', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355871, 'allMarkAsRead', '全部标为已读', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355872, 'sorryServerError', '抱歉，服务器出错了', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355873, 'routerPath', '路由路径', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355874, 'menus.pureSegmented', '分段控制器', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355875, 'menus.pureLineTree', '树形连接线', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355876, 'menus.pureSwiper', 'Swiper插件', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355877, 'adminUser_username', '用户名', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355878, 'menus.pureDownload', '下载', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355879, 'required_fields', '填写必填项', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355880, 'i18n_summary', '多语言详情解释', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355881, 'adminUser_dept', '部门', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355882, 'menuSearchHistory', '菜单搜索历史', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355883, 'quartzExecuteLog_executeResult', '执行结果', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355884, 'click_to_upload', '点击上传文件', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355885, 'userLoginLog_token', '令牌', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355886, 'added', '已添加', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355887, 'assignBatchRolesToRouter', '批量分配角色', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355888, 'animationNotExist', '动画不存在', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355889, 'status.pureNoTodo', '暂无待办', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355890, 'menus.pureHome', '首页', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355891, 'confirmText', '确认文字', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355892, 'inputRequestUrlTip', '请求URL需要以 \'/\' 开头', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355893, 'menuName', '菜单名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355894, 'login.password', '密码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355895, 'fixedHeader', '固定头', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355896, 'power_parentId', '权限父级', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355897, 'menus.pureTableHigh', '高级用法', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355898, 'dept_remarks', '备注', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355899, 'warning', '警告', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355900, 'female', '女', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355901, 'schedulers_jobGroup', '任务分组', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355902, 'info', '信息', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355903, 'add', '添加', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355904, 'buttons.pureTagsStyleChromeTip', '谷歌风格，经典美观', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355905, 'status.pureNoNotify', '暂无通知', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355906, 'buttons.pureTagsStyleSmart', '灵动', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816008355907, 'quartzExecuteLog_triggerName', '触发器名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293825, 'emailUsers_isDefault', '是否默认', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293826, 'menus.pureEmpty', '无Layout页', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293827, 'menus.pureVideoFrame', '视频帧截取-wasm版', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293828, 'buttons.pureOpenText', '开', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293829, 'menus.pureRipple', '波纹(Ripple)', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293830, 'buttons.reset', '重置', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293831, 'adminUser_nickname', '昵称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293832, 'search.pureTotal', '共', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293833, 'login.purePassWordDifferentReg', '两次密码不一致!', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293834, 'success', '成功', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293835, 'login.pureDefinite', '确定', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293836, 'panel.pureOverallStyleLightTip', '清新启航，点亮舒适的工作界面', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293837, 'menus.pureText', '文本省略', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293838, 'messageName', '消息名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293839, 'sorryNoAccess', '抱歉，你无权访问该页面', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293840, 'menuArrowIconNoTransition', '菜单箭头图标是否没有过渡效果', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293841, 'assignBatchRolesToRouterTip', '批量分配角色，会清除已分配的角色并不会追加角色', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293842, 'notifyAll', '通知全部', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293843, 'for', '为', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293844, 'back', '返回', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293845, 'forced_offline', '强制下线', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293846, 'title', '标题', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293847, 'take_back', '收回', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293848, 'content', '内容', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293849, 'stretch', '是否拉伸', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293850, 'confirm_update_password', '确认修改密码吗', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293851, 'emailUsers_password', '密码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293852, 'pixel', '像素', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293853, 'menus.pureColorPicker', '颜色选择器', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293854, 'schedulers_cronExpression', 'cron表达式', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293855, 'menus.pureWatermark', '水印', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293856, 'monitor', '系统监控', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293857, 'userLoginLog_username', '用户名', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293858, 'power_powerName', '权限名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293859, 'message', '消息', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293860, 'confirmDelete', '是否确认删除', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293861, 'login.pureQRCodeLogin', '二维码登录', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293862, 'login.purePassWordSureReg', '请输入确认密码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293863, 'modify', '修改', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293864, 'clearAllRolesSelect', '清除选中所以角色', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293865, 'menus.pureMap', '地图', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293866, 'menus.pureOptimize', '防抖、截流、复制、长按指令', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293867, 'i18n.typeName', '类型名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293868, 'menus.pureAnimatecss', 'animate.css选择器', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293869, 'login.pureUsername', '账号', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293870, 'pleaseSelectAnimation', '请选择动画', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293871, 'no_server', '无服务', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293872, 'clearAllRolesSelectTip', '此操作会清除已经分配的菜单角色，如果确认此操作不可恢复，菜单下分配好的角色也将清除！！！', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293873, 'username', '用户名', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293874, 'copyright', '版权', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293875, 'menus.pureTableEdit', '可编辑用法', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293876, 'select', '选择', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293877, 'epThemeColor', '主题颜色', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293878, 'userLoginLog_type', '操作类型', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293879, 'sorryPageNotFound', '抱歉，你访问的页面不存在', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293880, 'login.pureVerifyCodeCorrectReg', '请输入正确的验证码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293881, 'select_icon', '选择图标', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293882, 'batchUpdates', '确认批量更新吗？', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293883, 'menus.pureTabs', '标签页操作', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293884, 'buttons.pureTagsStyleSmartTip', '灵动标签，添趣生辉', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293885, 'system_menu', '系统菜单', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293886, 'dept_parentId', '部门父级', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293887, 'i18n_type', '多语言类型', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293888, 'id', '主键', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293889, 'emailUsers_smtpAgreement', 'smtp 协议', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293890, 'status.pureNotify', '通知', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293891, 'power_setting', '权限设置', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293892, 'messageEditing', '消息编辑', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293893, 'modifyingConfiguration', '修改配置', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293894, 'download_batch', '批量下载', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293895, 'menus.purePermissionPage', '页面权限', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293896, 'login.pureGetVerifyCode', '获取验证码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293897, 'panel.pureCloseSystemSet', '关闭配置', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293898, 'element_plus', '饿了么UI', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293899, 'index', '序号', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293900, 'menus.pureCardList', '卡片列表页', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293901, 'menus.pureAbout', '关于', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293902, 'table.createUser', '创建用户', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293903, 'account_password', '账户密码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293904, 'panel.pureStretchCustomTip', '最小1280、最大1600', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293905, '404', '404', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293906, 'deleteBatches', '批量删除', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293907, 'menus.pureCheckButton', '可选按钮', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293908, 'menuType', '菜单类型', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293909, 'buttons.pureContentExitFullScreen', '内容区退出全屏', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293910, 'status', '状态', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293911, 'external_page', '外部页面', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293912, 'menus.pureVirtualList', '虚拟列表', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293913, 'login.pureRegister', '注册', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293914, 'buttons.pureInterfaceDisplay', '界面显示', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293915, 'userPassword', '用户的密码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293916, 'menuIcon_iconCode', '图标类名', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293917, 'quartzExecuteLog_endTime', '结束时间', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293918, 'login', '登录', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293919, 'menus.pureLoginLog', '登录日志', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816201293920, 'menus.pureExternalLink', 'vue-pure-admin', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816264208386, 'userLoginLog_rtt', '往返时间', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816264208387, 'schedulers_jobMethodName', '方法名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816264208388, 'menus.pureCountTo', '数字动画', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816264208389, 'tooltipEffect', '工具提示的效果', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426113, 'menus.pureStatistic', '统计组件', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426114, 'man', '男', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426115, 'addMultilingual', '添加多语言', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426116, 'login.purePassWordReg', '请输入密码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426117, 'view_user_info', '查看用户信息', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426118, 'schedulersGroup', '任务调度分组', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426119, 'avatar', '头像', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426120, 'deleteBatchTip', '输入 yes/YES/y/Y 来确认批量删除，此操作不可逆', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426121, 'menu', '菜单', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426122, 'file_size', '文件大小', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426123, 'menus.pureDebounce', '防抖节流', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426124, 'sendNickname', '发送人昵称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426125, 'disable', '禁用', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426126, 'userLoginLog_secChUaPlatformVersion', '操作系统版本', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426127, 'responsiveStorageNameSpace', '响应式存储的命名空间', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426128, 'panel.pureWeakModel', '色弱模式', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426129, 'panel.pureInterfaceDisplay', '界面显示', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426130, 'editorType', '编辑器类型', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426131, 'unfold_all', '展开全部', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426132, 'Searching_for_router', '搜索路由', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426133, 'panel.pureOverallStyleDarkTip', '月光序曲，沉醉于夜的静谧雅致', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426134, 'showLogo', '是否显示logo', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426135, 'menuIcon', '菜单图标', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426136, 'status.pureLoad', '加载中...', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426137, 'files_filepath', '文件存储路径', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426138, 'quartzExecuteLog_duration', '执行时间', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426139, 'swagger', 'swagger', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426140, 'format_error', '格式错误', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426141, 'Searching_for_roles', '搜索角色', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426142, 'menus.pureAbnormal', '异常页面', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426143, 'download', '下载', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426144, 'quartzExecuteLog_jobGroup', '任务分组', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426145, 'menus.pureChildMenuOverflow', '菜单超出显示Tooltip文字提示', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426146, 'previousMenu', '上级菜单', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426147, 'buttons.pureSwitch', '切换', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426148, 'menus.pureResult', '结果页面', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426149, 'login.loginSuccess', '登录成功', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426150, 'personDescription', '个人详情', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426151, 'all', '全部', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426152, 'table.updateTime', '更新时间', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426153, 'hideTabs', '是否隐藏选项卡', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426154, 'level', '消息等级', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426155, 'menus.pureSelector', '范围选择器', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426156, 'menus.pureMessage', '消息提示', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426157, 'sort', '排序', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426158, 'buttons.pureReload', '重新加载', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426159, 'viewTemplate', '查看模板', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426160, 'login.purePrivacyPolicy', '《隐私政策》', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426161, 'adminUser_password', '密码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426162, 'doubleCheck', '再次确认是否继续？！', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426163, 'menus.pureWaterfall', '瀑布流无限滚动', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426164, 'menus.pureBoard', '艺术画板', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426165, 'login.purePassWordUpdateReg', '修改密码成功', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816398426166, 'menus.purePermission', '权限管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340674, 'login.pureVerifyCodeReg', '请输入验证码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340675, 'emailUsers', '邮件用户配置', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340676, 'menus.pureWavesurfer', '音频可视化', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340677, 'login.pureTickPrivacy', '请勾选隐私政策', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340678, 'menus.pureElButton', '按钮', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340679, 'quartzExecuteLog_jobName', '任务名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340680, 'status.systemMessage', '系统消息', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340681, 'delete', '删除', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340682, 'role_description', '角色详情', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340683, 'formatError', '格式错误', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340684, 'total', '总数', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340685, 'routerPathTip', '路由路径为必填项且为\"/\"开头', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340686, 'buttons.pureAccountSettings', '账户设置', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340687, 'login.getCodeInfo', '秒后获取验证码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340688, 'extra', '消息简介', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340689, 'menus.pureSuccess', '成功页面', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340690, 'login.getEmailCode', '获取验证码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340691, 'status.pureTodo', '待办', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340692, 'menus.pureFourZeroFour', '404', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340694, 'menus.pureUser', '用户管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340697, 'buttons.pureClickExpand', '点击展开', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340698, 'user_status', '用户状态', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340699, 'menus.pureSchemaForm', '表单', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340700, 'buttons.accountSettings', '账户设置', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340701, 'buttons.pureCloseAllTabs', '关闭全部标签页', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340702, 'fold_all', '折叠全部', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340703, 'buttons.pureLogin', '登录', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340704, 'search.pureHistory', '搜索历史', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340705, 'markAsUnread', '标为未读', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340706, 'menus.pureOperationLog', '操作日志', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340707, 'panel.pureStretchCustom', '自定义', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340708, 'security_log', '安全日志', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340709, 'greyStyle', '是否启用灰色模式', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340710, 'system_file', '系统文件管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340711, 'menus.purePiniaDoc', 'pinia', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340712, 'bytes', '字节', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340713, 'schedulers_description', '调度器详情信息', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340714, 'iconCode', '图标类名', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340715, 'adminUser_status', '状态', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340716, 'darkMode', '暗色主题', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340717, 'menus.pureBarcode', '条形码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340718, 'knife4j', 'knife4j', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816461340719, 'menus.pureUpload', '文件上传', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364097, 'schedulersGroup_description', '任务调度详情', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364098, 'user_details', '用户详情', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364099, 'op_time', '操作时间', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364100, 'menus.pureEditor', '编辑器', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364101, 'addNew', '新增', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364102, 'quartzExecuteLog', '任务执行日志', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364103, 'panel.pureOverallStyleLight', '浅色', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364104, 'danger', '危险', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364105, 'cover', '封面', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364106, 'userLoginLog_viewportWidth', '视口宽度', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364107, 'panel.pureGreyModel', '灰色模式', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364108, 'routerName', '路由名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364109, 'menus.pureCollapse', '折叠面板', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364110, 'menus.pureMenus', '多级菜单', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364111, 'panel.pureTagsStyle', '页签风格', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364112, 'upload_avatar', '上传头像', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364113, 'panel.pureHiddenFooter', '隐藏页脚', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364114, 'adminUser_summary', '简介', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364115, 'sidebarStatus', '侧边栏的状态', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364116, 'monitoring', '系统监控', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364117, 'menus.pureDept', '部门管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364118, 'i18n', '多语言管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364119, 'adminUser_avatar', '头像', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364120, 'userLoginLog_contentDpr', '设备像素比', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364121, 'input', '输入', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364122, 'menus.pureExcel', '导出Excel', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364123, 'login.purePhoneLogin', '手机登录', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364124, 'power_requestUrl', '请求URL', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364125, 'i18n.translation', '翻译', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364126, 'menuIcon_iconName', '图标名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364127, 'emailTemplate_type', '模板类型', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364128, 'update_information', '更新信息', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364129, 'userLoginLog_secChUaModel', '设备模型', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364130, 'menus.pureFlowChart', '流程图', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364131, 'unread', '未读', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364132, 'menus.pureSystemMenu', '菜单管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364133, 'menus.pureTag', '标签', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364134, 'userLoginLog_xRequestedWith', '请求方式', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364135, 'menus.pureTableBase', '基础用法', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364136, 'panel.pureTagsStyleCard', '卡片', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364137, 'files_fileType', '文件类型', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364138, 'iconify', 'iconify图标', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364139, 'lastLoginIp', 'IP地址', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364140, 'default', '默认', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364141, 'hiddenSideBar', '侧边栏是否隐藏', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364142, 'assign_roles', '分配角色', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364143, 'system_i18n', '多语言', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364144, 'menus.pureGuide', '引导页', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364145, 'markdown', 'Markdown', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364146, 'panel.pureTagsStyleChromeTip', '谷歌风格，经典美观', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364147, 'upload_success', '上传成功', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364148, 'menus.pureFourZeroOne', '403', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364149, 'userLoginLog_dpr', '设备像素比', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364150, 'menus.pureMenu2', '菜单二', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364151, 'email', '邮箱', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364152, 'menus.pureMenu1', '菜单1', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364153, 'role_roleCode', '角色码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364154, 'delete_success', '删除成功', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364155, 'keepAlive', '保持存活', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364156, 'image_size', '图像大小', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364157, 'messageReceivingManagement', '消息接收管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364158, 'login.pureSmsVerifyCode', '短信验证码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364159, 'menus.pureJsonEditor', 'JSON编辑器', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364160, 'login.purePhoneCorrectReg', '请输入正确的手机号码格式', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364161, 'buttons.pureTagsStyleCard', '卡片', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364162, 'cancel_delete', '取消删除', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364163, 'dept', '部门管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364164, 'login.pureSure', '确认密码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364165, 'login.login', '登录', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364166, 'search.pureEmpty', '暂无搜索结果', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364167, 'confirm', '确定', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364168, 'login.pureRememberInfo', '勾选并登录后，规定天数内无需输入用户名和密码会自动登入系统', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364169, 'menus.pureFormDesign', '表单设计器', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364170, 'menus.pureMenuTree', '菜单树结构', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364171, 'login.purePassWordRuleReg', '密码格式应为8-18位数字、字母、符号的任意两种组合', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364172, 'logManagement', '日志管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364173, 'i18n_typeName', '多语言类型名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364174, 'menus.pureExternalDoc', '文档外链', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364175, 'update_batches_parent', '批量更新父级', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364176, 'userLoginLog_ipRegion', 'IP归属地', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364177, 'panel.pureStretchFixedTip', '紧凑页面，轻松找到所需信息', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364178, 'menus.pureVxeTable', '虚拟滚动', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364179, 'login.pureBack', '返回', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816591364180, 'view', '查看', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278658, 'forcedOffline', '管理员强制下线', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278659, 'systemi18n', '多语言', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278660, 'quartzExecuteLog_jobClassName', '任务类名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278661, 'status.pureMessage', '消息', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278662, 'panel.pureTagsStyleSmart', '灵动', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278663, 'menus.pureProgress', '进度条', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278664, 'menus.pureInfiniteScroll', '表格无限滚动', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278665, 'login.pureWeChatLogin', '微信登录', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278666, 'schedulers_triggerState', '触发器状态', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278667, 'table.updateUser', '更新用户', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278668, 'menus.pureLogin', '登录', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278669, 'menus.pureComponents', '组件', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278670, 'iconName', '图标名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278671, 'menus.pureCropping', '图片裁剪', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278672, 'dept_manager', '管理员', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816654278673, 'no_data', '无数据', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107777, 'userLoginLog_userId', '用户ID', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107778, 'menus.home', '首页', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107779, 'menus.pureUiGradients', '渐变色', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107780, 'buttons.pureCloseCurrentTab', '关闭当前标签页', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107781, 'menus.purePrint', '打印', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107782, 'knife4j_Interface_documentation', 'knife4j接口文档', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107783, 'lastLoginIpAddress', '归属地', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107784, 'files_downloadCount', '下载量', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107785, 'emailTemplate_subject', '主题', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107786, 'buttons.pureConfirm', '确认', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107787, 'menus.pureFive', '500', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107788, 'menus.pureSysMonitor', '系统监控', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107789, 'userLoginLog_ipAddress', 'IP地址', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107790, 'hidden', '隐藏', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107791, 'submit', '提交', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107792, 'menus.pureMqtt', 'MQTT客户端(mqtt)', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107793, 'show', '显示', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107794, 'description', '详情', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107795, 'system_files', '后台文件管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107796, 'update', '更新', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107797, 'menus.pureFail', '失败页面', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107798, 'receivedUserIds', '接收用户', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107799, 'userLoginLog', '用户登录日志', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107800, 'contentTooShortTip', '内容不能少于30字', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107801, 'login.pureThirdLogin', '第三方登录', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107802, 'scheduler', '定时任务', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107803, 'login.pureInfo', '秒后重新获取', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107804, 'emailTemplate_templateName', '模板名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107805, 'account_management', '账户管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107806, 'continue_adding', '继续添加', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107807, 'adminUser_email', '邮箱', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107808, 'login.pureTip', '扫码后点击\"确认\"，即可完成登录', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107809, 'userinfo', '用户信息', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107810, 'systemCaches', '系统缓存', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107811, 'summary', '简介', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107812, 'normal', '正常', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107813, 'menus.purePermissionButton', '按钮权限', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107814, 'login.pureQQLogin', 'QQ登录', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107815, 'table.acceptanceTime', '接收时间', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107816, 'systemManagement', '系统管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107817, 'update_multilingual', '更新多语言', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107818, 'need_number', '需要数字', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107819, 'upload_user_avatar_tip', '上传头像成功不会自动保存', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107820, 'layout', '应用程序的布局', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107821, 'login.pureTest', '模拟测试', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107822, 'webConifg', 'web配置', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107823, 'adminUser', '后台用户', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107824, 'external_pages', '外部页面', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107825, 'appLocale', '本地语言', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107826, 'quartzExecuteLog_cronExpression', 'cron表达式', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107827, 'login.pureVerifyCodeSixReg', '请输入6位数字验证码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107828, 'menus.pureContextmenu', '右键菜单', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107829, 'panel.pureMixTip', '混合菜单，灵活多变', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107830, 'externalLink', '外链', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107831, 'panel.pureMultiTagsCache', '页签持久化', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107832, 'hideFooter', '是否隐藏页脚', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107833, 'markAsRead', '标为已读', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107834, 'login.username', '用户名', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107835, 'files_filename', '文件名', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107836, 'menus.pureQrcode', '二维码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107837, 'Interface_documentation', '接口文档', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107838, 'logout', '退出', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107839, 'menus.pureAble', '功能', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107840, 'menus.pureVideo', '视频', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107841, 'enable', '已启用', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107842, 'login.purePassword', '密码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107843, 'search.pureDragSort', '（可拖拽排序）', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107844, 'menus.pureSplitPane', '切割面板', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107845, 'menus.pureColorHuntDoc', '调色板', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107846, 'menus.pureGanttastic', '甘特图', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107847, 'menus.pureIconSelect', '图标选择器', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107848, 'buttons.pureTagsStyleChrome', '谷歌', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107849, 'login.pureWeiBoLogin', '微博登录', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107850, 'emailTemplate', '邮件模板', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107851, 'buttons.pureCloseRightTabs', '关闭右侧标签页', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107852, 'rest_password_tip', '忘记密码或重置密码，修改密码后会跳转到登录页重新登录', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107853, 'emailUsers_port', '端口', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107854, 'phone', '手机号', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107855, 'dept_summary', '部门简介', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107856, 'menus.pureDraggable', '拖拽', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107857, 'confirm_update_status', '确认修改状态吗', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107858, 'menus.purePinyin', '汉语拼音', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107859, 'primary', '默认', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107860, 'power_powerCode', '权限码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107861, 'userLoginLog_userAgent', '用户代理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107862, 'userLoginLog_secChUaMobile', '是否为手机设备', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107863, 'userLoginLog_downlink', '带宽', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107864, 'menus.pureSystemLog', '系统日志', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107865, 'login.emailCode', '输入验证码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107866, 'emailUsers_email', '邮箱', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107867, 'portion', '部分', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107868, 'login.pureReadAccept', '我已仔细阅读并接受', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107869, 'i18n.keyName', '多语言key', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107870, 'table.operation', '操作', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107871, 'external_chaining', '外链接', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107872, 'panel.pureHiddenTags', '隐藏标签页', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107873, 'login.pureVerifyCode', '验证码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107874, 'cropper_preview_tips', '温馨提示：右键上方裁剪区可开启功能菜单', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107875, 'weakStyle', '色弱模式', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816780107876, 'theme', '主题', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131202, 'menus.pureTimeline', '时间线', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131203, 'power', '权限管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131204, 'messageManagement', '消息管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131205, 'menus.purePdf', 'PDF预览', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131207, 'schedulers_triggerName', '触发器名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131208, 'menus.pureRouterDoc', 'vue-router', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131210, 'systemMenuIcon.officialWebsite', '菜单图标官网', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131211, 'login.pureRegisterSuccess', '注册成功', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131212, 'login.pureRemember', '天内免登录', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131213, 'panel.pureStretchFixed', '固定', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131214, 'menus.pureMenuOverflow', '目录超出显示Tooltip文字提示', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131215, 'not_added', '未添加', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131216, 'pure_admin', '后台管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131217, 'emailUsers_emailTemplate', '关联模板', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131218, 'login.pureAlipayLogin', '支付宝登录', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131219, 'menus.pureViteDoc', 'vite', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131220, 'componentPath', '组件路径', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131221, 'menus.pureMindMap', '思维导图', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131222, 'buttons.pureLoginOut', '退出系统', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131223, 'embedded_doc', '文档内嵌', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131224, 'menus.pureVueDoc', 'vue3', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131225, 'panel.pureOverallStyleSystemTip', '同步时光，界面随晨昏自然呼应', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131226, 'menus.pureOnlineUser', '在线用户', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131227, 'menus.pureDrawer', '函数式抽屉', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131228, 'buttons.pureOpenSystemSet', '打开系统配置', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131229, 'userLoginLog_secChUaPlatform', '操作系统/平台', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131230, 'panel.pureTagsStyleChrome', '谷歌', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131231, 'panel.pureStretch', '页宽', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131232, 'adminUser_sex', '性别', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131233, 'login.usernameRegex', '用户名格式错误', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131234, 'userLoginLog_secChUaArch', '平台架构', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131235, 'panel.pureClearCacheAndToLogin', '清空缓存并返回登录页', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131236, 'roleCode', '角色码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131237, 'emailTemplate_body', '模板内容', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131238, 'menus.purePermissionButtonRouter', '路由返回按钮权限', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131239, 'systemMaintenance', '系统维护', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131240, 'panel.pureVerticalTip', '左侧菜单，亲切熟悉', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131241, 'showModel', '要显示的模型', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131242, 'crop_and_upload_avatars', '裁剪、上传头像', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131243, 'visible', '隐藏', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131244, 'messageSendManagement', '消息发送管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131245, 'login.pureUsernameReg', '请输入账号', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131246, 'menus.pureSeamless', '无缝滚动', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131247, 'richText', '富文本', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131248, 'external_doc', '文档外链', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131249, 'pause', '暂停', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131250, 'panel.pureClearCache', '清空缓存', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131251, 'menus.pureExternalPage', '外部页面', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131252, 'menus.pureSensitive', '敏感词过滤', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131253, 'files', '文件', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131254, 'monitoring_server', '服务监控', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131255, 'schedulers_jobClassName', '任务类名', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131256, 'panel.pureTagsStyleSmartTip', '灵动标签，添趣生辉', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131257, 'admin_user', '用户管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131258, 'schedulersGroup_groupName', '分组名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131259, 'buttons.pureCloseOtherTabs', '关闭其他标签页', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131260, 'status.pureNoMessage', '暂无消息', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131261, 'confirmUpdateConfiguration', '确认修改配置吗？', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131262, 'configuration', '系统配置', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131263, 'update_success', '修改成功', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131264, 'schedulers_jobName', '任务名称', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131265, 'email_user_send_config', '邮件用户发送配置管理', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131266, 'routerNameTip', '路由名称为必填项', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131267, 'menus.pureUtilsLink', 'pure-admin-utils', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131268, 'menuIcon_preview', '图标预览', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131269, 'sendUserId', '发送用户', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131270, 'panel.pureTagsStyleCardTip', '卡片标签，高效浏览', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131271, 'menus.pureDateTimePicker', '日期时间选择器', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131272, 'confirm_forcedOffline', '确认强制此用户下线吗', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131273, 'menus.pureTailwindcssDoc', 'tailwindcss', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131274, 'menus.pureDanmaku', '弹幕', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131275, 'menus.pureDialog', '函数式弹框', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131276, 'menus.pureTable', '表格', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131277, 'confirm_update_sort', '是否确认更新排序', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131278, 'panel.pureLayoutModel', '导航模式', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131279, 'login.pureLoginSuccess', '登录成功', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131280, 'i18n_type_setting', '多语言类型', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131281, 'menus.pureEpDoc', 'element-plus', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131282, 'panel.pureSystemSet', '系统配置', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131283, 'login.pureLogin', '登录', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131284, 'panel.pureHorizontalTip', '顶部菜单，简洁概览', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131285, 'emailTemplate_emailUser', '邮件模板用户', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131286, 'login.pureForget', '忘记密码?', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131287, 'login.purePhoneReg', '请输入手机号码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131288, 'login.pureLoginFail', '登录失败', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131289, 'search.pureCollect', '收藏', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131290, 'buttons.pureClose', '关闭', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131291, 'deleteBatchPlaceholder', '输入 yes/YES/y/Y 来确认', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816910131292, 'download_configuration', '下载配置', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816973045761, 'download_json', '下载JSON', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816973045762, 'download_excel', '下载Excel', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816973045763, 'file_update', '文件更新', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816973045764, 'use_json_update', '使用JSON更新', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816973045765, 'use_excel_update', '使用Excel更新', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816973045766, 'update_tip', '更新时会完全替换当前所有内容（原有内容将被清除），请确保文件包含所有需要保留的数据。', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816973045767, 'reset_passwords', '重置密码', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816973045768, 'file_import', '文件导入', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);
INSERT INTO `sys_i18n` VALUES (1916083816973045769, 'requestMethod', '请求方法', 'en', 1, 1, '2025-04-26 18:55:56', '2025-04-26 18:55:56', 0);

-- ----------------------------
-- Table structure for sys_i18n_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_i18n_type`;
CREATE TABLE `sys_i18n_type`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '多语言类型(比如zh,en)',
  `summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '名称解释(比如中文,英文)',
  `is_default` tinyint NULL DEFAULT NULL COMMENT '是否为默认语言',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录文件最后修改的时间戳',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '文件是否被删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_type_name_deleted`(`type_name` ASC) USING BTREE COMMENT '唯一内容',
  INDEX `idx_type_name`(`type_name` ASC) USING BTREE,
  INDEX `idx_summary`(`summary` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '多语言类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_i18n_type
-- ----------------------------
INSERT INTO `sys_i18n_type` VALUES (1840386017158090753, 'zh', '中文', 1, 1, 1, '2025-04-26 21:02:57', '2024-09-30 05:39:54', 0);
INSERT INTO `sys_i18n_type` VALUES (1840402418253996034, 'en', '英语', 0, 1, 1, '2024-09-30 06:45:04', '2024-09-30 06:45:04', 0);

-- ----------------------------
-- Table structure for sys_menu_icon
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu_icon`;
CREATE TABLE `sys_menu_icon`  (
  `id` bigint NOT NULL,
  `icon_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'icon类名',
  `icon_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'icon 名称',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `icon_code`(`icon_code` ASC) USING BTREE COMMENT '图标code不能重复',
  INDEX `idx_icon_name`(`icon_name` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '图标code不能重复' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu_icon
-- ----------------------------
INSERT INTO `sys_menu_icon` VALUES (1837123533672370177, 'material-symbols:view-carousel', '轮播图', '2024-09-20 21:35:57', '2024-10-05 19:23:27', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1837127664847831041, 'line-md:iconify1', '消息', '2024-09-20 21:52:22', '2024-10-05 20:51:08', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1837128141505314817, 'line-md:email-filled', '邮箱', '2024-09-20 21:54:16', '2024-10-05 20:58:06', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1837128346233487361, 'material-symbols:router', '消息', '2024-09-20 21:55:05', '2024-10-05 20:57:56', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1837128498058903553, 'octicon:log-16', '日志', '2024-09-20 21:55:41', '2024-10-05 20:51:57', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1837128688530636802, 'ion:navigate', '导航', '2024-09-20 21:56:26', '2024-10-05 19:24:20', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1837128993204879361, 'grommet-icons:user-manager', '用户', '2024-09-20 21:57:39', '2024-10-05 19:24:13', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1837129632592969729, 'ic:round-manage-accounts', '用户管理', '2024-09-20 22:00:11', '2024-10-05 19:24:07', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1837129891234725890, 'fluent-mdl2:manager-self-service', '权限', '2024-09-20 22:01:13', '2024-10-05 19:24:01', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1837130085451972609, 'carbon:user-role', '权限', '2024-09-20 22:01:59', '2024-10-05 19:23:55', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1837130248237105154, 'oui:app-users-roles', '角色管理', '2024-09-20 22:02:38', '2024-10-05 19:23:47', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1837132226136653826, 'material-symbols:language', '国际化', '2024-09-20 22:10:30', '2024-10-05 19:23:38', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1837132285360226305, 'clarity:language-line', '国际化', '2024-09-20 22:10:44', '2024-10-05 19:23:41', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1837132323981377537, 'clarity:language-solid', '国际化', '2024-09-20 22:10:53', '2024-10-05 21:17:06', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1837132606656495617, 'carbon:router', '路由', '2024-09-20 22:12:00', '2024-10-05 19:23:20', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1841516265060802562, 'ion:albums-outline', '轮播图', '2024-10-03 00:31:06', '2024-10-05 20:51:50', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1843935459918163970, 'line-md:file-filled', '文件管理', '2024-10-09 16:44:07', '2024-10-09 16:44:07', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844291727040147458, 'fluent-mdl2:chart-template', '模板', '2024-10-10 16:19:48', '2024-10-28 10:09:44', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844660350732599297, 'carbon:cloud-monitoring', '系统监控', '2024-10-11 16:44:34', '2024-10-11 16:44:34', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844660527954526209, 'bxs:server', '服务', '2024-10-11 16:45:17', '2024-10-11 16:45:17', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844903931720433665, 'hugeicons:configuration-01', '系统配置', '2024-10-12 08:52:29', '2024-10-12 08:52:29', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844904858841972737, 'subway:menu', '菜单', '2024-10-12 08:56:10', '2024-10-12 08:56:10', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844905064786493441, 'tdesign:file-icon', '图标', '2024-10-12 08:56:59', '2024-10-12 08:56:59', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844931953475416065, 'raphael:db', 'db', '2024-10-12 10:43:50', '2024-10-12 10:43:50', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844932695623954433, 'devicon:redis', 'redis', '2024-10-12 10:46:46', '2024-10-12 10:46:46', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844933323939082242, 'material-symbols:terminal', 'terminal', '2024-10-12 10:49:16', '2024-10-12 10:49:16', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844933588884877314, 'simple-icons:minio', 'minio', '2024-10-12 10:50:19', '2024-10-12 10:50:19', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844933885178900482, 'mage:compact-disk', 'disk', '2024-10-12 10:51:30', '2024-10-12 10:51:30', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844935187489320962, 'devicon:swagger', 'swagger', '2024-10-12 10:56:41', '2024-10-12 10:56:41', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844935519208435714, 'file-icons:swagger', 'swagger', '2024-10-12 10:58:00', '2024-10-12 10:58:00', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844954519585890305, 'logos:element', '饿了么', '2024-10-12 12:13:30', '2024-10-12 12:13:30', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844954711328497665, 'file-icons:pure', 'pureadmin', '2024-10-12 12:14:15', '2024-10-12 12:14:15', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844955395549503489, 'mdi:iframe-outline', 'iframe', '2024-10-12 12:16:59', '2024-10-12 12:16:59', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844963007485640706, 'noto:letter-k', 'k', '2024-10-12 12:47:13', '2024-10-12 12:47:13', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844963373547716609, 'mdi:iframe-braces', 'iframe', '2024-10-12 12:48:41', '2024-10-12 12:48:41', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1844966804500971522, 'line-md:link', '链接', '2024-10-12 13:02:19', '2024-10-12 13:02:19', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1845817076322480129, 'simple-icons:apachedolphinscheduler', '任务调度', '2024-10-14 21:20:59', '2024-10-14 21:20:59', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1846832706716651521, 'uis:layer-group', '分组', '2024-10-17 16:36:44', '2024-10-17 16:36:44', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1846832884685164546, 'mingcute:time-fill', '时间', '2024-10-17 16:37:27', '2024-10-17 16:37:27', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1847144431877865474, 'icon-park-solid:log', '日志', '2024-10-18 13:15:26', '2024-10-18 13:15:26', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1847144521539502081, 'ph:log-bold', '日志', '2024-10-18 13:15:47', '2024-10-18 13:15:47', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1848233211644801026, 'ph:clock-user', '用户', '2024-10-21 13:21:51', '2024-10-21 13:21:51', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1848233345497624578, 'eos-icons:cronjob', '任务', '2024-10-21 13:22:23', '2024-10-21 13:22:23', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1848991874416324610, 'octicon:cache-16', '缓存', '2024-10-23 15:36:30', '2024-10-23 15:36:30', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1849278944816918529, 'vscode-icons:file-type-jsconfig', '配置', '2024-10-24 10:37:13', '2024-10-24 10:37:13', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1849677540270116865, 'mingcute:web-fill', 'web', '2024-10-25 13:01:06', '2024-10-25 13:01:06', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1849677639935168514, 'mingcute:server-fill', 'server', '2024-10-25 13:01:29', '2024-10-25 13:01:29', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1851511239723253761, 'lets-icons:message-alt-fill', '消息', '2024-10-30 14:27:34', '2024-10-30 15:26:57', 1849444494908125181, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1851511559568293890, 'hugeicons:message-edit-02', '消息管理', '2024-10-30 14:28:50', '2024-10-30 15:25:41', 1849444494908125181, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1851525682550214657, 'tabler:message-circle-cog', '消息', '2024-10-30 15:24:57', '2024-10-30 15:24:57', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1851527033812357121, 'wpf:gps-receiving', '接收消息', '2024-10-30 15:30:19', '2024-10-30 15:30:19', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1851527456963104769, 'grommet-icons:vm-maintenance', '系统维护', '2024-10-30 15:32:00', '2024-10-30 15:32:00', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1873365450202648578, 'file-icons:config-react', '系统配置', '2024-12-29 21:48:23', '2024-12-29 21:48:23', 1, 1, 0);
INSERT INTO `sys_menu_icon` VALUES (1915426199414087681, 'entypo:email', '邮箱', '2025-04-24 23:22:47', '2025-04-24 23:22:47', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_message
-- ----------------------------
DROP TABLE IF EXISTS `sys_message`;
CREATE TABLE `sys_message`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `title` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '消息标题',
  `send_user_id` bigint NULL DEFAULT NULL COMMENT '发送人用户ID',
  `message_type` bigint NULL DEFAULT NULL COMMENT 'sys:系统消息,user用户消息',
  `cover` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '封面',
  `summary` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '简介',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '消息内容',
  `editor_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '编辑器类型',
  `level` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '消息等级',
  `extra` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '消息等级详情',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_message_type`(`message_type` ASC) USING BTREE,
  INDEX `idx_editor_type`(`editor_type` ASC) USING BTREE,
  INDEX `idx_send_user_id`(`send_user_id` ASC) USING BTREE,
  INDEX `idx_level`(`level` ASC) USING BTREE,
  INDEX `idx_extra`(`extra` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统消息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_message
-- ----------------------------
INSERT INTO `sys_message` VALUES (1873378732024107009, '版本更新 2.2.0', 1, 1851507850609356802, 'http://116.196.101.14:9000/auth-admin/message/2024/12-29/6e6009cd-a4ec-4955-bb11-fa195e3d0d66.png', '版本更新', 'PHA+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMjI1LCA2MCwgNTcpOyBmb250LXNpemU6IDQ4cHg7Ij48c3Ryb25nPueJiOacrOabtOaWsCAyLjIuMDwvc3Ryb25nPjwvc3Bhbj48L3A+PHA+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMTQ2LCA4NCwgMjIyKTsiPjEuIDwvc3Bhbj48YSBocmVmPSJodHRwOi8vMTI5LjIxMS4zMS41ODozMDAwL2F1dGgvYXV0aC1zZXJ2ZXItamF2YS9jb21taXQvYjJlMmI4MDY5MjRmNDkyYWUyNGIwMzFkODJhNDY5ZmI4MjFkMDcyNCIgdGFyZ2V0PSIiIHN0eWxlPSJ0ZXh0LWFsaWduOiBzdGFydDsiPjxzcGFuIHN0eWxlPSJjb2xvcjogcmdiKDE0NiwgODQsIDIyMik7Ij7nvLrlsJHmm7TmlrDlrprml7bku7vliqHmjqXlj6M8L3NwYW4+PC9hPjwvcD48cD48c3BhbiBzdHlsZT0iY29sb3I6IHJnYigxNDYsIDg0LCAyMjIpOyI+Mi4gPC9zcGFuPjxhIGhyZWY9Imh0dHA6Ly8xMjkuMjExLjMxLjU4OjMwMDAvYXV0aC9hdXRoLXNlcnZlci1qYXZhL2NvbW1pdC82MTUzMzM3NWY4OGUwODFhOGJkZmEyMmVlMjljZmY5NDRjZGM3MjNkIiB0YXJnZXQ9IiIgc3R5bGU9InRleHQtYWxpZ246IHN0YXJ0OyI+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMTQ2LCA4NCwgMjIyKTsiPuS4u+mimOminOiJsua3u+WKoOagoemqjDwvc3Bhbj48L2E+PC9wPjxwPjxzcGFuIHN0eWxlPSJjb2xvcjogcmdiKDE0NiwgODQsIDIyMik7Ij4zLiA8L3NwYW4+PGEgaHJlZj0iaHR0cDovLzEyOS4yMTEuMzEuNTg6MzAwMC9hdXRoL2F1dGgtd2ViL2NvbW1pdC8wNGVmMGY3MDIwNTQ3NTAwMjg2M2YwNmFmMjk3NDU3NjJkYzkxNjVlIiB0YXJnZXQ9IiIgc3R5bGU9InRleHQtYWxpZ246IHN0YXJ0OyI+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMTQ2LCA4NCwgMjIyKTsiPiDmt7vliqDmtojmga/mj5DnpLo76KGo5qC86Led56a75LyY5YyWPC9zcGFuPjwvYT48L3A+PHA+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMTQ2LCA4NCwgMjIyKTsiPjQuIDwvc3Bhbj48YSBocmVmPSJodHRwOi8vMTI5LjIxMS4zMS41ODozMDAwL2F1dGgvYXV0aC13ZWIvY29tbWl0LzZhNzczODIwOTg4ZjA4MTNjMmU3NGY0YjlhMmJhZTQ2NTE0ZmNhNDgiIHRhcmdldD0iIiBzdHlsZT0idGV4dC1hbGlnbjogc3RhcnQ7Ij48c3BhbiBzdHlsZT0iY29sb3I6IHJnYigxNDYsIDg0LCAyMjIpOyI+5pel5b+X6KGo5qC85pi+56S66Zeu6aKYPC9zcGFuPjwvYT48L3A+', 'rich', 'success', '版本更新', '2024-12-29 22:41:10', '2024-12-29 22:41:10', 1, 1, 0);
INSERT INTO `sys_message` VALUES (1877006536699645953, '版本更新 2.4.9', 1, 1851507850609356802, 'http://116.196.101.14:9000/auth-admin/message/2025/01-08/f4d2f8ff-6fce-4b6b-a87c-8fdb2140c09b.jpg', '版本更新 2.4.9', 'PHA+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMjI1LCA2MCwgNTcpOyBmb250LXNpemU6IDQ4cHg7Ij7niYjmnKzmm7TmlrAgMi40Ljk8L3NwYW4+PC9wPjxoMT48c3BhbiBzdHlsZT0iY29sb3I6IHJnYigxNDYsIDg0LCAyMjIpOyI+MS4g5bCG5YmN56uv6YWN572u5paH5Lu25pS+5YWlUmVkaXPkuK3kuI3lho3ku47mlofku7bns7vnu5/or7vlj5Y8L3NwYW4+PC9oMT48aDEgc3R5bGU9ImxpbmUtaGVpZ2h0OiAxLjU7Ij48c3BhbiBzdHlsZT0iY29sb3I6IHJnYigyNTUsIDc3LCA3OSk7IGZvbnQtZmFtaWx5OiDmpbfkvZM7Ij48c3Ryb25nPuWmguaenOWPkeeOsOe9keermeaJk+W8gOeZveWxj+W+iOacieWPr+iDveaYr+WboOS4uuabtOaWsOmAoOaIkOeahO+8jOWboOS4uumcgOimgee7tOaKpOWIoOmZpOS4jemcgOimgeeahOWKn+iDveWPr+iDveS8muWvvOiHtOi/meS4quaDheWGtTwvc3Ryb25nPjwvc3Bhbj48L2gxPg==', 'rich', 'success', '版本更新', '2025-01-08 22:56:46', '2025-01-08 22:56:46', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_message_received
-- ----------------------------
DROP TABLE IF EXISTS `sys_message_received`;
CREATE TABLE `sys_message_received`  (
  `id` bigint NOT NULL COMMENT '主键',
  `received_user_id` bigint NULL DEFAULT NULL COMMENT '接受者用户ID',
  `message_id` bigint NULL DEFAULT NULL COMMENT '消息ID',
  `status` tinyint NULL DEFAULT 0 COMMENT '0:未读 1:已读',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_received_user_id`(`received_user_id` ASC) USING BTREE,
  INDEX `idx_message_id`(`message_id` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_message_received
-- ----------------------------
INSERT INTO `sys_message_received` VALUES (1873378732309319681, 1, 1873378732024107009, 1, '2024-12-29 22:41:10', '2025-03-24 21:58:49', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1873378732321902593, 1849444494908125181, 1873378732024107009, 1, '2024-12-29 22:41:10', '2024-12-30 18:27:07', 1849444494908125181, 1, 0);
INSERT INTO `sys_message_received` VALUES (1873378732326096897, 1849681227633758210, 1873378732024107009, 0, '2024-12-29 22:41:10', '2024-12-29 22:41:10', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1873378732326096898, 1850075157831454722, 1873378732024107009, 0, '2024-12-29 22:41:10', '2024-12-29 22:41:10', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1873378732330291202, 1850080272764211202, 1873378732024107009, 0, '2024-12-29 22:41:10', '2024-12-29 22:41:10', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1873378732330291203, 1850789068551200769, 1873378732024107009, 0, '2024-12-29 22:41:10', '2024-12-29 22:41:10', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1877006536917749761, 1, 1877006536699645953, 0, '2025-01-08 22:56:46', '2025-01-08 22:56:46', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1877006536921944066, 1849444494908125181, 1877006536699645953, 1, '2025-01-08 22:56:46', '2025-01-09 10:13:27', 1849444494908125181, 1, 0);
INSERT INTO `sys_message_received` VALUES (1877006536926138370, 1849681227633758210, 1877006536699645953, 0, '2025-01-08 22:56:46', '2025-01-08 22:56:46', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1877006536930332673, 1850075157831454722, 1877006536699645953, 0, '2025-01-08 22:56:46', '2025-01-08 22:56:46', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1877006536930332674, 1850080272764211202, 1877006536699645953, 0, '2025-01-08 22:56:46', '2025-01-08 22:56:46', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1877006536934526977, 1850789068551200769, 1877006536699645953, 0, '2025-01-08 22:56:46', '2025-01-08 22:56:46', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_message_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_message_type`;
CREATE TABLE `sys_message_type`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `message_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '消息名称',
  `message_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '消息类型',
  `summary` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '消息备注',
  `status` tinyint NULL DEFAULT NULL COMMENT '0:启用 1:禁用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '是否被删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_message_type`(`message_type` ASC) USING BTREE,
  INDEX `idx_message_name`(`message_name` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统消息类型' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_message_type
-- ----------------------------
INSERT INTO `sys_message_type` VALUES (1851498066518687745, '用户消息类型', 'user', '用户消息类型啊', 1, '2024-10-30 13:35:13', '2025-04-26 22:10:21', 1, 1, 0);
INSERT INTO `sys_message_type` VALUES (1851507850609356802, '系统消息类型', 'sys', '系统消息类型', 1, '2024-10-30 14:14:06', '2025-04-26 22:10:56', 1, 1, 0);
INSERT INTO `sys_message_type` VALUES (1851894134725136386, '通知消息', 'notifications', '通知消息，用户用户接受通知消息', 1, '2024-10-31 15:49:03', '2024-10-31 15:49:03', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_permission`;
CREATE TABLE `sys_permission`  (
  `id` bigint NOT NULL COMMENT '权限ID',
  `parent_id` bigint NULL DEFAULT NULL COMMENT '父级id',
  `power_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限编码',
  `power_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '权限名称',
  `request_url` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '请求路径',
  `request_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求方法',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '是否删除，0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE,
  INDEX `idx_power_name`(`power_name` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间',
  INDEX `power_code`(`power_code` ASC, `power_name` ASC, `request_method` ASC) USING BTREE,
  FULLTEXT INDEX `idx_request_url`(`request_url`),
  FULLTEXT INDEX `idx_request_method`(`request_method`) COMMENT '索引请求方法'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_permission
-- ----------------------------
INSERT INTO `sys_permission` VALUES (1849471636643618818, 0, 'admin::actuator', 'actuator端点访问', NULL, NULL, '2025-04-28 17:30:04', '2025-04-28 17:30:04', 1, 1, 0);
INSERT INTO `sys_permission` VALUES (1849471846698557442, 1849471636643618818, 'actuator::all', 'Springboot端点全部可以访问', '/api/actuator/**', NULL, '2025-04-28 17:30:04', '2025-04-28 17:30:04', 1, 1, 0);
INSERT INTO `sys_permission` VALUES (1916799569930055682, 0, 'user::user', '用户信息', '/api/user/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799569959415809, 1916799569930055682, 'user::delete', '删除用户', '/api/user', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799569967804418, 1916799569930055682, 'user::add', '添加', '/api/user', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799569967804419, 1916799569930055682, 'user::query', '分页查询', '/api/user/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:27', NULL, 1, 0);
INSERT INTO `sys_permission` VALUES (1916799569967804420, 1916799569930055682, 'user::update', '更新', '/api/user', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799569971998721, 1916799569930055682, 'user::update', '强制退出', '/api/user/forcedOffline', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799569992970241, 0, 'user::menuIcon', '系统菜单图标', '/api/menuIcon/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570005553153, 1916799569992970241, 'menuIcon::update', '更新', '/api/menuIcon', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570005553154, 1916799569992970241, 'menuIcon::query', '分页查询', '/api/menuIcon/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570005553155, 1916799569992970241, 'menuIcon::add', '添加', '/api/menuIcon', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570005553156, 1916799569992970241, 'menuIcon::delete', '删除', '/api/menuIcon', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570026524674, 0, 'user::routerRole', '路由和角色', '/api/routerRole/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570039107585, 1916799570026524674, 'routerRole::delete', '清除选中菜单所有角色', '/api/routerRole/clearRouterRole', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570055884802, 0, 'user::config', '系统配置', '/api/config/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570064273409, 1916799570055884802, 'config::update', '更新web配置文件', '/api/config', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570085244929, 0, 'user::messageReceived', '消息接收(用户消息)', '/api/messageReceived/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570097827841, 1916799570085244929, 'messageReceived::update', '更新', '/api/messageReceived', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570097827842, 1916799570085244929, 'messageReceived::query', '分页查询', '/api/messageReceived/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570097827843, 1916799570085244929, 'messageReceived::delete', '删除', '/api/messageReceived', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570114605057, 0, 'user::permission', '系统权限', '/api/permission/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570127187969, 1916799570114605057, 'permission::update', '批量修改权限父级', '/api/permission/update/permissionListByParentId', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570131382274, 1916799570114605057, 'permission::update', '导出权限', '/api/permission/file/export', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570131382275, 1916799570114605057, 'permission::update', '更新', '/api/permission', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570131382276, 1916799570114605057, 'permission::page', '分页查询', '/api/permission/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570131382277, 1916799570114605057, 'permission::delete', '删除', '/api/permission', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570131382278, 1916799570114605057, 'permission::add', '添加', '/api/permission', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570139770881, 1916799570114605057, 'permission::update', '导入权限', '/api/permission/file/import', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570164936706, 0, 'user::rolePermission', '系统角色和权限', '/api/rolePermission/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570173325313, 1916799570164936706, 'rolePermission::update', '为角色分配权限', '/api/rolePermission', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570185908225, 0, 'user::emailUsers', '邮箱用户发送配置', '/api/emailUsers/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570202685441, 1916799570185908225, 'emailUsers::add', '添加', '/api/emailUsers', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570202685442, 1916799570185908225, 'emailUsers::delete', '删除', '/api/emailUsers', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570202685443, 1916799570185908225, 'emailUsers::query', '分页查询', '/api/emailUsers/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570202685444, 1916799570185908225, 'emailUsers::update', '更新', '/api/emailUsers', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570227851265, 0, 'user::i18n', '多语言', '/api/i18n/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570240434177, 1916799570227851265, 'i18n::update', '文件导入多语言', '/api/i18n/file', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570244628481, 1916799570227851265, 'i18n::query', '分页查询', '/api/i18n/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570244628482, 1916799570227851265, 'i18n::update', '文件导出多语言', '/api/i18n/file', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570244628483, 1916799570227851265, 'i18n::update', '更新', '/api/i18n', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570244628484, 1916799570227851265, 'i18n::delete', '删除', '/api/i18n', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570244628485, 1916799570227851265, 'i18n::add', '添加', '/api/i18n', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570269794306, 0, 'user::scheduleExecuteLog', '调度任务执行日志', '/api/scheduleExecuteLog/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570290765825, 1916799570269794306, 'scheduleExecuteLog::query', '分页查询', '/api/scheduleExecuteLog/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570290765826, 1916799570269794306, 'scheduleExecuteLog::delete', '删除', '/api/scheduleExecuteLog', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570307543041, 0, 'user::messageType', '系统消息类型', '/api/messageType/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570320125953, 1916799570307543041, 'messageType::delete', '删除', '/api/messageType', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570324320257, 1916799570307543041, 'messageType::query', '分页查询', '/api/messageType/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570324320258, 1916799570307543041, 'messageType::update', '更新', '/api/messageType', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570324320259, 1916799570307543041, 'messageType::add', '添加', '/api/messageType', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570341097474, 0, 'user::files', '系统文件表', '/api/files/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570357874690, 1916799570341097474, 'files::query', '分页查询', '/api/files/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570362068994, 1916799570341097474, 'files::update', '更新', '/api/files', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570362068995, 1916799570341097474, 'files::delete', '删除', '/api/files', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570362068996, 1916799570341097474, 'files::query', '下载文件', '/api/files/file/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570362068997, 1916799570341097474, 'files::add', '添加', '/api/files', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570383040514, 0, 'user::message', '系统消息', '/api/message/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570395623426, 1916799570383040514, 'message::query', '分页查询', '/api/message/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570404012034, 1916799570383040514, 'message::delete', '删除', '/api/message', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570404012035, 1916799570383040514, 'message::update', '更新', '/api/message', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570404012036, 1916799570383040514, 'message::add', '添加', '/api/message', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570420789250, 0, 'user::schedulers', '调度任务', '/api/schedulers/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570433372162, 1916799570420789250, 'schedulers::update', '恢复任务', '/api/schedulers/resume', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570433372163, 1916799570420789250, 'schedulers::query', '分页查询', '/api/schedulers/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570433372164, 1916799570420789250, 'schedulers::add', '添加', '/api/schedulers', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570433372165, 1916799570420789250, 'schedulers::delete', '删除', '/api/schedulers', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570433372166, 1916799570420789250, 'schedulers::update', '更新', '/api/schedulers', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570437566465, 1916799570420789250, 'schedulers::update', '暂停任务', '/api/schedulers/pause', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570462732290, 0, 'user::dept', '系统部门', '/api/dept/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570466926594, 1916799570462732290, 'dept::query', '分页查询部门', '/api/dept/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:29:47', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570466926595, 1916799570462732290, 'dept::delete', '删除部门', '/api/dept', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:29:17', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570466926596, 1916799570462732290, 'dept::add', '添加部门', '/api/dept', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:29:18', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570466926597, 1916799570462732290, 'dept::update', '更新部门', '/api/dept', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:29:19', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570487898113, 0, 'user::userRole', '用户和角色', '/api/userRole/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570508869634, 1916799570487898113, 'user::add', '为用户分配角色', '/api/userRole', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570521452545, 0, 'user::userLoginLog', '用户登录日志', '/api/userLoginLog/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570534035457, 1916799570521452545, 'userLoginLog::delete', '删除', '/api/userLoginLog', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570534035458, 1916799570521452545, 'userLoginLog::query', '分页查询', '/api/userLoginLog/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570542424065, 0, 'user::router', '系统路由', '/api/router/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570559201281, 1916799570542424065, 'router::update', '更新', '/api/router', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570559201282, 1916799570542424065, 'router::delete', '删除', '/api/router', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570559201283, 1916799570542424065, 'router::add', '添加', '/api/router', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570559201284, 1916799570542424065, 'router::query', '查询管理菜单列表', '/api/router/routerList', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570580172802, 0, 'user::emailTemplate', '邮件模板', '/api/emailTemplate/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570596950017, 1916799570580172802, 'emailTemplate::add', '添加', '/api/emailTemplate', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570596950018, 1916799570580172802, 'emailTemplate::delete', '删除', '/api/emailTemplate', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570596950019, 1916799570580172802, 'emailTemplate::query', '分页查询', '/api/emailTemplate/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570596950020, 1916799570580172802, 'emailTemplate::update', '更新', '/api/emailTemplate', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570613727234, 0, 'user::role', '系统角色', '/api/role/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570617921538, 1916799570613727234, 'role::update', '导出角色列表', '/api/role/file/export', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570617921539, 1916799570613727234, 'role::update', '更新角色列表', '/api/role/file/import', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570622115842, 1916799570613727234, 'role::query', '分页查询角色', '/api/role/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570622115843, 1916799570613727234, 'role::add', '添加', '/api/role', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570622115844, 1916799570613727234, 'role::update', '更新', '/api/role', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570622115845, 1916799570613727234, 'role::delete', '删除', '/api/role', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570634698753, 0, 'user::i18nType', '多语言类型', '/api/i18nType/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570647281665, 1916799570634698753, 'i18nType::query', '添加', '/api/i18nType', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570647281666, 1916799570634698753, 'i18nType::update', '更新', '/api/i18nType', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570647281667, 1916799570634698753, 'i18nType::delete', '删除', '/api/i18nType', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570655670274, 0, 'user::schedulersGroup', '任务调度分组', '/api/schedulersGroup/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570672447490, 1916799570655670274, 'schedulersGroup::add', '添加', '/api/schedulersGroup', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570672447491, 1916799570655670274, 'schedulersGroup::query', '分页查询', '/api/schedulersGroup/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570672447492, 1916799570655670274, 'schedulersGroup::query', '获取所有任务调度分组', '/api/schedulersGroup/getSchedulersGroupList', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570672447493, 1916799570655670274, 'schedulersGroup::delete', '删除', '/api/schedulersGroup', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570672447494, 1916799570655670274, 'schedulersGroup::update', '更新', '/api/schedulersGroup', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` bigint NOT NULL,
  `role_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色代码',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `role_code`(`role_code` ASC) USING BTREE COMMENT '角色码不能重复',
  INDEX `idx_description`(`description` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, 'admin', '管理员用户', '2025-04-28 17:38:59', '2025-04-28 18:27:26', 1, 1849681227633758210, 0);
INSERT INTO `sys_role` VALUES (1852621694771773442, 'actuator', 'actuator端点可访问', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1915784833780183043, 'page::system::dept', '系统部门', '2025-04-28 17:38:59', '2025-04-28 18:27:28', 1, 1849681227633758210, 0);
INSERT INTO `sys_role` VALUES (1915784833780183044, 'page::system::files', '系统文件', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1915784833780183045, 'page::system::power', '系统权限', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1915784833780183046, 'page::system::role', '系统角色', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1915784833796960257, 'page::system::rolePower', '系统角色和权限', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1915784833796960258, 'page::system::router', '系统路由', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1915784833796960259, 'page::system::routerRole', '系统路由和角色', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1915786941359206409, 'page::system::user', '系统用户管理', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1915786941359206410, 'page::system::userRole', '系统用户和角色', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229422989313, 'page::extend', '外部页面', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903873, 'page::config::menuIcon', '菜单图标', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903874, 'page::config::email-user', '邮件用户配置', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903875, 'page::config::web-configuration', 'web配置', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903876, 'page::config::email-template', '邮件模板', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903877, 'page::monitor::server', '服务监控', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903878, 'page::monitor::caches', '系统缓存', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903879, 'page::scheduler::schedulers', '调度任务', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903880, 'page::scheduler::schedulers-group', '任务调度分组', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903881, 'page::i18n::i18n-setting', '多语言', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903882, 'page::i18n::i18n-type-setting', '多语言类型', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903883, 'page::logManagement::user-login-log', '任务执行日志', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903884, 'page::logManagement::scheduler-execute-log', '用户登录日志', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903885, 'page::message::message-type', '消息类型', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903886, 'page::message::message-send', '消息发送管理', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903887, 'page::message::message-editing', '消息编辑', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1916789229485903888, 'page::message::message-received', '消息接收管理', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_role_permission
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_permission`;
CREATE TABLE `sys_role_permission`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `role_id` bigint NOT NULL COMMENT '角色id',
  `power_id` bigint NOT NULL COMMENT '权限id',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '是否删除，0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_role_power`(`role_id` ASC, `power_id` ASC) USING BTREE COMMENT '角色和权限两种不能重复',
  INDEX `idx_role_id`(`role_id` ASC) USING BTREE,
  INDEX `idx_power_id`(`power_id` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间',
  CONSTRAINT `sys_role_permission_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_role_permission_ibfk_2` FOREIGN KEY (`power_id`) REFERENCES `sys_permission` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统角色权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_permission
-- ----------------------------
INSERT INTO `sys_role_permission` VALUES (1916794765916864513, 1852621694771773442, 1849471636643618818, '2025-04-28 18:00:59', '2025-04-28 18:00:59', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916794765916864514, 1852621694771773442, 1849471846698557442, '2025-04-28 18:00:59', '2025-04-28 18:00:59', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916795712181207041, 1916789229485903878, 1849471636643618818, '2025-04-28 18:04:45', '2025-04-28 18:04:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916795712181207042, 1916789229485903878, 1849471846698557442, '2025-04-28 18:04:45', '2025-04-28 18:04:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799774297505794, 1915784833780183043, 1916799570462732290, '2025-04-28 18:20:53', '2025-04-28 18:20:53', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799774297505795, 1915784833780183043, 1916799570466926594, '2025-04-28 18:20:53', '2025-04-28 18:20:53', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799774297505796, 1915784833780183043, 1916799570466926595, '2025-04-28 18:20:53', '2025-04-28 18:20:53', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799774297505797, 1915784833780183043, 1916799570466926596, '2025-04-28 18:20:53', '2025-04-28 18:20:53', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799774297505798, 1915784833780183043, 1916799570466926597, '2025-04-28 18:20:53', '2025-04-28 18:20:53', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799875044687873, 1915784833780183044, 1916799570341097474, '2025-04-28 18:21:17', '2025-04-28 18:21:17', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799875053076481, 1915784833780183044, 1916799570357874690, '2025-04-28 18:21:17', '2025-04-28 18:21:17', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799875053076482, 1915784833780183044, 1916799570362068994, '2025-04-28 18:21:17', '2025-04-28 18:21:17', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799875053076483, 1915784833780183044, 1916799570362068995, '2025-04-28 18:21:17', '2025-04-28 18:21:17', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799875053076484, 1915784833780183044, 1916799570362068996, '2025-04-28 18:21:17', '2025-04-28 18:21:17', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799875053076485, 1915784833780183044, 1916799570362068997, '2025-04-28 18:21:17', '2025-04-28 18:21:17', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799911329611777, 1915784833780183045, 1916799570114605057, '2025-04-28 18:21:26', '2025-04-28 18:21:26', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799911329611778, 1915784833780183045, 1916799570127187969, '2025-04-28 18:21:26', '2025-04-28 18:21:26', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799911329611779, 1915784833780183045, 1916799570131382274, '2025-04-28 18:21:26', '2025-04-28 18:21:26', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799911329611780, 1915784833780183045, 1916799570131382275, '2025-04-28 18:21:26', '2025-04-28 18:21:26', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799911329611781, 1915784833780183045, 1916799570131382276, '2025-04-28 18:21:26', '2025-04-28 18:21:26', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799911329611782, 1915784833780183045, 1916799570131382277, '2025-04-28 18:21:26', '2025-04-28 18:21:26', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799911329611783, 1915784833780183045, 1916799570131382278, '2025-04-28 18:21:26', '2025-04-28 18:21:26', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799911329611784, 1915784833780183045, 1916799570139770881, '2025-04-28 18:21:26', '2025-04-28 18:21:26', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799991184965633, 1915784833780183046, 1916799570164936706, '2025-04-28 18:21:45', '2025-04-28 18:21:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799991184965634, 1915784833780183046, 1916799570173325313, '2025-04-28 18:21:45', '2025-04-28 18:21:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799991184965635, 1915784833780183046, 1916799570613727234, '2025-04-28 18:21:45', '2025-04-28 18:21:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799991184965636, 1915784833780183046, 1916799570617921538, '2025-04-28 18:21:45', '2025-04-28 18:21:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799991184965637, 1915784833780183046, 1916799570617921539, '2025-04-28 18:21:45', '2025-04-28 18:21:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799991184965638, 1915784833780183046, 1916799570622115842, '2025-04-28 18:21:45', '2025-04-28 18:21:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799991184965639, 1915784833780183046, 1916799570622115843, '2025-04-28 18:21:45', '2025-04-28 18:21:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799991184965640, 1915784833780183046, 1916799570622115844, '2025-04-28 18:21:45', '2025-04-28 18:21:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799991184965641, 1915784833780183046, 1916799570622115845, '2025-04-28 18:21:45', '2025-04-28 18:21:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800021241348097, 1915784833796960257, 1916799570164936706, '2025-04-28 18:21:52', '2025-04-28 18:21:52', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800021241348098, 1915784833796960257, 1916799570173325313, '2025-04-28 18:21:52', '2025-04-28 18:21:52', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800082159419394, 1915784833796960258, 1916799570542424065, '2025-04-28 18:22:07', '2025-04-28 18:22:07', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800082159419395, 1915784833796960258, 1916799570559201281, '2025-04-28 18:22:07', '2025-04-28 18:22:07', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800082159419396, 1915784833796960258, 1916799570559201282, '2025-04-28 18:22:07', '2025-04-28 18:22:07', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800082159419397, 1915784833796960258, 1916799570559201283, '2025-04-28 18:22:07', '2025-04-28 18:22:07', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800082159419398, 1915784833796960258, 1916799570559201284, '2025-04-28 18:22:07', '2025-04-28 18:22:07', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800111800565762, 1915784833796960259, 1916799570026524674, '2025-04-28 18:22:14', '2025-04-28 18:22:14', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800111800565763, 1915784833796960259, 1916799570039107585, '2025-04-28 18:22:14', '2025-04-28 18:22:14', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800196475174913, 1915786941359206409, 1916799569930055682, '2025-04-28 18:22:34', '2025-04-28 18:22:34', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800196475174914, 1915786941359206409, 1916799569959415809, '2025-04-28 18:22:34', '2025-04-28 18:22:34', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800196475174915, 1915786941359206409, 1916799569967804418, '2025-04-28 18:22:34', '2025-04-28 18:22:34', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800196475174916, 1915786941359206409, 1916799569967804419, '2025-04-28 18:22:34', '2025-04-28 18:22:34', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800196475174917, 1915786941359206409, 1916799569967804420, '2025-04-28 18:22:34', '2025-04-28 18:22:34', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800196475174918, 1915786941359206409, 1916799569971998721, '2025-04-28 18:22:34', '2025-04-28 18:22:34', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800196475174919, 1915786941359206409, 1916799570508869634, '2025-04-28 18:22:34', '2025-04-28 18:22:34', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800196475174920, 1915786941359206409, 1916799570487898113, '2025-04-28 18:22:34', '2025-04-28 18:22:34', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800308119158785, 1915786941359206410, 1916799570487898113, '2025-04-28 18:23:01', '2025-04-28 18:23:01', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800308119158786, 1915786941359206410, 1916799570508869634, '2025-04-28 18:23:01', '2025-04-28 18:23:01', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800350112530433, 1916789229422989313, 1849471636643618818, '2025-04-28 18:23:11', '2025-04-28 18:23:11', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800350112530434, 1916789229422989313, 1849471846698557442, '2025-04-28 18:23:11', '2025-04-28 18:23:11', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800374699540482, 1916789229485903873, 1916799569992970241, '2025-04-28 18:23:16', '2025-04-28 18:23:16', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800374699540483, 1916789229485903873, 1916799570005553153, '2025-04-28 18:23:16', '2025-04-28 18:23:16', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800374699540484, 1916789229485903873, 1916799570005553154, '2025-04-28 18:23:16', '2025-04-28 18:23:16', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800374699540485, 1916789229485903873, 1916799570005553155, '2025-04-28 18:23:16', '2025-04-28 18:23:16', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800374699540486, 1916789229485903873, 1916799570005553156, '2025-04-28 18:23:16', '2025-04-28 18:23:16', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800491376689154, 1916789229485903874, 1916799570185908225, '2025-04-28 18:23:44', '2025-04-28 18:23:44', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800491376689155, 1916789229485903874, 1916799570202685441, '2025-04-28 18:23:44', '2025-04-28 18:23:44', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800491376689156, 1916789229485903874, 1916799570202685442, '2025-04-28 18:23:44', '2025-04-28 18:23:44', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800491376689157, 1916789229485903874, 1916799570202685443, '2025-04-28 18:23:44', '2025-04-28 18:23:44', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800491376689158, 1916789229485903874, 1916799570202685444, '2025-04-28 18:23:44', '2025-04-28 18:23:44', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800533038710785, 1916789229485903875, 1916799570064273409, '2025-04-28 18:23:54', '2025-04-28 18:23:54', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800533038710786, 1916789229485903875, 1916799570055884802, '2025-04-28 18:23:54', '2025-04-28 18:23:54', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800554924589058, 1916789229485903876, 1916799570580172802, '2025-04-28 18:23:59', '2025-04-28 18:23:59', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800554924589059, 1916789229485903876, 1916799570596950017, '2025-04-28 18:23:59', '2025-04-28 18:23:59', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800554924589060, 1916789229485903876, 1916799570596950018, '2025-04-28 18:23:59', '2025-04-28 18:23:59', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800554924589061, 1916789229485903876, 1916799570596950019, '2025-04-28 18:23:59', '2025-04-28 18:23:59', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800554924589062, 1916789229485903876, 1916799570596950020, '2025-04-28 18:23:59', '2025-04-28 18:23:59', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800571827634178, 1916789229485903877, 1849471636643618818, '2025-04-28 18:24:03', '2025-04-28 18:24:03', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800571827634179, 1916789229485903877, 1849471846698557442, '2025-04-28 18:24:03', '2025-04-28 18:24:03', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800644976295937, 1916789229485903879, 1916799570420789250, '2025-04-28 18:24:21', '2025-04-28 18:24:21', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800644976295938, 1916789229485903879, 1916799570433372162, '2025-04-28 18:24:21', '2025-04-28 18:24:21', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800644976295939, 1916789229485903879, 1916799570433372163, '2025-04-28 18:24:21', '2025-04-28 18:24:21', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800644976295940, 1916789229485903879, 1916799570433372164, '2025-04-28 18:24:21', '2025-04-28 18:24:21', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800644976295941, 1916789229485903879, 1916799570433372165, '2025-04-28 18:24:21', '2025-04-28 18:24:21', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800644976295942, 1916789229485903879, 1916799570433372166, '2025-04-28 18:24:21', '2025-04-28 18:24:21', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800644976295943, 1916789229485903879, 1916799570437566465, '2025-04-28 18:24:21', '2025-04-28 18:24:21', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800678174212097, 1916789229485903880, 1916799570655670274, '2025-04-28 18:24:29', '2025-04-28 18:24:29', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800678174212098, 1916789229485903880, 1916799570672447490, '2025-04-28 18:24:29', '2025-04-28 18:24:29', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800678174212099, 1916789229485903880, 1916799570672447491, '2025-04-28 18:24:29', '2025-04-28 18:24:29', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800678174212100, 1916789229485903880, 1916799570672447492, '2025-04-28 18:24:29', '2025-04-28 18:24:29', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800678174212101, 1916789229485903880, 1916799570672447493, '2025-04-28 18:24:29', '2025-04-28 18:24:29', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800678174212102, 1916789229485903880, 1916799570672447494, '2025-04-28 18:24:29', '2025-04-28 18:24:29', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800711170801665, 1916789229485903881, 1916799570227851265, '2025-04-28 18:24:37', '2025-04-28 18:24:37', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800711170801666, 1916789229485903881, 1916799570240434177, '2025-04-28 18:24:37', '2025-04-28 18:24:37', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800711170801667, 1916789229485903881, 1916799570244628481, '2025-04-28 18:24:37', '2025-04-28 18:24:37', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800711170801668, 1916789229485903881, 1916799570244628482, '2025-04-28 18:24:37', '2025-04-28 18:24:37', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800711170801669, 1916789229485903881, 1916799570244628483, '2025-04-28 18:24:37', '2025-04-28 18:24:37', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800711170801670, 1916789229485903881, 1916799570244628484, '2025-04-28 18:24:37', '2025-04-28 18:24:37', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800711170801671, 1916789229485903881, 1916799570244628485, '2025-04-28 18:24:37', '2025-04-28 18:24:37', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800747761909762, 1916789229485903882, 1916799570634698753, '2025-04-28 18:24:45', '2025-04-28 18:24:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800747761909763, 1916789229485903882, 1916799570647281665, '2025-04-28 18:24:45', '2025-04-28 18:24:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800747761909764, 1916789229485903882, 1916799570647281666, '2025-04-28 18:24:45', '2025-04-28 18:24:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800747761909765, 1916789229485903882, 1916799570647281667, '2025-04-28 18:24:45', '2025-04-28 18:24:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800797443440641, 1916789229485903883, 1916799570269794306, '2025-04-28 18:24:57', '2025-04-28 18:24:57', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800797443440642, 1916789229485903883, 1916799570290765825, '2025-04-28 18:24:57', '2025-04-28 18:24:57', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800797443440643, 1916789229485903883, 1916799570290765826, '2025-04-28 18:24:57', '2025-04-28 18:24:57', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800948065091585, 1916789229485903884, 1916799570521452545, '2025-04-28 18:25:33', '2025-04-28 18:25:33', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800948065091586, 1916789229485903884, 1916799570534035457, '2025-04-28 18:25:33', '2025-04-28 18:25:33', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916800948065091587, 1916789229485903884, 1916799570534035458, '2025-04-28 18:25:33', '2025-04-28 18:25:33', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801009553588226, 1916789229485903885, 1916799570307543041, '2025-04-28 18:25:48', '2025-04-28 18:25:48', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801009553588227, 1916789229485903885, 1916799570320125953, '2025-04-28 18:25:48', '2025-04-28 18:25:48', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801009553588228, 1916789229485903885, 1916799570324320257, '2025-04-28 18:25:48', '2025-04-28 18:25:48', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801009553588229, 1916789229485903885, 1916799570324320258, '2025-04-28 18:25:48', '2025-04-28 18:25:48', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801009553588230, 1916789229485903885, 1916799570324320259, '2025-04-28 18:25:48', '2025-04-28 18:25:48', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801128759902209, 1916789229485903886, 1916799570383040514, '2025-04-28 18:26:16', '2025-04-28 18:26:16', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801128759902210, 1916789229485903886, 1916799570395623426, '2025-04-28 18:26:16', '2025-04-28 18:26:16', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801128759902211, 1916789229485903886, 1916799570404012034, '2025-04-28 18:26:16', '2025-04-28 18:26:16', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801128759902212, 1916789229485903886, 1916799570404012035, '2025-04-28 18:26:16', '2025-04-28 18:26:16', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801128759902213, 1916789229485903886, 1916799570404012036, '2025-04-28 18:26:16', '2025-04-28 18:26:16', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801207122083841, 1916789229485903887, 1916799570383040514, '2025-04-28 18:26:35', '2025-04-28 18:26:35', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801207122083842, 1916789229485903887, 1916799570395623426, '2025-04-28 18:26:35', '2025-04-28 18:26:35', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801207122083843, 1916789229485903887, 1916799570404012034, '2025-04-28 18:26:35', '2025-04-28 18:26:35', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801207122083844, 1916789229485903887, 1916799570404012035, '2025-04-28 18:26:35', '2025-04-28 18:26:35', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801207122083845, 1916789229485903887, 1916799570404012036, '2025-04-28 18:26:35', '2025-04-28 18:26:35', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801249300004866, 1916789229485903888, 1916799570085244929, '2025-04-28 18:26:45', '2025-04-28 18:26:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801249300004867, 1916789229485903888, 1916799570097827841, '2025-04-28 18:26:45', '2025-04-28 18:26:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801249300004868, 1916789229485903888, 1916799570097827842, '2025-04-28 18:26:45', '2025-04-28 18:26:45', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916801249300004869, 1916789229485903888, 1916799570097827843, '2025-04-28 18:26:45', '2025-04-28 18:26:45', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_router
-- ----------------------------
DROP TABLE IF EXISTS `sys_router`;
CREATE TABLE `sys_router`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `parent_id` bigint NULL DEFAULT NULL COMMENT '父级id',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '在项目中路径',
  `route_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由名称',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件位置',
  `redirect` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由重定向',
  `menu_type` int NULL DEFAULT NULL COMMENT '菜单类型',
  `meta` varchar(700) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由meta',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录文件最后修改的时间戳',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '文件是否被删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_path`(`path` ASC) USING BTREE COMMENT '唯一路由路径',
  UNIQUE INDEX `unique_router_name`(`route_name` ASC) USING BTREE COMMENT '唯一路由名称',
  INDEX `idx_id_parent_id`(`id` ASC, `parent_id` ASC) USING BTREE COMMENT 'id和父级id索引',
  INDEX `idx_id`(`id` ASC) USING BTREE COMMENT 'id',
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE COMMENT '父级id索引',
  INDEX `idx_component`(`component` ASC) USING BTREE COMMENT '组件索引',
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_router
-- ----------------------------
INSERT INTO `sys_router` VALUES (1, 0, '/system', 'SystemManger', '', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"hiddenTag\":false,\"icon\":\"grommet-icons:vm-maintenance\",\"keepAlive\":false,\"rank\":1,\"roles\":[\"1915784833780183043\",\"1915784833780183044\",\"1915784833780183045\",\"1915784833780183046\",\"1915784833796960257\",\"1915784833796960258\",\"1915784833796960259\",\"1915786941359206409\",\"1915786941359206410\"],\"showLink\":true,\"showParent\":true,\"title\":\"systemManagement\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__fadeOut\"}}', NULL, 1, '2025-04-28 18:10:16', '2024-09-29 09:46:31', 0);
INSERT INTO `sys_router` VALUES (2, 1, '/system/menu', 'MenuManger', '/system/menu/index', NULL, 0, '{\"activePath\":\"\",\"auths\":[],\"fixedTag\":false,\"hiddenTag\":false,\"icon\":\"subway:menu\",\"keepAlive\":false,\"rank\":5,\"roles\":[\"1915784833796960258\",\"1915784833796960259\"],\"showLink\":true,\"showParent\":true,\"title\":\"system_menu\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__fadeOut\"}}', NULL, 1, '2025-04-28 18:07:37', '2024-09-29 09:46:31', 0);
INSERT INTO `sys_router` VALUES (1840211412516524034, 1841716459123634177, '/i18n/i18n-setting', 'I18n', '/i18n/i18n-setting/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"clarity:language-solid\",\"keepAlive\":false,\"rank\":5,\"roles\":[\"1916789229485903881\"],\"showLink\":true,\"showParent\":true,\"title\":\"system_i18n\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__fadeOut\"}}', 1, 1, '2025-04-28 18:35:10', '2024-09-29 18:06:05', 0);
INSERT INTO `sys_router` VALUES (1840292695145963522, 1841716459123634177, '/i18n/i18n-type-setting', 'I18nType', '/i18n/i18n-type-setting/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"clarity:language-solid\",\"keepAlive\":false,\"rank\":6,\"roles\":[\"1916789229485903882\"],\"showLink\":true,\"showParent\":true,\"title\":\"i18n_type_setting\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__fadeOut\"}}', 1, 1, '2025-04-28 18:35:16', '2024-09-29 23:29:04', 0);
INSERT INTO `sys_router` VALUES (1841506924681338881, 1844900259930243074, '/configuration/menu-icon', 'MenuIconConfiguration', '/configuration/menu-icon/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"subway:menu\",\"keepAlive\":false,\"rank\":2,\"roles\":[\"1916789229485903873\"],\"showLink\":true,\"showParent\":true,\"title\":\"menuIcon\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-28 18:08:01', '2024-10-03 07:53:59', 0);
INSERT INTO `sys_router` VALUES (1841716459123634177, 0, '/i18n', 'I18nManger', '/i18n', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"material-symbols:language\",\"keepAlive\":false,\"rank\":5,\"roles\":[\"1916789229485903882\",\"1916789229485903881\"],\"showLink\":true,\"showParent\":true,\"title\":\"i18n\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__fadeOut\"}}', 1, 1, '2025-04-28 18:35:00', '2024-10-03 21:46:36', 0);
INSERT INTO `sys_router` VALUES (1841726844983701505, 1, '/system/role', 'RoleManger', '/system/role/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"fluent-mdl2:manager-self-service\",\"keepAlive\":false,\"rank\":2,\"roles\":[\"1915784833780183046\"],\"showLink\":true,\"showParent\":true,\"title\":\"role\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__fadeOut\"}}', 1, 1, '2025-04-28 18:07:08', '2024-10-03 22:27:52', 0);
INSERT INTO `sys_router` VALUES (1841750734275416065, 1, '/system/power', 'PermissionManger', '/system/permission/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"oui:app-users-roles\",\"keepAlive\":false,\"rank\":3,\"roles\":[\"1915784833780183045\"],\"showLink\":true,\"showParent\":true,\"title\":\"power\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__fadeOut\"}}', 1, 1, '2025-04-28 18:07:18', '2024-10-04 00:02:48', 0);
INSERT INTO `sys_router` VALUES (1841794929635635201, 1844956874037469185, '/element-plus', 'element_plus', '', NULL, 1, '{\"auths\":[],\"fixedTag\":false,\"frameLoading\":true,\"frameSrc\":\"https://element-plus.org/zh-CN/\",\"icon\":\"logos:element\",\"keepAlive\":false,\"rank\":62,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"element_plus\",\"transition\":{\"enterTransition\":\"animate__bounce\",\"leaveTransition\":\"animate__rubberBand\"}}', 1, 1, '2025-04-25 16:34:25', '2024-10-04 02:58:25', 0);
INSERT INTO `sys_router` VALUES (1841796585525985281, 0, '/iframe', 'external_page', '', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"mdi:iframe-outline\",\"keepAlive\":false,\"rank\":8,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"external_page\",\"transition\":{\"enterTransition\":\"animate__rubberBand\",\"leaveTransition\":\"animate__rubberBand\"}}', 1, 1, '2025-04-25 16:34:45', '2024-10-04 03:05:00', 0);
INSERT INTO `sys_router` VALUES (1841796893769580546, 1844956874037469185, '/pure-admin', 'pure_admin', '', NULL, 1, '{\"auths\":[],\"fixedTag\":false,\"frameLoading\":true,\"frameSrc\":\"https://pure-admin.cn/\",\"icon\":\"file-icons:pure\",\"keepAlive\":false,\"rank\":63,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"pure_admin\",\"transition\":{\"enterTransition\":\"animate__shakeX\",\"leaveTransition\":\"animate__jello\"}}', 1, 1, '2025-04-25 16:34:22', '2024-10-04 03:06:13', 0);
INSERT INTO `sys_router` VALUES (1841803086252548097, 1, '/system/admin-user', 'AdminUserManger', '/system/admin-user/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"ic:round-manage-accounts\",\"keepAlive\":false,\"rank\":1,\"roles\":[\"1915786941359206409\"],\"showLink\":true,\"showParent\":true,\"title\":\"admin_user\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__fadeOut\"}}', 1, 1, '2025-04-28 18:06:56', '2024-10-04 03:30:49', 0);
INSERT INTO `sys_router` VALUES (1842033245832458241, 1, '/system/dept', 'DeptManger', '/system/dept/index', NULL, 0, '{\"auths\":[],\"icon\":\"grommet-icons:user-manager\",\"keepAlive\":false,\"rank\":4,\"roles\":[\"1915784833780183043\"],\"showLink\":true,\"showParent\":true,\"title\":\"dept\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__fadeOut\"}}', 1, 1, '2025-04-28 18:07:25', '2024-10-04 18:45:24', 0);
INSERT INTO `sys_router` VALUES (1843932804747603970, 1, '/system/files', 'FileManger', '/system/files/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"line-md:file-filled\",\"keepAlive\":false,\"rank\":6,\"roles\":[\"1915784833780183044\"],\"showLink\":true,\"showParent\":true,\"title\":\"system_files\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__fadeOut\"}}', 1, 1, '2025-04-28 18:07:44', '2024-10-10 00:33:34', 0);
INSERT INTO `sys_router` VALUES (1844276961265557505, 1844900259930243074, '/configuration/email-user', 'EmailUsersConfiguration', '/configuration/email-user/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"ic:baseline-voicemail\",\"keepAlive\":false,\"rank\":3,\"roles\":[\"1916789229485903874\"],\"showLink\":true,\"showParent\":true,\"title\":\"emailUsers\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-28 18:08:09', '2024-10-10 23:21:07', 0);
INSERT INTO `sys_router` VALUES (1844290948342456321, 1844900259930243074, '/configuration/email-template', 'EmailTemplate', '/configuration/email-template/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"entypo:email\",\"keepAlive\":false,\"rank\":5,\"roles\":[\"1916789229485903876\"],\"showLink\":true,\"showParent\":true,\"title\":\"emailTemplate\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-28 18:08:17', '2024-10-11 00:16:42', 0);
INSERT INTO `sys_router` VALUES (1844644093987880962, 0, '/monitor', 'Monitor', '', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"carbon:cloud-monitoring\",\"keepAlive\":false,\"rank\":3,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"monitor\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-26 09:30:47', '2024-10-11 23:39:58', 0);
INSERT INTO `sys_router` VALUES (1844644779039358978, 1844644093987880962, '/monitor/server', 'MonitorServer', '/monitor/server/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"mingcute:server-fill\",\"keepAlive\":false,\"rank\":3,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"monitoring_server\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-26 09:30:52', '2024-10-11 23:42:42', 0);
INSERT INTO `sys_router` VALUES (1844900259930243074, 0, '/configuration', 'SystemConfiguration', '', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"hugeicons:configuration-01\",\"keepAlive\":false,\"rank\":2,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"configuration\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-26 09:30:28', '2024-10-12 16:37:53', 0);
INSERT INTO `sys_router` VALUES (1844956874037469185, 1841796585525985281, '/iframe/embedded-doc', 'embedded_doc', '', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"mdi:iframe-braces\",\"keepAlive\":false,\"rank\":9,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"embedded_doc\",\"transition\":{\"enterTransition\":\"animate__bounce\",\"leaveTransition\":\"animate__flash\"}}', 1, 1, '2025-04-25 16:34:28', '2024-10-12 20:22:51', 0);
INSERT INTO `sys_router` VALUES (1844957189138751490, 1841796585525985281, '/ifram/external-doc', 'external_doc', '', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"line-md:link\",\"keepAlive\":false,\"rank\":8,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"external_doc\",\"transition\":{\"enterTransition\":\"animate__flash\",\"leaveTransition\":\"animate__flash\"}}', 1, 1, '2025-04-25 16:34:42', '2024-10-12 20:24:06', 0);
INSERT INTO `sys_router` VALUES (1844957830590468097, 1844957189138751490, '/external-doc/element-plus', 'https://element-plus.org/zh-CN/component/overview.html', '', NULL, 2, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"logos:element\",\"keepAlive\":true,\"rank\":9,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"element_plus\",\"transition\":{\"enterTransition\":\"animate__bounceInRight\",\"leaveTransition\":\"animate__bounceInRight\"}}', 1, 1, '2025-04-25 16:34:32', '2024-10-12 20:26:39', 0);
INSERT INTO `sys_router` VALUES (1844958437262987265, 1844957189138751490, '/external-doc/iconify', 'https://icon-sets.iconify.design/', '', NULL, 2, '{\"auths\":[],\"icon\":\"line-md:iconify1\",\"rank\":8,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"iconify\",\"transition\":{\"enterTransition\":\"animate__bounceInRight\",\"leaveTransition\":\"fade\"}}', 1, 1, '2025-04-25 16:34:35', '2024-10-12 20:29:04', 0);
INSERT INTO `sys_router` VALUES (1845812113861079042, 1846804024660791298, '/scheduler/schedulers', 'SchedulerTask', '/scheduler/schedulers/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"simple-icons:apachedolphinscheduler\",\"keepAlive\":false,\"rank\":6,\"roles\":[\"1916789229485903879\"],\"showLink\":true,\"showParent\":true,\"title\":\"schedulers\",\"transition\":{\"enterTransition\":\"animate__fadeInUp\",\"leaveTransition\":\"animate__fadeInDown\"}}', 1, 1, '2025-04-28 18:32:06', '2024-10-15 05:01:16', 0);
INSERT INTO `sys_router` VALUES (1846166163060285441, 1846804024660791298, '/scheduler/schedulers-group', 'SchedulerGroup', '/scheduler/schedulers-group/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"uis:layer-group\",\"keepAlive\":false,\"rank\":7,\"roles\":[\"1916789229485903880\"],\"showLink\":true,\"showParent\":true,\"title\":\"schedulersGroup\",\"transition\":{\"enterTransition\":\"animate__fadeInUp\",\"leaveTransition\":\"animate__fadeInDown\"}}', 1, 1, '2025-04-28 18:32:14', '2024-10-16 04:28:08', 0);
INSERT INTO `sys_router` VALUES (1846804024660791298, 0, '/scheduler', 'Scheduler', '', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"mingcute:time-fill\",\"keepAlive\":false,\"rank\":4,\"roles\":[\"1916789229485903879\",\"1916789229485903880\"],\"showLink\":true,\"showParent\":true,\"title\":\"scheduler\",\"transition\":{\"enterTransition\":\"animate__fadeInUp\",\"leaveTransition\":\"animate__fadeInDown\"}}', 1, 1, '2025-04-28 18:31:59', '2024-10-17 14:42:46', 0);
INSERT INTO `sys_router` VALUES (1847140225619992577, 1852321196101464065, '/log/scheduler-execute-log', 'SchedulerExecuteLog', '/monitor/scheduler-execute-log/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"eos-icons:cronjob\",\"keepAlive\":false,\"rank\":6,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"quartzExecuteLog\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__tada\"}}', 1, 1, '2025-04-26 09:36:47', '2024-10-18 12:58:43', 0);
INSERT INTO `sys_router` VALUES (1847291834822123521, 1852321196101464065, '/log/user-login-log', 'UserLoginLog', '/monitor/user-login-log/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"ph:clock-user\",\"keepAlive\":false,\"rank\":7,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"userLoginLog\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__tada\"}}', 1, 1, '2025-04-26 09:36:51', '2024-10-18 23:01:09', 0);
INSERT INTO `sys_router` VALUES (1848989760243838978, 1844644093987880962, '/monitor/caches', 'SystemCaches', '/monitor/caches/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"devicon:redis\",\"keepAlive\":false,\"rank\":4,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"systemCaches\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-26 09:30:59', '2024-10-23 15:28:06', 0);
INSERT INTO `sys_router` VALUES (1849000501604724738, 1844900259930243074, '/configuration/web-configuration', 'WebConfiguration', '/configuration/web-configuration/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"file-icons:config-react\",\"keepAlive\":false,\"rank\":4,\"roles\":[\"1916789229485903875\"],\"showLink\":true,\"showParent\":true,\"title\":\"webConifg\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-28 18:08:28', '2024-10-23 16:10:47', 0);
INSERT INTO `sys_router` VALUES (1851488898978103297, 0, '/message', 'MessageManger', '', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"line-md:email-filled\",\"keepAlive\":false,\"rank\":7,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"messageManagement\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1849444494908125181, 1, '2025-04-26 09:36:56', '2024-10-30 12:58:47', 0);
INSERT INTO `sys_router` VALUES (1851488972810436609, 1851488898978103297, '/message/message-type', 'MessageType', '/message-manger/message-type/index', NULL, 0, '{\"auths\":[],\"icon\":\"hugeicons:message-edit-02\",\"rank\":7,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"messageType\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1849444494908125181, 1, '2025-04-26 09:37:01', '2024-10-30 12:59:05', 0);
INSERT INTO `sys_router` VALUES (1851490002939887618, 0, '/systemMaintenance', 'systemMaintenance', '', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"simple-icons:minio\",\"keepAlive\":false,\"rank\":10,\"roles\":[],\"showLink\":false,\"showParent\":true,\"title\":\"systemMaintenance\",\"transition\":{\"enterTransition\":\"animate__bounceInRight\",\"leaveTransition\":\"animate__bounceInLeft\"}}', 1, 1, '2025-04-25 16:34:18', '2024-10-30 13:03:10', 0);
INSERT INTO `sys_router` VALUES (1851491818972856321, 1851488898978103297, '/message/message-editing', 'MessageEditer', '/message-manger/message-editing/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"hugeicons:message-edit-02\",\"keepAlive\":false,\"rank\":9,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"messageEditing\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-26 09:37:11', '2024-10-30 13:10:23', 0);
INSERT INTO `sys_router` VALUES (1851525168378875906, 1851488898978103297, '/message/message-received', 'MessageReceived', '/message-manger/message-received/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"wpf:gps-receiving\",\"keepAlive\":false,\"rank\":10,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"messageReceivingManagement\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-26 09:37:15', '2024-10-30 15:22:54', 0);
INSERT INTO `sys_router` VALUES (1852321196101464065, 0, '/logManagement', 'logManagement', '', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"octicon:log-16\",\"keepAlive\":false,\"rank\":6,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"logManagement\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__tada\"}}', 1, 1, '2025-04-26 09:36:43', '2024-11-01 20:06:02', 0);
INSERT INTO `sys_router` VALUES (1853083388413304834, 1851488898978103297, '/message/message-send', 'MessageSender', '/message-manger/message-send/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"lets-icons:message-alt-fill\",\"keepAlive\":false,\"rank\":8,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"messageSendManagement\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-26 09:37:05', '2024-11-03 22:34:43', 0);

-- ----------------------------
-- Table structure for sys_router_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_router_role`;
CREATE TABLE `sys_router_role`  (
  `id` bigint NOT NULL COMMENT '主键ID',
  `router_id` bigint NOT NULL COMMENT '路由ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '最后修改的时间戳',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否被删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_router_role`(`router_id` ASC, `role_id` ASC) USING BTREE COMMENT '录音和角色不能重复',
  INDEX `idx_router_id`(`router_id` ASC) USING BTREE,
  INDEX `idx_role_id`(`role_id` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间',
  CONSTRAINT `sys_router_role_ibfk_1` FOREIGN KEY (`router_id`) REFERENCES `sys_router` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_router_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统路由角色关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_router_role
-- ----------------------------
INSERT INTO `sys_router_role` VALUES (1916796263593771010, 1841803086252548097, 1915786941359206409, '2025-04-28 18:06:56', '2025-04-28 18:06:56', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916796312897814530, 1841726844983701505, 1915784833780183046, '2025-04-28 18:07:08', '2025-04-28 18:07:08', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916796353641283586, 1841750734275416065, 1915784833780183045, '2025-04-28 18:07:18', '2025-04-28 18:07:18', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916796384196788226, 1842033245832458241, 1915784833780183043, '2025-04-28 18:07:25', '2025-04-28 18:07:25', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916796433328865282, 2, 1915784833796960258, '2025-04-28 18:07:37', '2025-04-28 18:07:37', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916796433328865283, 2, 1915784833796960259, '2025-04-28 18:07:37', '2025-04-28 18:07:37', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916796464261857282, 1843932804747603970, 1915784833780183044, '2025-04-28 18:07:44', '2025-04-28 18:07:44', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916796535867015169, 1841506924681338881, 1916789229485903873, '2025-04-28 18:08:01', '2025-04-28 18:08:01', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916796567101997058, 1844276961265557505, 1916789229485903874, '2025-04-28 18:08:09', '2025-04-28 18:08:09', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916796603693105153, 1844290948342456321, 1916789229485903876, '2025-04-28 18:08:17', '2025-04-28 18:08:17', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916796650153410561, 1849000501604724738, 1916789229485903875, '2025-04-28 18:08:28', '2025-04-28 18:08:28', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916797101477298178, 1, 1915784833780183043, '2025-04-28 18:10:16', '2025-04-28 18:10:16', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916797101477298179, 1, 1915784833780183044, '2025-04-28 18:10:16', '2025-04-28 18:10:16', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916797101477298180, 1, 1915784833780183045, '2025-04-28 18:10:16', '2025-04-28 18:10:16', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916797101477298181, 1, 1915784833780183046, '2025-04-28 18:10:16', '2025-04-28 18:10:16', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916797101477298182, 1, 1915784833796960257, '2025-04-28 18:10:16', '2025-04-28 18:10:16', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916797101477298183, 1, 1915784833796960258, '2025-04-28 18:10:16', '2025-04-28 18:10:16', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916797101477298184, 1, 1915784833796960259, '2025-04-28 18:10:16', '2025-04-28 18:10:16', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916797101477298185, 1, 1915786941359206409, '2025-04-28 18:10:16', '2025-04-28 18:10:16', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916797101477298186, 1, 1915786941359206410, '2025-04-28 18:10:16', '2025-04-28 18:10:16', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916802565124472834, 1846804024660791298, 1916789229485903879, '2025-04-28 18:31:59', '2025-04-28 18:31:59', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916802565124472835, 1846804024660791298, 1916789229485903880, '2025-04-28 18:31:59', '2025-04-28 18:31:59', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916802595524788225, 1845812113861079042, 1916789229485903879, '2025-04-28 18:32:06', '2025-04-28 18:32:06', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916802629616091138, 1846166163060285441, 1916789229485903880, '2025-04-28 18:32:14', '2025-04-28 18:32:14', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916803323932786689, 1841716459123634177, 1916789229485903882, '2025-04-28 18:35:00', '2025-04-28 18:35:00', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916803323932786690, 1841716459123634177, 1916789229485903881, '2025-04-28 18:35:00', '2025-04-28 18:35:00', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916803366169427970, 1840211412516524034, 1916789229485903881, '2025-04-28 18:35:10', '2025-04-28 18:35:10', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1916803393386266625, 1840292695145963522, 1916789229485903882, '2025-04-28 18:35:16', '2025-04-28 18:35:16', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `nickname` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `password` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sex` tinyint NULL DEFAULT 1 COMMENT '0:女 1:男',
  `summary` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '个人描述',
  `ip_address` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最后登录IP',
  `ip_region` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '最后登录ip归属地',
  `status` tinyint NULL DEFAULT 0 COMMENT '1:禁用 0:正常',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `unique_username`(`username` ASC) USING BTREE COMMENT '用户名不能重复',
  UNIQUE INDEX `unique_email`(`email` ASC) USING BTREE COMMENT '邮箱不能重复',
  INDEX `idx_nickname`(`nickname` ASC) USING BTREE,
  INDEX `idx_phone`(`phone` ASC) USING BTREE,
  INDEX `idx_avatar`(`avatar` ASC) USING BTREE,
  INDEX `idx_summary`(`summary` ASC) USING BTREE,
  INDEX `idx_ip_address`(`ip_address` ASC) USING BTREE,
  INDEX `idx_ip_region`(`ip_region` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'Administrator', 'Administrator', 'admin@qq.com', '123456789', '$2a$10$KR5VyJ2FGZfQ3Eumz9Jpi.XKrJZhQStR55oeRSbW.sNoX.4RVlxqC', '/auth-admin/avatar/2025/03-24/43bb03d4-e2a4-478b-901e-81dd5a69fe59', 1, 'admin 1', '127.0.0.1', '内网IP', 0, '2024-10-24 21:35:03', NULL, 1, NULL, 0);
INSERT INTO `sys_user` VALUES (1849444494908125181, 'bunny', 'bunny', '1319900154@qq.com', '18012062876', '$2a$10$h5BUwmMaVcEuu7Bz0TPPy.PQV8JP6CFJlbHTgT78G1s0YPIu2kfXe', '/auth-admin/avatar/2025/01-17/b3aba651-bfb1-45dd-a470-0bcaad26f6ef', 1, '搜索', '127.0.0.1', '内网IP', 0, '2024-09-26 14:29:33', '2025-04-25 20:39:26', 0, 1, 0);
INSERT INTO `sys_user` VALUES (1849681227633758210, 'Operation', '系统配置', 'Operation@qq.com', '18012345678', '$2a$10$h5BUwmMaVcEuu7Bz0TPPy.PQV8JP6CFJlbHTgT78G1s0YPIu2kfXe', '/auth-admin/avatar/2025/03-24/151a11fa-1a11-40c5-9845-202ab0a7f830', 0, '能看到定时任务和系统配置页面可以发布和更新消息，密码：admin123', '127.0.0.1', '内网IP', 0, '2024-10-25 13:15:45', '2025-04-28 18:09:47', 1, 1, 0);
INSERT INTO `sys_user` VALUES (1850075157831454722, 'system', '只能看到系统配置用户1', 'system@Gmail.com', '18012062876', '$2a$10$h5BUwmMaVcEuu7Bz0TPPy.PQV8JP6CFJlbHTgT78G1s0YPIu2kfXe', '/auth-admin/avatar/2024/10-28/057cb028-dea3-4054-ae07-8321eaeceaf1', 0, '只能看到系统设置1内容页面，密码：admin123', '113.201.133.129', '陕西省,西安市 联通', 0, '2024-10-26 15:21:05', '2025-04-28 18:30:54', 1, 1849681227633758210, 1);
INSERT INTO `sys_user` VALUES (1850080272764211202, 'timing', '定时任务', 'timing@163.com', '212122', '$2a$10$h5BUwmMaVcEuu7Bz0TPPy.PQV8JP6CFJlbHTgT78G1s0YPIu2kfXe', '/auth-admin/avatar/2024/10-28/6b9cbcd2-31af-4c91-b74e-2d66e5b0558a', 0, '只能看到定时任务页面，密码：admin123', '127.0.0.1', '内网IP', 0, '2024-10-26 15:41:25', NULL, 1, NULL, 0);
INSERT INTO `sys_user` VALUES (1850789068551200769, 'i18n', 'i18n', 'i18n@qq.com', '18012345678', '$2a$10$h5BUwmMaVcEuu7Bz0TPPy.PQV8JP6CFJlbHTgT78G1s0YPIu2kfXe', '/auth-admin/avatar/2024/10-28/71a8b92c-ef68-425c-9993-d95292613916', 1, '可见i18n，定时任务，密码：admin123', '127.0.0.1', '内网IP', 0, '2024-10-28 14:37:55', NULL, 1, NULL, 0);
INSERT INTO `sys_user` VALUES (1853494274437152770, 'test', 'test', 'test@qq.com', '18012062876', '$2a$10$h5BUwmMaVcEuu7Bz0TPPy.PQV8JP6CFJlbHTgT78G1s0YPIu2kfXe', NULL, 0, 'test', '127.0.0.1', '内网IP', 0, '2024-11-05 01:47:26', '2025-02-22 21:21:06', 1, 1, 1);

-- ----------------------------
-- Table structure for sys_user_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_dept`;
CREATE TABLE `sys_user_dept`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `dept_id` bigint NOT NULL COMMENT '部门id',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '是否删除，0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_user_dept`(`user_id` ASC, `dept_id` ASC) USING BTREE COMMENT '用户id和部门不能相同',
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_dept_id`(`dept_id` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间',
  CONSTRAINT `sys_user_dept_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_user_dept_ibfk_2` FOREIGN KEY (`dept_id`) REFERENCES `sys_dept` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门用户关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_dept
-- ----------------------------
INSERT INTO `sys_user_dept` VALUES (1849443729225383937, 1, 1842883239493881857, '2024-10-24 21:32:01', '2024-10-24 21:32:01', 1, 1, 0);
INSERT INTO `sys_user_dept` VALUES (1850080272827125761, 1850080272764211202, 1850077710275153922, '2024-10-26 15:41:25', '2024-10-26 15:41:25', 1, 1, 0);
INSERT INTO `sys_user_dept` VALUES (1850914498145005569, 1850789068551200769, 1842844360640327682, '2024-10-28 22:56:19', '2024-10-28 22:56:19', 1, 1, 0);
INSERT INTO `sys_user_dept` VALUES (1904170881874931714, 1849444494908125181, 1842844360640327682, '2025-03-24 21:58:11', '2025-03-24 21:58:11', 1, 1, 0);
INSERT INTO `sys_user_dept` VALUES (1916796760199364610, 1849681227633758210, 1842885831187877890, '2025-04-28 18:08:55', '2025-04-28 18:08:55', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `role_id` bigint NOT NULL COMMENT '角色id',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '是否删除，0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `idx_user_role`(`user_id` ASC, `role_id` ASC) USING BTREE COMMENT '用户和角色不能相同',
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_role_id`(`role_id` ASC) USING BTREE,
  INDEX `idx_update_user`(`update_user` ASC) USING BTREE COMMENT '索引创更新用户',
  INDEX `idx_create_user`(`create_user` ASC) USING BTREE COMMENT '索引创建用户',
  INDEX `idx_user`(`update_user` ASC, `create_user` ASC) USING BTREE COMMENT '索引创建用户和更新用户',
  INDEX `idx_time`(`update_time` ASC, `create_time` ASC) USING BTREE COMMENT '索引创建时间和更新时间',
  CONSTRAINT `sys_user_role_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `sys_user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `sys_user_role_ibfk_2` FOREIGN KEY (`role_id`) REFERENCES `sys_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统用户角色关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1916796980769423362, 1849681227633758210, 1915784833780183043, '2025-04-28 18:09:47', '2025-04-28 18:09:47', 1, 1, 0);
INSERT INTO `sys_user_role` VALUES (1916796980769423363, 1849681227633758210, 1915784833780183046, '2025-04-28 18:09:47', '2025-04-28 18:09:47', 1, 1, 0);
INSERT INTO `sys_user_role` VALUES (1916796980769423364, 1849681227633758210, 1915786941359206409, '2025-04-28 18:09:47', '2025-04-28 18:09:47', 1, 1, 0);
INSERT INTO `sys_user_role` VALUES (1916802342448873474, 1850080272764211202, 1916789229485903879, '2025-04-28 18:31:06', '2025-04-28 18:31:06', 1, 1, 0);
INSERT INTO `sys_user_role` VALUES (1916802342448873475, 1850080272764211202, 1916789229485903880, '2025-04-28 18:31:06', '2025-04-28 18:31:06', 1, 1, 0);
INSERT INTO `sys_user_role` VALUES (1916803203606593538, 1850789068551200769, 1916789229485903881, '2025-04-28 18:34:31', '2025-04-28 18:34:31', 1, 1, 0);
INSERT INTO `sys_user_role` VALUES (1916803203606593539, 1850789068551200769, 1916789229485903882, '2025-04-28 18:34:31', '2025-04-28 18:34:31', 1, 1, 0);

-- ----------------------------
-- View structure for view_qrtz_schedulers
-- ----------------------------
DROP VIEW IF EXISTS `view_qrtz_schedulers`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_qrtz_schedulers` AS select `job`.`job_name` AS `job_name`,`job`.`job_group` AS `job_group`,`job`.`description` AS `description`,`job`.`job_class_name` AS `job_class_name`,`cron`.`cron_expression` AS `cron_expression`,`tri`.`trigger_name` AS `trigger_name`,`tri`.`trigger_state` AS `trigger_state` from ((`qrtz_job_details` `job` join `qrtz_triggers` `tri` on(((`job`.`job_name` = `tri`.`job_name`) and (`job`.`job_group` = `tri`.`job_group`)))) join `qrtz_cron_triggers` `cron` on(((`cron`.`trigger_name` = `tri`.`trigger_name`) and (`cron`.`trigger_group` = `tri`.`job_group`)))) where (`tri`.`trigger_type` = 'CRON');

SET FOREIGN_KEY_CHECKS = 1;
