/*
 Navicat Premium Dump SQL

 Source Server         : mysql(192.168.3.98)
 Source Server Type    : MySQL
 Source Server Version : 80033 (8.0.33)
 Source Host           : 192.168.3.98:3304
 Source Schema         : auth_admin

 Target Server Type    : MySQL
 Target Server Version : 80033 (8.0.33)
 File Encoding         : 65001

 Date: 19/10/2024 16:39:06
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
  `end_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '结束时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `update_user` int NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '文件是否被删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '调度任务执行日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of log_quartz_execute
-- ----------------------------

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
  `user_agent` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '登录时代理',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作类型',
  `x_requested_with` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '标识客户端是否是通过Ajax发送请求的',
  `sec_ch_ua` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户代理的品牌和版本',
  `sec_ch_ua_mobile` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户代理是否在手机设备上运行',
  `sec_ch_ua_platform` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '用户代理的底层操作系统/平台',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '修改时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `update_user` int NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否被删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '用户登录日志' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of log_user_login
-- ----------------------------
INSERT INTO `log_user_login` VALUES (1847355954367836162, 1, 'bunny', 'eyJhbGciOiJIUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_yWLQQrCMBBF7zLrRjImk0m6EnduvENiZkCh1bYGFPHuBtx93nv_A1srMMKxzfMbBpDXA0bkfYrRMYUB2ibrqXb2n-c8Sc_RYUrWIvnDsuwu96lfb89rNyqsrko0hJSNZ68m-0DGBi2WC4rWAN8fveZ32HcAAAA.3ojnO1B0cRHidpCTdMlHFGpY_ZPTC8AvMx4LhprjVrU', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'login', 'XMLHttpRequest', '\"Google Chrome\";v=\"129\", \"Not=A?Brand\";v=\"8\", \"Chromium\";v=\"129\"', '?0', '\"Windows\"', '2024-10-19 03:15:56', '2024-10-19 03:15:56', 1, 1, 0);
INSERT INTO `log_user_login` VALUES (1847355983346282498, 1, 'bunny', 'eyJhbGciOiJIUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_yWLQQrCMBBF7zLrRjImk0m6EnduvENiZkCh1bYGFPHuBtx93nv_A1srMMKxzfMbBpDXA0bkfYrRMYUB2ibrqXb2n-c8Sc_RYUrWIvnDsuwu96lfb89rNyqsrko0hJSNZ68m-0DGBi2WC4rWAN8fveZ32HcAAAA.3ojnO1B0cRHidpCTdMlHFGpY_ZPTC8AvMx4LhprjVrU', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'logout', 'XMLHttpRequest', '\"Google Chrome\";v=\"129\", \"Not=A?Brand\";v=\"8\", \"Chromium\";v=\"129\"', '?0', '\"Windows\"', '2024-10-19 03:16:03', '2024-10-19 03:16:03', 1, 1, 0);
INSERT INTO `log_user_login` VALUES (1847356167765635073, 1, 'bunny', 'eyJhbGciOiJIUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_yWLQQrCMBBF7zLrRjJtks50Je668Q4m-YJCq7UGKuLdjbj7vPf-m9YSaaBDmecXNYTtTgP3rYp0YvuGyorHmCv7z-NpQs25Y1Vr2bv9suzSbarX6_PyMwIPwBlEhnGaookpqBHnUwj5nHMr9PkC8ofSBncAAAA.Hd5yqpx-oUCtt8EykNFcKm0EHRkKtrFrik4kXTad774', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'login', 'XMLHttpRequest', '\"Google Chrome\";v=\"129\", \"Not=A?Brand\";v=\"8\", \"Chromium\";v=\"129\"', '?0', '\"Windows\"', '2024-10-19 03:16:47', '2024-10-19 03:16:47', 1, 1, 0);
INSERT INTO `log_user_login` VALUES (1847356246924734465, 1, NULL, NULL, '127.0.0.1', '内网IP', NULL, 'forcedOffline', NULL, NULL, NULL, NULL, '2024-10-19 03:17:06', '2024-10-19 03:17:06', 1, 1, 0);
INSERT INTO `log_user_login` VALUES (1847356317057691650, 1, 'bunny', 'eyJhbGciOiJIUzI1NiIsInppcCI6IkdaSVAifQ.H4sIAAAAAAAA_yWLQQrCMBBF7zLrRmaSmXbSlXTnxjukcQoKrdY2oIh3N-Du8977H9jKCD0MZVne0IC9HtBT56NqUPYNlM2ep0tl_3lOs9WcAsWISMLHdT3k-1yvt_1aDbN46YScBhLHKbQuobXOcPIjTpo5G3x_bEMAvHcAAAA.hWcfG-ulaNVTFqKl1EGFeoJP6L3DtQMKCS3Hwo4JSLM', '127.0.0.1', '内网IP', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/129.0.0.0 Safari/537.36', 'login', 'XMLHttpRequest', '\"Google Chrome\";v=\"129\", \"Not=A?Brand\";v=\"8\", \"Chromium\";v=\"129\"', '?0', '\"Windows\"', '2024-10-19 03:17:23', '2024-10-19 03:17:23', 1, 1, 0);

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
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '唯一id',
  `group_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分组名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分组详情',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务调度分组表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_schedulers_group
-- ----------------------------
INSERT INTO `qrtz_schedulers_group` VALUES ('1846167458097774594', 'hello分组', 'hello分组作为第一个测试', '2024-10-15 20:33:17', '2024-10-15 20:33:17', 1, '1', 0);

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

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '唯一id',
  `parent_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '0' COMMENT '父级id',
  `manager` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '管理者id',
  `dept_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '部门名称',
  `summary` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '部门简介',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('1842844360640327682', '0', '梁子异,彭秀英,戴子韬,曾致远', '山东总公司', '山东总公司', '2024-10-06 16:28:29', '2024-10-06 19:41:21', 1, '1', 0);
INSERT INTO `sys_dept` VALUES ('1842874908557541377', '1842844360640327682', 'bunny,史安琪,邱致远,秦詩涵', '深圳分公司', '深圳分公司', '2024-10-06 18:29:52', '2024-10-06 19:10:47', 1, '1', 0);
INSERT INTO `sys_dept` VALUES ('1842877591473455106', '1842844360640327682', '程嘉伦,武嘉伦,孙震南', '郑州分公司', '郑州分公司', '2024-10-06 18:40:31', '2024-10-06 19:02:27', 1, '1', 0);
INSERT INTO `sys_dept` VALUES ('1842882951345197057', '1842874908557541377', '彭致远,彭秀英,冯宇宁,黎子韬', '财务部门', '财务部门', '2024-10-06 19:01:49', '2024-10-09 10:40:22', 1, '1', 0);
INSERT INTO `sys_dept` VALUES ('1842883239493881857', '1842877591473455106', '于致远,曹致远,李璐,戴子韬', '研发部门', '研发部门', '2024-10-06 19:02:58', '2024-10-06 19:02:58', 1, '1', 0);
INSERT INTO `sys_dept` VALUES ('1842885275601981441', '1842874908557541377', '宋宇宁,彭秀英,刘子韬', '市场部门', '市场部门', '2024-10-06 19:11:04', '2024-10-06 19:11:04', 1, '1', 0);
INSERT INTO `sys_dept` VALUES ('1842885316358033409', '1842877591473455106', '宋宇宁,曾致远,刘子韬', '财务部门', '财务部门', '2024-10-06 19:11:13', '2024-10-09 10:38:35', 1, '1', 0);
INSERT INTO `sys_dept` VALUES ('1842885375015374850', '1842877591473455106', '冯宇宁,刘子韬,曾致远', '测试部门', '测试部门', '2024-10-06 19:11:27', '2024-10-06 19:11:52', 1, '1', 0);
INSERT INTO `sys_dept` VALUES ('1842885831187877890', '1842877591473455106', '龚岚,杜安琪,李子异,彭睿,宋宇宁,bunny', '运维部门', '运维部门', '2024-10-06 19:13:16', '2024-10-06 19:13:16', 1, '1', 0);

-- ----------------------------
-- Table structure for sys_email_template
-- ----------------------------
DROP TABLE IF EXISTS `sys_email_template`;
CREATE TABLE `sys_email_template`  (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '唯一id',
  `template_name` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '模板名称',
  `email_user` bigint NULL DEFAULT NULL COMMENT '关联邮件用户配置',
  `subject` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '主题',
  `body` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '邮件内容',
  `type` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邮件类型',
  `is_default` tinyint(1) NULL DEFAULT 0 COMMENT '是否默认',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '邮件模板表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_email_template
-- ----------------------------
INSERT INTO `sys_email_template` VALUES ('1791870020197625858', 'email-1', 2, '邮箱验证码', '<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n  <meta charset=\"UTF-8\">\n  <meta content=\"IE=edge\" http-equiv=\"X-UA-Compatible\">\n  <meta content=\"width=device-width, initial-scale=1.0\" name=\"viewport\">\n  <title>Email Verification Code</title>\n</head>\n<body style=\"margin: 0; padding: 0; background-color: #f5f5f5;\">\n<div style=\"max-width: 600px; margin: 0 auto;\">\n  <table style=\"width: 100%; border-collapse: collapse; background-color: #ffffff; font-family: Arial, sans-serif;\">\n    <tr>\n      <th style=\"height: 60px; padding: 20px; background-color: #0074d3; border-radius: 5px 5px 0 0;\"\n          valign=\"middle\">\n        <h1 style=\"margin: 0; color: #ffffff; font-size: 24px;\">Bunny邮箱验证码</h1>\n      </th>\n    </tr>\n    <tr>\n      <td style=\"padding: 20px;\">\n        <div style=\"background-color: #ffffff; padding: 25px;\">\n          <h2 style=\"margin: 10px 0; font-size: 18px; color: #333333;\">\n            尊敬的用户,\n          </h2>\n          <p style=\"margin: 10px 0; font-size: 16px; color: #333333;\">\n            感谢您注册我们的产品. 您的账号正在进行电子邮件验证.\n          </p>\n          <p style=\"margin: 10px 0; font-size: 16px; color: #333333;\">\n            验证码为: <span class=\"button\" style=\"color: #1100ff;\">${verifyCode}</span>\n          </p>\n          <p style=\"margin: 10px 0; font-size: 16px; color: #333333;\">\n            验证码的有效期只有一分钟，请抓紧时间进行验证吧！\n          </p>\n          <p style=\"margin: 10px 0; font-size: 16px; color: #dc1818;\">\n            如果非本人操作,请忽略此邮件\n          </p>\n        </div>\n      </td>\n    </tr>\n    <tr>\n      <td style=\"text-align: center; padding: 20px; background-color: #f5f5f5;\">\n        <p style=\"margin: 0; font-size: 12px; color: #747474;\">\n          Bunny邮件验证码<br>\n          Contact us: ${sendEmailUser}\n        </p>\n        <p style=\"margin: 10px 0; font-size: 12px; color: #747474;\">\n          This is an automated email, please do not reply.<br>\n          © Company Name\n        </p>\n      </td>\n    </tr>\n  </table>\n</div>\n</body>\n</html>', 'verification_code', 1, '2024-05-18 16:34:38', '2024-10-14 20:10:24', 0, '1', 0);

-- ----------------------------
-- Table structure for sys_email_users
-- ----------------------------
DROP TABLE IF EXISTS `sys_email_users`;
CREATE TABLE `sys_email_users`  (
  `id` bigint NOT NULL,
  `email` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '邮箱',
  `password` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '密码',
  `host` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT 'Host地址',
  `port` int NOT NULL COMMENT '端口号',
  `smtp_agreement` varchar(15) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '邮箱协议',
  `is_default` tinyint NULL DEFAULT NULL COMMENT '是否为默认邮件',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '是否被删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '邮箱发送表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_email_users
-- ----------------------------
INSERT INTO `sys_email_users` VALUES (1, '3@qq.com', 'fdehkkbmavalcjea', 'smtp.qq.com', 465, NULL, 0, '2024-05-14 18:43:50', '2024-10-12 18:30:06', 0, 1, 0);
INSERT INTO `sys_email_users` VALUES (2, '3324855376@qq.com', 'fdehkkbmavalcjea', 'smtp.qq.com', 465, NULL, 1, '2024-05-14 18:43:50', '2024-10-12 18:31:26', 0, 1, 0);
INSERT INTO `sys_email_users` VALUES (3, '2@qq.com', 'fdehkkbmavalcjea', 'smtp.qq.com', 465, NULL, 0, '2024-05-14 18:43:50', '2024-10-11 20:53:50', 0, 1, 0);
INSERT INTO `sys_email_users` VALUES (1662369791, '1@qq.com', 'fdehkkbmavalcjea', 'smtp.qq.com', 465, NULL, 0, '2024-05-14 18:43:50', '2024-10-11 21:05:47', 0, 1, 0);

-- ----------------------------
-- Table structure for sys_files
-- ----------------------------
DROP TABLE IF EXISTS `sys_files`;
CREATE TABLE `sys_files`  (
  `id` bigint NOT NULL COMMENT '文件的唯一标识符，自动递增',
  `filename` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '文件的名称',
  `filepath` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '文件在服务器上的存储路径',
  `file_size` int NOT NULL COMMENT '文件的大小，以字节为单位',
  `file_type` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '文件的MIME类型',
  `download_count` int NULL DEFAULT 0 COMMENT '下载数量',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录文件最后修改的时间戳',
  `update_user` int NULL DEFAULT NULL COMMENT '操作用户',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '文件是否被删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '系统文件表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_files
-- ----------------------------
INSERT INTO `sys_files` VALUES (1842110808781082625, '5C7D14EDDC3ED2A9470F05FB60890431.png', '/auth-admin/avatar/2024/10-04/76ba1e92-4071-40da-ad1d-786c095caa83.png', 258720, 'image/png', 0, 1, NULL, NULL, '2024-10-04 15:53:36', 0);
INSERT INTO `sys_files` VALUES (1842212956680331265, 'blob', '/auth-admin/avatar/2024/10-04/d06ce74a-4c20-44cc-92be-e2cee9af70df', 1148373, 'image/png', 0, 1, '2024-10-05 06:39:30', 1, '2024-10-04 22:39:30', 0);
INSERT INTO `sys_files` VALUES (1845703953328300033, '1.jpg', '/auth-admin/avatar/2024/10-14/98b53ed4-f973-4d42-bdba-2c8760a5792c.jpg', 3338, 'image/jpeg', 4, 1, NULL, NULL, '2024-10-14 13:51:29', 0);
INSERT INTO `sys_files` VALUES (1845703953336688641, '2.jpg', '/auth-admin/avatar/2024/10-14/649e0a3e-9b12-4995-be38-17c59db996c2.jpg', 1646, 'image/jpeg', 0, 1, '2024-10-14 21:51:29', 1, '2024-10-14 13:51:29', 0);

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
  `update_user` int NULL DEFAULT NULL COMMENT '操作用户',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录文件最后修改的时间戳',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '文件是否被删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '多语言表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_i18n
-- ----------------------------
INSERT INTO `sys_i18n` VALUES (1840622816000196609, 'menus.pureSuccess', '成功页面', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816000196610, 'menus.pureInfiniteScroll', '表格无限滚动', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816000196611, 'menus.pureSplitPane', '切割面板', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816000196612, 'menus.pureDownload', '下载', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816000196613, 'menus.pureDept', '部门管理', 'zh', 1, 1, '2024-09-30 22:45:06', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816000196614, 'menus.pureText', '文本省略', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816000196615, 'search.pureCollect', '收藏', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816000196616, 'menus.pureCascader', '区域级联选择器', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816000196617, 'menus.pureTypeit', '打字机', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816000196618, 'panel.pureOverallStyle', '整体风格', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816121831425, 'menus.pureMessage', '消息提示', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816121831426, 'panel.pureWeakModel', '色弱模式', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816121831427, 'menus.pureJsonEditor', 'JSON编辑器', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816121831428, 'menus.pureMindMap', '思维导图', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816121831429, 'status.pureNotify', '通知', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816193134594, 'menus.pureIconSelect', '图标选择器', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816193134595, 'buttons.pureSwitch', '切换', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816193134596, 'menus.pureCardList', '卡片列表页', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816193134597, 'menus.pureButton', '按钮动效', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816193134598, 'status.pureTodo', '待办', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816256049154, 'login.pureForget', '忘记密码?', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816256049155, 'buttons.pureClickCollapse', '点击折叠', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816256049156, 'menus.pureSystemLog', '系统日志', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816256049157, 'menus.pureSchemaForm', '表单', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816256049158, 'status.pureMessage', '消息', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816256049159, 'menus.pureVueDoc', 'vue3', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816323158017, 'status.pureLoad', '加载中...', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816323158018, 'menus.pureTimeline', '时间线', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816323158019, 'menus.pureOptimize', '防抖、截流、复制、长按指令', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816323158020, 'menus.pureAbout', '关于', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816331546625, 'login.purePhoneLogin', '手机登录', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816344129538, 'search.pureEmpty', '暂无搜索结果', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816344129539, 'menus.purePermissionButton', '按钮权限', 'zh', 1, 1, '2024-10-17 18:14:30', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816344129540, 'login.pureUsername', '账号', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816344129541, 'menus.pureTableBase', '基础用法', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816377683969, 'panel.pureTagsStyleCardTip', '卡片标签，高效浏览', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816402849794, 'search.pureHistory', '搜索历史', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816411238401, 'status.pureNoNotify', '暂无通知', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816411238402, 'menus.pureTabs', '标签页操作', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816411238403, 'menus.pureTag', '标签', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816411238404, 'panel.pureClearCacheAndToLogin', '清空缓存并返回登录页', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816411238405, 'menus.pureUiGradients', '渐变色', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816419627011, 'menus.purePinyin', '汉语拼音', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816419627012, 'menus.pureBarcode', '条形码', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816453181441, 'panel.pureOverallStyleDark', '深色', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816453181442, 'status.pureNoTodo', '暂无待办', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816453181443, 'menus.pureTable', '表格', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816453181444, 'menus.pureTableHigh', '高级用法', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816453181445, 'panel.pureInterfaceDisplay', '界面显示', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816453181446, 'menus.pureRole', '角色管理', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816453181447, 'panel.pureTagsStyleChromeTip', '谷歌风格，经典美观', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816453181448, 'panel.pureGreyModel', '灰色模式', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816453181449, 'login.pureRememberInfo', '勾选并登录后，规定天数内无需输入用户名和密码会自动登入系统', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816453181450, 'buttons.pureContentFullScreen', '内容区全屏', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816532873218, 'menus.pureOnlineUser', '在线用户', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816532873219, 'panel.pureVerticalTip', '左侧菜单，亲切熟悉', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816583204866, 'menus.pureSysMonitor', '系统监控', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816583204867, 'login.pureGetVerifyCode', '获取验证码', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816583204868, 'panel.pureTagsStyleSmart', '灵动', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816583204869, 'menus.pureElButton', '按钮', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816583204870, 'login.pureBack', '返回', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816583204871, 'login.pureVerifyCodeCorrectReg', '请输入正确的验证码', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816583204872, 'menus.pureGuide', '引导页', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816583204873, 'menus.pureGanttastic', '甘特图', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816583204874, 'buttons.pureContentExitFullScreen', '内容区退出全屏', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816650313729, 'panel.pureOverallStyleLightTip', '清新启航，点亮舒适的工作界面', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816717422594, 'menus.purePiniaDoc', 'pinia', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816717422595, 'menus.pureEpDoc', 'element-plus', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816717422596, 'panel.pureClearCache', '清空缓存', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816717422597, 'panel.pureSystemSet', '系统配置', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816717422598, 'menus.pureWavesurfer', '音频可视化', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816717422599, 'menus.pureSystemMenu', '菜单管理', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816717422600, 'menus.pureViteDoc', 'vite', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816717422601, 'panel.pureTagsStyleSmartTip', '灵动标签，添趣生辉', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816717422602, 'menus.pureTailwindcssDoc', 'tailwindcss', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816717422603, 'menus.purePdf', 'PDF预览', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816776142850, 'menus.pureColorPicker', '颜色选择器', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816776142851, 'menus.pureDraggable', '拖拽', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816776142852, 'menus.purePermissionPage', '页面权限', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816776142853, 'buttons.pureAccountSettings', '账户设置', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816776142854, 'panel.pureTagsStyleCard', '卡片', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816776142855, 'menus.pureCheckButton', '可选按钮', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816776142856, 'panel.pureLayoutModel', '导航模式', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816776142857, 'menus.pureVirtualList', '虚拟列表', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816776142858, 'menus.pureLoginLog', '登录日志', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816843251713, 'buttons.pureBackTop', '回到顶部', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816843251714, 'menus.pureMenu2', '菜单二', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816843251715, 'menus.pureProgress', '进度条', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816843251716, 'menus.pureMenus', '多级菜单', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816843251717, 'menus.pureFive', '500', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816843251718, 'menus.pureQrcode', '二维码', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816843251719, 'menus.pureCollapse', '折叠面板', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816843251720, 'panel.pureStretchFixed', '固定', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816843251721, 'menus.pureOperationLog', '操作日志', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816843251722, 'search.purePlaceholder', '搜索菜单（支持拼音搜索）', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816906166274, 'menus.pureWaterfall', '瀑布流无限滚动', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816906166275, 'panel.pureOverallStyleSystemTip', '同步时光，界面随晨昏自然呼应', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816906166276, 'menus.pureWatermark', '水印', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816906166277, 'panel.pureOverallStyleLight', '浅色', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816906166278, 'menus.pureMenuOverflow', '目录超出显示Tooltip文字提示', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816973275137, 'menus.pureContextmenu', '右键菜单', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816973275138, 'menus.purePermission', '权限管理', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816973275139, 'buttons.pureCloseRightTabs', '关闭右侧标签页', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816973275140, 'menus.pureVideo', '视频', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816973275141, 'menus.pureMenuTree', '菜单树结构', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816973275142, 'panel.pureCloseSystemSet', '关闭配置', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816973275143, 'menus.pureUtilsLink', 'pure-admin-utils', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817036189698, 'menus.pureChildMenuOverflow', '菜单超出显示Tooltip文字提示', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817036189699, 'panel.pureStretchCustom', '自定义', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817036189700, 'menus.pureDatePicker', '日期选择器', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817036189701, 'panel.pureTagsStyle', '页签风格', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817036189702, 'panel.pureOverallStyleDarkTip', '月光序曲，沉醉于夜的静谧雅致', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817036189703, 'menus.pureUpload', '文件上传', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817036189704, 'menus.pureRouterDoc', 'vue-router', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817036189705, 'login.pureVerifyCode', '验证码', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817036189706, 'panel.pureThemeColor', '主题色', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817036189707, 'menus.pureExternalLink', 'vue-pure-admin', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817099104258, 'menus.pureFourZeroOne', '403', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817099104259, 'login.pureLogin', '登录', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817099104260, 'menus.pureTimePicker', '时间选择器', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817099104261, 'buttons.pureCloseLeftTabs', '关闭左侧标签页', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817099104262, 'menus.pureVideoFrame', '视频帧截取-wasm版', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817099104263, 'menus.pureVerify', '图形验证码', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817099104264, 'menus.pureMenu1-3', '菜单1-3', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817099104265, 'menus.pureFormDesign', '表单设计器', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817099104266, 'search.pureTotal', '共', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817162018817, 'menus.pureEditor', '编辑器', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817162018818, 'menus.pureCountTo', '数字动画', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817162018819, 'menus.pureFlowChart', '流程图', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817162018820, 'menus.pureSwiper', 'Swiper插件', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817162018821, 'menus.pureMenu1-2-1', '菜单1-2-1', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817162018822, 'buttons.pureClickExpand', '点击展开', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817162018823, 'menus.pureSegmented', '分段控制器', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817162018824, 'menus.pureLineTree', '树形连接线', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817162018825, 'menus.purePermissionButtonLogin', '登录接口返回按钮权限', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817162018826, 'panel.pureStretchCustomTip', '最小1280、最大1600', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817162018827, 'menus.pureBoard', '艺术画板', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817229127681, 'menus.pureMenu1-2', '菜单1-2', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817229127682, 'menus.pureExternalPage', '外部页面', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817229127683, 'menus.pureSeamless', '无缝滚动', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817296236545, 'panel.pureStretchFixedTip', '紧凑页面，轻松找到所需信息', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817296236546, 'menus.pureFourZeroFour', '404', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817296236547, 'menus.pureSelector', '范围选择器', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817296236548, 'menus.pureDateTimePicker', '日期时间选择器', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817296236549, 'menus.pureAbnormal', '异常页面', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817296236550, 'menus.pureExternalDoc', '文档外链', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817296236551, 'buttons.pureConfirm', '确认', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817296236552, 'menus.pureDebounce', '防抖节流', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817296236553, 'login.purePassword', '密码', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817296236554, 'login.pureThirdLogin', '第三方登录', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817359151105, 'menus.pureDrawer', '函数式抽屉', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817359151106, 'menus.purePermissionButtonRouter', '路由返回按钮权限', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817359151107, 'menus.pureEmpty', '无Layout页', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817359151108, 'menus.pureColorHuntDoc', '调色板', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817359151109, 'buttons.pureCloseOtherTabs', '关闭其他标签页', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817359151110, 'panel.pureStretch', '页宽', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817359151111, 'buttons.pureCloseText', '关', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817359151112, 'menus.pureMap', '地图', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817359151113, 'menus.pureRipple', '波纹(Ripple)', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817359151114, 'buttons.pureCloseCurrentTab', '关闭当前标签页', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817417871362, 'menus.pureMenu1-1', '菜单1-1', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817417871363, 'buttons.pureReload', '重新加载', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817417871364, 'panel.pureHiddenTags', '隐藏标签页', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817417871365, 'menus.pureDialog', '函数式弹框', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817417871366, 'buttons.pureOpenText', '开', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817417871367, 'menus.pureCropping', '图片裁剪', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817417871368, 'buttons.pureClose', '关闭', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817417871369, 'menus.pureVxeTable', '虚拟滚动', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817417871370, 'menus.pureAble', '功能', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817417871371, 'menus.pureAnimatecss', 'animate.css选择器', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817480785922, 'search.pureDragSort', '（可拖拽排序）', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817480785923, 'panel.pureHorizontalTip', '顶部菜单，简洁概览', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817543700481, 'menus.pureDanmaku', '弹幕', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817543700482, 'menus.pureUser', '用户管理', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817543700483, 'buttons.pureLoginOut', '退出系统', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817543700484, 'buttons.pureCloseAllTabs', '关闭全部标签页', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817543700485, 'panel.pureMultiTagsCache', '页签持久化', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817543700486, 'status.pureNoMessage', '暂无消息', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817543700487, 'panel.pureOverallStyleSystem', '自动', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817543700488, 'menus.pureSensitive', '敏感词过滤', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817543700489, 'buttons.pureOpenSystemSet', '打开系统配置', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817610809345, 'menus.pureMenu1-2-2', '菜单1-2-2', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817610809346, 'login.pureSure', '确认密码', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817610809347, 'menus.pureHome', '首页', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817610809348, 'menus.pureFail', '失败页面', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817610809349, 'panel.pureHiddenFooter', '隐藏页脚', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817610809350, 'menus.pureLogin', '登录', 'zh', 1, 1, '2024-10-18 22:09:37', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817610809351, 'menus.pureStatistic', '统计组件', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817610809352, 'login.pureRemember', '天内免登录', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817610809353, 'menus.purePrint', '打印', 'zh', 1, 1, '2024-09-30 21:20:51', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622817610809354, 'menus.pureList', '列表页面', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817669529602, 'menus.pureEmbeddedDoc', '文档内嵌', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817669529603, 'menus.pureMqtt', 'MQTT客户端(mqtt)', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817669529604, 'menus.pureMenu1', '菜单1', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817669529605, 'menus.pureTableEdit', '可编辑用法', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817669529606, 'menus.pureComponents', '组件', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817669529607, 'panel.pureMixTip', '混合菜单，灵活多变', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817669529608, 'login.pureQRCodeLogin', '二维码登录', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817669529609, 'menus.pureSysManagement', '系统管理', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817669529610, 'menus.pureResult', '结果页面', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817669529611, 'login.purePhoneCorrectReg', '请输入正确的手机号码格式', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817736638466, 'login.pureRegister', '注册', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817736638467, 'login.pureWeChatLogin', '微信登录', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817736638468, 'login.purePassWordSureReg', '请输入确认密码', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817799553025, 'login.purePhone', '手机号码', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817799553026, 'login.pureAlipayLogin', '支付宝登录', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817799553027, 'login.pureTip', '扫码后点击\"确认\"，即可完成登录', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817799553028, 'login.purePhoneReg', '请输入手机号码', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817799553029, 'login.purePassWordUpdateReg', '修改密码成功', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817799553030, 'login.pureLoginSuccess', '登录成功', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817799553031, 'login.pureReadAccept', '我已仔细阅读并接受', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817799553032, 'login.pureSmsVerifyCode', '短信验证码', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817799553033, 'login.pureWeiBoLogin', '微博登录', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817866661890, 'login.pureTest', '模拟测试', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817866661891, 'login.pureUsernameReg', '请输入账号', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817866661892, 'login.pureQQLogin', 'QQ登录', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817866661893, 'login.pureDefinite', '确定', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817866661894, 'login.purePassWordReg', '请输入密码', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817866661895, 'login.pureVerifyCodeReg', '请输入验证码', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817866661896, 'login.pureInfo', '秒后重新获取', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817866661897, 'login.purePassWordDifferentReg', '两次密码不一致!', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817866661898, 'login.pureTickPrivacy', '请勾选隐私政策', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817866661899, 'menus.pureCheckCard', '多选卡片', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817929576450, 'buttons.pureLogin', '登录', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817929576451, 'menus.pureExcel', '导出Excel', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817929576452, 'login.pureRegisterSuccess', '注册成功', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817929576453, 'login.pureVerifyCodeSixReg', '请输入6位数字验证码', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817929576454, 'login.pureLoginFail', '登录失败', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817929576455, 'login.purePassWordRuleReg', '密码格式应为8-18位数字、字母、符号的任意两种组合', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840622817929576456, 'login.purePrivacyPolicy', '《隐私政策》', 'zh', 1, 1, '2024-09-30 21:20:52', '2024-09-30 21:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1840623074184773633, 'buttons.pureLoginOut', 'LoginOut', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074184773634, 'buttons.pureCloseAllTabs', 'CloseAllTabs', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074184773635, 'buttons.pureAccountSettings', 'Account', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074184773636, 'buttons.pureLogin', 'Login', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074184773637, 'buttons.pureOpenSystemSet', 'OpenSystemConfigs', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074184773638, 'buttons.pureReload', 'Reload', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074184773639, 'buttons.pureCloseCurrentTab', 'CloseCurrentTab', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074184773640, 'buttons.pureCloseLeftTabs', 'CloseLeftTabs', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074184773641, 'buttons.pureCloseOtherTabs', 'CloseOtherTabs', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074184773642, 'buttons.pureCloseRightTabs', 'CloseRightTabs', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074310602754, 'search.pureTotal', 'Total', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074310602755, 'buttons.pureContentExitFullScreen', 'ContentExitFullScreen', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074310602756, 'buttons.pureSwitch', 'Switch', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074310602757, 'buttons.pureBackTop', 'BackTop', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074310602758, 'buttons.pureClose', 'Close', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074310602759, 'menus.pureSchemaForm', 'Form', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074310602760, 'buttons.pureClickExpand', 'Expand', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074310602761, 'menus.pureTableEdit', 'EditUsage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074310602762, 'menus.pureBarcode', 'Barcode', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074310602763, 'buttons.pureConfirm', 'Confirm', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074440626177, 'search.pureCollect', 'Collect', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074440626178, 'panel.pureClearCache', 'ClearCache', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074440626179, 'buttons.pureCloseText', 'Close', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074440626180, 'panel.pureStretchFixed', 'Fixed', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074440626181, 'search.pureHistory', 'History', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074440626182, 'search.pureDragSort', '（DragSort）', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074440626183, 'search.purePlaceholder', 'SearchMenu', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074440626184, 'panel.pureClearCacheAndToLogin', 'Clearcacheandreturntologinpage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074440626185, 'panel.pureSystemSet', 'SystemConfigs', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074440626186, 'panel.pureThemeColor', 'ThemeColor', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074499346433, 'panel.pureOverallStyleLight', 'Light', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074499346434, 'panel.pureOverallStyleSystem', 'Auto', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074499346435, 'search.pureEmpty', 'Empty', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074499346436, 'panel.pureVerticalTip', 'Themenuontheleftisfamiliarandfriendly', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074499346437, 'panel.pureOverallStyleDark', 'Dark', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074499346438, 'panel.pureOverallStyle', 'OverallStyle', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074499346439, 'panel.pureCloseSystemSet', 'CloseSystemConfigs', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074499346440, 'panel.pureOverallStyleDarkTip', 'MoonlightOverture,indulgeinthetranquilityandeleganceofthenight', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074499346441, 'panel.pureOverallStyleLightTip', 'Setsailfreshlyandlightupthecomfortableworkinterface', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074499346442, 'panel.pureOverallStyleSystemTip', 'Synchronizetime,theinterfacenaturallyrespondstomorninganddusk', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074562260994, 'panel.pureLayoutModel', 'LayoutModel', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074562260995, 'panel.pureHorizontalTip', 'Topmenu,conciseoverview', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074562260996, 'panel.pureTagsStyle', 'TagsStyle', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074562260997, 'panel.pureStretch', 'StretchPage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074562260998, 'panel.pureStretchFixedTip', 'Compactpagesmakeiteasytofindtheinformationyouneed', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074562260999, 'panel.pureInterfaceDisplay', 'InterfaceDisplay', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074562261000, 'panel.pureMixTip', 'Mixedmenu,flexible', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074562261001, 'panel.pureStretchCustomTip', 'Minimum1280,maximum1600', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074562261002, 'panel.pureTagsStyleSmart', 'Smart', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074629369858, 'panel.pureHiddenTags', 'HiddenTags', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074629369859, 'panel.pureGreyModel', 'GreyModel', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074629369860, 'panel.pureTagsStyleSmartTip', 'Smarttagsaddfunandbrilliance', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074629369861, 'menus.pureTable', 'Table', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074629369862, 'menus.pureHome', 'Home', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074629369863, 'panel.pureTagsStyleChromeTip', 'Chromestyleisclassicandelegant', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074629369864, 'panel.pureTagsStyleCardTip', 'Cardtagsforefficientbrowsing', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074629369865, 'menus.pureEmpty', 'EmptyPage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074629369866, 'panel.pureWeakModel', 'WeakModel', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074629369867, 'panel.pureTagsStyleCard', 'Card', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074692284417, 'panel.pureStretchCustom', 'Custom', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074692284418, 'menus.pureSysManagement', 'SystemManage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074692284419, 'menus.pureSystemMenu', 'MenuManage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074692284420, 'panel.pureMultiTagsCache', 'MultiTagsCache', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074692284421, 'panel.pureHiddenFooter', 'HiddenFooter', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074692284422, 'menus.pureUser', 'UserManage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074692284423, 'menus.pureOnlineUser', 'OnlineUser', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074692284424, 'menus.pureLogin', 'Login', 'en', 1, 1, '2024-10-18 22:09:43', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074692284425, 'menus.pureRole', 'RoleManage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074692284426, 'menus.pureDept', 'DeptManage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074755198978, 'menus.pureSysMonitor', 'SystemMonitor', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074755198979, 'menus.pureLoginLog', 'LoginLog', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074881028098, 'menus.pureDialog', 'Dialog', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074881028099, 'menus.pureSystemLog', 'SystemLog', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074881028100, 'menus.pureEditor', 'Editor', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074881028101, 'menus.pureComponents', 'Components', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074881028102, 'menus.pureOperationLog', 'OperationLog', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074881028103, 'menus.pureFive', '500', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074881028104, 'menus.pureAbnormal', 'AbnormalPage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074881028105, 'menus.pureFourZeroFour', '404', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074881028106, 'menus.pureFourZeroOne', '403', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623074948136961, 'menus.pureDrawer', 'Drawer', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075011051521, 'menus.pureVideo', 'Video', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075011051522, 'menus.pureWaterfall', 'Waterfall', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075011051523, 'menus.pureMessage', 'MessageTips', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075011051524, 'menus.pureSegmented', 'Segmented', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075011051525, 'menus.pureMap', 'Map', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075011051526, 'menus.pureSplitPane', 'SplitPane', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075011051527, 'menus.pureDraggable', 'Draggable', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075011051528, 'menus.pureText', 'TextEllipsis', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075011051529, 'menus.pureElButton', 'Button', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075011051530, 'menus.pureButton', 'ButtonAnimation', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075073966082, 'menus.pureCheckButton', 'CheckButton', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075073966083, 'menus.pureAnimatecss', 'AnimateCssSelector', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075073966084, 'menus.pureCropping', 'PictureCropping', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075073966085, 'menus.pureCountTo', 'DigitalAnimation', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075073966086, 'menus.pureSelector', 'ScopeSelector', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075073966087, 'menus.pureContextmenu', 'ContextMenu', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075073966088, 'menus.pureFlowChart', 'FlowChart', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075073966089, 'menus.pureJsonEditor', 'JSONEditor', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075073966090, 'menus.pureSeamless', 'SeamlessScroll', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075073966091, 'menus.pureTypeit', 'Typeit', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075136880641, 'menus.pureDatePicker', 'DatePicker', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075136880642, 'menus.pureColorPicker', 'ColorPicker', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075136880643, 'menus.pureStatistic', 'Statistic', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075203989506, 'menus.pureTimePicker', 'TimePicker', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075203989507, 'menus.pureUpload', 'FileUpload', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075203989508, 'menus.pureProgress', 'Progress', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075203989509, 'menus.pureGanttastic', 'GanttChart', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075203989510, 'menus.pureTag', 'Tag', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075203989511, 'menus.pureDateTimePicker', 'DateTimePicker', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075203989512, 'menus.pureCollapse', 'Collapse', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075203989513, 'menus.pureCheckCard', 'CheckCard', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075203989514, 'menus.pureMenu1', 'Menu1', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075271098370, 'menus.pureMenu1-1', 'Menu1-1', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075271098371, 'menus.pureMenu2', 'Menu2', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075271098372, 'menus.pureMenus', 'MultiLevelMenu', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075271098373, 'menus.pureMenu1-2-1', 'Menu1-2-1', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075271098374, 'menus.pureMenu1-2', 'Menu1-2', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075271098375, 'menus.pureMenu1-2-2', 'Menu1-2-2', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075271098376, 'menus.purePermissionButtonRouter', 'Routereturnbuttonpermission', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075271098377, 'menus.pureMenu1-3', 'Menu1-3', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075271098378, 'menus.purePermissionPage', 'PagePermission', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075271098379, 'menus.purePermissionButton', 'ButtonPermission', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075334012930, 'menus.purePermission', 'PermissionManage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075334012931, 'menus.pureTabs', 'TabsOperate', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075334012932, 'menus.purePermissionButtonLogin', 'Logininterfacereturnbuttonpermission', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075334012933, 'menus.pureGuide', 'Guide', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075334012934, 'menus.pureVideoFrame', 'VideoFrameCapture', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075334012935, 'menus.purePrint', 'Print', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075334012936, 'menus.pureMenuTree', 'MenuTree', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075334012937, 'menus.pureWatermark', 'WaterMark', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075334012938, 'menus.pureOptimize', 'Debounce、Throttle、Copy、LongpressDirectives', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075401121793, 'menus.pureMqtt', 'MqttClient', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075401121794, 'menus.pureExternalPage', 'ExternalPage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075401121795, 'menus.pureEmbeddedDoc', 'DocsEmbedded', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075401121796, 'menus.pureVerify', 'Captcha', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075401121797, 'menus.pureDownload', 'Download', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075401121798, 'menus.pureWavesurfer', 'AudioVisualization', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075401121799, 'menus.pureAble', 'Able', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075401121800, 'menus.pureRipple', 'Ripple', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075401121801, 'menus.pureExternalDoc', 'DocsExternal', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075401121802, 'menus.pureTailwindcssDoc', 'Tailwindcss', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075464036354, 'menus.pureRouterDoc', 'Vue-Router', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075464036355, 'menus.purePiniaDoc', 'Pinia', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075464036356, 'menus.pureViteDoc', 'Vite', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075464036357, 'menus.pureEpDoc', 'Element-Plus', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075464036358, 'menus.pureUtilsLink', 'Pure-Admin-Utils', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075464036359, 'menus.pureExternalLink', 'Vue-Pure-Admin', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075464036360, 'menus.pureAbout', 'About', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075531145218, 'menus.pureUiGradients', 'UiGradients', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075531145219, 'menus.pureSuccess', 'SuccessPage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075531145220, 'menus.pureColorHuntDoc', 'ColorHunt', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075531145221, 'menus.pureVueDoc', 'Vue3', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075531145222, 'menus.pureLineTree', 'LineTree', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075531145223, 'menus.pureTimeline', 'TimeLine', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075531145224, 'menus.pureFail', 'FailPage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075531145225, 'menus.pureIconSelect', 'IconSelect', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075531145226, 'menus.pureResult', 'ResultPage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075531145227, 'menus.pureList', 'ListPage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075594059778, 'menus.pureCardList', 'CardListPage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075594059779, 'menus.pureFormDesign', 'FormDesign', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075594059780, 'menus.pureDebounce', 'Debounce&Throttle', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075594059781, 'buttons.pureContentFullScreen', 'ContentFullScreen', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075594059782, 'menus.pureQrcode', 'Qrcode', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075594059783, 'menus.pureVirtualList', 'VirtualList', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075594059784, 'menus.pureCascader', 'AreaCascader', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075594059785, 'menus.pureSwiper', 'SwiperPlugin', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075656974338, 'menus.purePdf', 'PDFPreview', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075656974339, 'menus.purePinyin', 'PinYin', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075656974340, 'menus.pureExcel', 'ExportExcel', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075656974341, 'menus.pureInfiniteScroll', 'TableInfiniteScroll', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075656974342, 'menus.pureSensitive', 'SensitiveFilter', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075656974343, 'menus.pureDanmaku', 'Danmaku', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075656974344, 'menus.pureTableBase', 'BaseUsage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075656974345, 'menus.pureTableHigh', 'HighUsage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075656974346, 'menus.pureBoard', 'PaintBoard', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075715694593, 'buttons.pureOpenText', 'Open', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075724083201, 'buttons.pureClickCollapse', 'Collapse', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075749249025, 'menus.pureMindMap', 'MindMap', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075749249026, 'menus.pureMenuOverflow', 'MenuOverflowShowTooltipText', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075778609154, 'menus.pureVxeTable', 'VirtualUsage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075778609155, 'status.pureNoMessage', 'NoMessage', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075778609156, 'status.pureLoad', 'Loading...', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075778609157, 'status.pureNotify', 'Notify', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075778609158, 'status.pureMessage', 'Message', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075778609159, 'status.pureTodo', 'Todo', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075778609160, 'menus.pureChildMenuOverflow', 'ChildMenuOverflowShowTooltipText', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075778609161, 'login.pureUsername', 'Username', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075778609162, 'status.pureNoNotify', 'NoNotify', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075845718018, 'login.pureRemember', 'daysnoneedtologin', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075845718019, 'login.pureWeiBoLogin', 'WeiboLogin', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075845718020, 'login.pureSure', 'SurePassword', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075845718021, 'login.pureForget', 'ForgetPassword?', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075845718022, 'login.pureSmsVerifyCode', 'SMSVerifyCode', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075845718023, 'login.pureRememberInfo', 'Aftercheckingandloggingin,willautomaticallylogintothesystemwithoutenteringyourusernameandpasswordwithinthespecifiednumberofdays.', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075845718024, 'status.pureNoTodo', 'NoTodo', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075845718025, 'login.purePassword', 'Password', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075845718026, 'login.pureVerifyCode', 'VerifyCode', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075845718027, 'login.pureQQLogin', 'QQLogin', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075845718028, 'login.pureQRCodeLogin', 'QRCodeLogin', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075908632577, 'login.pureWeChatLogin', 'WeChatLogin', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075908632578, 'login.pureBack', 'Back', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075908632579, 'login.pureThirdLogin', 'ThirdLogin', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075908632580, 'login.pureAlipayLogin', 'AlipayLogin', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075908632581, 'login.pureRegister', 'Register', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075908632582, 'login.purePhone', 'Phone', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075908632583, 'login.pureTest', 'MockTest', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075908632584, 'login.pureLogin', 'Login', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075908632585, 'login.purePhoneLogin', 'PhoneLogin', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075908632586, 'login.pureDefinite', 'Definite', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075979935746, 'login.pureLoginFail', 'LoginFail', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075979935747, 'login.pureRegisterSuccess', 'RegistSuccess', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075979935748, 'login.pureLoginSuccess', 'LoginSuccess', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075979935749, 'login.pureReadAccept', 'Ihavereaditcarefullyandaccept', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075979935750, 'login.pureGetVerifyCode', 'GetVerifyCode', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075979935751, 'login.pureInfo', 'Seconds', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075979935752, 'login.purePrivacyPolicy', 'PrivacyPolicy', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075979935753, 'login.pureTickPrivacy', 'PleasetickPrivacyPolicy', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075979935754, 'login.pureTip', 'Afterscanningthecode,click\"Confirm\"tocompletethelogin', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623075979935755, 'login.purePassWordReg', 'Pleaseenterpassword', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623076042850305, 'login.purePassWordRuleReg', 'Thepasswordformatshouldbeanycombinationof8-18digits', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623076042850306, 'login.purePassWordDifferentReg', 'Thetwopasswordsdonotmatch!', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623076042850307, 'login.pureVerifyCodeSixReg', 'Pleaseentera6-digitverifycode', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623076042850308, 'login.purePhoneCorrectReg', 'Pleaseenterthecorrectphonenumberformat', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623076042850309, 'login.pureUsernameReg', 'Pleaseenterusername', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623076109959169, 'login.purePassWordSureReg', 'Pleaseenterconfirmpassword', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623076109959170, 'login.pureVerifyCodeCorrectReg', 'Pleaseentercorrectverifycode', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623076109959171, 'login.pureVerifyCodeReg', 'Pleaseenterverifycode', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623076109959172, 'login.purePhoneReg', 'Pleaseenterthephone', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840623076109959173, 'login.purePassWordUpdateReg', 'Passwordhasbeenupdated', 'en', 1, 1, '2024-09-30 21:21:53', '2024-09-30 21:21:53', 0);
INSERT INTO `sys_i18n` VALUES (1840624204067356674, 'menus.home', '首页', 'zh', 1, 1, '2024-09-30 21:26:22', '2024-09-30 21:26:22', 0);
INSERT INTO `sys_i18n` VALUES (1840624249072238594, 'menus.home', 'home', 'en', 1, 1, '2024-09-30 21:26:33', '2024-09-30 21:26:33', 0);
INSERT INTO `sys_i18n` VALUES (1840624304726458369, 'table.operation', 'operation', 'en', 1, 1, '2024-09-30 21:26:46', '2024-09-30 21:26:46', 0);
INSERT INTO `sys_i18n` VALUES (1840624340386430978, 'table.operation', '操作', 'zh', 1, 1, '2024-09-30 21:26:55', '2024-09-30 21:26:55', 0);
INSERT INTO `sys_i18n` VALUES (1840624448058408962, 'table.updateUser', '更新用户', 'zh', 1, 1, '2024-09-30 21:27:20', '2024-09-30 21:27:20', 0);
INSERT INTO `sys_i18n` VALUES (1840624467247349761, 'table.updateUser', 'updateUser', 'en', 1, 1, '2024-09-30 21:27:25', '2024-09-30 21:27:25', 0);
INSERT INTO `sys_i18n` VALUES (1840624527796322306, 'table.updateTime', 'updateTime', 'en', 1, 1, '2024-09-30 21:27:39', '2024-09-30 21:27:39', 0);
INSERT INTO `sys_i18n` VALUES (1840624560805494785, 'table.updateTime', '更新时间', 'zh', 1, 1, '2024-09-30 21:27:47', '2024-09-30 21:27:47', 0);
INSERT INTO `sys_i18n` VALUES (1840624626299551746, 'i18n.keyName', 'i18nkeyName', 'en', 1, 1, '2024-09-30 21:28:03', '2024-09-30 21:28:03', 0);
INSERT INTO `sys_i18n` VALUES (1840624649577938946, 'i18n.keyName', '多语言key', 'zh', 1, 1, '2024-09-30 21:28:08', '2024-09-30 21:28:08', 0);
INSERT INTO `sys_i18n` VALUES (1840624688777904129, 'id', 'id', 'en', 1, 1, '2024-09-30 21:28:18', '2024-09-30 21:28:18', 0);
INSERT INTO `sys_i18n` VALUES (1840624713004204033, 'id', '主键', 'zh', 1, 1, '2024-09-30 21:28:23', '2024-09-30 21:28:23', 0);
INSERT INTO `sys_i18n` VALUES (1840624849604296705, 'system_setting', '系统设置', 'zh', 1, 1, '2024-09-30 21:28:56', '2024-09-30 21:28:56', 0);
INSERT INTO `sys_i18n` VALUES (1840624933591040001, 'system_menu', '系统菜单', 'zh', 1, 1, '2024-09-30 21:29:16', '2024-09-30 21:29:16', 0);
INSERT INTO `sys_i18n` VALUES (1840624952817729538, 'system_menu', 'systemmenu', 'en', 1, 1, '2024-09-30 21:29:21', '2024-09-30 21:29:21', 0);
INSERT INTO `sys_i18n` VALUES (1840624983046078465, 'system_setting', 'systemsetting', 'en', 1, 1, '2024-09-30 21:29:28', '2024-09-30 21:29:28', 0);
INSERT INTO `sys_i18n` VALUES (1840625073609490434, 'i18n_type_setting', 'i18ntype', 'en', 1, 1, '2024-09-30 21:29:49', '2024-09-30 21:29:49', 0);
INSERT INTO `sys_i18n` VALUES (1840625098888560641, 'i18n_type_setting', '多语言类型', 'zh', 1, 1, '2024-09-30 21:29:55', '2024-09-30 21:29:55', 0);
INSERT INTO `sys_i18n` VALUES (1840625165057900546, 'systemi18n', 'systemi18n', 'en', 1, 1, '2024-09-30 21:30:11', '2024-09-30 21:30:11', 0);
INSERT INTO `sys_i18n` VALUES (1840625190110478337, 'systemi18n', '多语言', 'zh', 1, 1, '2024-09-30 21:30:17', '2024-09-30 21:30:17', 0);
INSERT INTO `sys_i18n` VALUES (1840625220133306370, 'system_i18n', '多语言', 'zh', 1, 1, '2024-09-30 21:30:24', '2024-09-30 21:30:24', 0);
INSERT INTO `sys_i18n` VALUES (1840625245538205698, 'system_i18n', 'systemi18n', 'en', 1, 1, '2024-09-30 21:30:30', '2024-09-30 21:30:30', 0);
INSERT INTO `sys_i18n` VALUES (1840625821000908802, 'buttons.reset', '重置', 'zh', 1, 1, '2024-09-30 21:32:48', '2024-09-30 21:32:48', 0);
INSERT INTO `sys_i18n` VALUES (1840625841406197762, 'buttons.reset', 'reset', 'en', 1, 1, '2024-09-30 21:32:52', '2024-09-30 21:32:52', 0);
INSERT INTO `sys_i18n` VALUES (1840625910868066305, 'i18n.translation', 'translation', 'en', 1, 1, '2024-09-30 21:33:09', '2024-09-30 21:33:09', 0);
INSERT INTO `sys_i18n` VALUES (1840625928060518401, 'i18n.translation', '翻译', 'zh', 1, 1, '2024-09-30 21:33:13', '2024-09-30 21:33:13', 0);
INSERT INTO `sys_i18n` VALUES (1840626513975427073, 'buttons.pureTagsStyleChrome', 'Chrome', 'en', 1, 1, '2024-09-30 21:35:33', '2024-09-30 21:35:33', 0);
INSERT INTO `sys_i18n` VALUES (1840626513975427074, 'buttons.pureTagsStyleChromeTip', 'Chromestyleisclassicandelegant', 'en', 1, 1, '2024-09-30 21:35:33', '2024-09-30 21:35:33', 0);
INSERT INTO `sys_i18n` VALUES (1840626513975427075, 'buttons.pureTagsStyleCardTip', 'Cardtagsforefficientbrowsing', 'en', 1, 1, '2024-09-30 21:35:33', '2024-09-30 21:35:33', 0);
INSERT INTO `sys_i18n` VALUES (1840626513996398594, 'buttons.pureTagsStyleSmart', 'Smart', 'en', 1, 1, '2024-09-30 21:35:33', '2024-09-30 21:35:33', 0);
INSERT INTO `sys_i18n` VALUES (1840626513996398595, 'buttons.pureTagsStyleCard', 'Card', 'en', 1, 1, '2024-09-30 21:35:33', '2024-09-30 21:35:33', 0);
INSERT INTO `sys_i18n` VALUES (1840626513996398596, 'buttons.pureTagsStyle', 'TagsStyle', 'en', 1, 1, '2024-09-30 21:35:33', '2024-09-30 21:35:33', 0);
INSERT INTO `sys_i18n` VALUES (1840626513996398597, 'buttons.pureTagsStyleSmartTip', 'Smarttagsaddfunandbrilliance', 'en', 1, 1, '2024-09-30 21:35:33', '2024-09-30 21:35:33', 0);
INSERT INTO `sys_i18n` VALUES (1840626714077282305, 'buttons.pureTagsStyleSmart', '灵动', 'zh', 1, 1, '2024-09-30 21:36:20', '2024-09-30 21:36:20', 0);
INSERT INTO `sys_i18n` VALUES (1840626714077282306, 'buttons.pureTagsStyle', '页签风格', 'zh', 1, 1, '2024-09-30 21:36:20', '2024-09-30 21:36:20', 0);
INSERT INTO `sys_i18n` VALUES (1840626714077282307, 'buttons.pureTagsStyleSmartTip', '灵动标签，添趣生辉', 'zh', 1, 1, '2024-09-30 21:36:20', '2024-09-30 21:36:20', 0);
INSERT INTO `sys_i18n` VALUES (1840626714077282308, 'buttons.pureTagsStyleChromeTip', '谷歌风格，经典美观', 'zh', 1, 1, '2024-09-30 21:36:20', '2024-09-30 21:36:20', 0);
INSERT INTO `sys_i18n` VALUES (1840626714094059522, 'buttons.pureTagsStyleCardTip', '卡片标签，高效浏览', 'zh', 1, 1, '2024-09-30 21:36:20', '2024-09-30 21:36:20', 0);
INSERT INTO `sys_i18n` VALUES (1840626714094059523, 'buttons.pureTagsStyleChrome', '谷歌', 'zh', 1, 1, '2024-09-30 21:36:20', '2024-09-30 21:36:20', 0);
INSERT INTO `sys_i18n` VALUES (1840626714094059524, 'buttons.pureTagsStyleCard', '卡片', 'zh', 1, 1, '2024-09-30 21:36:20', '2024-09-30 21:36:20', 0);
INSERT INTO `sys_i18n` VALUES (1840626714094059525, 'buttons.pureInterfaceDisplay', '界面显示', 'zh', 1, 1, '2024-09-30 21:36:20', '2024-09-30 21:36:20', 0);
INSERT INTO `sys_i18n` VALUES (1840628069839912961, 'table.createUser', '创建用户', 'zh', 1, 1, '2024-09-30 21:41:44', '2024-09-30 21:41:44', 0);
INSERT INTO `sys_i18n` VALUES (1840628085585330178, 'table.createUser', 'createUser', 'en', 1, 1, '2024-09-30 21:41:47', '2024-09-30 21:41:47', 0);
INSERT INTO `sys_i18n` VALUES (1840628120091869186, 'table.createTime', 'createTime', 'en', 1, 1, '2024-09-30 21:41:56', '2024-09-30 21:41:56', 0);
INSERT INTO `sys_i18n` VALUES (1840628145895227393, 'table.createTime', '创建时间', 'zh', 1, 1, '2024-09-30 21:42:02', '2024-09-30 21:42:02', 0);
INSERT INTO `sys_i18n` VALUES (1840628239633727489, 'i18n.typeId', '类型id', 'zh', 1, 1, '2024-09-30 21:42:24', '2024-09-30 21:42:24', 0);
INSERT INTO `sys_i18n` VALUES (1840628267655872514, 'i18n.typeId', 'typeId', 'en', 1, 1, '2024-09-30 21:42:31', '2024-09-30 21:42:31', 0);
INSERT INTO `sys_i18n` VALUES (1840628457825615873, 'i18n.typeName', 'typeName', 'en', 1, 1, '2024-09-30 21:43:16', '2024-09-30 21:43:16', 0);
INSERT INTO `sys_i18n` VALUES (1840628483540893698, 'i18n.typeName', '类型名称', 'zh', 1, 1, '2024-09-30 21:43:22', '2024-09-30 21:43:22', 0);
INSERT INTO `sys_i18n` VALUES (1840629067752914945, 'panel.pureTagsStyleChrome', 'Chrome', 'en', 1, 1, '2024-09-30 21:45:42', '2024-09-30 21:45:42', 0);
INSERT INTO `sys_i18n` VALUES (1840629106558615553, 'panel.pureTagsStyleChrome', '谷歌', 'zh', 1, 1, '2024-09-30 21:45:51', '2024-09-30 21:45:51', 0);
INSERT INTO `sys_i18n` VALUES (1840631408195518465, 'please_select_animation', '请选择动画', 'zh', 1, 1, '2024-09-30 21:55:00', '2024-09-30 21:55:00', 0);
INSERT INTO `sys_i18n` VALUES (1840631437878607873, 'please_select_animation', 'Pleaseselectanimation', 'en', 1, 1, '2024-09-30 21:55:07', '2024-09-30 21:55:07', 0);
INSERT INTO `sys_i18n` VALUES (1840631608989433857, 'animation_not_exist', '动画不存在', 'zh', 1, 1, '2024-09-30 21:55:48', '2024-09-30 21:55:48', 0);
INSERT INTO `sys_i18n` VALUES (1840631639922425857, 'animation_not_exist', 'Animationdoesnotexist', 'en', 1, 1, '2024-09-30 21:55:55', '2024-09-30 21:55:55', 0);
INSERT INTO `sys_i18n` VALUES (1840632122200276994, 'cancel', '取消', 'zh', 1, 1, '2024-09-30 21:57:50', '2024-09-30 21:57:50', 0);
INSERT INTO `sys_i18n` VALUES (1840632142228078593, 'cancel', 'cancel', 'en', 1, 1, '2024-09-30 21:57:55', '2024-09-30 21:57:55', 0);
INSERT INTO `sys_i18n` VALUES (1840632222834212865, 'confirm', 'confirm', 'en', 1, 1, '2024-09-30 21:58:14', '2024-09-30 21:58:14', 0);
INSERT INTO `sys_i18n` VALUES (1840632242182537218, 'confirm', '确定', 'zh', 1, 1, '2024-09-30 21:58:18', '2024-09-30 21:58:18', 0);
INSERT INTO `sys_i18n` VALUES (1840632586597810177, 'sorry_no_access', '抱歉，你无权访问该页面', 'zh', 1, 1, '2024-09-30 21:59:41', '2024-09-30 21:59:41', 0);
INSERT INTO `sys_i18n` VALUES (1840632615198769153, 'sorry_no_access', 'Sorry,youdonothaveaccesstothispage', 'en', 1, 1, '2024-09-30 21:59:47', '2024-09-30 21:59:47', 0);
INSERT INTO `sys_i18n` VALUES (1840632848200744961, 'return_to_homepage', '返回首页', 'zh', 1, 1, '2024-09-30 22:00:43', '2024-09-30 22:00:43', 0);
INSERT INTO `sys_i18n` VALUES (1840632875962843138, 'return_to_homepage', 'Returntohomepage', 'en', 1, 1, '2024-09-30 22:00:50', '2024-09-30 22:00:50', 0);
INSERT INTO `sys_i18n` VALUES (1840633021773627394, 'sorry_page_not_found', '抱歉，你访问的页面不存在', 'zh', 1, 1, '2024-09-30 22:01:24', '2024-09-30 22:01:24', 0);
INSERT INTO `sys_i18n` VALUES (1840633050957594626, 'sorry_page_not_found', 'Sorry,thepageyouaretryingtoaccessdoesnotexist', 'en', 1, 1, '2024-09-30 22:01:31', '2024-09-30 22:01:31', 0);
INSERT INTO `sys_i18n` VALUES (1840633244000436225, 'sorry_server_error', '抱歉，服务器出错了', 'zh', 1, 1, '2024-09-30 22:02:17', '2024-09-30 22:02:17', 0);
INSERT INTO `sys_i18n` VALUES (1840633267354320897, 'sorry_server_error', 'Sorry,therewasaservererror', 'en', 1, 1, '2024-09-30 22:02:23', '2024-09-30 22:02:23', 0);
INSERT INTO `sys_i18n` VALUES (1840633499433549825, 'input', '输入', 'zh', 1, 1, '2024-09-30 22:03:18', '2024-09-30 22:03:18', 0);
INSERT INTO `sys_i18n` VALUES (1840633523756318721, 'input', 'Input', 'en', 1, 1, '2024-09-30 22:03:24', '2024-09-30 22:03:24', 0);
INSERT INTO `sys_i18n` VALUES (1840633757135781889, 'add_multilingual', '添加多语言', 'zh', 1, 1, '2024-09-30 22:04:20', '2024-09-30 22:04:20', 0);
INSERT INTO `sys_i18n` VALUES (1840633786038730754, 'add_multilingual', 'Addmultilingual', 'en', 1, 1, '2024-09-30 22:04:27', '2024-09-30 22:04:27', 0);
INSERT INTO `sys_i18n` VALUES (1840634611121242113, 'search', '搜索', 'zh', 1, 1, '2024-09-30 22:07:43', '2024-09-30 22:07:43', 0);
INSERT INTO `sys_i18n` VALUES (1840634622747852801, 'search', 'search', 'en', 1, 1, '2024-09-30 22:07:46', '2024-09-30 22:07:46', 0);
INSERT INTO `sys_i18n` VALUES (1840635706920910850, 'multilingual_management', '多语言管理', 'zh', 1, 1, '2024-09-30 22:12:05', '2024-09-30 22:12:05', 0);
INSERT INTO `sys_i18n` VALUES (1840635727644966913, 'multilingual_management', 'Multilingualmanagement', 'en', 1, 1, '2024-09-30 22:12:09', '2024-09-30 22:12:09', 0);
INSERT INTO `sys_i18n` VALUES (1840635826995445762, 'modify', 'modify', 'en', 1, 1, '2024-09-30 22:12:33', '2024-09-30 22:12:33', 0);
INSERT INTO `sys_i18n` VALUES (1840635859077677057, 'modify', '修改', 'zh', 1, 1, '2024-09-30 22:12:41', '2024-09-30 22:12:41', 0);
INSERT INTO `sys_i18n` VALUES (1840635970096709634, 'add_new', '新增', 'zh', 1, 1, '2024-09-30 22:13:07', '2024-09-30 22:13:07', 0);
INSERT INTO `sys_i18n` VALUES (1840635995648409601, 'add_new', 'Addnew', 'en', 1, 1, '2024-09-30 22:13:13', '2024-09-30 22:13:13', 0);
INSERT INTO `sys_i18n` VALUES (1840636123172028417, 'delete', 'delete', 'en', 1, 1, '2024-09-30 22:13:44', '2024-09-30 22:13:44', 0);
INSERT INTO `sys_i18n` VALUES (1840636143061417986, 'delete', '删除', 'zh', 1, 1, '2024-09-30 22:13:49', '2024-09-30 22:13:49', 0);
INSERT INTO `sys_i18n` VALUES (1840636714942185474, 'confirm_delete', '是否确认删除', 'zh', 1, 1, '2024-09-30 22:16:05', '2024-09-30 22:16:05', 0);
INSERT INTO `sys_i18n` VALUES (1840636746160390146, 'confirm_delete', 'Areyousureyouwanttodelete?', 'en', 1, 1, '2024-09-30 22:16:12', '2024-09-30 22:16:12', 0);
INSERT INTO `sys_i18n` VALUES (1840637772653367297, 'i18n_typeName', '多语言类型名称', 'zh', 1, 1, '2024-09-30 22:20:17', '2024-09-30 22:20:17', 0);
INSERT INTO `sys_i18n` VALUES (1840637792601477122, 'i18n_typeName', 'typeName', 'en', 1, 1, '2024-09-30 22:20:22', '2024-09-30 22:20:22', 0);
INSERT INTO `sys_i18n` VALUES (1840637824083922946, 'i18n_summary', 'summary', 'en', 1, 1, '2024-09-30 22:20:29', '2024-09-30 22:20:29', 0);
INSERT INTO `sys_i18n` VALUES (1840637861253844993, 'i18n_summary', '多语言详情解释', 'zh', 1, 1, '2024-09-30 22:20:38', '2024-09-30 22:20:38', 0);
INSERT INTO `sys_i18n` VALUES (1840637894418206721, 'isDefault', '是否默认', 'zh', 1, 1, '2024-09-30 22:21:08', '2024-09-30 22:20:46', 0);
INSERT INTO `sys_i18n` VALUES (1840637915700105217, 'isDefault', 'isDefault', 'en', 1, 1, '2024-09-30 22:20:51', '2024-09-30 22:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840640585928163330, 'continue_adding', '继续添加', 'zh', 1, 1, '2024-09-30 22:31:28', '2024-09-30 22:31:28', 0);
INSERT INTO `sys_i18n` VALUES (1840640614814334977, 'continue_adding', 'Continueadding', 'en', 1, 1, '2024-09-30 22:31:35', '2024-09-30 22:31:35', 0);
INSERT INTO `sys_i18n` VALUES (1840640782846541825, 'update_multilingual', '更新多语言', 'zh', 1, 1, '2024-09-30 22:32:15', '2024-09-30 22:32:15', 0);
INSERT INTO `sys_i18n` VALUES (1840640818317770754, 'update_multilingual', 'Updatemultilingual', 'en', 1, 1, '2024-09-30 22:32:23', '2024-09-30 22:32:23', 0);
INSERT INTO `sys_i18n` VALUES (1840641548629983234, 'delete_warning', '删除警告', 'zh', 1, 1, '2024-09-30 22:35:17', '2024-09-30 22:35:17', 0);
INSERT INTO `sys_i18n` VALUES (1840641573288296450, 'delete_warning', 'DeleteWarning', 'en', 1, 1, '2024-09-30 22:35:23', '2024-09-30 22:35:23', 0);
INSERT INTO `sys_i18n` VALUES (1840641755467890689, 'delete_success', '删除成功', 'zh', 1, 1, '2024-09-30 22:36:07', '2024-09-30 22:36:07', 0);
INSERT INTO `sys_i18n` VALUES (1840641784718966786, 'delete_success', 'Deletedsuccessfully', 'en', 1, 1, '2024-09-30 22:36:14', '2024-09-30 22:36:14', 0);
INSERT INTO `sys_i18n` VALUES (1840641874405769217, 'cancel_delete', '取消删除', 'zh', 1, 1, '2024-09-30 22:36:35', '2024-09-30 22:36:35', 0);
INSERT INTO `sys_i18n` VALUES (1840641902549549057, 'cancel_delete', 'Canceldeletion', 'en', 1, 1, '2024-09-30 22:36:42', '2024-09-30 22:36:42', 0);
INSERT INTO `sys_i18n` VALUES (1840651619317489665, 'avatar', 'avatar', 'en', 1, 1, '2024-09-30 23:15:18', '2024-09-30 23:15:18', 0);
INSERT INTO `sys_i18n` VALUES (1840651657141723137, 'nickName', 'nickName', 'en', 1, 1, '2024-09-30 23:15:27', '2024-09-30 23:15:27', 0);
INSERT INTO `sys_i18n` VALUES (1840651675848318978, 'nickName', '昵称', 'zh', 1, 1, '2024-09-30 23:15:32', '2024-09-30 23:15:32', 0);
INSERT INTO `sys_i18n` VALUES (1840651705091006465, 'username', '用户名', 'zh', 1, 1, '2024-09-30 23:15:39', '2024-09-30 23:15:39', 0);
INSERT INTO `sys_i18n` VALUES (1840651716516290562, 'username', 'username', 'en', 1, 1, '2024-09-30 23:15:42', '2024-09-30 23:15:42', 0);
INSERT INTO `sys_i18n` VALUES (1840651732572086273, 'email', 'email', 'en', 1, 1, '2024-09-30 23:15:45', '2024-09-30 23:15:45', 0);
INSERT INTO `sys_i18n` VALUES (1840651753421971458, 'email', '邮箱', 'zh', 1, 1, '2024-09-30 23:15:50', '2024-09-30 23:15:50', 0);
INSERT INTO `sys_i18n` VALUES (1840651793037172738, 'phone', 'phone', 'en', 1, 1, '2024-09-30 23:16:17', '2024-09-30 23:16:00', 0);
INSERT INTO `sys_i18n` VALUES (1840651822246305793, 'phone', '手机号', 'zh', 1, 1, '2024-09-30 23:16:07', '2024-09-30 23:16:07', 0);
INSERT INTO `sys_i18n` VALUES (1840651900814008322, 'sex', 'sex', 'en', 1, 1, '2024-09-30 23:16:25', '2024-09-30 23:16:25', 0);
INSERT INTO `sys_i18n` VALUES (1840651938634047489, 'sex', '性别', 'zh', 1, 1, '2024-09-30 23:16:34', '2024-09-30 23:16:34', 0);
INSERT INTO `sys_i18n` VALUES (1840652192943087618, 'avatar', '头像', 'zh', 1, 1, '2024-09-30 23:17:35', '2024-09-30 23:17:35', 0);
INSERT INTO `sys_i18n` VALUES (1840652244923097090, 'personDescription', '个人详情', 'zh', 1, 1, '2024-09-30 23:17:48', '2024-09-30 23:17:48', 0);
INSERT INTO `sys_i18n` VALUES (1840652304280887298, 'view_user_info', '查看用户信息', 'zh', 1, 1, '2024-09-30 23:18:02', '2024-09-30 23:18:02', 0);
INSERT INTO `sys_i18n` VALUES (1840652331334148098, 'view_user_info', 'Viewuserinformation', 'en', 1, 1, '2024-09-30 23:18:08', '2024-09-30 23:18:08', 0);
INSERT INTO `sys_i18n` VALUES (1840652486686973954, 'user_status', '用户状态', 'zh', 1, 1, '2024-09-30 23:18:45', '2024-09-30 23:18:45', 0);
INSERT INTO `sys_i18n` VALUES (1840652511882158081, 'user_status', 'Userstatus', 'en', 1, 1, '2024-09-30 23:18:51', '2024-09-30 23:18:51', 0);
INSERT INTO `sys_i18n` VALUES (1840652750135402498, 'user_details', '用户详情', 'zh', 1, 1, '2024-09-30 23:19:48', '2024-09-30 23:19:48', 0);
INSERT INTO `sys_i18n` VALUES (1840652774948904961, 'user_details', 'Userdetails', 'en', 1, 1, '2024-09-30 23:19:54', '2024-09-30 23:19:54', 0);
INSERT INTO `sys_i18n` VALUES (1840652963843579906, 'disable', '禁用', 'zh', 1, 1, '2024-09-30 23:20:39', '2024-09-30 23:20:39', 0);
INSERT INTO `sys_i18n` VALUES (1840652976632012802, 'disable', 'disable', 'en', 1, 1, '2024-09-30 23:20:42', '2024-09-30 23:20:42', 0);
INSERT INTO `sys_i18n` VALUES (1840653070802526210, 'normal', 'normal', 'en', 1, 1, '2024-09-30 23:21:04', '2024-09-30 23:21:04', 0);
INSERT INTO `sys_i18n` VALUES (1840653097419579393, 'normal', '正常', 'zh', 1, 1, '2024-09-30 23:21:11', '2024-09-30 23:21:11', 0);
INSERT INTO `sys_i18n` VALUES (1841028924382728194, 'delete_batches', '批量删除', 'zh', 1, 1, '2024-10-02 00:14:57', '2024-10-02 00:14:35', 0);
INSERT INTO `sys_i18n` VALUES (1841028945958227970, 'delete_batches', 'delete in batches', 'en', 1, 1, '2024-10-02 00:30:53', '2024-10-02 00:14:40', 0);
INSERT INTO `sys_i18n` VALUES (1841502159956189185, 'select_icon', '选择图标', 'zh', 1, 1, '2024-10-03 07:35:03', '2024-10-03 07:35:03', 0);
INSERT INTO `sys_i18n` VALUES (1841502177396105218, 'select_icon', 'Select icon', 'en', 1, 1, '2024-10-03 07:35:07', '2024-10-03 07:35:07', 0);
INSERT INTO `sys_i18n` VALUES (1841514203879153665, 'menuIcon_iconName', '图标名称', 'zh', 1, 1, '2024-10-03 08:22:55', '2024-10-03 08:22:55', 0);
INSERT INTO `sys_i18n` VALUES (1841514234652762114, 'menuIcon_iconName', 'icon name', 'en', 1, 1, '2024-10-03 08:23:02', '2024-10-03 08:23:02', 0);
INSERT INTO `sys_i18n` VALUES (1841514306765430785, 'menuIcon', '菜单图标', 'zh', 1, 1, '2024-10-03 08:23:19', '2024-10-03 08:23:19', 0);
INSERT INTO `sys_i18n` VALUES (1841514333357318146, 'menuIcon', 'menu icon', 'en', 1, 1, '2024-10-03 08:23:25', '2024-10-03 08:23:25', 0);
INSERT INTO `sys_i18n` VALUES (1841514371345129474, 'iconName', 'icon name', 'en', 1, 1, '2024-10-03 08:23:34', '2024-10-03 08:23:34', 0);
INSERT INTO `sys_i18n` VALUES (1841514394548019201, 'iconName', '图标名称', 'zh', 1, 1, '2024-10-03 08:23:40', '2024-10-03 08:23:40', 0);
INSERT INTO `sys_i18n` VALUES (1841515706471784449, 'menuIcon_preview', '图标预览', 'zh', 1, 1, '2024-10-03 08:28:53', '2024-10-03 08:28:53', 0);
INSERT INTO `sys_i18n` VALUES (1841515739887804417, 'menuIcon_preview', 'menu Icon preview', 'en', 1, 1, '2024-10-03 08:29:01', '2024-10-03 08:29:01', 0);
INSERT INTO `sys_i18n` VALUES (1841716682239635457, 'i18n', '多语言管理', 'zh', 1, 1, '2024-10-03 21:47:29', '2024-10-03 21:47:29', 0);
INSERT INTO `sys_i18n` VALUES (1841716695489441794, 'i18n', 'i18n', 'en', 1, 1, '2024-10-03 21:47:32', '2024-10-03 21:47:32', 0);
INSERT INTO `sys_i18n` VALUES (1841728533304279042, 'role', '角色管理', 'zh', 1, 1, '2024-10-03 22:34:35', '2024-10-03 22:34:35', 0);
INSERT INTO `sys_i18n` VALUES (1841728542099734529, 'role', 'role', 'en', 1, 1, '2024-10-03 22:34:37', '2024-10-03 22:34:37', 0);
INSERT INTO `sys_i18n` VALUES (1841728587649875969, 'role_roleCode', 'role Code', 'en', 1, 1, '2024-10-03 22:34:48', '2024-10-03 22:34:48', 0);
INSERT INTO `sys_i18n` VALUES (1841728614023659522, 'role_roleCode', '角色码', 'zh', 1, 1, '2024-10-03 22:34:54', '2024-10-03 22:34:54', 0);
INSERT INTO `sys_i18n` VALUES (1841728639499862018, 'role_description', '角色详情', 'zh', 1, 1, '2024-10-03 22:35:00', '2024-10-03 22:35:00', 0);
INSERT INTO `sys_i18n` VALUES (1841728659913539585, 'role_description', 'description', 'en', 1, 1, '2024-10-03 22:35:05', '2024-10-03 22:35:05', 0);
INSERT INTO `sys_i18n` VALUES (1841730399794724865, 'login.getEmailCode', 'get code', 'en', 1, 1, '2024-10-03 22:42:00', '2024-10-03 22:42:00', 0);
INSERT INTO `sys_i18n` VALUES (1841730422775316481, 'login.getEmailCode', '获取验证码', 'zh', 1, 1, '2024-10-03 22:42:05', '2024-10-03 22:42:05', 0);
INSERT INTO `sys_i18n` VALUES (1841730470758154241, 'login.login', '登录', 'zh', 1, 1, '2024-10-03 22:42:17', '2024-10-03 22:42:17', 0);
INSERT INTO `sys_i18n` VALUES (1841730480505716737, 'login.login', 'login', 'en', 1, 1, '2024-10-03 22:42:19', '2024-10-03 22:42:19', 0);
INSERT INTO `sys_i18n` VALUES (1841730543046983681, 'login.emailCode', 'Enter verification code', 'en', 1, 1, '2024-10-03 22:42:34', '2024-10-03 22:42:34', 0);
INSERT INTO `sys_i18n` VALUES (1841730557194371073, 'login.emailCode', '输入验证码', 'zh', 1, 1, '2024-10-03 22:42:37', '2024-10-03 22:42:37', 0);
INSERT INTO `sys_i18n` VALUES (1841730688719355906, 'login.usernameRegex', '用户名格式错误', 'zh', 1, 1, '2024-10-03 22:43:09', '2024-10-03 22:43:09', 0);
INSERT INTO `sys_i18n` VALUES (1841730726057050113, 'login.usernameRegex', 'The user name format is incorrect', 'en', 1, 1, '2024-10-03 22:43:17', '2024-10-03 22:43:17', 0);
INSERT INTO `sys_i18n` VALUES (1841730770315345922, 'login.username', 'username', 'en', 1, 1, '2024-10-03 22:43:28', '2024-10-03 22:43:28', 0);
INSERT INTO `sys_i18n` VALUES (1841730786949955585, 'login.username', '用户名', 'zh', 1, 1, '2024-10-03 22:43:32', '2024-10-03 22:43:32', 0);
INSERT INTO `sys_i18n` VALUES (1841730823381680130, 'login.password', 'password', 'en', 1, 1, '2024-10-03 22:43:41', '2024-10-03 22:43:41', 0);
INSERT INTO `sys_i18n` VALUES (1841730835448692738, 'login.password', '密码', 'zh', 1, 1, '2024-10-03 22:43:44', '2024-10-03 22:43:44', 0);
INSERT INTO `sys_i18n` VALUES (1841731186721652737, 'roleCode', '角色码', 'zh', 1, 1, '2024-10-03 22:45:07', '2024-10-03 22:45:07', 0);
INSERT INTO `sys_i18n` VALUES (1841731194120404994, 'roleCode', 'roleCode', 'en', 1, 1, '2024-10-03 22:45:09', '2024-10-03 22:45:09', 0);
INSERT INTO `sys_i18n` VALUES (1841731223354703873, 'description', 'description', 'en', 1, 1, '2024-10-03 22:45:16', '2024-10-03 22:45:16', 0);
INSERT INTO `sys_i18n` VALUES (1841731279419965442, 'description', '详情', 'zh', 1, 1, '2024-10-03 22:45:29', '2024-10-03 22:45:29', 0);
INSERT INTO `sys_i18n` VALUES (1841733470847340546, 'login.loginSuccess', '登录成功', 'zh', 1, 1, '2024-10-03 22:54:12', '2024-10-03 22:54:12', 0);
INSERT INTO `sys_i18n` VALUES (1841733512337395714, 'login.loginSuccess', 'Login Success', 'en', 1, 1, '2024-10-03 22:54:22', '2024-10-03 22:54:22', 0);
INSERT INTO `sys_i18n` VALUES (1841750791636717569, 'power', 'power', 'en', 1, 1, '2024-10-04 00:03:01', '2024-10-04 00:03:01', 0);
INSERT INTO `sys_i18n` VALUES (1841750813451292673, 'power', '权限管理', 'zh', 1, 1, '2024-10-04 00:03:07', '2024-10-04 00:03:07', 0);
INSERT INTO `sys_i18n` VALUES (1841750873094295554, 'power_parentId', '权限父级', 'zh', 1, 1, '2024-10-07 00:16:05', '2024-10-04 00:03:21', 0);
INSERT INTO `sys_i18n` VALUES (1841750887887605761, 'power_parentId', 'power parentId', 'en', 1, 1, '2024-10-04 00:03:24', '2024-10-04 00:03:24', 0);
INSERT INTO `sys_i18n` VALUES (1841750943424385026, 'power_powerCode', 'power code', 'en', 1, 1, '2024-10-04 00:03:38', '2024-10-04 00:03:38', 0);
INSERT INTO `sys_i18n` VALUES (1841750959161413634, 'power_powerCode', '权限码', 'zh', 1, 1, '2024-10-04 00:03:41', '2024-10-04 00:03:41', 0);
INSERT INTO `sys_i18n` VALUES (1841751049632550913, 'power_powerName', 'powerName', 'en', 1, 1, '2024-10-04 00:04:03', '2024-10-04 00:04:03', 0);
INSERT INTO `sys_i18n` VALUES (1841751066955026433, 'power_powerName', '权限名称', 'zh', 1, 1, '2024-10-04 00:04:07', '2024-10-04 00:04:07', 0);
INSERT INTO `sys_i18n` VALUES (1841751116561059842, 'power_requestUrl', '请求URL', 'zh', 1, 1, '2024-10-04 00:04:19', '2024-10-04 00:04:19', 0);
INSERT INTO `sys_i18n` VALUES (1841751128472883202, 'power_requestUrl', 'requestUrl', 'en', 1, 1, '2024-10-04 00:04:22', '2024-10-04 00:04:22', 0);
INSERT INTO `sys_i18n` VALUES (1841796250208157697, 'external_chaining', '外链接', 'zh', 1, 1, '2024-10-04 03:03:40', '2024-10-04 03:03:40', 0);
INSERT INTO `sys_i18n` VALUES (1841796259234299905, 'external_chaining', 'External chaining', 'en', 1, 1, '2024-10-04 03:03:42', '2024-10-04 03:03:42', 0);
INSERT INTO `sys_i18n` VALUES (1841796337671979009, 'element_plus', 'element plus', 'en', 1, 1, '2024-10-04 03:04:00', '2024-10-04 03:04:00', 0);
INSERT INTO `sys_i18n` VALUES (1841796361881501698, 'element_plus', '饿了么UI', 'zh', 1, 1, '2024-10-04 03:04:06', '2024-10-04 03:04:06', 0);
INSERT INTO `sys_i18n` VALUES (1841796953085427713, 'pure_admin', '后台管理', 'zh', 1, 1, '2024-10-04 03:06:27', '2024-10-04 03:06:27', 0);
INSERT INTO `sys_i18n` VALUES (1841796971171266562, 'pure_admin', 'pure admin', 'en', 1, 1, '2024-10-04 03:06:32', '2024-10-04 03:06:32', 0);
INSERT INTO `sys_i18n` VALUES (1841803192141946881, 'admin_user', 'admin用户管理', 'zh', 1, 1, '2024-10-04 03:31:15', '2024-10-04 03:31:15', 0);
INSERT INTO `sys_i18n` VALUES (1841803211754512386, 'admin_user', 'admin user', 'en', 1, 1, '2024-10-04 03:31:19', '2024-10-04 03:31:19', 0);
INSERT INTO `sys_i18n` VALUES (1841803580333170689, 'adminUser_username', '用户名', 'zh', 1, 1, '2024-10-04 03:32:47', '2024-10-04 03:32:47', 0);
INSERT INTO `sys_i18n` VALUES (1841803610410524674, 'adminUser_username', 'username', 'en', 1, 1, '2024-10-04 03:32:54', '2024-10-04 03:32:54', 0);
INSERT INTO `sys_i18n` VALUES (1841803639217004545, 'adminUser_summary', 'summary', 'en', 1, 1, '2024-10-04 03:33:01', '2024-10-04 03:33:01', 0);
INSERT INTO `sys_i18n` VALUES (1841803660402434050, 'adminUser_summary', '简介', 'zh', 1, 1, '2024-10-04 03:33:06', '2024-10-04 03:33:06', 0);
INSERT INTO `sys_i18n` VALUES (1841812113845985281, 'adminUser_phone', '手机号', 'zh', 1, 1, '2024-10-04 04:06:42', '2024-10-04 04:06:42', 0);
INSERT INTO `sys_i18n` VALUES (1841812125778780162, 'adminUser_phone', 'phone', 'en', 1, 1, '2024-10-04 04:06:45', '2024-10-04 04:06:45', 0);
INSERT INTO `sys_i18n` VALUES (1841812150026051586, 'adminUser_sex', 'sex', 'en', 1, 1, '2024-10-04 04:06:50', '2024-10-04 04:06:50', 0);
INSERT INTO `sys_i18n` VALUES (1841812176966066178, 'adminUser_sex', '性别', 'zh', 1, 1, '2024-10-04 04:06:57', '2024-10-04 04:06:57', 0);
INSERT INTO `sys_i18n` VALUES (1841812201393692674, 'adminUser_status', 'status', 'en', 1, 1, '2024-10-04 04:07:03', '2024-10-04 04:07:03', 0);
INSERT INTO `sys_i18n` VALUES (1841812220557467650, 'adminUser_status', '状态', 'zh', 1, 1, '2024-10-04 04:07:07', '2024-10-04 04:07:07', 0);
INSERT INTO `sys_i18n` VALUES (1841812298995146754, 'adminUser_nickName', '昵称', 'zh', 1, 1, '2024-10-04 04:07:26', '2024-10-04 04:07:26', 0);
INSERT INTO `sys_i18n` VALUES (1841812311011827713, 'adminUser_nickName', 'nickName', 'en', 1, 1, '2024-10-04 04:07:29', '2024-10-04 04:07:29', 0);
INSERT INTO `sys_i18n` VALUES (1841812335980519425, 'adminUser_email', 'email', 'en', 1, 1, '2024-10-04 04:07:35', '2024-10-04 04:07:35', 0);
INSERT INTO `sys_i18n` VALUES (1841812350509588482, 'adminUser_email', '邮箱', 'zh', 1, 1, '2024-10-04 04:07:38', '2024-10-04 04:07:38', 0);
INSERT INTO `sys_i18n` VALUES (1841812376996618241, 'adminUser_password', '密码', 'zh', 1, 1, '2024-10-04 04:07:45', '2024-10-04 04:07:45', 0);
INSERT INTO `sys_i18n` VALUES (1841812384592502785, 'adminUser_password', 'password', 'en', 1, 1, '2024-10-04 04:07:46', '2024-10-04 04:07:46', 0);
INSERT INTO `sys_i18n` VALUES (1841812402510569474, 'adminUser_avatar', 'avatar', 'en', 1, 1, '2024-10-04 04:07:51', '2024-10-04 04:07:51', 0);
INSERT INTO `sys_i18n` VALUES (1841812423914102785, 'adminUser_avatar', '头像', 'zh', 1, 1, '2024-10-04 04:07:56', '2024-10-04 04:07:56', 0);
INSERT INTO `sys_i18n` VALUES (1842071767704457218, 'dept', '部门管理', 'zh', 1, 1, '2024-10-04 21:18:28', '2024-10-04 21:18:28', 0);
INSERT INTO `sys_i18n` VALUES (1842071781499523073, 'dept', 'dept', 'en', 1, 1, '2024-10-04 21:18:31', '2024-10-04 21:18:31', 0);
INSERT INTO `sys_i18n` VALUES (1842071819848044545, 'dept_parentId', 'parentId', 'en', 1, 1, '2024-10-04 21:18:41', '2024-10-04 21:18:41', 0);
INSERT INTO `sys_i18n` VALUES (1842071846653841409, 'dept_parentId', '部门父级', 'zh', 1, 1, '2024-10-07 00:15:53', '2024-10-04 21:18:47', 0);
INSERT INTO `sys_i18n` VALUES (1842071905986465793, 'dept_deptName', '部门名称', 'zh', 1, 1, '2024-10-04 21:19:01', '2024-10-04 21:19:01', 0);
INSERT INTO `sys_i18n` VALUES (1842071915134242817, 'dept_deptName', 'deptName', 'en', 1, 1, '2024-10-04 21:19:03', '2024-10-04 21:19:03', 0);
INSERT INTO `sys_i18n` VALUES (1842071946604105729, 'dept_summary', 'summary', 'en', 1, 1, '2024-10-04 21:19:11', '2024-10-04 21:19:11', 0);
INSERT INTO `sys_i18n` VALUES (1842071966757736449, 'dept_summary', '部门简介', 'zh', 1, 1, '2024-10-04 21:19:16', '2024-10-04 21:19:16', 0);
INSERT INTO `sys_i18n` VALUES (1842072010714042369, 'dept_remarks', '备注', 'zh', 1, 1, '2024-10-04 21:19:26', '2024-10-04 21:19:26', 0);
INSERT INTO `sys_i18n` VALUES (1842072030364356609, 'dept_remarks', 'remarks', 'en', 1, 1, '2024-10-04 21:19:31', '2024-10-04 21:19:31', 0);
INSERT INTO `sys_i18n` VALUES (1842072163294433282, 'dept_manager', '管理员', 'zh', 1, 1, '2024-10-07 02:07:20', '2024-10-04 21:20:02', 0);
INSERT INTO `sys_i18n` VALUES (1842072177274048514, 'dept_manager', 'managerId', 'en', 1, 1, '2024-10-07 02:07:26', '2024-10-04 21:20:06', 0);
INSERT INTO `sys_i18n` VALUES (1842083185061359618, 'adminUser', 'admin User', 'en', 1, 1, '2024-10-04 22:03:50', '2024-10-04 22:03:50', 0);
INSERT INTO `sys_i18n` VALUES (1842083211523223554, 'adminUser', '后台用户', 'zh', 1, 1, '2024-10-06 00:54:29', '2024-10-04 22:03:57', 0);
INSERT INTO `sys_i18n` VALUES (1842089843728674818, 'format_error', '格式错误', 'zh', 1, 1, '2024-10-04 22:30:18', '2024-10-04 22:30:18', 0);
INSERT INTO `sys_i18n` VALUES (1842089863492235266, 'format_error', 'format error', 'en', 1, 1, '2024-10-04 22:30:22', '2024-10-04 22:30:22', 0);
INSERT INTO `sys_i18n` VALUES (1842093436103868418, 'confirm_update_password', '确认修改密码吗', 'zh', 1, 1, '2024-10-04 22:44:34', '2024-10-04 22:44:34', 0);
INSERT INTO `sys_i18n` VALUES (1842093463375233026, 'confirm_update_password', 'confirm update password', 'en', 1, 1, '2024-10-04 22:44:41', '2024-10-04 22:44:41', 0);
INSERT INTO `sys_i18n` VALUES (1842093536737804290, 'confirm_update_status', 'confirm update status', 'en', 1, 1, '2024-10-04 22:44:58', '2024-10-04 22:44:58', 0);
INSERT INTO `sys_i18n` VALUES (1842093566240538625, 'confirm_update_status', '确认修改状态吗', 'zh', 1, 1, '2024-10-04 22:45:05', '2024-10-04 22:45:05', 0);
INSERT INTO `sys_i18n` VALUES (1842129455721324545, 'systemMenuIcon.officialWebsite', '菜单图标官网', 'zh', 1, 1, '2024-10-05 01:07:42', '2024-10-05 01:07:42', 0);
INSERT INTO `sys_i18n` VALUES (1842129506480791553, 'systemMenuIcon.officialWebsite', 'menu icon officialWebsite', 'en', 1, 1, '2024-10-05 01:07:54', '2024-10-05 01:07:54', 0);
INSERT INTO `sys_i18n` VALUES (1842421456882696194, 'iconCode', '图标类名', 'zh', 1, 1, '2024-10-05 20:28:01', '2024-10-05 20:28:01', 0);
INSERT INTO `sys_i18n` VALUES (1842421468110848002, 'iconCode', 'iconCode', 'en', 1, 1, '2024-10-05 20:28:03', '2024-10-05 20:28:03', 0);
INSERT INTO `sys_i18n` VALUES (1842421504374800386, 'menuIcon_iconCode', 'iconCode', 'en', 1, 1, '2024-10-05 20:28:12', '2024-10-05 20:28:12', 0);
INSERT INTO `sys_i18n` VALUES (1842421542454886401, 'menuIcon_iconCode', '图标类名', 'zh', 1, 1, '2024-10-05 20:28:21', '2024-10-05 20:28:21', 0);
INSERT INTO `sys_i18n` VALUES (1842459763058425858, 'confirm_forcedOffline', '确认强制此用户下线吗', 'zh', 1, 1, '2024-10-05 23:00:13', '2024-10-05 23:00:13', 0);
INSERT INTO `sys_i18n` VALUES (1842459805987127297, 'confirm_forcedOffline', 'Are you sure you want to force this user offline', 'en', 1, 1, '2024-10-05 23:00:24', '2024-10-05 23:00:24', 0);
INSERT INTO `sys_i18n` VALUES (1842818493851754497, 'personDescription', 'person description', 'en', 1, 1, '2024-10-06 22:45:42', '2024-10-06 22:45:42', 0);
INSERT INTO `sys_i18n` VALUES (1842818976683253762, 'i18n_type', '多语言类型', 'zh', 1, 1, '2024-10-06 22:47:37', '2024-10-06 22:47:37', 0);
INSERT INTO `sys_i18n` VALUES (1842819008958423041, 'i18n_type', 'i18n type', 'en', 1, 1, '2024-10-06 22:47:44', '2024-10-06 22:47:44', 0);
INSERT INTO `sys_i18n` VALUES (1843839302994923521, 'adminUser_dept', '部门', 'zh', 1, 1, '2024-10-09 18:22:01', '2024-10-09 18:22:01', 0);
INSERT INTO `sys_i18n` VALUES (1843839320715857921, 'adminUser_dept', 'dept', 'en', 1, 1, '2024-10-09 18:22:06', '2024-10-09 18:22:06', 0);
INSERT INTO `sys_i18n` VALUES (1843934190784688130, 'system_files', '后台文件管理', 'zh', 1, 1, '2024-10-10 00:39:04', '2024-10-10 00:39:04', 0);
INSERT INTO `sys_i18n` VALUES (1843934307294064642, 'system_files', 'files management', 'en', 1, 1, '2024-10-10 00:39:32', '2024-10-10 00:39:32', 0);
INSERT INTO `sys_i18n` VALUES (1843934352957452290, 'files_filename', 'filename', 'en', 1, 1, '2024-10-10 00:39:43', '2024-10-10 00:39:43', 0);
INSERT INTO `sys_i18n` VALUES (1843934375904489474, 'files_filename', '文件名', 'zh', 1, 1, '2024-10-10 00:39:49', '2024-10-10 00:39:49', 0);
INSERT INTO `sys_i18n` VALUES (1843934415549050882, 'files_fileType', '文件类型', 'zh', 1, 1, '2024-10-10 00:39:58', '2024-10-10 00:39:58', 0);
INSERT INTO `sys_i18n` VALUES (1843934442052857857, 'files_fileType', 'file type', 'en', 1, 1, '2024-10-10 00:40:04', '2024-10-10 00:40:04', 0);
INSERT INTO `sys_i18n` VALUES (1843934486097244162, 'files_filepath', 'filepath', 'en', 1, 1, '2024-10-10 00:40:15', '2024-10-10 00:40:15', 0);
INSERT INTO `sys_i18n` VALUES (1843934520696057857, 'files_filepath', '文件存储路径', 'zh', 1, 1, '2024-10-10 00:40:23', '2024-10-10 00:40:23', 0);
INSERT INTO `sys_i18n` VALUES (1843934624882569218, 'files_downloadCount', '下载量', 'zh', 1, 1, '2024-10-10 00:40:48', '2024-10-10 00:40:48', 0);
INSERT INTO `sys_i18n` VALUES (1843934661125550082, 'files_downloadCount', 'download count', 'en', 1, 1, '2024-10-10 00:40:57', '2024-10-10 00:40:57', 0);
INSERT INTO `sys_i18n` VALUES (1844181170454773761, 'update_batches_parent', '批量更新父级', 'zh', 1, 1, '2024-10-10 17:00:29', '2024-10-10 17:00:29', 0);
INSERT INTO `sys_i18n` VALUES (1844181240872943617, 'update_batches_parent', 'Batch updates to the parent', 'en', 1, 1, '2024-10-10 17:00:46', '2024-10-10 17:00:46', 0);
INSERT INTO `sys_i18n` VALUES (1844204105605267458, 'files', '文件', 'zh', 1, 1, '2024-10-10 18:31:37', '2024-10-10 18:31:37', 0);
INSERT INTO `sys_i18n` VALUES (1844204123649163265, 'files', 'files', 'en', 1, 1, '2024-10-10 18:31:41', '2024-10-10 18:31:41', 0);
INSERT INTO `sys_i18n` VALUES (1844293227430772738, 'emailTemplate', '邮件模板', 'zh', 1, 1, '2024-10-11 00:25:45', '2024-10-11 00:25:45', 0);
INSERT INTO `sys_i18n` VALUES (1844293316861722625, 'emailTemplate', 'email template', 'en', 1, 1, '2024-10-11 00:26:07', '2024-10-11 00:26:07', 0);
INSERT INTO `sys_i18n` VALUES (1844293490401050625, 'emailUsers', '邮件用户配置', 'zh', 1, 1, '2024-10-11 00:26:48', '2024-10-11 00:26:48', 0);
INSERT INTO `sys_i18n` VALUES (1844293529705873409, 'emailUsers', 'Mail User Configuration', 'en', 1, 1, '2024-10-11 00:26:57', '2024-10-11 00:26:57', 0);
INSERT INTO `sys_i18n` VALUES (1844294141063430145, 'emailTemplate_templateName', '模板名称', 'zh', 1, 1, '2024-10-11 00:29:23', '2024-10-11 00:29:23', 0);
INSERT INTO `sys_i18n` VALUES (1844294181450383362, 'emailTemplate_templateName', 'Template name', 'en', 1, 1, '2024-10-11 00:29:33', '2024-10-11 00:29:33', 0);
INSERT INTO `sys_i18n` VALUES (1844294308298719233, 'emailTemplate_subject', '主题', 'zh', 1, 1, '2024-10-11 00:30:03', '2024-10-11 00:30:03', 0);
INSERT INTO `sys_i18n` VALUES (1844294363063746561, 'emailTemplate_subject', 'email subject', 'en', 1, 1, '2024-10-11 00:30:16', '2024-10-11 00:30:16', 0);
INSERT INTO `sys_i18n` VALUES (1844294503606484994, 'emailTemplate_body', '模板内容', 'zh', 1, 1, '2024-10-11 00:30:50', '2024-10-11 00:30:50', 0);
INSERT INTO `sys_i18n` VALUES (1844294534854049793, 'emailTemplate_body', 'Template content', 'en', 1, 1, '2024-10-11 00:30:57', '2024-10-11 00:30:57', 0);
INSERT INTO `sys_i18n` VALUES (1844294605473546242, 'emailTemplate_type', '模板类型', 'zh', 1, 1, '2024-10-11 00:31:14', '2024-10-11 00:31:14', 0);
INSERT INTO `sys_i18n` VALUES (1844294636079382529, 'emailTemplate_type', 'Template types', 'en', 1, 1, '2024-10-11 00:31:21', '2024-10-11 00:31:21', 0);
INSERT INTO `sys_i18n` VALUES (1844294770779455489, 'emailUsers_email', '邮箱', 'zh', 1, 1, '2024-10-11 00:31:53', '2024-10-11 00:31:53', 0);
INSERT INTO `sys_i18n` VALUES (1844294790404603906, 'emailUsers_email', 'email', 'en', 1, 1, '2024-10-11 00:31:58', '2024-10-11 00:31:58', 0);
INSERT INTO `sys_i18n` VALUES (1844294868242497538, 'emailUsers_smtpAgreement', 'smtp 协议', 'zh', 1, 1, '2024-10-11 00:32:17', '2024-10-11 00:32:17', 0);
INSERT INTO `sys_i18n` VALUES (1844294903759863809, 'emailUsers_smtpAgreement', 'smtp Protocol', 'en', 1, 1, '2024-10-11 00:32:25', '2024-10-11 00:32:25', 0);
INSERT INTO `sys_i18n` VALUES (1844294971086831617, 'emailUsers_emailTemplate', '关联模板', 'zh', 1, 1, '2024-10-11 00:32:41', '2024-10-11 00:32:41', 0);
INSERT INTO `sys_i18n` VALUES (1844295012593664001, 'emailUsers_emailTemplate', 'Association templates', 'en', 1, 1, '2024-10-11 00:32:51', '2024-10-11 00:32:51', 0);
INSERT INTO `sys_i18n` VALUES (1844295069057384449, 'emailUsers_password', 'password', 'en', 1, 1, '2024-10-11 00:33:04', '2024-10-11 00:33:04', 0);
INSERT INTO `sys_i18n` VALUES (1844295093002665985, 'emailUsers_password', '密码', 'zh', 1, 1, '2024-10-11 00:33:10', '2024-10-11 00:33:10', 0);
INSERT INTO `sys_i18n` VALUES (1844295146853335041, 'emailUsers_host', '主机地址', 'zh', 1, 1, '2024-10-11 00:33:23', '2024-10-11 00:33:23', 0);
INSERT INTO `sys_i18n` VALUES (1844295164578463746, 'emailUsers_host', 'host', 'en', 1, 1, '2024-10-11 00:33:27', '2024-10-11 00:33:27', 0);
INSERT INTO `sys_i18n` VALUES (1844295211680497666, 'emailUsers_port', 'port', 'en', 1, 1, '2024-10-11 00:33:38', '2024-10-11 00:33:38', 0);
INSERT INTO `sys_i18n` VALUES (1844295234430402561, 'emailUsers_port', '端口', 'zh', 1, 1, '2024-10-11 00:33:44', '2024-10-11 00:33:44', 0);
INSERT INTO `sys_i18n` VALUES (1844295317817360386, 'emailUsers_isDefault', '是否默认', 'zh', 1, 1, '2024-10-11 00:34:04', '2024-10-11 00:34:04', 0);
INSERT INTO `sys_i18n` VALUES (1844295331373350913, 'emailUsers_isDefault', 'isDefault', 'en', 1, 1, '2024-10-11 00:34:07', '2024-10-11 00:34:07', 0);
INSERT INTO `sys_i18n` VALUES (1844296437952380929, 'cropper_preview_tips', '温馨提示：右键上方裁剪区可开启功能菜单', 'zh', 1, 1, '2024-10-11 00:38:31', '2024-10-11 00:38:31', 0);
INSERT INTO `sys_i18n` VALUES (1844296467685801986, 'cropper_preview_tips', 'Tips: Right click on the clipping area to open the function menu', 'en', 1, 1, '2024-10-11 00:38:38', '2024-10-11 00:38:38', 0);
INSERT INTO `sys_i18n` VALUES (1844296655930359810, 'image_size', 'Image size', 'en', 1, 1, '2024-10-11 00:39:23', '2024-10-11 00:39:23', 0);
INSERT INTO `sys_i18n` VALUES (1844296699492401153, 'image_size', '图像大小', 'zh', 1, 1, '2024-10-11 00:39:33', '2024-10-11 00:39:33', 0);
INSERT INTO `sys_i18n` VALUES (1844296792836636674, 'pixel', 'pixel', 'en', 1, 1, '2024-10-11 00:39:55', '2024-10-11 00:39:55', 0);
INSERT INTO `sys_i18n` VALUES (1844296817750802434, 'pixel', '像素', 'zh', 1, 1, '2024-10-11 00:40:01', '2024-10-11 00:40:01', 0);
INSERT INTO `sys_i18n` VALUES (1844296897291583489, 'bytes', '字节', 'zh', 1, 1, '2024-10-11 00:40:20', '2024-10-11 00:40:20', 0);
INSERT INTO `sys_i18n` VALUES (1844296913812946946, 'bytes', 'bytes', 'en', 1, 1, '2024-10-11 00:40:24', '2024-10-11 00:40:24', 0);
INSERT INTO `sys_i18n` VALUES (1844297033203810305, 'file_size', 'File size', 'en', 1, 1, '2024-10-11 00:40:53', '2024-10-11 00:40:53', 0);
INSERT INTO `sys_i18n` VALUES (1844297055324569601, 'file_size', '文件大小', 'zh', 1, 1, '2024-10-11 00:40:58', '2024-10-11 00:40:58', 0);
INSERT INTO `sys_i18n` VALUES (1844558055848214530, 'email_user_send_config', 'Email users send configuration management', 'en', 1, 1, '2024-10-11 17:58:05', '2024-10-11 17:58:05', 0);
INSERT INTO `sys_i18n` VALUES (1844558146776530945, 'email_user_send_config', '邮件用户发送配置管理', 'zh', 1, 1, '2024-10-11 17:58:27', '2024-10-11 17:58:27', 0);
INSERT INTO `sys_i18n` VALUES (1844558671299411969, 'enable', 'enable', 'en', 1, 1, '2024-10-11 18:00:32', '2024-10-11 18:00:32', 0);
INSERT INTO `sys_i18n` VALUES (1844558797979975682, 'enable', '已启用', 'zh', 1, 1, '2024-10-11 18:01:02', '2024-10-11 18:01:02', 0);
INSERT INTO `sys_i18n` VALUES (1844559004654305282, 'default', 'default', 'en', 1, 1, '2024-10-11 18:01:52', '2024-10-11 18:01:52', 0);
INSERT INTO `sys_i18n` VALUES (1844559034299645953, 'default', '默认', 'zh', 1, 1, '2024-10-11 18:01:59', '2024-10-11 18:01:59', 0);
INSERT INTO `sys_i18n` VALUES (1844559532901728258, 'man', 'man', 'en', 1, 1, '2024-10-11 18:03:58', '2024-10-11 18:03:58', 0);
INSERT INTO `sys_i18n` VALUES (1844559553797750786, 'man', '男', 'zh', 1, 1, '2024-10-11 18:04:03', '2024-10-11 18:04:03', 0);
INSERT INTO `sys_i18n` VALUES (1844559722232610818, 'female', 'female', 'en', 1, 1, '2024-10-11 18:04:43', '2024-10-11 18:04:43', 0);
INSERT INTO `sys_i18n` VALUES (1844559740263923713, 'female', '女', 'zh', 1, 1, '2024-10-11 18:04:47', '2024-10-11 18:04:47', 0);
INSERT INTO `sys_i18n` VALUES (1844559851270373377, 'upload_avatar', 'upload photo as avatar', 'en', 1, 1, '2024-10-11 18:05:13', '2024-10-11 18:05:13', 0);
INSERT INTO `sys_i18n` VALUES (1844559893720924161, 'upload_avatar', '上传头像', 'zh', 1, 1, '2024-10-11 18:05:24', '2024-10-11 18:05:24', 0);
INSERT INTO `sys_i18n` VALUES (1844560060381593602, 'reset_passwords', 'reset passwords', 'en', 1, 1, '2024-10-11 18:06:03', '2024-10-11 18:06:03', 0);
INSERT INTO `sys_i18n` VALUES (1844560178728075265, 'reset_passwords', '重置密码', 'zh', 1, 1, '2024-10-11 18:06:32', '2024-10-11 18:06:32', 0);
INSERT INTO `sys_i18n` VALUES (1844560262307971074, 'assign_roles', '分配角色', 'zh', 1, 1, '2024-10-11 18:06:51', '2024-10-11 18:06:51', 0);
INSERT INTO `sys_i18n` VALUES (1844560285464723457, 'assign_roles', 'assign roles', 'en', 1, 1, '2024-10-11 18:06:57', '2024-10-11 18:06:57', 0);
INSERT INTO `sys_i18n` VALUES (1844560501022588929, 'forced_offline', '强制下线', 'zh', 1, 1, '2024-10-11 18:07:48', '2024-10-11 18:07:48', 0);
INSERT INTO `sys_i18n` VALUES (1844560530084921346, 'forced_offline', 'Forced offline', 'en', 1, 1, '2024-10-11 18:07:55', '2024-10-11 18:07:55', 0);
INSERT INTO `sys_i18n` VALUES (1844560645558304770, 'userinfo', '用户信息', 'zh', 1, 1, '2024-10-11 18:08:23', '2024-10-11 18:08:23', 0);
INSERT INTO `sys_i18n` VALUES (1844560657025531905, 'userinfo', 'userinfo', 'en', 1, 1, '2024-10-11 18:08:26', '2024-10-11 18:08:26', 0);
INSERT INTO `sys_i18n` VALUES (1844562076713549825, 'hidden', '隐藏', 'zh', 1, 1, '2024-10-11 18:14:04', '2024-10-11 18:14:04', 0);
INSERT INTO `sys_i18n` VALUES (1844562087274807297, 'hidden', 'hidden', 'en', 1, 1, '2024-10-11 18:14:07', '2024-10-11 18:14:07', 0);
INSERT INTO `sys_i18n` VALUES (1844562367865356290, 'show', 'show', 'en', 1, 1, '2024-10-11 18:15:13', '2024-10-11 18:15:13', 0);
INSERT INTO `sys_i18n` VALUES (1844562383967289346, 'show', '显示', 'zh', 1, 1, '2024-10-11 18:15:17', '2024-10-11 18:15:17', 0);
INSERT INTO `sys_i18n` VALUES (1844564091338424321, 'no_default', 'No default', 'en', 1, 1, '2024-10-11 18:22:04', '2024-10-11 18:22:04', 0);
INSERT INTO `sys_i18n` VALUES (1844564130471280641, 'no_default', '不默认', 'zh', 1, 1, '2024-10-11 18:22:14', '2024-10-11 18:22:14', 0);
INSERT INTO `sys_i18n` VALUES (1844604203015266306, 'need_number', '需要数字', 'zh', 1, 1, '2024-10-11 21:01:28', '2024-10-11 21:01:28', 0);
INSERT INTO `sys_i18n` VALUES (1844604230043361281, 'need_number', 'need number', 'en', 1, 1, '2024-10-11 21:01:34', '2024-10-11 21:01:34', 0);
INSERT INTO `sys_i18n` VALUES (1844644169502130177, 'monitoring', '系统监控', 'zh', 1, 1, '2024-10-11 23:40:17', '2024-10-11 23:40:17', 0);
INSERT INTO `sys_i18n` VALUES (1844644182143762434, 'monitoring', 'monitoring', 'en', 1, 1, '2024-10-12 16:44:58', '2024-10-11 23:40:20', 0);
INSERT INTO `sys_i18n` VALUES (1844651505742381058, 'monitoring_server', '服务监控', 'zh', 1, 1, '2024-10-12 00:09:26', '2024-10-12 00:09:26', 0);
INSERT INTO `sys_i18n` VALUES (1844651527384989697, 'monitoring_server', 'monitoring server', 'en', 1, 1, '2024-10-12 00:09:31', '2024-10-12 00:09:31', 0);
INSERT INTO `sys_i18n` VALUES (1844659771528577026, 'no_server', '无服务', 'zh', 1, 1, '2024-10-12 00:42:16', '2024-10-12 00:42:16', 0);
INSERT INTO `sys_i18n` VALUES (1844659789966737409, 'no_server', 'no server', 'en', 1, 1, '2024-10-12 00:42:21', '2024-10-12 00:42:21', 0);
INSERT INTO `sys_i18n` VALUES (1844900103403012098, 'configuration', '系统配置', 'zh', 1, 1, '2024-10-12 16:37:16', '2024-10-12 16:37:16', 0);
INSERT INTO `sys_i18n` VALUES (1844900118364094466, 'configuration', 'configuration', 'en', 1, 1, '2024-10-12 16:37:19', '2024-10-12 16:37:19', 0);
INSERT INTO `sys_i18n` VALUES (1844902107705704450, 'monitor', '系统监控', 'zh', 1, 1, '2024-10-12 16:45:14', '2024-10-12 16:45:14', 0);
INSERT INTO `sys_i18n` VALUES (1844902128467509249, 'monitor', 'monitor', 'en', 1, 1, '2024-10-12 16:45:19', '2024-10-12 16:45:19', 0);
INSERT INTO `sys_i18n` VALUES (1844934839320145921, 'Interface_documentation', '接口文档', 'zh', 1, 1, '2024-10-12 18:55:18', '2024-10-12 18:55:18', 0);
INSERT INTO `sys_i18n` VALUES (1844934862648864770, 'Interface_documentation', 'Interface documentation', 'en', 1, 1, '2024-10-12 18:55:23', '2024-10-12 18:55:23', 0);
INSERT INTO `sys_i18n` VALUES (1844936112886980609, 'swagger', 'swagger', 'zh', 1, 1, '2024-10-12 19:00:21', '2024-10-12 19:00:21', 0);
INSERT INTO `sys_i18n` VALUES (1844936128821141505, 'swagger', 'swagger', 'en', 1, 1, '2024-10-12 19:00:25', '2024-10-12 19:00:25', 0);
INSERT INTO `sys_i18n` VALUES (1844954974030340098, 'external_pages', '外部页面', 'zh', 1, 1, '2024-10-12 20:15:18', '2024-10-12 20:15:18', 0);
INSERT INTO `sys_i18n` VALUES (1844955005282099201, 'external_pages', 'External pages', 'en', 1, 1, '2024-10-12 20:15:26', '2024-10-12 20:15:26', 0);
INSERT INTO `sys_i18n` VALUES (1844959128110993409, 'external_page', 'external page', 'en', 1, 1, '2024-10-12 20:31:48', '2024-10-12 20:31:48', 0);
INSERT INTO `sys_i18n` VALUES (1844959150793789441, 'external_page', '外部页面', 'zh', 1, 1, '2024-10-12 20:31:54', '2024-10-12 20:31:54', 0);
INSERT INTO `sys_i18n` VALUES (1844959641233756161, 'external_doc', 'external doc', 'en', 1, 1, '2024-10-12 20:33:51', '2024-10-12 20:33:51', 0);
INSERT INTO `sys_i18n` VALUES (1844959655108513794, 'external_doc', '文档外链', 'zh', 1, 1, '2024-10-12 20:33:54', '2024-10-12 20:33:54', 0);
INSERT INTO `sys_i18n` VALUES (1844960098299645954, 'embedded_doc', '文档内嵌', 'zh', 1, 1, '2024-10-12 20:35:40', '2024-10-12 20:35:40', 0);
INSERT INTO `sys_i18n` VALUES (1844960129098420225, 'embedded_doc', 'embedded doc', 'en', 1, 1, '2024-10-12 20:35:47', '2024-10-12 20:35:47', 0);
INSERT INTO `sys_i18n` VALUES (1844960249751769089, 'iconify', 'iconify', 'en', 1, 1, '2024-10-12 20:36:16', '2024-10-12 20:36:16', 0);
INSERT INTO `sys_i18n` VALUES (1844960292177154049, 'iconify', 'iconify图标', 'zh', 1, 1, '2024-10-12 20:36:26', '2024-10-12 20:36:26', 0);
INSERT INTO `sys_i18n` VALUES (1844960334082445313, '404', '404', 'zh', 1, 1, '2024-10-12 20:36:36', '2024-10-12 20:36:36', 0);
INSERT INTO `sys_i18n` VALUES (1844960346455642113, '404', '404', 'en', 1, 1, '2024-10-12 20:36:39', '2024-10-12 20:36:39', 0);
INSERT INTO `sys_i18n` VALUES (1844960385240371202, 'knife4j', 'knife4j', 'en', 1, 1, '2024-10-12 20:36:48', '2024-10-12 20:36:48', 0);
INSERT INTO `sys_i18n` VALUES (1844960408090939393, 'knife4j', 'knife4j', 'zh', 1, 1, '2024-10-12 20:36:54', '2024-10-12 20:36:54', 0);
INSERT INTO `sys_i18n` VALUES (1844962203596935169, 'knife4j_Interface_documentation', 'knife4j接口文档', 'zh', 1, 1, '2024-10-12 20:44:02', '2024-10-12 20:44:02', 0);
INSERT INTO `sys_i18n` VALUES (1844962249914634241, 'knife4j_Interface_documentation', 'knife4j swagger', 'en', 1, 1, '2024-10-12 20:44:13', '2024-10-12 20:44:13', 0);
INSERT INTO `sys_i18n` VALUES (1845012372040376321, 'download', '下载', 'zh', 1, 1, '2024-10-13 00:03:23', '2024-10-13 00:03:23', 0);
INSERT INTO `sys_i18n` VALUES (1845012381687275521, 'download', 'download', 'en', 1, 1, '2024-10-13 00:03:25', '2024-10-13 00:03:25', 0);
INSERT INTO `sys_i18n` VALUES (1845153335302008833, 'no_data', '无数据', 'zh', 1, 1, '2024-10-13 09:23:31', '2024-10-13 09:23:31', 0);
INSERT INTO `sys_i18n` VALUES (1845153362330103809, 'no_data', 'no data', 'en', 1, 1, '2024-10-13 09:23:38', '2024-10-13 09:23:38', 0);
INSERT INTO `sys_i18n` VALUES (1845169963913723905, 'download_batch', '批量下载', 'zh', 1, 1, '2024-10-13 10:29:36', '2024-10-13 10:29:36', 0);
INSERT INTO `sys_i18n` VALUES (1845170015587549186, 'download_batch', 'batch download', 'en', 1, 1, '2024-10-13 10:29:48', '2024-10-13 10:29:48', 0);
INSERT INTO `sys_i18n` VALUES (1845694618749558786, 'drop_file_here', '拖拽文件到此处', 'zh', 1, 1, '2024-10-14 21:15:00', '2024-10-14 21:14:23', 0);
INSERT INTO `sys_i18n` VALUES (1845694640245366785, 'drop_file_here', 'Drop file here', 'en', 1, 1, '2024-10-14 21:15:07', '2024-10-14 21:14:28', 0);
INSERT INTO `sys_i18n` VALUES (1845695055984779266, 'click_to_upload', 'click to upload', 'en', 1, 1, '2024-10-14 21:16:07', '2024-10-14 21:16:07', 0);
INSERT INTO `sys_i18n` VALUES (1845695096321400833, 'click_to_upload', '点击上传文件', 'zh', 1, 1, '2024-10-14 21:16:17', '2024-10-14 21:16:17', 0);
INSERT INTO `sys_i18n` VALUES (1845728756311470081, 'emailTemplate_emailUser', '邮件模板用户', 'zh', 1, 1, '2024-10-14 23:30:02', '2024-10-14 23:30:02', 0);
INSERT INTO `sys_i18n` VALUES (1845728797554061313, 'emailTemplate_emailUser', 'email user', 'en', 1, 1, '2024-10-14 23:30:12', '2024-10-14 23:30:12', 0);
INSERT INTO `sys_i18n` VALUES (1845747295038627841, 'login.getCodeInfo', '秒后获取验证码', 'zh', 1, 1, '2024-10-15 00:46:22', '2024-10-15 00:43:42', 0);
INSERT INTO `sys_i18n` VALUES (1845747342224547841, 'login.getCodeInfo', 'Then get the CAPtCHA', 'en', 1, 1, '2024-10-15 00:44:53', '2024-10-15 00:43:53', 0);
INSERT INTO `sys_i18n` VALUES (1845812211793883137, 'schedulers', 'schedulers', 'en', 1, 1, '2024-10-15 05:01:39', '2024-10-15 05:01:39', 0);
INSERT INTO `sys_i18n` VALUES (1845812245377675265, 'schedulers', '调度任务', 'zh', 1, 1, '2024-10-15 05:01:47', '2024-10-15 05:01:47', 0);
INSERT INTO `sys_i18n` VALUES (1845813667406110721, 'schedulers_jobName', '任务名称', 'zh', 1, 1, '2024-10-15 05:07:27', '2024-10-15 05:07:27', 0);
INSERT INTO `sys_i18n` VALUES (1845813783856766978, 'schedulers_jobName', 'job name', 'en', 1, 1, '2024-10-15 05:07:54', '2024-10-15 05:07:54', 0);
INSERT INTO `sys_i18n` VALUES (1845813842665103361, 'schedulers_jobGroup', 'job group', 'en', 1, 1, '2024-10-15 05:08:08', '2024-10-15 05:08:08', 0);
INSERT INTO `sys_i18n` VALUES (1845813892493434881, 'schedulers_jobGroup', '任务分组', 'zh', 1, 1, '2024-10-15 05:08:20', '2024-10-15 05:08:20', 0);
INSERT INTO `sys_i18n` VALUES (1845814247906172930, 'schedulers_jobClassName', '任务类名', 'zh', 1, 1, '2024-10-15 05:09:45', '2024-10-15 05:09:45', 0);
INSERT INTO `sys_i18n` VALUES (1845814307473678337, 'schedulers_jobClassName', 'job class name', 'en', 1, 1, '2024-10-15 05:09:59', '2024-10-15 05:09:59', 0);
INSERT INTO `sys_i18n` VALUES (1845814364751093761, 'schedulers_cronExpression', 'cron expression', 'en', 1, 1, '2024-10-15 05:10:13', '2024-10-15 05:10:13', 0);
INSERT INTO `sys_i18n` VALUES (1845814398544601090, 'schedulers_cronExpression', 'cron表达式', 'zh', 1, 1, '2024-10-15 05:10:21', '2024-10-15 05:10:21', 0);
INSERT INTO `sys_i18n` VALUES (1845814446418386945, 'schedulers_triggerName', '触发器名称', 'zh', 1, 1, '2024-10-15 05:10:32', '2024-10-15 05:10:32', 0);
INSERT INTO `sys_i18n` VALUES (1845814475761737730, 'schedulers_triggerName', 'trigger name', 'en', 1, 1, '2024-10-15 05:10:39', '2024-10-15 05:10:39', 0);
INSERT INTO `sys_i18n` VALUES (1845814538957316097, 'schedulers_triggerState', 'trigger state', 'en', 1, 1, '2024-10-15 05:10:54', '2024-10-15 05:10:54', 0);
INSERT INTO `sys_i18n` VALUES (1845814585149186050, 'schedulers_triggerState', '触发器状态', 'zh', 1, 1, '2024-10-15 05:11:05', '2024-10-15 05:11:05', 0);
INSERT INTO `sys_i18n` VALUES (1846108511321853954, 'schedulers_description', '调度器详情信息', 'zh', 1, 1, '2024-10-16 00:39:03', '2024-10-16 00:39:03', 0);
INSERT INTO `sys_i18n` VALUES (1846108529533521922, 'schedulers_description', 'schedulers description', 'en', 1, 1, '2024-10-16 00:39:07', '2024-10-16 00:39:07', 0);
INSERT INTO `sys_i18n` VALUES (1846108688728330242, 'schedulers_jobMethodName', '方法名称', 'zh', 1, 1, '2024-10-16 00:39:45', '2024-10-16 00:39:45', 0);
INSERT INTO `sys_i18n` VALUES (1846108702896689154, 'schedulers_jobMethodName', 'job method name', 'en', 1, 1, '2024-10-16 00:39:48', '2024-10-16 00:39:48', 0);
INSERT INTO `sys_i18n` VALUES (1846166712669290497, 'schedulersGroup', '任务调度分组', 'zh', 1, 1, '2024-10-16 04:30:19', '2024-10-16 04:30:19', 0);
INSERT INTO `sys_i18n` VALUES (1846166744009129985, 'schedulersGroup', 'schedulers group', 'en', 1, 1, '2024-10-16 04:30:27', '2024-10-16 04:30:27', 0);
INSERT INTO `sys_i18n` VALUES (1846166844051668994, 'schedulersGroup_description', 'Task scheduling details', 'en', 1, 1, '2024-10-16 04:30:50', '2024-10-16 04:30:50', 0);
INSERT INTO `sys_i18n` VALUES (1846166863429353474, 'schedulersGroup_description', '任务调度详情', 'zh', 1, 1, '2024-10-16 04:30:55', '2024-10-16 04:30:55', 0);
INSERT INTO `sys_i18n` VALUES (1846167004513157122, 'schedulersGroup_groupName', '分组名称', 'zh', 1, 1, '2024-10-16 04:31:29', '2024-10-16 04:31:29', 0);
INSERT INTO `sys_i18n` VALUES (1846167025753112578, 'schedulersGroup_groupName', 'Group name', 'en', 1, 1, '2024-10-16 04:31:34', '2024-10-16 04:31:34', 0);
INSERT INTO `sys_i18n` VALUES (1846181942593871873, 'select', '选择', 'zh', 1, 1, '2024-10-16 05:30:50', '2024-10-16 05:30:50', 0);
INSERT INTO `sys_i18n` VALUES (1846181955273252866, 'select', 'select', 'en', 1, 1, '2024-10-16 05:30:53', '2024-10-16 05:30:53', 0);
INSERT INTO `sys_i18n` VALUES (1846721170048233473, 'system_file', '系统文件管理', 'zh', 1, 1, '2024-10-17 17:13:32', '2024-10-17 17:13:32', 0);
INSERT INTO `sys_i18n` VALUES (1846721211487956994, 'system_file', 'system file', 'en', 1, 1, '2024-10-17 17:13:42', '2024-10-17 17:13:42', 0);
INSERT INTO `sys_i18n` VALUES (1846722381619081217, 'take_back', 'take back', 'en', 1, 1, '2024-10-17 17:18:21', '2024-10-17 17:18:21', 0);
INSERT INTO `sys_i18n` VALUES (1846722416603770882, 'take_back', '收回', 'zh', 1, 1, '2024-10-17 17:18:29', '2024-10-17 17:18:29', 0);
INSERT INTO `sys_i18n` VALUES (1846722608895832065, 'add', '添加', 'zh', 1, 1, '2024-10-17 17:19:15', '2024-10-17 17:19:15', 0);
INSERT INTO `sys_i18n` VALUES (1846722624137932802, 'add', 'add', 'en', 1, 1, '2024-10-17 17:19:19', '2024-10-17 17:19:19', 0);
INSERT INTO `sys_i18n` VALUES (1846722757160284162, 'total', '总数', 'zh', 1, 1, '2024-10-17 17:19:50', '2024-10-17 17:19:50', 0);
INSERT INTO `sys_i18n` VALUES (1846722773543235586, 'total', 'total', 'en', 1, 1, '2024-10-17 17:19:54', '2024-10-17 17:19:54', 0);
INSERT INTO `sys_i18n` VALUES (1846722967924060161, 'not_added', 'not added', 'en', 1, 1, '2024-10-17 17:20:41', '2024-10-17 17:20:41', 0);
INSERT INTO `sys_i18n` VALUES (1846722991999365121, 'not_added', '未添加', 'zh', 1, 1, '2024-10-17 17:20:46', '2024-10-17 17:20:46', 0);
INSERT INTO `sys_i18n` VALUES (1846723119468457986, 'added', '已添加', 'zh', 1, 1, '2024-10-17 17:21:17', '2024-10-17 17:21:17', 0);
INSERT INTO `sys_i18n` VALUES (1846723128570097665, 'added', 'added', 'en', 1, 1, '2024-10-17 17:21:19', '2024-10-17 17:21:19', 0);
INSERT INTO `sys_i18n` VALUES (1846723242105712642, 'Searching_for_roles', 'Searching for roles', 'en', 1, 1, '2024-10-17 17:21:46', '2024-10-17 17:21:46', 0);
INSERT INTO `sys_i18n` VALUES (1846723280617811970, 'Searching_for_roles', '搜索角色', 'zh', 1, 1, '2024-10-17 17:21:55', '2024-10-17 17:21:55', 0);
INSERT INTO `sys_i18n` VALUES (1846724078055665666, 'fold_all', 'Fold all', 'en', 1, 1, '2024-10-17 17:25:05', '2024-10-17 17:25:05', 0);
INSERT INTO `sys_i18n` VALUES (1846724104735633409, 'fold_all', '折叠全部', 'zh', 1, 1, '2024-10-17 17:25:12', '2024-10-17 17:25:12', 0);
INSERT INTO `sys_i18n` VALUES (1846724227280613378, 'unfold_all', '展开全部', 'zh', 1, 1, '2024-10-17 17:25:41', '2024-10-17 17:25:41', 0);
INSERT INTO `sys_i18n` VALUES (1846724256506523650, 'unfold_all', 'Unfold All', 'en', 1, 1, '2024-10-17 17:25:48', '2024-10-17 17:25:48', 0);
INSERT INTO `sys_i18n` VALUES (1846724760791887874, 'Searching_for_router', '搜索路由', 'zh', 1, 1, '2024-10-17 17:27:48', '2024-10-17 17:27:48', 0);
INSERT INTO `sys_i18n` VALUES (1846724796934205442, 'Searching_for_router', 'Searching routes', 'en', 1, 1, '2024-10-17 17:27:57', '2024-10-17 17:27:57', 0);
INSERT INTO `sys_i18n` VALUES (1846726171617341441, 'crop_and_upload_avatars', 'Crop and upload avatars', 'en', 1, 1, '2024-10-17 17:33:24', '2024-10-17 17:33:24', 0);
INSERT INTO `sys_i18n` VALUES (1846726203942842370, 'crop_and_upload_avatars', '裁剪、上传头像', 'zh', 1, 1, '2024-10-17 17:33:32', '2024-10-17 17:33:32', 0);
INSERT INTO `sys_i18n` VALUES (1846726909902925826, 'power_setting', '权限设置', 'zh', 1, 1, '2024-10-17 17:36:21', '2024-10-17 17:36:21', 0);
INSERT INTO `sys_i18n` VALUES (1846726933797875713, 'power_setting', 'power setting', 'en', 1, 1, '2024-10-17 17:36:26', '2024-10-17 17:36:26', 0);
INSERT INTO `sys_i18n` VALUES (1846741328917647362, 'lastLoginIpAddress', '归属地', 'zh', 1, 1, '2024-10-17 18:33:38', '2024-10-17 18:33:38', 0);
INSERT INTO `sys_i18n` VALUES (1846741373821865986, 'lastLoginIpAddress', 'ip address', 'en', 1, 1, '2024-10-17 18:33:49', '2024-10-17 18:33:49', 0);
INSERT INTO `sys_i18n` VALUES (1846741404901658626, 'lastLoginIp', 'IP', 'en', 1, 1, '2024-10-17 18:33:56', '2024-10-17 18:33:56', 0);
INSERT INTO `sys_i18n` VALUES (1846741428301680642, 'lastLoginIp', 'IP地址', 'zh', 1, 1, '2024-10-17 18:34:02', '2024-10-17 18:34:02', 0);
INSERT INTO `sys_i18n` VALUES (1846804376957161474, 'scheduler', '定时任务', 'zh', 1, 1, '2024-10-17 14:44:10', '2024-10-17 14:44:10', 0);
INSERT INTO `sys_i18n` VALUES (1846804387132542978, 'scheduler', 'scheduler', 'en', 1, 1, '2024-10-17 14:44:13', '2024-10-17 14:44:13', 0);
INSERT INTO `sys_i18n` VALUES (1847141605097324546, 'quartzExecuteLog', '任务执行日志', 'zh', 1, 1, '2024-10-19 02:36:19', '2024-10-18 13:04:12', 0);
INSERT INTO `sys_i18n` VALUES (1847141637393465345, 'quartzExecuteLog', 'Execute Log', 'en', 1, 1, '2024-10-19 02:36:23', '2024-10-18 13:04:19', 0);
INSERT INTO `sys_i18n` VALUES (1847141821846372354, 'quartzExecuteLog_jobName', '任务名称', 'zh', 1, 1, '2024-10-18 13:05:03', '2024-10-18 13:05:03', 0);
INSERT INTO `sys_i18n` VALUES (1847141856860422146, 'quartzExecuteLog_jobName', 'job name', 'en', 1, 1, '2024-10-18 13:05:12', '2024-10-18 13:05:12', 0);
INSERT INTO `sys_i18n` VALUES (1847141909066924033, 'quartzExecuteLog_jobGroup', 'job group', 'en', 1, 1, '2024-10-18 13:05:24', '2024-10-18 13:05:24', 0);
INSERT INTO `sys_i18n` VALUES (1847141930059415553, 'quartzExecuteLog_jobGroup', '任务分组', 'zh', 1, 1, '2024-10-18 13:05:29', '2024-10-18 13:05:29', 0);
INSERT INTO `sys_i18n` VALUES (1847141983062835202, 'quartzExecuteLog_jobClassName', '任务类名称', 'zh', 1, 1, '2024-10-18 13:05:42', '2024-10-18 13:05:42', 0);
INSERT INTO `sys_i18n` VALUES (1847142014981488641, 'quartzExecuteLog_jobClassName', 'job class name', 'en', 1, 1, '2024-10-18 13:05:49', '2024-10-18 13:05:49', 0);
INSERT INTO `sys_i18n` VALUES (1847142081477984257, 'quartzExecuteLog_cronExpression', 'cron expression', 'en', 1, 1, '2024-10-18 13:06:05', '2024-10-18 13:06:05', 0);
INSERT INTO `sys_i18n` VALUES (1847142109676290050, 'quartzExecuteLog_cronExpression', 'cron表达式', 'zh', 1, 1, '2024-10-18 13:06:12', '2024-10-18 13:06:12', 0);
INSERT INTO `sys_i18n` VALUES (1847142161954095105, 'quartzExecuteLog_triggerName', '触发器名称', 'zh', 1, 1, '2024-10-18 13:06:24', '2024-10-18 13:06:24', 0);
INSERT INTO `sys_i18n` VALUES (1847142207181275138, 'quartzExecuteLog_triggerName', 'trigger name', 'en', 1, 1, '2024-10-18 13:06:35', '2024-10-18 13:06:35', 0);
INSERT INTO `sys_i18n` VALUES (1847142250885922817, 'quartzExecuteLog_executeResult', 'result', 'en', 1, 1, '2024-10-18 13:06:46', '2024-10-18 13:06:46', 0);
INSERT INTO `sys_i18n` VALUES (1847142295274242049, 'quartzExecuteLog_executeResult', '执行结果', 'zh', 1, 1, '2024-10-18 13:06:56', '2024-10-18 13:06:56', 0);
INSERT INTO `sys_i18n` VALUES (1847142411544543233, 'quartzExecuteLog_duration', '执行时间', 'zh', 1, 1, '2024-10-18 13:07:24', '2024-10-18 13:07:24', 0);
INSERT INTO `sys_i18n` VALUES (1847142430951587841, 'quartzExecuteLog_duration', 'duration', 'en', 1, 1, '2024-10-18 13:07:28', '2024-10-18 13:07:28', 0);
INSERT INTO `sys_i18n` VALUES (1847142538338353154, 'quartzExecuteLog_endTime', 'end time', 'en', 1, 1, '2024-10-18 13:07:54', '2024-10-18 13:07:54', 0);
INSERT INTO `sys_i18n` VALUES (1847142563105718274, 'quartzExecuteLog_endTime', '结束时间', 'zh', 1, 1, '2024-10-18 13:08:00', '2024-10-18 13:08:00', 0);
INSERT INTO `sys_i18n` VALUES (1847149633842397185, 'confirm_update_sort', '是否确认更新排序', 'zh', 1, 1, '2024-10-18 13:36:06', '2024-10-18 13:36:06', 0);
INSERT INTO `sys_i18n` VALUES (1847149685306507266, 'confirm_update_sort', 'confirm update sort', 'en', 1, 1, '2024-10-18 13:36:18', '2024-10-18 13:36:18', 0);
INSERT INTO `sys_i18n` VALUES (1847292350901882881, 'userLoginLog', '用户登录日志', 'zh', 1, 1, '2024-10-18 23:03:12', '2024-10-18 23:03:12', 0);
INSERT INTO `sys_i18n` VALUES (1847292378651398146, 'userLoginLog', 'user login log', 'en', 1, 1, '2024-10-18 23:03:19', '2024-10-18 23:03:19', 0);
INSERT INTO `sys_i18n` VALUES (1847292460075421698, 'userLoginLog_userId', 'user id', 'en', 1, 1, '2024-10-18 23:03:38', '2024-10-18 23:03:38', 0);
INSERT INTO `sys_i18n` VALUES (1847292488735100930, 'userLoginLog_userId', '用户ID', 'zh', 1, 1, '2024-10-18 23:03:45', '2024-10-18 23:03:45', 0);
INSERT INTO `sys_i18n` VALUES (1847292535451258882, 'userLoginLog_username', '用户名', 'zh', 1, 1, '2024-10-18 23:03:56', '2024-10-18 23:03:56', 0);
INSERT INTO `sys_i18n` VALUES (1847292560050851842, 'userLoginLog_username', 'username', 'en', 1, 1, '2024-10-18 23:04:02', '2024-10-18 23:04:02', 0);
INSERT INTO `sys_i18n` VALUES (1847292641894305794, 'userLoginLog_token', 'token', 'en', 1, 1, '2024-10-18 23:04:22', '2024-10-18 23:04:22', 0);
INSERT INTO `sys_i18n` VALUES (1847292660152111105, 'userLoginLog_token', '令牌', 'zh', 1, 1, '2024-10-18 23:06:49', '2024-10-18 23:04:26', 0);
INSERT INTO `sys_i18n` VALUES (1847292717630853121, 'userLoginLog_ipRegion', 'IP归属地', 'zh', 1, 1, '2024-10-18 23:56:57', '2024-10-18 23:04:40', 0);
INSERT INTO `sys_i18n` VALUES (1847292736668798978, 'userLoginLog_ipRegion', 'IP Region', 'en', 1, 1, '2024-10-18 23:57:11', '2024-10-18 23:04:44', 0);
INSERT INTO `sys_i18n` VALUES (1847292786773954561, 'userLoginLog_ipAddress', 'IP Address', 'en', 1, 1, '2024-10-18 23:04:56', '2024-10-18 23:04:56', 0);
INSERT INTO `sys_i18n` VALUES (1847292824388472833, 'userLoginLog_ipAddress', 'IP地址', 'zh', 1, 1, '2024-10-18 23:56:34', '2024-10-18 23:05:05', 0);
INSERT INTO `sys_i18n` VALUES (1847292923139166209, 'userLoginLog_userAgent', '用户代理', 'zh', 1, 1, '2024-10-18 23:07:10', '2024-10-18 23:05:29', 0);
INSERT INTO `sys_i18n` VALUES (1847293016768614401, 'userLoginLog_userAgent', 'userAgent', 'en', 1, 1, '2024-10-18 23:05:51', '2024-10-18 23:05:51', 0);
INSERT INTO `sys_i18n` VALUES (1847302853715935234, 'userLoginLog_type', '操作类型', 'zh', 1, 1, '2024-10-18 23:44:56', '2024-10-18 23:44:56', 0);
INSERT INTO `sys_i18n` VALUES (1847302869188722690, 'userLoginLog_type', 'type', 'en', 1, 1, '2024-10-18 23:45:00', '2024-10-18 23:45:00', 0);
INSERT INTO `sys_i18n` VALUES (1847323170987311106, 'userLoginLog_xRequestedWith', '请求方式', 'zh', 1, 1, '2024-10-19 01:05:40', '2024-10-19 01:05:40', 0);
INSERT INTO `sys_i18n` VALUES (1847323198384504833, 'userLoginLog_xRequestedWith', 'Requested With', 'en', 1, 1, '2024-10-19 01:05:47', '2024-10-19 01:05:47', 0);
INSERT INTO `sys_i18n` VALUES (1847323243800428545, 'userLoginLog_dpr', 'dpr', 'en', 1, 1, '2024-10-19 01:05:58', '2024-10-19 01:05:58', 0);
INSERT INTO `sys_i18n` VALUES (1847323366068584449, 'userLoginLog_dpr', '设备像素比', 'zh', 1, 1, '2024-10-19 01:06:27', '2024-10-19 01:06:27', 0);
INSERT INTO `sys_i18n` VALUES (1847323475879657474, 'userLoginLog_deviceMemory', 'Memory', 'en', 1, 1, '2024-10-19 01:07:33', '2024-10-19 01:06:53', 0);
INSERT INTO `sys_i18n` VALUES (1847323514496614401, 'userLoginLog_deviceMemory', '内存', 'zh', 1, 1, '2024-10-19 01:07:42', '2024-10-19 01:07:02', 0);
INSERT INTO `sys_i18n` VALUES (1847323985986715649, 'userLoginLog_secChUa', '品牌和版本', 'zh', 1, 1, '2024-10-19 01:08:55', '2024-10-19 01:08:55', 0);
INSERT INTO `sys_i18n` VALUES (1847324012045926401, 'userLoginLog_secChUa', 'ua', 'en', 1, 1, '2024-10-19 01:09:01', '2024-10-19 01:09:01', 0);
INSERT INTO `sys_i18n` VALUES (1847324095156060162, 'userLoginLog_secChUaArch', '平台架构', 'zh', 1, 1, '2024-10-19 01:09:21', '2024-10-19 01:09:21', 0);
INSERT INTO `sys_i18n` VALUES (1847324113980096513, 'userLoginLog_secChUaArch', 'Arch', 'en', 1, 1, '2024-10-19 01:09:25', '2024-10-19 01:09:25', 0);
INSERT INTO `sys_i18n` VALUES (1847324209819942913, 'userLoginLog_secChUaBitness', 'CPU架构位数', 'zh', 1, 1, '2024-10-19 01:09:48', '2024-10-19 01:09:48', 0);
INSERT INTO `sys_i18n` VALUES (1847324243043024897, 'userLoginLog_secChUaBitness', 'CPU architecture bits', 'en', 1, 1, '2024-10-19 01:09:56', '2024-10-19 01:09:56', 0);
INSERT INTO `sys_i18n` VALUES (1847324352078151681, 'userLoginLog_secChUaMobile', '是否为手机设备', 'zh', 1, 1, '2024-10-19 01:10:22', '2024-10-19 01:10:22', 0);
INSERT INTO `sys_i18n` VALUES (1847324387943645185, 'userLoginLog_secChUaMobile', 'Whether it is a mobile device', 'en', 1, 1, '2024-10-19 01:10:30', '2024-10-19 01:10:30', 0);
INSERT INTO `sys_i18n` VALUES (1847324455065092098, 'userLoginLog_viewportWidth', '视口宽度', 'zh', 1, 1, '2024-10-19 01:10:46', '2024-10-19 01:10:46', 0);
INSERT INTO `sys_i18n` VALUES (1847324485322801153, 'userLoginLog_viewportWidth', 'Viewport width', 'en', 1, 1, '2024-10-19 01:10:54', '2024-10-19 01:10:54', 0);
INSERT INTO `sys_i18n` VALUES (1847324543262916609, 'userLoginLog_width', 'width', 'en', 1, 1, '2024-10-19 01:11:07', '2024-10-19 01:11:07', 0);
INSERT INTO `sys_i18n` VALUES (1847324603753168897, 'userLoginLog_width', '视口宽度', 'zh', 1, 1, '2024-10-19 01:11:22', '2024-10-19 01:11:22', 0);
INSERT INTO `sys_i18n` VALUES (1847324681897246722, 'userLoginLog_downlink', '带宽', 'zh', 1, 1, '2024-10-19 01:11:40', '2024-10-19 01:11:40', 0);
INSERT INTO `sys_i18n` VALUES (1847324710154272769, 'userLoginLog_downlink', 'bandwidth', 'en', 1, 1, '2024-10-19 01:11:47', '2024-10-19 01:11:47', 0);
INSERT INTO `sys_i18n` VALUES (1847324816844783617, 'userLoginLog_secChUaModel', '设备模型', 'zh', 1, 1, '2024-10-19 01:12:13', '2024-10-19 01:12:13', 0);
INSERT INTO `sys_i18n` VALUES (1847324842652336129, 'userLoginLog_secChUaModel', 'Device model', 'en', 1, 1, '2024-10-19 01:12:19', '2024-10-19 01:12:19', 0);
INSERT INTO `sys_i18n` VALUES (1847325049490243586, 'userLoginLog_secChUaPlatform', '操作系统/平台', 'zh', 1, 1, '2024-10-19 01:13:08', '2024-10-19 01:13:08', 0);
INSERT INTO `sys_i18n` VALUES (1847325078904897538, 'Operating system/platform', '操作系统/平台', 'en', 1, 1, '2024-10-19 01:13:15', '2024-10-19 01:13:15', 0);
INSERT INTO `sys_i18n` VALUES (1847325201533763586, 'userLoginLog_secChUaPlatformVersion', '操作系统版本', 'zh', 1, 1, '2024-10-19 01:13:44', '2024-10-19 01:13:44', 0);
INSERT INTO `sys_i18n` VALUES (1847325224900231170, 'userLoginLog_secChUaPlatformVersion', 'Operating system version', 'en', 1, 1, '2024-10-19 01:13:50', '2024-10-19 01:13:50', 0);
INSERT INTO `sys_i18n` VALUES (1847325327832645634, 'userLoginLog_contentDpr', '设备像素比', 'zh', 1, 1, '2024-10-19 01:14:14', '2024-10-19 01:14:14', 0);
INSERT INTO `sys_i18n` VALUES (1847325351165558785, 'userLoginLog_contentDpr', 'Device pixel ratio', 'en', 1, 1, '2024-10-19 01:14:20', '2024-10-19 01:14:20', 0);
INSERT INTO `sys_i18n` VALUES (1847325468958392321, 'userLoginLog_ect', '有效连接类型', 'zh', 1, 1, '2024-10-19 01:14:48', '2024-10-19 01:14:48', 0);
INSERT INTO `sys_i18n` VALUES (1847325499652308994, 'userLoginLog_ect', 'Valid connection types', 'en', 1, 1, '2024-10-19 01:14:55', '2024-10-19 01:14:55', 0);
INSERT INTO `sys_i18n` VALUES (1847325577599254529, 'userLoginLog_rtt', '往返时间', 'zh', 1, 1, '2024-10-19 01:15:14', '2024-10-19 01:15:14', 0);
INSERT INTO `sys_i18n` VALUES (1847325602458894337, 'userLoginLog_rtt', 'Round trip time', 'en', 1, 1, '2024-10-19 01:15:20', '2024-10-19 01:15:20', 0);
INSERT INTO `sys_i18n` VALUES (1847342042503266305, 'view', 'view', 'en', 1, 1, '2024-10-19 02:20:40', '2024-10-19 02:20:40', 0);
INSERT INTO `sys_i18n` VALUES (1847342062514290689, 'view', '查看', 'zh', 1, 1, '2024-10-19 02:20:44', '2024-10-19 02:20:44', 0);

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
  `update_user` int NULL DEFAULT NULL COMMENT '操作用户',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录文件最后修改的时间戳',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '文件是否被删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '多语言类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_i18n_type
-- ----------------------------
INSERT INTO `sys_i18n_type` VALUES (1840386017158090753, 'zh', '中文', 1, 1, 1, '2024-10-17 18:15:40', '2024-09-30 05:39:54', 0);
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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统菜单图标' ROW_FORMAT = DYNAMIC;

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
INSERT INTO `sys_menu_icon` VALUES (1844291727040147458, 'fluent-mdl2:chart-template', '邮箱模板', '2024-10-10 16:19:48', '2024-10-10 16:19:48', 1, 1, 0);
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

-- ----------------------------
-- Table structure for sys_power
-- ----------------------------
DROP TABLE IF EXISTS `sys_power`;
CREATE TABLE `sys_power`  (
  `id` bigint NOT NULL COMMENT '权限ID',
  `parent_id` bigint NULL DEFAULT NULL COMMENT '父级id',
  `power_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '权限编码',
  `power_name` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '权限名称',
  `request_url` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '请求路径',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `update_user` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '是否删除，0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '系统权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_power
-- ----------------------------
INSERT INTO `sys_power` VALUES (1, 0, 'admin::user', '用户信息', NULL, '2024-10-16 21:37:52', '2024-10-16 21:37:52', 1, '1', 0);
INSERT INTO `sys_power` VALUES (2, 0, 'admin::schedulersGroup', '任务调度分组', NULL, '2024-10-16 21:37:52', '2024-10-16 21:37:52', 1, '1', 0);
INSERT INTO `sys_power` VALUES (3, 0, 'admin::schedulers', 'Schedulers视图', NULL, '2024-10-16 21:37:52', '2024-10-16 21:37:52', 1, '1', 0);
INSERT INTO `sys_power` VALUES (4, 0, 'admin::router', '系统路由', NULL, '2024-10-16 21:37:53', '2024-10-16 21:37:53', 1, '1', 0);
INSERT INTO `sys_power` VALUES (5, 0, 'admin::role', '角色', NULL, '2024-10-16 21:37:53', '2024-10-16 21:37:53', 1, '1', 0);
INSERT INTO `sys_power` VALUES (6, 0, 'admin::power', '权限', NULL, '2024-10-16 21:37:53', '2024-10-16 21:37:53', 1, '1', 0);
INSERT INTO `sys_power` VALUES (7, 0, 'admin::menuIcon', '系统菜单图标', NULL, '2024-10-16 21:37:53', '2024-10-16 21:37:53', 1, '1', 0);
INSERT INTO `sys_power` VALUES (8, 0, 'admin::i18nType', '多语言类型', NULL, '2024-10-16 21:37:53', '2024-10-16 21:37:53', 1, '1', 0);
INSERT INTO `sys_power` VALUES (9, 0, 'admin::i18n', '多语言', NULL, '2024-10-16 21:37:53', '2024-10-16 21:37:53', 1, '1', 0);
INSERT INTO `sys_power` VALUES (10, 0, 'admin::files', '系统文件表', NULL, '2024-10-16 21:37:53', '2024-10-16 21:37:53', 1, '1', 0);
INSERT INTO `sys_power` VALUES (11, 0, 'admin::emailUsers', '邮箱用户发送配置', NULL, '2024-10-16 21:37:53', '2024-10-16 21:37:53', 1, '1', 0);
INSERT INTO `sys_power` VALUES (12, 0, 'admin::emailTemplate', '邮件模板', NULL, '2024-10-16 21:37:53', '2024-10-16 21:37:53', 1, '1', 0);
INSERT INTO `sys_power` VALUES (13, 0, 'admin::dept', '部门', NULL, '2024-10-16 21:37:53', '2024-10-16 21:37:53', 1, '1', 0);
INSERT INTO `sys_power` VALUES (14, 0, 'admin::userRole', '用户和角色', NULL, '2024-10-16 21:37:53', '2024-10-16 21:37:53', 1, '1', 0);
INSERT INTO `sys_power` VALUES (15, 0, 'admin::routerRole', '路由和角色', NULL, '2024-10-16 21:37:53', '2024-10-16 21:37:53', 1, '1', 0);
INSERT INTO `sys_power` VALUES (16, 0, 'admin::rolePower', '角色和权限', NULL, '2024-10-16 21:37:53', '2024-10-16 21:37:53', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546448910213121, 1, 'user::uploadAvatarByAdmin', '管理员修改用户头像', '/admin/user/uploadAvatarByAdmin', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546448968933377, 1, 'user::updateUserStatusByAdmin', '管理员修改用户状态', '/admin/user/updateUserStatusByAdmin', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546448968933378, 1, 'user::updateUserPasswordByAdmin', '管理员修改管理员用户密码', '/admin/user/updateUserPasswordByAdmin', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449031847937, 1, 'user::updateAdminUser', '更新用户信息', '/admin/user/updateAdminUser', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449031847938, 1, 'user::forcedOffline', '强制退出', '/admin/user/forcedOffline', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449031847939, 1, 'user::logout', '退出登录', '/admin/user/logout', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449098956801, 1, 'user::addAdminUser', '添加用户信息', '/admin/user/addAdminUser', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449161871361, 1, 'user::queryUser', '多条件查询用户', '/admin/user/queryUser', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449161871362, 1, 'user::getUserinfoById', '获取用户信息', '/admin/user/getUserinfoById', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449161871363, 1, 'user::getAdminUserList', '分页查询用户信息', '/admin/user/getAdminUserList/\\d+/\\d+', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449224785922, 1, 'user::deleteAdminUser', '删除用户信息', '/admin/user/deleteAdminUser', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449291894785, 2, 'schedulersGroup::updateSchedulersGroup', '更新任务调度分组', '/admin/schedulersGroup/updateSchedulersGroup', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449291894786, 2, 'schedulersGroup::addSchedulersGroup', '添加任务调度分组', '/admin/schedulersGroup/addSchedulersGroup', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449354809345, 2, 'schedulersGroup::getSchedulersGroupList', '分页查询任务调度分组', '/admin/schedulersGroup/getSchedulersGroupList/\\d+/\\d+', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449354809346, 2, 'schedulersGroup::getAllSchedulersGroup', '获取所有任务调度分组', '/admin/schedulersGroup/getAllSchedulersGroup', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449421918209, 2, 'schedulersGroup::deleteSchedulersGroup', '删除任务调度分组', '/admin/schedulersGroup/deleteSchedulersGroup', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449421918210, 3, 'schedulers::resumeScheduler', '恢复任务', '/admin/schedulers/resumeScheduler', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449489027073, 3, 'schedulers::pauseScheduler', '暂停任务', '/admin/schedulers/pauseScheduler', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449489027074, 3, 'schedulers::addSchedulers', '添加任务', '/admin/schedulers/addSchedulers', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449551941633, 3, 'schedulers::getSchedulersList', '分页查询视图', '/admin/schedulers/getSchedulersList/\\d+/\\d+', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449551941634, 3, 'schedulers::getAllScheduleJobList', '获取所有可用调度任务', '/admin/schedulers/getAllScheduleJobList', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449614856194, 3, 'schedulers::deleteSchedulers', '删除任务', '/admin/schedulers/deleteSchedulers', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449614856195, 4, 'router::updateMenu', '更新路由菜单', '/admin/router/updateMenu', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449677770753, 4, 'router::addMenu', '添加路由菜单', '/admin/router/addMenu', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449677770754, 4, 'router::getRouterAsync', '获取用户菜单', '/admin/router/getRouterAsync', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449736491009, 4, 'router::getMenusList', '管理菜单列', '/admin/router/getMenusList', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449803599874, 4, 'router::deletedMenuByIds', '删除路由菜单', '/admin/router/deletedMenuByIds', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449866514433, 5, 'role::updateRole', '更新角色', '/admin/role/updateRole', '2024-10-16 21:39:15', '2024-10-16 21:39:15', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546449996537858, 5, 'role::addRole', '添加角色', '/admin/role/addRole', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450063646722, 5, 'role::getRoleList', '分页查询角色', '/admin/role/getRoleList/\\d+/\\d+', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450063646723, 5, 'role::getAllRoles', '获取所有角色', '/admin/role/getAllRoles', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450130755585, 5, 'role::deleteRole', '删除角色', '/admin/role/deleteRole', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450130755586, 6, 'power::updatePower', '更新权限', '/admin/power/updatePower', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450193670145, 6, 'power::updateBatchByPowerWithParentId', '批量修改权限父级', '/admin/power/updateBatchByPowerWithParentId', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450256584706, 6, 'power::addPower', '添加权限', '/admin/power/addPower', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450256584707, 6, 'power::getPowerList', '分页查询权限', '/admin/power/getPowerList/\\d+/\\d+', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450256584708, 6, 'power::getAllPowers', '获取所有权限', '/admin/power/getAllPowers', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450319499265, 6, 'power::deletePower', '删除权限', '/admin/power/deletePower', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450319499266, 7, 'menuIcon::updateMenuIcon', '更新系统菜单图标', '/admin/menuIcon/updateMenuIcon', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450386608129, 7, 'menuIcon::addMenuIcon', '添加系统菜单图标', '/admin/menuIcon/addMenuIcon', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450453716994, 7, 'menuIcon::getMenuIconList', '分页查询系统菜单图标', '/admin/menuIcon/getMenuIconList/\\d+/\\d+', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450453716995, 7, 'menuIcon::getIconNameList', '获取查询图标名称列', '/admin/menuIcon/getIconNameList', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450453716996, 7, 'menuIcon::deleteMenuIcon', '删除系统菜单图标', '/admin/menuIcon/deleteMenuIcon', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450516631553, 8, 'i18nType::updateI18nType', '更新多语言类型', '/admin/i18nType/updateI18nType', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450579546113, 8, 'i18nType::addI18nType', '添加多语言类型', '/admin/i18nType/addI18nType', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450579546114, 8, 'i18nType::deleteI18nType', '删除多语言类型', '/admin/i18nType/deleteI18nType', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450642460674, 9, 'i18n::updateI18n', '更新多语言', '/admin/i18n/updateI18n', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450705375234, 9, 'i18n::addI18n', '添加多语言', '/admin/i18n/addI18n', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450705375235, 9, 'i18n::getI18n', '获取多语言内容', '/admin/i18n/getI18n', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450705375236, 9, 'i18n::getI18nList', '获取管理多语言列', '/admin/i18n/getI18nList/\\d+/\\d+', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450772484097, 9, 'i18n::deleteI18n', '删除多语言', '/admin/i18n/deleteI18n', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450772484098, 10, 'files::updateFiles', '更新系统文件', '/admin/files/updateFiles', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450835398658, 10, 'files::upload', '上传文件', '/admin/files/upload', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450902507522, 10, 'files::addFiles', '添加系统文件', '/admin/files/addFiles', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450902507523, 10, 'files::getFilesList', '分页查询系统文件', '/admin/files/getFilesList/\\d+/\\d+', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450902507524, 10, 'files::getAllMediaTypes', '获取所有文件类型', '/admin/files/getAllMediaTypes', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450965422081, 10, 'files::getAllFilesStoragePath', '获取所有文件存储基础路径', '/admin/files/getAllFilesStoragePath', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546450965422082, 10, 'files::downloadFilesByFilepath', '根据文件名下载文件', '/admin/files/downloadFilesByFilepath', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451028336642, 10, 'files::downloadFilesByFileId::{fileId}', '下载文件', '/admin/files/downloadFilesByFileId/{fileId}', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451028336643, 10, 'files::deleteFiles', '删除系统文件', '/admin/files/deleteFiles', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451091251202, 11, 'emailUsers::updateEmailUsers', '更新邮箱用户发送配置', '/admin/emailUsers/updateEmailUsers', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451091251203, 11, 'emailUsers::updateEmailUserStatus', '更新邮箱用户状态', '/admin/emailUsers/updateEmailUserStatus', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451091251204, 11, 'emailUsers::addEmailUsers', '添加邮箱用户发送配置', '/admin/emailUsers/addEmailUsers', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451158360066, 11, 'emailUsers::getEmailUsersList', '分页查询邮箱用户发送配置', '/admin/emailUsers/getEmailUsersList/\\d+/\\d+', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451158360067, 11, 'emailUsers::getAllMailboxConfigurationUsers', '获取所有邮箱配置用户', '/admin/emailUsers/getAllMailboxConfigurationUsers', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451158360068, 11, 'emailUsers::deleteEmailUsers', '删除邮箱用户发送配置', '/admin/emailUsers/deleteEmailUsers', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451221274625, 12, 'emailTemplate::updateEmailTemplate', '更新邮件模板', '/admin/emailTemplate/updateEmailTemplate', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451284189185, 12, 'emailTemplate::addEmailTemplate', '添加邮件模板', '/admin/emailTemplate/addEmailTemplate', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451284189186, 12, 'emailTemplate::getEmailTypes', '获取邮件模板类型字段', '/admin/emailTemplate/getEmailTypes', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451347103745, 12, 'emailTemplate::getEmailTemplateList', '分页查询邮件模板', '/admin/emailTemplate/getEmailTemplateList/\\d+/\\d+', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451347103746, 12, 'emailTemplate::deleteEmailTemplate', '删除邮件模板', '/admin/emailTemplate/deleteEmailTemplate', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451414212610, 13, 'dept::updateDept', '更新部门', '/admin/dept/updateDept', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451414212611, 13, 'dept::addDept', '添加部门', '/admin/dept/addDept', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451477127169, 13, 'dept::getDeptList', '分页查询部门', '/admin/dept/getDeptList/\\d+/\\d+', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451477127170, 13, 'dept::getAllDeptList', '获取所有部门', '/admin/dept/getAllDeptList', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451477127171, 13, 'dept::deleteDept', '删除部门', '/admin/dept/deleteDept', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451540041730, 14, 'userRole::assignRolesToUsers', '为用户分配角色', '/admin/userRole/assignRolesToUsers', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451602956290, 14, 'userRole::getRoleListByUserId', '根据用户id获取角色列', '/admin/userRole/getRoleListByUserId', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451602956291, 15, 'routerRole::assignRolesToRouter', '为菜单分配角色', '/admin/routerRole/assignRolesToRouter', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451665870850, 15, 'routerRole::getRoleListByRouterId', '根据菜单id获取所有角色', '/admin/routerRole/getRoleListByRouterId', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451728785410, 16, 'rolePower::assignPowersToRole', '为角色分配权限', '/admin/rolePower/assignPowersToRole', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);
INSERT INTO `sys_power` VALUES (1846546451728785411, 16, 'rolePower::getPowerListByRoleId', '角色列获取已选择的权限', '/admin/rolePower/getPowerListByRoleId', '2024-10-16 21:39:16', '2024-10-16 21:39:16', 1, '1', 0);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL,
  `role_code` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '角色代码',
  `description` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '描述',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '系统角色表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', 'admin', '管理员用户', '2024-05-17 15:09:34', '2024-05-17 15:09:34', 0, '4', 0);
INSERT INTO `sys_role` VALUES ('1838499178568450050', 'fuzhu', '辅助', '2024-09-24 16:42:16', '2024-09-24 16:42:16', 1, '1', 0);
INSERT INTO `sys_role` VALUES ('1838835872391942145', 'common', '公共权限', '2024-09-25 15:00:11', '2024-09-25 15:00:11', 1, '1', 0);

-- ----------------------------
-- Table structure for sys_role_power
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_power`;
CREATE TABLE `sys_role_power`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `role_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '角色id',
  `power_id` varchar(50) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '权限id',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '是否删除，0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci COMMENT = '系统角色权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_power
-- ----------------------------

-- ----------------------------
-- Table structure for sys_router
-- ----------------------------
DROP TABLE IF EXISTS `sys_router`;
CREATE TABLE `sys_router`  (
  `id` bigint NOT NULL COMMENT '主键id',
  `parent_id` bigint NULL DEFAULT NULL COMMENT '父级id',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '在项目中路径',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '组件位置',
  `frame_src` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'frame路径',
  `route_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由名称',
  `title` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '路由title',
  `menu_type` int NULL DEFAULT NULL COMMENT '菜单类型',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '图标',
  `router_rank` int NULL DEFAULT NULL COMMENT '等级',
  `visible` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否显示 返给前端为 showLink',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `update_user` int NULL DEFAULT NULL COMMENT '操作用户',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '记录文件最后修改的时间戳',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '文件是否被删除',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_id_parent_id`(`id` ASC, `parent_id` ASC) USING BTREE,
  INDEX `idx_id`(`id` ASC) USING BTREE,
  INDEX `idx_parent_id`(`parent_id` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '系统菜单表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_router
-- ----------------------------
INSERT INTO `sys_router` VALUES (1, 0, '/system', '', '', '/system', 'system_setting', 0, 'carbon:router', 1, 1, NULL, 1, '2024-10-09 18:05:48', '2024-09-29 09:46:31', 0);
INSERT INTO `sys_router` VALUES (2, 1, '/system/menu', '/system/menu/index', '', 'menu', 'system_menu', 0, 'subway:menu', 2, 1, NULL, 1, '2024-10-12 16:56:24', '2024-09-29 09:46:31', 0);
INSERT INTO `sys_router` VALUES (1840211412516524034, 1841716459123634177, '/i18n/i18n-setting', '/i18n/i18n-setting/index', '', 'system_i18n', 'system_i18n', 0, 'clarity:language-solid', 6, 1, 1, 1, '2024-10-18 13:39:21', '2024-09-29 18:06:05', 0);
INSERT INTO `sys_router` VALUES (1840292695145963522, 1841716459123634177, '/i18n/i18n-type-setting', '/i18n/i18n-type-setting/index', '', 'i18n-type-setting', 'i18n_type_setting', 0, 'clarity:language-line', 7, 1, 1, 1, '2024-10-18 13:39:25', '2024-09-29 23:29:04', 0);
INSERT INTO `sys_router` VALUES (1841506924681338881, 1844900259930243074, '/configuration/menuIcon', '/configuration/menuIcon/index', '', 'menuIcon', 'menuIcon', 0, 'tdesign:file-icon', 3, 1, 1, 1, '2024-10-12 16:57:20', '2024-10-03 07:53:59', 0);
INSERT INTO `sys_router` VALUES (1841716459123634177, 0, '/i18n', '/i18n', '', 'i18n', 'i18n', 0, 'material-symbols:language', 5, 1, 1, 1, '2024-10-17 14:43:29', '2024-10-03 21:46:36', 0);
INSERT INTO `sys_router` VALUES (1841726844983701505, 1, '/system/role', '/system/role/index', '', 'role', 'role', 0, 'fluent-mdl2:manager-self-service', 4, 1, 1, 1, '2024-10-18 13:37:29', '2024-10-03 22:27:52', 0);
INSERT INTO `sys_router` VALUES (1841750734275416065, 1, '/system/power', '/system/power/index', '', 'power', 'power', 0, 'oui:app-users-roles', 5, 1, 1, 1, '2024-10-18 13:37:36', '2024-10-04 00:02:48', 0);
INSERT INTO `sys_router` VALUES (1841794929635635201, 1844956874037469185, '/element-plus', '', 'https://element-plus.org/zh-CN/component/switch.html', 'element_plus', 'element_plus', 1, 'logos:element', 1, 1, 1, 1, '2024-10-12 20:37:50', '2024-10-04 02:58:25', 0);
INSERT INTO `sys_router` VALUES (1841796585525985281, 0, '/iframe', '', '', 'external_page', 'external_page', 0, 'mdi:iframe-outline', 6, 1, 1, 1, '2024-10-17 14:43:34', '2024-10-04 03:05:00', 0);
INSERT INTO `sys_router` VALUES (1841796893769580546, 1844956874037469185, '/pure-admin', '', 'https://pure-admin.github.io/vue-pure-admin/#/system/user/index', 'pure_admin', 'pure_admin', 1, 'file-icons:pure', 4, 1, 1, 1, '2024-10-12 20:38:05', '2024-10-04 03:06:13', 0);
INSERT INTO `sys_router` VALUES (1841803086252548097, 1, '/system/admin-user', '/system/adminUser/index', '', 'admin_user', 'admin_user', 0, 'ic:round-manage-accounts', 3, 1, 1, 1, '2024-10-18 13:37:22', '2024-10-04 03:30:49', 0);
INSERT INTO `sys_router` VALUES (1842033245832458241, 1, '/system/dept', '/system/dept/index', '', 'dept', 'dept', 0, 'grommet-icons:user-manager', 6, 1, 1, 1, '2024-10-18 13:37:41', '2024-10-04 18:45:24', 0);
INSERT INTO `sys_router` VALUES (1843932804747603970, 1844644093987880962, '/monitor/files', '/monitor/files/index', '', 'system_files', 'system_files', 0, 'line-md:file-filled', 5, 1, 1, 1, '2024-10-18 13:38:45', '2024-10-10 00:33:34', 0);
INSERT INTO `sys_router` VALUES (1844276961265557505, 1844900259930243074, '/configuration/emailUsers', '/configuration/emailUsers/index', '', 'emailUsers', 'emailUsers', 0, 'line-md:email-filled', 4, 1, 1, 1, '2024-10-18 13:38:16', '2024-10-10 23:21:07', 0);
INSERT INTO `sys_router` VALUES (1844290948342456321, 1844900259930243074, '/configuration/emailTemplate', '/configuration/emailTemplate/index', '', 'emailTemplate', 'emailTemplate', 0, 'fluent-mdl2:chart-template', 5, 1, 1, 1, '2024-10-18 13:38:20', '2024-10-11 00:16:42', 0);
INSERT INTO `sys_router` VALUES (1844644093987880962, 0, '/monitor', '', '', 'monitor', 'monitor', 0, 'carbon:cloud-monitoring', 3, 1, 1, 1, '2024-10-12 16:47:22', '2024-10-11 23:39:58', 0);
INSERT INTO `sys_router` VALUES (1844644779039358978, 1844644093987880962, '/monitor/server', '/monitor/server/index', '', 'monitoring_server', 'monitoring_server', 0, 'bxs:server', 4, 1, 1, 1, '2024-10-18 13:38:40', '2024-10-11 23:42:42', 0);
INSERT INTO `sys_router` VALUES (1844900259930243074, 0, '/configuration', '', '', 'configuration', 'configuration', 0, 'hugeicons:configuration-01', 2, 1, 1, 1, '2024-10-18 13:34:35', '2024-10-12 16:37:53', 0);
INSERT INTO `sys_router` VALUES (1844935022925803521, 1844956874037469185, '/knife4j', '', 'http://localhost:7070/doc.html#/home', 'knife4j_Interface_documentation', 'knife4j_Interface_documentation', 1, 'noto:letter-k', 2, 1, 1, 1, '2024-10-12 20:47:29', '2024-10-12 18:56:01', 0);
INSERT INTO `sys_router` VALUES (1844936047493586945, 1844956874037469185, '/swagger-ui', '', 'http://localhost:7070/swagger-ui/index.html', 'swagger', 'swagger', 1, 'devicon:swagger', 3, 1, 1, 1, '2024-10-12 20:38:01', '2024-10-12 19:00:06', 0);
INSERT INTO `sys_router` VALUES (1844956874037469185, 1841796585525985281, '/iframe/embedded-doc', '', '', 'embedded_doc', 'embedded_doc', 0, 'mdi:iframe-braces', 2, 1, 1, 1, '2024-10-12 20:48:58', '2024-10-12 20:22:51', 0);
INSERT INTO `sys_router` VALUES (1844957189138751490, 1841796585525985281, '/ifram/external-doc', '', '', 'external_doc', 'external_doc', 0, 'line-md:link', 3, 1, 1, 1, '2024-10-12 21:02:29', '2024-10-12 20:24:06', 0);
INSERT INTO `sys_router` VALUES (1844957830590468097, 1844957189138751490, '/external-doc/element-plus', '', '', 'https://element-plus.org/zh-CN/component/overview.html', 'element_plus', 2, 'logos:element', 1, 1, 1, 1, '2024-10-12 20:41:03', '2024-10-12 20:26:39', 0);
INSERT INTO `sys_router` VALUES (1844958437262987265, 1844957189138751490, '/external-doc/iconify', '', '', 'https://icon-sets.iconify.design/', 'iconify', 2, 'line-md:iconify1', 2, 1, 1, 1, '2024-10-12 20:42:18', '2024-10-12 20:29:04', 0);
INSERT INTO `sys_router` VALUES (1844958660366405634, 1844957189138751490, '/external-doc//knife4j', '', '', 'http://localhost:7070/doc.html#/home', 'knife4j_Interface_documentation', 2, 'noto:letter-k', 3, 1, 1, 1, '2024-10-12 20:47:38', '2024-10-12 20:29:57', 0);
INSERT INTO `sys_router` VALUES (1844958872170369025, 1844957189138751490, '/external-doc/swagger-ui', '', '', 'http://localhost:7070/swagger-ui/index.html', 'swagger', 2, 'devicon:swagger', 4, 1, 1, 1, '2024-10-12 20:42:26', '2024-10-12 20:30:47', 0);
INSERT INTO `sys_router` VALUES (1845812113861079042, 1846804024660791298, '/scheduler/schedulers', '/scheduler/schedulers/index', '', 'schedulers', 'schedulers', 0, 'simple-icons:apachedolphinscheduler', 5, 1, 1, 1, '2024-10-18 13:38:59', '2024-10-15 05:01:16', 0);
INSERT INTO `sys_router` VALUES (1846166163060285441, 1846804024660791298, '/scheduler/schedulersGroup', '/scheduler/schedulersGroup/index', '', 'schedulersGroup', 'schedulersGroup', 0, 'uis:layer-group', 6, 1, 1, 1, '2024-10-18 13:39:03', '2024-10-16 04:28:08', 0);
INSERT INTO `sys_router` VALUES (1846804024660791298, 0, '/scheduler', '', '', 'scheduler', 'scheduler', 0, 'mingcute:time-fill', 4, 1, 1, 1, '2024-10-18 10:17:55', '2024-10-17 14:42:46', 0);
INSERT INTO `sys_router` VALUES (1847140225619992577, 1844644093987880962, '/monitor/schedulerExecuteLog', '/monitor/schedulerExecuteLog/index', '', 'quartzExecuteLog', 'quartzExecuteLog', 0, 'octicon:log-16', 7, 1, 1, 1, '2024-10-18 22:33:07', '2024-10-18 12:58:43', 0);
INSERT INTO `sys_router` VALUES (1847291834822123521, 1844644093987880962, '/monitor/userLoginLog', '/monitor/userLoginLog/index', '', 'userLoginLog', 'userLoginLog', 0, 'ph:log-bold', 6, 1, 1, 1, '2024-10-18 23:08:53', '2024-10-18 23:01:09', 0);

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
  `update_user` int NULL DEFAULT NULL COMMENT '操作用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NOT NULL DEFAULT 0 COMMENT '是否被删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci COMMENT = '系统路由角色关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_router_role
-- ----------------------------

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `username` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户名',
  `nick_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '昵称',
  `email` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(15) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '手机号',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '密码',
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
  UNIQUE INDEX `key_email`(`email` ASC) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'bunny', 'bunny', '1319900154@qq.com', '12345678910', '0192023a7bbd73250516f069df18b500', '/auth-admin/avatar/2024/10-13/b7508e5a-1e7c-4422-88a5-61f0431f2aaa', 1, 'admin123', '127.0.0.1', '内网IP', 0, '2024-09-26 14:29:33', '2024-10-19 03:17:23', 0, 1, 0);
INSERT INTO `sys_user` VALUES (1842091082096930817, 'password', 'password', 'password@qq.com', '123456', 'd7cfe615ccf8fdcbec37ea905a7dab90', '/auth-admin/avatar/2024/10-13/b4dff57f-df93-496a-9a00-e6355ec8c5bc', 0, 'passwordpasswordpassword', NULL, NULL, 0, '2024-10-04 14:35:13', '2024-10-13 01:18:09', 1, 1, 0);
INSERT INTO `sys_user` VALUES (1843477994034401281, '测试', '测试', '测试@qq.com', '测试', 'db06c78d1e24cf708a14ce81c9b617ec', '/auth-admin/avatar/2024/10-13/8f531e28-8bd3-456e-8ada-1b6fdb652ace', 0, '测试测试测试', NULL, NULL, 0, '2024-10-08 10:26:19', '2024-10-13 22:36:12', 1, 1, 0);
INSERT INTO `sys_user` VALUES (1843908587394150402, '啊啊啊', '啊啊啊', '啊啊啊@qq.com', '2312312321', 'fc0ec9e6c7c3e1821db2254238e6a98e', NULL, 0, '这个人很懒,没有介绍', NULL, NULL, 1, '2024-10-09 14:57:20', '2024-10-10 10:22:21', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_user_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_dept`;
CREATE TABLE `sys_user_dept`  (
  `id` bigint NOT NULL COMMENT 'ID',
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '用户id',
  `dept_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '部门id',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建用户',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '是否删除，0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '部门用户关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_dept
-- ----------------------------
INSERT INTO `sys_user_dept` VALUES (1843881715746684930, '1843477994034401281', '1842882951345197057', '2024-10-09 13:10:33', '2024-10-09 13:10:33', 1, 1, 0);
INSERT INTO `sys_user_dept` VALUES (1843881758377590785, '1', '1842883239493881857', '2024-10-09 13:10:44', '2024-10-09 13:10:44', 1, 1, 0);
INSERT INTO `sys_user_dept` VALUES (1843890823090614274, '1842091082096930817', '1842874908557541377', '2024-10-09 13:46:45', '2024-10-09 13:46:45', 1, 1, 0);
INSERT INTO `sys_user_dept` VALUES (1843908587394150403, '1843908587394150402', '1842885375015374850', '2024-10-09 14:57:20', '2024-10-09 14:57:20', 1, 1, 0);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'ID',
  `user_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户id',
  `role_id` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色id',
  `create_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `create_user` bigint NOT NULL COMMENT '创建用户',
  `update_user` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新用户',
  `is_deleted` tinyint(1) UNSIGNED ZEROFILL NULL DEFAULT 0 COMMENT '是否删除，0-未删除，1-已删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统用户角色关系表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------

-- ----------------------------
-- View structure for view_qrtz_schedulers
-- ----------------------------
DROP VIEW IF EXISTS `view_qrtz_schedulers`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_qrtz_schedulers` AS select `job`.`job_name` AS `job_name`,`job`.`job_group` AS `job_group`,`job`.`description` AS `description`,`job`.`job_class_name` AS `job_class_name`,`cron`.`cron_expression` AS `cron_expression`,`tri`.`trigger_name` AS `trigger_name`,`tri`.`trigger_state` AS `trigger_state` from ((`qrtz_job_details` `job` join `qrtz_triggers` `tri` on(((`job`.`job_name` = `tri`.`job_name`) and (`job`.`job_group` = `tri`.`job_group`)))) join `qrtz_cron_triggers` `cron` on(((`cron`.`trigger_name` = `tri`.`trigger_name`) and (`cron`.`trigger_group` = `tri`.`job_group`)))) where (`tri`.`trigger_type` = 'CRON');

SET FOREIGN_KEY_CHECKS = 1;
