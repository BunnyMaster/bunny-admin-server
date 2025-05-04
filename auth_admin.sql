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

 Date: 04/05/2025 19:34:38
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
INSERT INTO `sys_email_users` VALUES (2, '3324855376@qq.com', 'fdehkkbmavalcjea', 'smtp.qq.com', 465, 'smtps', 0, 1, '2024-05-14 18:43:50', '2025-05-01 00:09:04', 0, 1, 0);

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
INSERT INTO `sys_files` VALUES (1917116805584637953, 'avatar', '/auth-admin/avatar/2025/04-29/b85d8959-48d8-44f7-9e0f-bdaca8b1bea4', 384185, 'application/octet-stream', 0, 1, 1, '2025-04-29 15:20:39', '2025-04-29 15:20:39', 0);
INSERT INTO `sys_files` VALUES (1917829325769256961, 'avatar', '/auth-admin/avatar/2025/05-01/bd079370-2389-49bb-9a75-978f39e87a61', 50149, 'application/octet-stream', 0, 1, 1, '2025-05-01 14:31:57', '2025-05-01 14:31:57', 0);
INSERT INTO `sys_files` VALUES (1917875110028263426, '003540AH4M72.jpg', '/auth-admin/message/2025/05-01/c63efe5e-a1aa-412a-8240-5c5ae701e28c.jpg', 99299, 'image/jpeg', 0, 1, 1, '2025-05-01 17:33:53', '2025-05-01 17:33:53', 0);
INSERT INTO `sys_files` VALUES (1917876823317561346, '003540AH4M72.jpg', '/auth-admin/message/2025/05-01/c59f1d79-0957-45ab-b4d0-5bbc0ca260d3.jpg', 99299, 'image/jpeg', 0, 1, 1, '2025-05-01 17:40:42', '2025-05-01 17:40:42', 0);
INSERT INTO `sys_files` VALUES (1917886451497684993, '003540AH4M72.jpg', '/auth-admin/message/2025/05-01/62a82b29-05e1-4419-9137-25c66a17407c.jpg', 99299, 'image/jpeg', 0, 1, 1, '2025-05-01 18:18:57', '2025-05-01 18:18:57', 0);
INSERT INTO `sys_files` VALUES (1918259017664008194, 'avatar', '/auth-admin/avatar/2025/05-02/68bc367d-0fcf-42be-a548-88a41568e4e8', 384185, 'application/octet-stream', 0, 1, 1, '2025-05-02 18:59:24', '2025-05-02 18:59:24', 0);

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
  UNIQUE INDEX `key_name`(`key_name` ASC, `type_name` ASC) USING BTREE COMMENT '类型名称键不能重复',
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
INSERT INTO `sys_i18n` VALUES (1918966812440088578, 'cancel', '取消', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812444282882, 'menus.pureVerify', '图形验证码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812444282883, 'buttons.pureTagsStyleCardTip', '卡片标签，高效浏览', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477186, 'buttons.pureTagsStyle', '页签风格', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477187, 'i18n.typeId', '类型id', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477188, 'menus.pureRole', '角色管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477189, 'login.purePhone', '手机号码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477190, 'search.purePlaceholder', '搜索菜单（支持拼音搜索）', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477191, 'readAlready', '已读', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477192, 'menus.pureCheckCard', '多选卡片', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477193, 'menus.pureTimePicker', '时间选择器', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477194, 'overallStyle', '应用程序的整体样式', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477195, 'menus.pureButton', '按钮动效', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477196, 'adminUser_phone', '手机号', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477197, 'path', '路由路径', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477198, 'receivedUserIdTip', '不填表示通知全部', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477199, 'schedulers', '调度任务', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477200, 'messageType', '消息类型', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477201, 'panel.pureThemeColor', '主题色', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477202, 'buttons.pureContentFullScreen', '内容区全屏', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477203, 'buttons.pureCloseText', '关', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477204, 'emailUsers_host', '主机地址', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812448477205, 'no_default', '不默认', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812456865793, 'returnToHomepage', '返回首页', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812456865794, 'cachingAsyncRoutes', '是否缓存异步路由', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812456865795, 'panel.pureOverallStyleSystem', '自动', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812456865796, 'panel.pureOverallStyle', '整体风格', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812456865797, 'multilingualManagement', '多语言管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812456865798, 'userLoginLog_secChUa', '品牌和版本', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812456865799, 'userLoginLog_ect', '有效连接类型', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812456865800, 'userLoginLog_secChUaBitness', 'CPU架构位数', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812456865801, 'version', '版本', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812456865802, 'menus.pureCascader', '区域级联选择器', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812456865803, 'isDefault', '是否默认', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812456865804, 'menus.purePermissionButtonLogin', '登录接口返回按钮权限', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812456865805, 'multiTagsCache', '是否缓存多个标签', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812461060097, 'menuNameTip', '菜单名称为必填项', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812461060098, 'table.createTime', '创建时间', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812461060099, 'menus.pureDatePicker', '日期选择器', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812461060100, 'receivedUserNickname', '收信人昵称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812461060101, 'role', '角色管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812461060102, 'panel.pureOverallStyleDark', '深色', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812461060103, 'delete_batches', '批量删除', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812461060104, 'buttons.pureCloseLeftTabs', '关闭左侧标签页', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812465254402, 'isRead', '是否已读', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812465254403, 'system_setting', '系统设置', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812465254404, 'buttons.pureBackTop', '回到顶部', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812465254405, 'appTitle', '网页title', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812465254406, 'menus.pureList', '列表页面', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812465254407, 'menus.pureTypeit', '打字机', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812465254408, 'logged_in_user', '已登录的用户', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812465254409, 'search', '搜索', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812465254410, 'userLoginLog_deviceMemory', '内存', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448705, 'menus.pureEmbeddedDoc', '文档内嵌', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448706, 'drop_file_here', '拖拽文件到此处', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448707, 'delete_warning', '删除警告', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448708, 'nickname', '昵称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448709, 'dept_deptName', '部门名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448710, 'buttons.pureClickCollapse', '点击折叠', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448711, 'resume', '恢复', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448712, 'menus.pureSysManagement', '系统管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448713, 'userLoginLog_width', '视口宽度', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448714, 'inputRuleMustBeEnglish', '必须是英文', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448715, 'sex', '性别', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448716, 'allMarkAsRead', '全部标为已读', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448717, 'sorryServerError', '抱歉，服务器出错了', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448718, 'routerPath', '路由路径', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448719, 'menus.pureSegmented', '分段控制器', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448720, 'menus.pureLineTree', '树形连接线', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448721, 'menus.pureSwiper', 'Swiper插件', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448722, 'adminUser_username', '用户名', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448723, 'menus.pureDownload', '下载', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448724, 'required_fields', '填写必填项', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448725, 'i18n_summary', '多语言详情解释', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812469448726, 'adminUser_dept', '部门', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812477837313, 'menuSearchHistory', '菜单搜索历史', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812477837314, 'quartzExecuteLog_executeResult', '执行结果', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812477837315, 'click_to_upload', '点击上传文件', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812477837316, 'userLoginLog_token', '令牌', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812477837317, 'added', '已添加', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812477837318, 'assignBatchRolesToRouter', '批量分配角色', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812477837319, 'animationNotExist', '动画不存在', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031618, 'status.pureNoTodo', '暂无待办', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031619, 'menus.pureHome', '首页', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031620, 'confirmText', '确认文字', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031621, 'inputRequestUrlTip', '请求URL需要以 \'/\' 开头', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031622, 'menuName', '菜单名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031623, 'login.password', '密码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031624, 'fixedHeader', '固定头', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031625, 'power_parentId', '权限父级', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031626, 'menus.pureTableHigh', '高级用法', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031627, 'dept_remarks', '备注', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031628, 'warning', '警告', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031629, 'female', '女', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031630, 'schedulers_jobGroup', '任务分组', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031631, 'info', '信息', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031632, 'add', '添加', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031633, 'buttons.pureTagsStyleChromeTip', '谷歌风格，经典美观', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031634, 'status.pureNoNotify', '暂无通知', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031635, 'buttons.pureTagsStyleSmart', '灵动', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031636, 'logged_in', '已登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031637, 'quartzExecuteLog_triggerName', '触发器名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031638, 'emailUsers_isDefault', '是否默认', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031639, 'menus.pureEmpty', '无Layout页', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031640, 'menus.pureVideoFrame', '视频帧截取-wasm版', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031641, 'buttons.pureOpenText', '开', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812482031642, 'menus.pureRipple', '波纹(Ripple)', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614529, 'buttons.reset', '重置', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614530, 'adminUser_nickname', '昵称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614531, 'search.pureTotal', '共', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614532, 'login.purePassWordDifferentReg', '两次密码不一致!', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614533, 'success', '成功', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614534, 'login.pureDefinite', '确定', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614535, 'panel.pureOverallStyleLightTip', '清新启航，点亮舒适的工作界面', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614536, 'menus.pureText', '文本省略', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614537, 'messageName', '消息名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614538, 'sorryNoAccess', '抱歉，你无权访问该页面', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614539, 'menuArrowIconNoTransition', '菜单箭头图标是否没有过渡效果', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614540, 'assignBatchRolesToRouterTip', '批量分配角色，会清除已分配的角色并不会追加角色', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614541, 'notifyAll', '通知全部', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614542, 'requestMethod', '请求方法', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614543, 'for', '为', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614544, 'back', '返回', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614545, 'forced_offline', '强制下线', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614546, 'title', '标题', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812494614547, 'take_back', '收回', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812498808833, 'content', '内容', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812498808834, 'stretch', '是否拉伸', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003137, 'confirm_update_password', '确认修改密码吗', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003138, 'emailUsers_password', '密码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003139, 'pixel', '像素', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003140, 'menus.pureColorPicker', '颜色选择器', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003141, 'schedulers_cronExpression', 'cron表达式', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003142, 'menus.pureWatermark', '水印', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003143, 'monitor', '系统监控', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003144, 'userLoginLog_username', '用户名', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003145, 'power_powerName', '权限名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003146, 'message', '消息', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003147, 'confirmDelete', '是否确认删除', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003148, 'login.pureQRCodeLogin', '二维码登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003149, 'login.purePassWordSureReg', '请输入确认密码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003150, 'modify', '修改', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003151, 'clearAllRolesSelect', '清除选中所以角色', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003152, 'menus.pureMap', '地图', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003153, 'menus.pureOptimize', '防抖、截流、复制、长按指令', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003154, 'i18n.typeName', '类型名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003155, 'menus.pureAnimatecss', 'animate.css选择器', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003156, 'login.pureUsername', '账号', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003157, 'pleaseSelectAnimation', '请选择动画', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003158, 'no_server', '无服务', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812503003159, 'clearAllRolesSelectTip', '此操作会清除已经分配的菜单角色，如果确认此操作不可恢复，菜单下分配好的角色也将清除！！！', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197441, 'username', '用户名', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197442, 'copyright', '版权', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197443, 'menus.pureTableEdit', '可编辑用法', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197444, 'select', '选择', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197445, 'epThemeColor', '主题颜色', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197446, 'userLoginLog_type', '操作类型', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197447, 'sorryPageNotFound', '抱歉，你访问的页面不存在', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197448, 'login.pureVerifyCodeCorrectReg', '请输入正确的验证码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197449, 'select_icon', '选择图标', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197450, 'batchUpdates', '确认批量更新吗？', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197451, 'menus.pureTabs', '标签页操作', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197452, 'buttons.pureTagsStyleSmartTip', '灵动标签，添趣生辉', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197453, 'system_menu', '系统菜单', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197454, 'dept_parentId', '部门父级', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197455, 'i18n_type', '多语言类型', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197456, 'id', '主键', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197457, 'emailUsers_smtpAgreement', 'smtp 协议', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197458, 'status.pureNotify', '通知', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197459, 'power_setting', '权限设置', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197460, 'messageEditing', '消息编辑', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197461, 'modifyingConfiguration', '修改配置', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197462, 'download_batch', '批量下载', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197463, 'menus.purePermissionPage', '页面权限', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197464, 'login.pureGetVerifyCode', '获取验证码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197465, 'panel.pureCloseSystemSet', '关闭配置', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197466, 'element_plus', '饿了么UI', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812507197467, 'index', '序号', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391746, 'email_login', '邮箱登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391747, 'menus.pureCardList', '卡片列表页', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391748, 'menus.pureAbout', '关于', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391749, 'table.createUser', '创建用户', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391750, 'account_password', '账户密码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391751, 'panel.pureStretchCustomTip', '最小1280、最大1600', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391752, '404', '404', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391753, 'deleteBatches', '批量删除', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391754, 'menus.pureCheckButton', '可选按钮', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391755, 'menuType', '菜单类型', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391756, 'buttons.pureContentExitFullScreen', '内容区退出全屏', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391757, 'status', '状态', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391758, 'external_page', '外部页面', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391759, 'menus.pureVirtualList', '虚拟列表', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391760, 'login.pureRegister', '注册', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391761, 'buttons.pureInterfaceDisplay', '界面显示', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391762, 'userPassword', '用户的密码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812511391763, 'menuIcon_iconCode', '图标类名', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812515586050, 'quartzExecuteLog_endTime', '结束时间', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812515586051, 'login', '登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812515586052, 'menus.pureLoginLog', '登录日志', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812515586053, 'menus.pureExternalLink', 'vue-pure-admin', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812515586054, 'userLoginLog_rtt', '往返时间', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812515586055, 'schedulers_jobMethodName', '方法名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812515586056, 'menus.pureCountTo', '数字动画', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812515586057, 'tooltipEffect', '工具提示的效果', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812515586058, 'menus.pureStatistic', '统计组件', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812515586059, 'man', '男', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812515586060, 'addMultilingual', '添加多语言', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812515586061, 'use_json_update', '使用JSON更新', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812515586062, 'login.purePassWordReg', '请输入密码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812515586063, 'view_user_info', '查看用户信息', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780354, 'schedulersGroup', '任务调度分组', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780355, 'avatar', '头像', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780356, 'deleteBatchTip', '输入 yes/YES/y/Y 来确认批量删除，此操作不可逆', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780357, 'menu', '菜单', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780358, 'file_size', '文件大小', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780359, 'menus.pureDebounce', '防抖节流', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780360, 'use_excel_update', '使用Excel更新', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780361, 'sendNickname', '发送人昵称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780362, 'disable', '禁用', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780363, 'userLoginLog_secChUaPlatformVersion', '操作系统版本', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780364, 'responsiveStorageNameSpace', '响应式存储的命名空间', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780365, 'panel.pureWeakModel', '色弱模式', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780366, 'panel.pureInterfaceDisplay', '界面显示', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780367, 'editorType', '编辑器类型', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780368, 'unfold_all', '展开全部', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780369, 'Searching_for_router', '搜索路由', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780370, 'panel.pureOverallStyleDarkTip', '月光序曲，沉醉于夜的静谧雅致', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780371, 'showLogo', '是否显示logo', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780372, 'menuIcon', '菜单图标', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780373, 'status.pureLoad', '加载中...', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780374, 'files_filepath', '文件存储路径', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780375, 'quartzExecuteLog_duration', '执行时间', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780376, 'swagger', 'swagger', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812519780377, 'format_error', '格式错误', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974658, 'Searching_for_roles', '搜索角色', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974659, 'menus.pureAbnormal', '异常页面', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974660, 'download', '下载', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974661, 'quartzExecuteLog_jobGroup', '任务分组', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974662, 'menus.pureChildMenuOverflow', '菜单超出显示Tooltip文字提示', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974663, 'previousMenu', '上级菜单', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974664, 'buttons.pureSwitch', '切换', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974665, 'menus.pureResult', '结果页面', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974666, 'login.loginSuccess', '登录成功', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974667, 'personDescription', '个人详情', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974668, 'all', '全部', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974669, 'table.updateTime', '更新时间', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974670, 'hideTabs', '是否隐藏选项卡', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974671, 'level', '消息等级', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974672, 'menus.pureSelector', '范围选择器', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974673, 'menus.pureMessage', '消息提示', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974674, 'sort', '排序', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974675, 'buttons.pureReload', '重新加载', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974676, 'login.purePrivacyPolicy', '《隐私政策》', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974677, 'adminUser_password', '密码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812523974678, 'doubleCheck', '再次确认是否继续？！', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812528168961, 'menus.pureWaterfall', '瀑布流无限滚动', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812528168962, 'menus.pureBoard', '艺术画板', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812528168963, 'login.purePassWordUpdateReg', '修改密码成功', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812528168964, 'menus.purePermission', '权限管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812528168965, 'login.pureVerifyCodeReg', '请输入验证码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812528168966, 'emailUsers', '邮件用户配置', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812528168967, 'menus.pureWavesurfer', '音频可视化', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812532363266, 'login.pureTickPrivacy', '请勾选隐私政策', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812532363267, 'menus.pureElButton', '按钮', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812532363268, 'quartzExecuteLog_jobName', '任务名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812532363269, 'status.systemMessage', '系统消息', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812532363270, 'delete', '删除', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812532363271, 'role_description', '角色详情', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812532363272, 'formatError', '格式错误', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812532363273, 'total', '总数', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812532363274, 'routerPathTip', '路由路径为必填项且为\"/\"开头', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812532363275, 'buttons.pureAccountSettings', '账户设置', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812532363276, 'login.getCodeInfo', '秒后获取验证码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812532363277, 'extra', '消息简介', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557569, 'menus.pureSuccess', '成功页面', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557570, 'login.getEmailCode', '获取验证码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557571, 'status.pureTodo', '待办', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557572, 'menus.pureFourZeroFour', '404', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557573, 'menus.pureMenu1-1', '菜单1-1', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557574, 'menus.pureUser', '用户管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557575, 'menus.pureMenu1-2', '菜单1-2', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557576, 'menus.pureMenu1-3', '菜单1-3', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557577, 'buttons.pureClickExpand', '点击展开', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557578, 'user_status', '用户状态', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557579, 'menus.pureSchemaForm', '表单', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557580, 'buttons.accountSettings', '账户设置', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557581, 'buttons.pureCloseAllTabs', '关闭全部标签页', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557582, 'fold_all', '折叠全部', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557583, 'buttons.pureLogin', '登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557584, 'search.pureHistory', '搜索历史', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557585, 'markAsUnread', '标为未读', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812536557586, 'menus.pureOperationLog', '操作日志', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751874, 'panel.pureStretchCustom', '自定义', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751875, 'security_log', '安全日志', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751876, 'greyStyle', '是否启用灰色模式', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751877, 'system_file', '系统文件管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751878, 'menus.purePiniaDoc', 'pinia', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751879, 'bytes', '字节', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751880, 'schedulers_description', '调度器详情信息', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751881, 'iconCode', '图标类名', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751882, 'adminUser_status', '状态', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751883, 'darkMode', '暗色主题', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751884, 'menus.pureBarcode', '条形码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751885, 'knife4j', 'knife4j', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751886, 'menus.pureUpload', '文件上传', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751887, 'schedulersGroup_description', '任务调度详情', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751888, 'user_details', '用户详情', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751889, 'op_time', '操作时间', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751890, 'menus.pureEditor', '编辑器', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751891, 'addNew', '新增', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751892, 'quartzExecuteLog', '任务执行日志', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751893, 'panel.pureOverallStyleLight', '浅色', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751894, 'danger', '危险', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751895, 'cover', '封面', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751896, 'userLoginLog_viewportWidth', '视口宽度', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812540751897, 'panel.pureGreyModel', '灰色模式', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946177, 'routerName', '路由名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946178, 'menus.pureCollapse', '折叠面板', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946179, 'menus.pureMenus', '多级菜单', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946180, 'panel.pureTagsStyle', '页签风格', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946181, 'upload_avatar', '上传头像', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946182, 'panel.pureHiddenFooter', '隐藏页脚', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946183, 'adminUser_summary', '简介', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946184, 'sidebarStatus', '侧边栏的状态', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946185, 'monitoring', '系统监控', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946186, 'menus.pureDept', '部门管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946187, 'i18n', '多语言管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946188, 'adminUser_avatar', '头像', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946189, 'userLoginLog_contentDpr', '设备像素比', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946190, 'input', '输入', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946191, 'menus.pureExcel', '导出Excel', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946192, 'login.purePhoneLogin', '手机登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946193, 'power_requestUrl', '请求URL', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946194, 'i18n.translation', '翻译', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946195, 'menuIcon_iconName', '图标名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946196, 'emailTemplate_type', '模板类型', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946197, 'update_information', '更新信息', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946198, 'userLoginLog_secChUaModel', '设备模型', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946199, 'update_tip', '更新时确保数据备份，以免丢失', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946200, 'menus.pureFlowChart', '流程图', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946201, 'unread', '未读', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946202, 'menus.pureSystemMenu', '菜单管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946203, 'menus.pureTag', '标签', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812544946204, 'userLoginLog_xRequestedWith', '请求方式', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140481, 'menus.pureTableBase', '基础用法', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140482, 'panel.pureTagsStyleCard', '卡片', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140483, 'files_fileType', '文件类型', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140484, 'iconify', 'iconify图标', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140485, 'lastLoginIp', 'IP地址', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140486, 'default', '默认', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140487, 'hiddenSideBar', '侧边栏是否隐藏', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140488, 'assign_roles', '分配角色', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140489, 'system_i18n', '多语言', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140490, 'download_excel', '下载Excel', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140491, 'menus.pureGuide', '引导页', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140492, 'markdown', 'Markdown', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140493, 'panel.pureTagsStyleChromeTip', '谷歌风格，经典美观', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140494, 'upload_success', '上传成功', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140495, 'menus.pureFourZeroOne', '403', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140496, 'userLoginLog_dpr', '设备像素比', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140497, 'menus.pureMenu2', '菜单二', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140498, 'email', '邮箱', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140499, 'menus.pureMenu1', '菜单1', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140500, 'role_roleCode', '角色码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140501, 'delete_success', '删除成功', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140502, 'keepAlive', '保持存活', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140503, 'image_size', '图像大小', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140504, 'messageReceivingManagement', '消息接收管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140505, 'login.pureSmsVerifyCode', '短信验证码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140506, 'menus.pureJsonEditor', 'JSON编辑器', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140507, 'login.purePhoneCorrectReg', '请输入正确的手机号码格式', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140508, 'buttons.pureTagsStyleCard', '卡片', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140509, 'cancel_delete', '取消删除', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812549140510, 'dept', '部门管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812553334786, 'login.pureSure', '确认密码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812553334787, 'login.login', '登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812553334788, 'search.pureEmpty', '暂无搜索结果', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812553334789, 'confirm', '确定', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812553334790, 'login.pureRememberInfo', '勾选并登录后，规定天数内无需输入用户名和密码会自动登入系统', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812553334791, 'readMeDay', '记住我多久', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812553334792, 'menus.pureFormDesign', '表单设计器', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812553334793, 'menus.pureMenuTree', '菜单树结构', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812553334794, 'login.purePassWordRuleReg', '密码格式应为8-18位数字、字母、符号的任意两种组合', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812553334795, 'logManagement', '日志管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812553334796, 'i18n_typeName', '多语言类型名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812553334797, 'menus.pureExternalDoc', '文档外链', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812553334798, 'update_batches_parent', '批量更新父级', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812553334799, 'userLoginLog_ipRegion', 'IP归属地', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812553334800, 'panel.pureStretchFixedTip', '紧凑页面，轻松找到所需信息', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812561723394, 'menus.pureVxeTable', '虚拟滚动', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812561723395, 'login.pureBack', '返回', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812561723396, 'view', '查看', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812561723397, 'forcedOffline', '管理员强制下线', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812561723398, 'systemi18n', '多语言', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812561723399, 'quartzExecuteLog_jobClassName', '任务类名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812561723400, 'status.pureMessage', '消息', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812561723401, 'panel.pureTagsStyleSmart', '灵动', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812561723402, 'menus.pureProgress', '进度条', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812561723403, 'menus.pureInfiniteScroll', '表格无限滚动', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812561723404, 'login.pureWeChatLogin', '微信登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812561723405, 'schedulers_triggerState', '触发器状态', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812561723406, 'table.updateUser', '更新用户', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812561723407, 'menus.pureLogin', '登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917697, 'menus.pureComponents', '组件', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917698, 'iconName', '图标名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917699, 'menus.pureCropping', '图片裁剪', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917700, 'dept_manager', '管理员', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917701, 'no_data', '无数据', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917702, 'userLoginLog_userId', '用户ID', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917703, 'menus.home', '首页', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917704, 'menus.pureUiGradients', '渐变色', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917705, 'buttons.pureCloseCurrentTab', '关闭当前标签页', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917706, 'menus.purePrint', '打印', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917707, 'knife4j_Interface_documentation', 'knife4j接口文档', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917708, 'lastLoginIpAddress', '归属地', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917709, 'files_downloadCount', '下载量', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917710, 'emailTemplate_subject', '主题', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917711, 'buttons.pureConfirm', '确认', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917712, 'menus.pureFive', '500', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917713, 'menus.pureSysMonitor', '系统监控', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917714, 'userLoginLog_ipAddress', 'IP地址', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917715, 'expires', '过期时间', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917716, 'more_actions', '更多操作', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917717, 'hidden', '隐藏', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917718, 'submit', '提交', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917719, 'menus.pureMqtt', 'MQTT客户端(mqtt)', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917720, 'show', '显示', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917721, 'description', '详情', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917722, 'system_files', '后台文件管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917723, 'update', '更新', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917724, 'menus.pureFail', '失败页面', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917725, 'receivedUserIds', '接收用户', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812565917726, 'userLoginLog', '用户登录日志', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112001, 'contentTooShortTip', '内容不能少于30字', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112002, 'login.pureThirdLogin', '第三方登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112003, 'scheduler', '定时任务', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112004, 'download_configuration', '下载配置', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112005, 'login.pureInfo', '秒后重新获取', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112006, 'emailTemplate_templateName', '模板名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112007, 'account_management', '账户管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112008, 'continue_adding', '继续添加', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112009, 'adminUser_email', '邮箱', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112010, 'login.pureTip', '扫码后点击\"确认\"，即可完成登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112011, 'userinfo', '用户信息', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112012, 'systemCaches', '系统缓存', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112013, 'summary', '简介', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112014, 'normal', '正常', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112015, 'menus.purePermissionButton', '按钮权限', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112016, 'login.pureQQLogin', 'QQ登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112017, 'table.acceptanceTime', '接收时间', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112018, 'systemManagement', '系统管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112019, 'update_multilingual', '更新多语言', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112020, 'need_number', '需要数字', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112021, 'upload_user_avatar_tip', '上传头像成功不会自动保存', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112022, 'layout', '应用程序的布局', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112023, 'login.pureTest', '模拟测试', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112024, 'webConifg', 'web配置', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112025, 'adminUser', '后台用户', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112026, 'external_pages', '外部页面', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112027, 'appLocale', '本地语言', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112028, 'quartzExecuteLog_cronExpression', 'cron表达式', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112029, 'login.pureVerifyCodeSixReg', '请输入6位数字验证码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112030, 'menus.pureContextmenu', '右键菜单', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112031, 'panel.pureMixTip', '混合菜单，灵活多变', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112032, 'externalLink', '外链', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112033, 'panel.pureMultiTagsCache', '页签持久化', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112034, 'hideFooter', '是否隐藏页脚', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812570112035, 'file_import', '文件导入', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306306, 'markAsRead', '标为已读', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306307, 'login.username', '用户名', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306308, 'files_filename', '文件名', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306309, 'menus.pureQrcode', '二维码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306310, 'Interface_documentation', '接口文档', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306311, 'logout', '退出', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306312, 'menus.pureAble', '功能', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306313, 'menus.pureVideo', '视频', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306314, 'enable', '已启用', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306315, 'login.purePassword', '密码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306316, 'search.pureDragSort', '（可拖拽排序）', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306317, 'menus.pureSplitPane', '切割面板', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306318, 'menus.pureColorHuntDoc', '调色板', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306319, 'menus.pureGanttastic', '甘特图', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306320, 'menus.pureIconSelect', '图标选择器', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306321, 'buttons.pureTagsStyleChrome', '谷歌', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306322, 'login.pureWeiBoLogin', '微博登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306323, 'emailTemplate', '邮件模板', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306324, 'buttons.pureCloseRightTabs', '关闭右侧标签页', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306325, 'rest_password_tip', '忘记密码或重置密码，修改密码后会跳转到登录页重新登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306326, 'emailUsers_port', '端口', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306327, 'phone', '手机号', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306328, 'dept_summary', '部门简介', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306329, 'menus.pureDraggable', '拖拽', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306330, 'confirm_update_status', '确认修改状态吗', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306331, 'menus.purePinyin', '汉语拼音', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306332, 'primary', '默认', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306333, 'power_powerCode', '权限码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306334, 'userLoginLog_userAgent', '用户代理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306335, 'userLoginLog_secChUaMobile', '是否为手机设备', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306336, 'userLoginLog_downlink', '带宽', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306337, 'menus.pureSystemLog', '系统日志', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306338, 'login.emailCode', '输入验证码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306339, 'emailUsers_email', '邮箱', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306340, 'portion', '部分', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306341, 'login.pureReadAccept', '我已仔细阅读并接受', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812574306342, 'i18n.keyName', '多语言key', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500609, 'table.operation', '操作', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500610, 'external_chaining', '外链接', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500611, 'panel.pureHiddenTags', '隐藏标签页', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500612, 'login.pureVerifyCode', '验证码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500613, 'cropper_preview_tips', '温馨提示：右键上方裁剪区可开启功能菜单', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500614, 'weakStyle', '色弱模式', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500615, 'theme', '主题', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500616, 'menus.pureTimeline', '时间线', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500617, 'power', '权限管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500618, 'messageManagement', '消息管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500619, 'menus.purePdf', 'PDF预览', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500620, 'menus.pureMenu1-2-1', '菜单1-2-1', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500621, 'schedulers_triggerName', '触发器名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500622, 'menus.pureRouterDoc', 'vue-router', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500623, 'menus.pureMenu1-2-2', '菜单1-2-2', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500624, 'systemMenuIcon.officialWebsite', '菜单图标官网', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500625, 'login.pureRegisterSuccess', '注册成功', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500626, 'login.pureRemember', '天内免登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500627, 'panel.pureStretchFixed', '固定', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500628, 'menus.pureMenuOverflow', '目录超出显示Tooltip文字提示', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500629, 'not_added', '未添加', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500630, 'pure_admin', '后台管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500631, 'emailUsers_emailTemplate', '关联模板', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500632, 'login.pureAlipayLogin', '支付宝登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500633, 'menus.pureViteDoc', 'vite', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500634, 'componentPath', '组件路径', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500635, 'menus.pureMindMap', '思维导图', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500636, 'buttons.pureLoginOut', '退出系统', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500637, 'embedded_doc', '文档内嵌', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500638, 'menus.pureVueDoc', 'vue3', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500639, 'panel.pureOverallStyleSystemTip', '同步时光，界面随晨昏自然呼应', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500640, 'menus.pureOnlineUser', '在线用户', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500641, 'menus.pureDrawer', '函数式抽屉', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500642, 'buttons.pureOpenSystemSet', '打开系统配置', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500643, 'userLoginLog_secChUaPlatform', '操作系统/平台', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812578500644, 'panel.pureTagsStyleChrome', '谷歌', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694914, 'panel.pureStretch', '页宽', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694915, 'adminUser_sex', '性别', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694916, 'login.usernameRegex', '用户名格式错误', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694917, 'userLoginLog_secChUaArch', '平台架构', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694918, 'panel.pureClearCacheAndToLogin', '清空缓存并返回登录页', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694919, 'roleCode', '角色码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694920, 'emailTemplate_body', '模板内容', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694921, 'menus.purePermissionButtonRouter', '路由返回按钮权限', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694922, 'systemMaintenance', '系统维护', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694923, 'panel.pureVerticalTip', '左侧菜单，亲切熟悉', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694924, 'showModel', '要显示的模型', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694925, 'crop_and_upload_avatars', '裁剪、上传头像', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694926, 'visible', '隐藏', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694927, 'messageSendManagement', '消息发送管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694928, 'login.pureUsernameReg', '请输入账号', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694929, 'menus.pureSeamless', '无缝滚动', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694930, 'richText', '富文本', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694931, 'external_doc', '文档外链', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694932, 'pause', '暂停', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694933, 'panel.pureClearCache', '清空缓存', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694934, 'menus.pureExternalPage', '外部页面', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694935, 'menus.pureSensitive', '敏感词过滤', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694936, 'files', '文件', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694937, 'monitoring_server', '服务监控', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694938, 'schedulers_jobClassName', '任务类名', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694939, 'panel.pureTagsStyleSmartTip', '灵动标签，添趣生辉', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694940, 'admin_user', '用户管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694941, 'schedulersGroup_groupName', '分组名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694942, 'buttons.pureCloseOtherTabs', '关闭其他标签页', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694943, 'status.pureNoMessage', '暂无消息', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694944, 'confirmUpdateConfiguration', '确认修改配置吗？', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694945, 'configuration', '系统配置', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694946, 'update_success', '修改成功', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694947, 'schedulers_jobName', '任务名称', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812582694948, 'email_user_send_config', '邮件用户发送配置管理', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889218, 'routerNameTip', '路由名称为必填项', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889219, 'menus.pureUtilsLink', 'pure-admin-utils', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889220, 'menuIcon_preview', '图标预览', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889221, 'sendUserId', '发送用户', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889222, 'panel.pureTagsStyleCardTip', '卡片标签，高效浏览', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889223, 'menus.pureDateTimePicker', '日期时间选择器', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889224, 'confirm_forcedOffline', '确认强制此用户下线吗', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889225, 'menus.pureTailwindcssDoc', 'tailwindcss', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889226, 'menus.pureDanmaku', '弹幕', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889227, 'menus.pureDialog', '函数式弹框', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889228, 'menus.pureTable', '表格', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889229, 'download_json', '下载JSON', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889230, 'confirm_update_sort', '是否确认更新排序', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889231, 'panel.pureLayoutModel', '导航模式', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889232, 'login.pureLoginSuccess', '登录成功', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889233, 'i18n_type_setting', '多语言类型', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889234, 'menus.pureEpDoc', 'element-plus', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889235, 'panel.pureSystemSet', '系统配置', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889236, 'login.pureLogin', '登录', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889237, 'panel.pureHorizontalTip', '顶部菜单，简洁概览', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889238, 'emailTemplate_emailUser', '邮件模板用户', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889239, 'login.pureForget', '忘记密码?', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889240, 'login.purePhoneReg', '请输入手机号码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889241, 'login.pureLoginFail', '登录失败', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889242, 'search.pureCollect', '收藏', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889243, 'buttons.pureClose', '关闭', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889244, 'deleteBatchPlaceholder', '输入 yes/YES/y/Y 来确认', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918966812586889245, 'reset_passwords', '重置密码', 'zh', 1, 1, '2025-05-04 17:51:55', '2025-05-04 17:51:55', 0);
INSERT INTO `sys_i18n` VALUES (1918989651650043906, 'cancel', 'Cancel', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651662626818, 'menus.pureVerify', 'Graphic Verification Code', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651662626819, 'buttons.pureTagsStyleCardTip', 'Card tags, efficient browsing', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651666821121, 'buttons.pureTagsStyle', 'Tab Style', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651666821122, 'i18n.typeId', 'Type ID', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651666821123, 'menus.pureRole', 'Role Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651666821124, 'login.purePhone', 'Phone Number', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651666821125, 'search.purePlaceholder', 'Search menu (supports pinyin search)', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651666821126, 'readAlready', 'Read', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651666821127, 'menus.pureCheckCard', 'Multiple Choice Cards', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651666821128, 'menus.pureTimePicker', 'Time Picker', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651666821129, 'overallStyle', 'Overall style of the application', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651671015425, 'menus.pureButton', 'Button Animation', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651671015426, 'adminUser_phone', 'Phone Number', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651671015427, 'path', 'Route Path', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651671015428, 'receivedUserIdTip', 'Leave blank to notify all', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651671015429, 'schedulers', 'Scheduled Tasks', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651671015430, 'messageType', 'Message Type', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651671015431, 'panel.pureThemeColor', 'Theme Color', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651671015432, 'buttons.pureContentFullScreen', 'Content Area Full Screen', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651675209729, 'buttons.pureCloseText', 'Off', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651675209730, 'emailUsers_host', 'Host Address', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651675209731, 'no_default', 'Not Default', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651675209732, 'returnToHomepage', 'Return to Homepage', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651675209733, 'cachingAsyncRoutes', 'Whether to cache async routes', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651675209734, 'panel.pureOverallStyleSystem', 'Auto', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651679404034, 'panel.pureOverallStyle', 'Overall Style', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651679404035, 'multilingualManagement', 'Multilingual Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651679404036, 'userLoginLog_secChUa', 'Brand and Version', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651679404037, 'userLoginLog_ect', 'Effective Connection Type', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651679404038, 'userLoginLog_secChUaBitness', 'CPU Architecture Bits', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651679404039, 'version', 'Version', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651683598337, 'menus.pureCascader', 'Region Cascader', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651683598338, 'isDefault', 'Is Default', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651683598339, 'menus.purePermissionButtonLogin', 'Login API Returns Button Permissions', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651683598340, 'multiTagsCache', 'Whether to cache multiple tags', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651683598341, 'menuNameTip', 'Menu name is required', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651683598342, 'table.createTime', 'Creation Time', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651683598343, 'menus.pureDatePicker', 'Date Picker', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651683598344, 'receivedUserNickname', 'Recipient Nickname', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651683598345, 'role', 'Role Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651691986946, 'panel.pureOverallStyleDark', 'Dark', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651691986947, 'delete_batches', 'Batch Delete', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651691986948, 'buttons.pureCloseLeftTabs', 'Close Left Tabs', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651691986949, 'isRead', 'Is Read', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651691986950, 'system_setting', 'System Settings', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651691986951, 'buttons.pureBackTop', 'Back to Top', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651691986952, 'appTitle', 'Page Title', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651691986953, 'menus.pureList', 'List Page', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651696181250, 'menus.pureTypeit', 'Typewriter', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651696181251, 'logged_in_user', 'Authenticated User', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651696181252, 'search', 'Search', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651696181253, 'userLoginLog_deviceMemory', 'Memory', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651696181254, 'menus.pureEmbeddedDoc', 'Embedded Document', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651696181255, 'drop_file_here', 'Drag file here', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651696181256, 'delete_warning', 'Delete Warning', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651696181257, 'nickname', 'Nickname', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651696181258, 'dept_deptName', 'Department Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651696181259, 'buttons.pureClickCollapse', 'Click to Collapse', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651696181260, 'resume', 'Resume', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651700375554, 'menus.pureSysManagement', 'System Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651700375555, 'userLoginLog_width', 'Viewport Width', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651700375556, 'inputRuleMustBeEnglish', 'Must be in English', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651700375557, 'sex', 'Gender', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651700375558, 'allMarkAsRead', 'Mark All as Read', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651700375559, 'sorryServerError', 'Sorry, server error occurred', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651700375560, 'routerPath', 'Route Path', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651700375561, 'menus.pureSegmented', 'Segmented Controller', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651704569858, 'menus.pureLineTree', 'Tree with Connection Lines', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651704569859, 'menus.pureSwiper', 'Swiper Plugin', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651704569860, 'adminUser_username', 'Username', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651704569861, 'menus.pureDownload', 'Download', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651704569862, 'required_fields', 'Fill in required fields', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651704569863, 'i18n_summary', 'Multilingual Details Explanation', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651704569864, 'adminUser_dept', 'Department', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651704569865, 'menuSearchHistory', 'Menu Search History', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651704569866, 'quartzExecuteLog_executeResult', 'Execution Result', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651708764161, 'click_to_upload', 'Click to upload file', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651708764162, 'userLoginLog_token', 'Token', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651708764163, 'added', 'Added', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651708764164, 'assignBatchRolesToRouter', 'Batch Assign Roles', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651708764165, 'animationNotExist', 'Animation does not exist', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651708764166, 'status.pureNoTodo', 'No pending tasks', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651708764167, 'menus.pureHome', 'Home', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651708764168, 'confirmText', 'Confirmation Text', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651708764169, 'inputRequestUrlTip', 'Request URL must start with \'/\'', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651708764170, 'menuName', 'Menu Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651712958465, 'login.password', 'Password', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651712958466, 'fixedHeader', 'Fixed Header', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651712958467, 'power_parentId', 'Permission Parent', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651712958468, 'menus.pureTableHigh', 'Advanced Usage', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651712958469, 'dept_remarks', 'Remarks', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651712958470, 'warning', 'Warning', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651712958471, 'female', 'Female', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651712958472, 'schedulers_jobGroup', 'Job Group', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651712958473, 'info', 'Info', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651712958474, 'add', 'Add', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651717152770, 'buttons.pureTagsStyleChromeTip', 'Chrome style, classic and beautiful', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651717152771, 'status.pureNoNotify', 'No notifications', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651717152772, 'buttons.pureTagsStyleSmart', 'Smart', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651717152773, 'logged_in', 'Logged In', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651717152774, 'quartzExecuteLog_triggerName', 'Trigger Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651717152775, 'emailUsers_isDefault', 'Is Default', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651717152776, 'menus.pureEmpty', 'No Layout Page', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651717152777, 'menus.pureVideoFrame', 'Video Frame Capture - WASM Version', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651717152778, 'buttons.pureOpenText', 'On', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651717152779, 'menus.pureRipple', 'Ripple', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651717152780, 'buttons.reset', 'Reset', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651717152781, 'adminUser_nickname', 'Nickname', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651725541378, 'search.pureTotal', 'Total', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651725541379, 'login.purePassWordDifferentReg', 'The two passwords do not match!', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651725541380, 'success', 'Success', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651725541381, 'login.pureDefinite', 'Confirm', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651725541382, 'panel.pureOverallStyleLightTip', 'Fresh start, bright and comfortable work interface', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651725541383, 'menus.pureText', 'Text Ellipsis', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651725541384, 'messageName', 'Message Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651729735681, 'sorryNoAccess', 'Sorry, you do not have access to this page', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651729735682, 'menuArrowIconNoTransition', 'Whether menu arrow icon has no transition effect', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651729735683, 'assignBatchRolesToRouterTip', 'Batch assigning roles will clear already assigned roles and not append roles', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651729735684, 'notifyAll', 'Notify All', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651729735685, 'requestMethod', 'Request Method', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651729735686, 'for', 'For', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651729735687, 'back', 'Back', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651729735688, 'forced_offline', 'Force Offline', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651729735689, 'title', 'Title', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651729735690, 'take_back', 'Take Back', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651729735691, 'content', 'Content', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651733929985, 'stretch', 'Whether to stretch', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651733929986, 'confirm_update_password', 'Confirm to update password?', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651733929987, 'emailUsers_password', 'Password', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651733929988, 'pixel', 'Pixel', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651733929989, 'menus.pureColorPicker', 'Color Picker', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651733929990, 'schedulers_cronExpression', 'Cron Expression', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651733929991, 'menus.pureWatermark', 'Watermark', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651733929992, 'monitor', 'System Monitor', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651733929993, 'userLoginLog_username', 'Username', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651733929994, 'power_powerName', 'Permission Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651742318593, 'message', 'Message', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651742318594, 'confirmDelete', 'Confirm to delete?', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651742318595, 'login.pureQRCodeLogin', 'QR Code Login', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651742318596, 'login.purePassWordSureReg', 'Please enter confirmation password', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651742318597, 'modify', 'Modify', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651742318598, 'clearAllRolesSelect', 'Clear All Selected Roles', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651742318599, 'menus.pureMap', 'Map', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651742318600, 'menus.pureOptimize', 'Debounce, Throttle, Copy, Long-press Directives', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651742318601, 'i18n.typeName', 'Type Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651742318602, 'menus.pureAnimatecss', 'animate.css Selector', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651742318603, 'login.pureUsername', 'Account', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651742318604, 'pleaseSelectAnimation', 'Please select animation', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651742318605, 'no_server', 'No Service', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651742318606, 'clearAllRolesSelectTip', 'This operation will clear already assigned menu roles. If confirmed, this operation cannot be undone, and roles assigned to the menu will also be cleared!!!', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651742318607, 'username', 'Username', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512897, 'copyright', 'Copyright', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512898, 'menus.pureTableEdit', 'Editable Usage', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512899, 'select', 'Select', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512900, 'epThemeColor', 'Theme Color', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512901, 'userLoginLog_type', 'Operation Type', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512902, 'sorryPageNotFound', 'Sorry, the page you visited does not exist', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512903, 'login.pureVerifyCodeCorrectReg', 'Please enter correct verification code', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512904, 'select_icon', 'Select Icon', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512905, 'batchUpdates', 'Confirm batch update?', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512906, 'menus.pureTabs', 'Tab Operations', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512907, 'buttons.pureTagsStyleSmartTip', 'Smart tags, adding fun and beauty', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512908, 'system_menu', 'System Menu', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512909, 'dept_parentId', 'Department Parent', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512910, 'i18n_type', 'Multilingual Type', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512911, 'id', 'Primary Key', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512912, 'emailUsers_smtpAgreement', 'SMTP Agreement', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512913, 'status.pureNotify', 'Notification', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512914, 'power_setting', 'Permission Settings', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651746512915, 'messageEditing', 'Message Editing', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651750707201, 'modifyingConfiguration', 'Modifying Configuration', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651750707202, 'download_batch', 'Batch Download', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651750707203, 'menus.purePermissionPage', 'Page Permission', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651750707204, 'login.pureGetVerifyCode', 'Get Verification Code', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651750707205, 'panel.pureCloseSystemSet', 'Close Configuration', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651750707206, 'element_plus', 'Element UI', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651750707207, 'index', 'Index', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651750707208, 'email_login', 'Email Login', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651750707209, 'menus.pureCardList', 'Card List Page', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651750707210, 'menus.pureAbout', 'About', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901505, 'table.createUser', 'Created By', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901506, 'account_password', 'Account Password', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901507, 'panel.pureStretchCustomTip', 'Minimum 1280, maximum 1600', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901508, '404', '404', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901509, 'deleteBatches', 'Batch Delete', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901510, 'menus.pureCheckButton', 'Selectable Button', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901511, 'menuType', 'Menu Type', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901512, 'buttons.pureContentExitFullScreen', 'Content Area Exit Full Screen', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901513, 'status', 'Status', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901514, 'external_page', 'External Page', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901515, 'menus.pureVirtualList', 'Virtual List', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901516, 'login.pureRegister', 'Register', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901517, 'buttons.pureInterfaceDisplay', 'Interface Display', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901518, 'userPassword', 'User Password', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901519, 'menuIcon_iconCode', 'Icon Class Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651754901520, 'quartzExecuteLog_endTime', 'End Time', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290113, 'login', 'Login', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290114, 'menus.pureLoginLog', 'Login Log', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290115, 'menus.pureExternalLink', 'vue-pure-admin', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290116, 'userLoginLog_rtt', 'Round Trip Time', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290117, 'schedulers_jobMethodName', 'Method Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290118, 'menus.pureCountTo', 'Number Animation', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290119, 'tooltipEffect', 'Tooltip Effect', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290120, 'menus.pureStatistic', 'Statistics Component', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290121, 'man', 'Male', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290122, 'addMultilingual', 'Add Multilingual', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290123, 'use_json_update', 'Update using JSON', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290124, 'login.purePassWordReg', 'Please enter password', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290125, 'view_user_info', 'View User Info', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290126, 'schedulersGroup', 'Task Scheduler Group', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290127, 'avatar', 'Avatar', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290128, 'deleteBatchTip', 'Enter yes/YES/y/Y to confirm batch deletion, this operation cannot be undone', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290129, 'menu', 'Menu', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290130, 'file_size', 'File Size', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290131, 'menus.pureDebounce', 'Debounce', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290132, 'use_excel_update', 'Update using Excel', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290133, 'sendNickname', 'Sender Nickname', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290134, 'disable', 'Disable', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651763290135, 'userLoginLog_secChUaPlatformVersion', 'OS Version', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651767484418, 'responsiveStorageNameSpace', 'Responsive Storage Namespace', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651767484419, 'panel.pureWeakModel', 'Color Weak Mode', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651767484420, 'panel.pureInterfaceDisplay', 'Interface Display', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651767484421, 'editorType', 'Editor Type', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651767484422, 'unfold_all', 'Expand All', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651767484423, 'Searching_for_router', 'Searching for router', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651767484424, 'panel.pureOverallStyleDarkTip', 'Moonlight prelude, immersed in the quiet elegance of the night', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651767484425, 'showLogo', 'Whether to show logo', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651767484426, 'menuIcon', 'Menu Icon', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651767484427, 'status.pureLoad', 'Loading...', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651767484428, 'files_filepath', 'File Storage Path', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651767484429, 'quartzExecuteLog_duration', 'Execution Time', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651771678722, 'swagger', 'swagger', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651771678723, 'format_error', 'Format Error', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651771678724, 'Searching_for_roles', 'Searching for roles', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651771678725, 'menus.pureAbnormal', 'Exception Page', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651771678726, 'download', 'Download', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651771678727, 'quartzExecuteLog_jobGroup', 'Job Group', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651771678728, 'menus.pureChildMenuOverflow', 'Menu overflow shows Tooltip text', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651771678729, 'previousMenu', 'Parent Menu', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651771678730, 'buttons.pureSwitch', 'Switch', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651771678731, 'menus.pureResult', 'Result Page', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651771678732, 'login.loginSuccess', 'Login Success', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651775873026, 'personDescription', 'Personal Details', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651775873027, 'all', 'All', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651775873028, 'table.updateTime', 'Update Time', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651775873029, 'hideTabs', 'Whether to hide tabs', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651775873030, 'level', 'Message Level', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651775873031, 'menus.pureSelector', 'Range Selector', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651775873032, 'menus.pureMessage', 'Message Prompt', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651775873033, 'sort', 'Sort', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651775873034, 'buttons.pureReload', 'Reload', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651775873035, 'login.purePrivacyPolicy', 'Privacy Policy', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651775873036, 'adminUser_password', 'Password', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651775873037, 'doubleCheck', 'Double check to confirm whether to continue?!', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261633, 'menus.pureWaterfall', 'Waterfall Infinite Scroll', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261634, 'menus.pureBoard', 'Art Board', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261635, 'login.purePassWordUpdateReg', 'Password updated successfully', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261636, 'menus.purePermission', 'Permission Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261637, 'login.pureVerifyCodeReg', 'Please enter verification code', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261638, 'emailUsers', 'Email User Configuration', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261639, 'menus.pureWavesurfer', 'Audio Visualization', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261640, 'login.pureTickPrivacy', 'Please check the privacy policy', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261641, 'menus.pureElButton', 'Button', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261642, 'quartzExecuteLog_jobName', 'Job Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261643, 'status.systemMessage', 'System Message', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261644, 'delete', 'Delete', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261645, 'role_description', 'Role Details', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261646, 'formatError', 'Format Error', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261647, 'total', 'Total', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261648, 'routerPathTip', 'Route path is required and must start with \'/\'', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261649, 'buttons.pureAccountSettings', 'Account Settings', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261650, 'login.getCodeInfo', 'seconds to get verification code', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261651, 'extra', 'Message Summary', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261652, 'menus.pureSuccess', 'Success Page', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261653, 'login.getEmailCode', 'Get Verification Code', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261654, 'status.pureTodo', 'Todo', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261655, 'menus.pureFourZeroFour', '404', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651784261656, 'menus.pureMenu1-1', 'Menu 1-1', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455937, 'menus.pureUser', 'User Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455938, 'menus.pureMenu1-2', 'Menu 1-2', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455939, 'menus.pureMenu1-3', 'Menu 1-3', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455940, 'buttons.pureClickExpand', 'Click to Expand', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455941, 'user_status', 'User Status', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455942, 'menus.pureSchemaForm', 'Form', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455943, 'buttons.accountSettings', 'Account Settings', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455944, 'buttons.pureCloseAllTabs', 'Close All Tabs', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455945, 'fold_all', 'Collapse All', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455946, 'buttons.pureLogin', 'Login', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455947, 'search.pureHistory', 'Search History', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455948, 'markAsUnread', 'Mark as Unread', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455949, 'korean', 'Korean', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455950, 'menus.pureOperationLog', 'Operation Log', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455951, 'panel.pureStretchCustom', 'Custom', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455952, 'security_log', 'Security Log', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455953, 'greyStyle', 'Whether to enable gray mode', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455954, 'system_file', 'System File Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455955, 'menus.purePiniaDoc', 'pinia', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455956, 'bytes', 'Bytes', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455957, 'schedulers_description', 'Scheduler Details', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455958, 'iconCode', 'Icon Class Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455959, 'adminUser_status', 'Status', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455960, 'darkMode', 'Dark Theme', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455961, 'menus.pureBarcode', 'Barcode', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455962, 'knife4j', 'knife4j', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455963, 'menus.pureUpload', 'File Upload', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455964, 'schedulersGroup_description', 'Task Scheduler Details', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651788455965, 'user_details', 'User Details', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650242, 'op_time', 'Operation Time', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650243, 'menus.pureEditor', 'Editor', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650244, 'addNew', 'Add New', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650245, 'quartzExecuteLog', 'Task Execution Log', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650246, 'panel.pureOverallStyleLight', 'Light', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650247, 'danger', 'Danger', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650248, 'cover', 'Cover', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650249, 'userLoginLog_viewportWidth', 'Viewport Width', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650250, 'panel.pureGreyModel', 'Gray Mode', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650251, 'routerName', 'Route Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650252, 'menus.pureCollapse', 'Collapse Panel', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650253, 'menus.pureMenus', 'Multi-level Menu', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650254, 'panel.pureTagsStyle', 'Tab Style', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650255, 'upload_avatar', 'Upload Avatar', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650256, 'panel.pureHiddenFooter', 'Hide Footer', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650257, 'adminUser_summary', 'Summary', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650258, 'sidebarStatus', 'Sidebar Status', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650259, 'monitoring', 'System Monitoring', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650260, 'menus.pureDept', 'Department Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650261, 'i18n', 'Multilingual Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650262, 'adminUser_avatar', 'Avatar', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650263, 'userLoginLog_contentDpr', 'Device Pixel Ratio', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650264, 'input', 'Input', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650265, 'menus.pureExcel', 'Export Excel', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650266, 'login.purePhoneLogin', 'Phone Login', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650267, 'power_requestUrl', 'Request URL', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650268, 'i18n.translation', 'Translation', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650269, 'menuIcon_iconName', 'Icon Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650270, 'emailTemplate_type', 'Template Type', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650271, 'update_information', 'Update Information', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650272, 'userLoginLog_secChUaModel', 'Device Model', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650273, 'update_tip', 'Ensure data backup when updating to avoid loss', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650274, 'menus.pureFlowChart', 'Flow Chart', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650275, 'unread', 'Unread', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650276, 'menus.pureSystemMenu', 'Menu Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650277, 'menus.pureTag', 'Tag', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650278, 'userLoginLog_xRequestedWith', 'Request Method', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650279, 'menus.pureTableBase', 'Basic Usage', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650280, 'panel.pureTagsStyleCard', 'Card', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650281, 'files_fileType', 'File Type', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650282, 'iconify', 'iconify Icon', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650283, 'lastLoginIp', 'IP Address', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650284, 'default', 'Default', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650285, 'hiddenSideBar', 'Whether to hide sidebar', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650286, 'assign_roles', 'Assign Roles', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650287, 'system_i18n', 'Multilingual', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650288, 'download_excel', 'Download Excel', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650289, 'menus.pureGuide', 'Guide Page', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650290, 'markdown', 'Markdown', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650291, 'panel.pureTagsStyleChromeTip', 'Chrome style, classic and beautiful', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650292, 'upload_success', 'Upload Success', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650293, 'menus.pureFourZeroOne', '403', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650294, 'userLoginLog_dpr', 'Device Pixel Ratio', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650295, 'menus.pureMenu2', 'Menu 2', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650296, 'email', 'Email', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650297, 'menus.pureMenu1', 'Menu 1', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650298, 'role_roleCode', 'Role Code', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650299, 'delete_success', 'Delete Success', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651792650300, 'keepAlive', 'Keep Alive', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038849, 'image_size', 'Image Size', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038850, 'messageReceivingManagement', 'Message Receiving Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038851, 'login.pureSmsVerifyCode', 'SMS Verification Code', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038852, 'menus.pureJsonEditor', 'JSON Editor', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038853, 'login.purePhoneCorrectReg', 'Please enter correct phone number format', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038854, 'buttons.pureTagsStyleCard', 'Card', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038855, 'cancel_delete', 'Cancel Delete', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038856, 'dept', 'Department Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038857, 'login.pureSure', 'Confirm Password', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038858, 'login.login', 'Login', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038859, 'search.pureEmpty', 'No search results yet', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038860, 'confirm', 'Confirm', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038861, 'login.pureRememberInfo', 'Check and log in, no need to enter username and password within the specified days to automatically log in to the system', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038862, 'readMeDay', 'Remember Me Until', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038863, 'menus.pureFormDesign', 'Form Designer', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038864, 'menus.pureMenuTree', 'Menu Tree Structure', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038865, 'login.purePassWordRuleReg', 'Password format should be 8-18 digits, letters, symbols in any two combinations', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038866, 'logManagement', 'Log Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038867, 'i18n_typeName', 'Multilingual Type Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038868, 'menus.pureExternalDoc', 'External Document', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038869, 'update_batches_parent', 'Batch Update Parent', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651801038870, 'userLoginLog_ipRegion', 'IP Location', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651809427458, 'panel.pureStretchFixedTip', 'Compact page, easily find needed information', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651809427459, 'menus.pureVxeTable', 'Virtual Scroll', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651809427460, 'login.pureBack', 'Back', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651809427461, 'view', 'View', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651809427462, 'forcedOffline', 'Admin Force Offline', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651809427463, 'systemi18n', 'Multilingual', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651809427464, 'quartzExecuteLog_jobClassName', 'Job Class Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651809427465, 'status.pureMessage', 'Message', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651809427466, 'panel.pureTagsStyleSmart', 'Smart', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651809427467, 'menus.pureProgress', 'Progress Bar', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651809427468, 'menus.pureInfiniteScroll', 'Table Infinite Scroll', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651809427469, 'login.pureWeChatLogin', 'WeChat Login', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651809427470, 'schedulers_triggerState', 'Trigger State', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651809427471, 'table.updateUser', 'Updated By', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651809427472, 'menus.pureLogin', 'Login', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621762, 'menus.pureComponents', 'Components', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621763, 'iconName', 'Icon Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621764, 'menus.pureCropping', 'Image Cropping', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621765, 'dept_manager', 'Manager', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621766, 'no_data', 'No Data', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621767, 'userLoginLog_userId', 'User ID', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621768, 'menus.home', 'Home', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621769, 'menus.pureUiGradients', 'Gradient Colors', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621770, 'buttons.pureCloseCurrentTab', 'Close Current Tab', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621771, 'menus.purePrint', 'Print', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621772, 'knife4j_Interface_documentation', 'knife4j Interface Documentation', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621773, 'lastLoginIpAddress', 'Location', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621774, 'files_downloadCount', 'Download Count', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621775, 'emailTemplate_subject', 'Subject', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621776, 'buttons.pureConfirm', 'Confirm', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621777, 'menus.pureFive', '500', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621778, 'menus.pureSysMonitor', 'System Monitor', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621779, 'userLoginLog_ipAddress', 'IP Address', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621780, 'expires', 'Expires Date', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621781, 'more_actions', 'Additional Actions', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621782, 'hidden', 'Hidden', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621783, 'submit', 'Submit', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621784, 'menus.pureMqtt', 'MQTT Client (mqtt)', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621785, 'show', 'Show', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621786, 'description', 'Details', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621787, 'system_files', 'Backend File Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651813621788, 'update', 'Update', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816065, 'menus.pureFail', 'Failure Page', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816066, 'receivedUserIds', 'Recipient Users', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816067, 'userLoginLog', 'User Login Log', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816068, 'contentTooShortTip', 'Content cannot be less than 30 characters', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816069, 'login.pureThirdLogin', 'Third-party Login', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816070, 'scheduler', 'Scheduled Task', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816071, 'download_configuration', 'Download Configuration', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816072, 'login.pureInfo', 'seconds to retry', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816073, 'emailTemplate_templateName', 'Template Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816074, 'account_management', 'Account Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816075, 'continue_adding', 'Continue Adding', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816076, 'adminUser_email', 'Email', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816077, 'login.pureTip', 'After scanning, click \"Confirm\" to complete login', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816078, 'userinfo', 'User Info', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816079, 'systemCaches', 'System Caches', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816080, 'summary', 'Summary', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816081, 'normal', 'Normal', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816082, 'menus.purePermissionButton', 'Button Permission', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816083, 'login.pureQQLogin', 'QQ Login', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816084, 'table.acceptanceTime', 'Acceptance Time', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816085, 'systemManagement', 'System Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816086, 'update_multilingual', 'Update Multilingual', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816087, 'need_number', 'Number Required', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816088, 'upload_user_avatar_tip', 'Uploading avatar successfully will not be saved automatically', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816089, 'layout', 'Application Layout', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816090, 'login.pureTest', 'Simulation Test', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816091, 'webConifg', 'Web Configuration', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816092, 'adminUser', 'Admin User', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816093, 'external_pages', 'External Pages', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816094, 'appLocale', 'Local Language', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816095, 'quartzExecuteLog_cronExpression', 'Cron Expression', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816096, 'login.pureVerifyCodeSixReg', 'Please enter 6-digit verification code', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816097, 'menus.pureContextmenu', 'Context Menu', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651817816098, 'panel.pureMixTip', 'Mixed menu, flexible and variable', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010369, 'externalLink', 'External Link', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010370, 'panel.pureMultiTagsCache', 'Tab Persistence', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010371, 'hideFooter', 'Whether to hide footer', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010372, 'file_import', 'File Import', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010373, 'markAsRead', 'Mark as Read', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010374, 'login.username', 'Username', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010375, 'files_filename', 'Filename', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010376, 'menus.pureQrcode', 'QR Code', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010377, 'Interface_documentation', 'Interface Documentation', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010378, 'logout', 'Logout', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010379, 'menus.pureAble', 'Function', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010380, 'menus.pureVideo', 'Video', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010381, 'enable', 'Enabled', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010382, 'login.purePassword', 'Password', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010383, 'search.pureDragSort', '(Drag to sort)', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010384, 'menus.pureSplitPane', 'Split Panel', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010385, 'menus.pureColorHuntDoc', 'Color Palette', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010386, 'menus.pureGanttastic', 'Gantt Chart', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010387, 'menus.pureIconSelect', 'Icon Selector', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010388, 'buttons.pureTagsStyleChrome', 'Chrome', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010389, 'login.pureWeiBoLogin', 'Weibo Login', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010390, 'emailTemplate', 'Email Template', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010391, 'buttons.pureCloseRightTabs', 'Close Right Tabs', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010392, 'rest_password_tip', 'Forgot password or reset password, after changing the password will jump to the login page to log in again', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010393, 'emailUsers_port', 'Port', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010394, 'phone', 'Phone Number', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010395, 'dept_summary', 'Department Summary', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010396, 'menus.pureDraggable', 'Drag', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010397, 'confirm_update_status', 'Confirm to update status?', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010398, 'menus.purePinyin', 'Chinese Pinyin', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010399, 'primary', 'Default', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010400, 'power_powerCode', 'Permission Code', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010401, 'userLoginLog_userAgent', 'User Agent', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010402, 'userLoginLog_secChUaMobile', 'Is Mobile Device', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651822010403, 'userLoginLog_downlink', 'Bandwidth', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204674, 'menus.pureSystemLog', 'System Log', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204675, 'login.emailCode', 'Enter Verification Code', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204676, 'emailUsers_email', 'Email', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204677, 'portion', 'Portion', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204678, 'login.pureReadAccept', 'I have carefully read and accept', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204679, 'i18n.keyName', 'Multilingual Key', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204680, 'table.operation', 'Operation', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204681, 'external_chaining', 'External Link', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204682, 'panel.pureHiddenTags', 'Hide Tabs', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204683, 'login.pureVerifyCode', 'Verification Code', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204684, 'cropper_preview_tips', 'Tip: Right-click the cropping area above to open the function menu', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204685, 'weakStyle', 'Color Weak Mode', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204686, 'theme', 'Theme', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204687, 'menus.pureTimeline', 'Timeline', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204688, 'power', 'Permission Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204689, 'messageManagement', 'Message Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204690, 'menus.purePdf', 'PDF Preview', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204691, 'menus.pureMenu1-2-1', 'Menu 1-2-1', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204692, 'schedulers_triggerName', 'Trigger Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204693, 'menus.pureRouterDoc', 'vue-router', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651826204694, 'menus.pureMenu1-2-2', 'Menu 1-2-2', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651830398977, 'systemMenuIcon.officialWebsite', 'Menu Icon Official Website', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651830398978, 'login.pureRegisterSuccess', 'Registration Success', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651830398979, 'login.pureRemember', 'days no login required', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651830398980, 'panel.pureStretchFixed', 'Fixed', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651830398981, 'menus.pureMenuOverflow', 'Directory overflow shows Tooltip text', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651830398982, 'not_added', 'Not Added', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651830398983, 'pure_admin', 'Admin Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651830398984, 'emailUsers_emailTemplate', 'Associated Template', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651830398985, 'login.pureAlipayLogin', 'Alipay Login', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651830398986, 'menus.pureViteDoc', 'vite', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651830398987, 'componentPath', 'Component Path', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593282, 'menus.pureMindMap', 'Mind Map', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593283, 'buttons.pureLoginOut', 'Logout', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593284, 'embedded_doc', 'Embedded Document', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593285, 'menus.pureVueDoc', 'vue3', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593286, 'panel.pureOverallStyleSystemTip', 'Synchronized time, interface naturally echoes with dawn and dusk', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593287, 'menus.pureOnlineUser', 'Online User', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593288, 'menus.pureDrawer', 'Functional Drawer', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593289, 'buttons.pureOpenSystemSet', 'Open System Configuration', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593290, 'userLoginLog_secChUaPlatform', 'OS/Platform', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593291, 'panel.pureTagsStyleChrome', 'Chrome', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593292, 'panel.pureStretch', 'Page Width', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593293, 'adminUser_sex', 'Gender', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593294, 'login.usernameRegex', 'Username format error', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593295, 'userLoginLog_secChUaArch', 'Platform Architecture', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593296, 'panel.pureClearCacheAndToLogin', 'Clear Cache and Return to Login Page', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593297, 'roleCode', 'Role Code', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593298, 'emailTemplate_body', 'Template Content', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593299, 'menus.purePermissionButtonRouter', 'Route Returns Button Permissions', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593300, 'systemMaintenance', 'System Maintenance', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593301, 'panel.pureVerticalTip', 'Left menu, familiar and friendly', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593302, 'showModel', 'Model to Display', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593303, 'crop_and_upload_avatars', 'Crop and Upload Avatars', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593304, 'visible', 'Hidden', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593305, 'messageSendManagement', 'Message Sending Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593306, 'login.pureUsernameReg', 'Please enter account', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593307, 'menus.pureSeamless', 'Seamless Scroll', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593308, 'richText', 'Rich Text', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593309, 'external_doc', 'External Document', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593310, 'pause', 'Pause', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593311, 'panel.pureClearCache', 'Clear Cache', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593312, 'menus.pureExternalPage', 'External Page', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593313, 'menus.pureSensitive', 'Sensitive Word Filter', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593314, 'files', 'Files', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593315, 'monitoring_server', 'Service Monitoring', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651834593316, 'schedulers_jobClassName', 'Job Class Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787586, 'panel.pureTagsStyleSmartTip', 'Smart tags, adding fun and beauty', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787587, 'admin_user', 'User Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787588, 'schedulersGroup_groupName', 'Group Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787589, 'buttons.pureCloseOtherTabs', 'Close Other Tabs', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787590, 'status.pureNoMessage', 'No messages', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787591, 'confirmUpdateConfiguration', 'Confirm to update configuration?', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787592, 'configuration', 'System Configuration', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787593, 'update_success', 'Update Success', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787594, 'schedulers_jobName', 'Job Name', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787595, 'email_user_send_config', 'Email User Send Configuration Management', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787596, 'routerNameTip', 'Route name is required', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787597, 'menus.pureUtilsLink', 'pure-admin-utils', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787598, 'menuIcon_preview', 'Icon Preview', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787599, 'sendUserId', 'Sender User', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787600, 'panel.pureTagsStyleCardTip', 'Card tags, efficient browsing', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787601, 'menus.pureDateTimePicker', 'DateTime Picker', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787602, 'confirm_forcedOffline', 'Confirm to force this user offline?', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787603, 'menus.pureTailwindcssDoc', 'tailwindcss', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787604, 'menus.pureDanmaku', 'Danmaku', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787605, 'menus.pureDialog', 'Functional Dialog', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787606, 'menus.pureTable', 'Table', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787607, 'download_json', 'Download JSON', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787608, 'confirm_update_sort', 'Confirm to update sort?', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787609, 'panel.pureLayoutModel', 'Navigation Mode', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787610, 'login.pureLoginSuccess', 'Login Success', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787611, 'i18n_type_setting', 'Multilingual Type', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787612, 'menus.pureEpDoc', 'element-plus', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787613, 'panel.pureSystemSet', 'System Configuration', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787614, 'login.pureLogin', 'Login', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787615, 'panel.pureHorizontalTip', 'Top menu, concise overview', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787616, 'emailTemplate_emailUser', 'Email Template User', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787617, 'login.pureForget', 'Forgot Password?', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787618, 'login.purePhoneReg', 'Please enter phone number', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787619, 'login.pureLoginFail', 'Login Failed', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787620, 'search.pureCollect', 'Collect', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787621, 'buttons.pureClose', 'Close', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787622, 'deleteBatchPlaceholder', 'Enter yes/YES/y/Y to confirm', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989651838787623, 'reset_passwords', 'Reset Password', 'en', 1, 1, '2025-05-04 19:22:41', '2025-05-04 19:22:41', 0);
INSERT INTO `sys_i18n` VALUES (1918989686894780417, 'cancel', '취소', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686894780418, 'menus.pureVerify', '그래픽 인증 코드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686894780419, 'buttons.pureTagsStyleCardTip', '카드 태그, 효율적인 탐색', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686894780420, 'buttons.pureTagsStyle', '탭 스타일', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686894780421, 'i18n.typeId', '유형 ID', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686894780422, 'menus.pureRole', '역할 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686894780423, 'login.purePhone', '휴대폰 번호', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974722, 'search.purePlaceholder', '메뉴 검색 (한어 병음 검색 지원)', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974723, 'readAlready', '읽음', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974724, 'menus.pureCheckCard', '다중 선택 카드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974725, 'menus.pureTimePicker', '시간 선택기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974726, 'overallStyle', '애플리케이션의 전체 스타일', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974727, 'menus.pureButton', '버튼 애니메이션', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974728, 'adminUser_phone', '휴대폰 번호', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974729, 'path', '라우팅 경로', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974730, 'receivedUserIdTip', '비워두면 모든 사용자에게 알림', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974731, 'schedulers', '스케줄링 작업', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974732, 'messageType', '메시지 유형', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974733, 'panel.pureThemeColor', '테마 색상', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974734, 'buttons.pureContentFullScreen', '콘텐츠 영역 전체 화면', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974735, 'buttons.pureCloseText', '닫기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974736, 'emailUsers_host', '호스트 주소', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974737, 'no_default', '기본값 없음', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974738, 'returnToHomepage', '홈페이지로 돌아가기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974739, 'cachingAsyncRoutes', '비동기 라우팅 캐시 여부', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974740, 'panel.pureOverallStyleSystem', '자동', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974741, 'panel.pureOverallStyle', '전체 스타일', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974742, 'multilingualManagement', '다국어 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974743, 'userLoginLog_secChUa', '브랜드 및 버전', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974744, 'userLoginLog_ect', '유효 연결 유형', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974745, 'userLoginLog_secChUaBitness', 'CPU 아키텍처 비트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974746, 'version', '버전', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974747, 'menus.pureCascader', '지역 계단식 선택기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974748, 'isDefault', '기본값 여부', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974749, 'menus.purePermissionButtonLogin', '로그인 인터페이스 버튼 권한 반환', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974750, 'multiTagsCache', '여러 태그 캐시 여부', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974751, 'menuNameTip', '메뉴 이름은 필수 항목입니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974752, 'table.createTime', '생성 시간', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974753, 'menus.pureDatePicker', '날짜 선택기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974754, 'receivedUserNickname', '수신자 닉네임', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974755, 'role', '역할 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974756, 'panel.pureOverallStyleDark', '다크', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974757, 'delete_batches', '일괄 삭제', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974758, 'buttons.pureCloseLeftTabs', '왼쪽 탭 닫기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686898974759, 'isRead', '읽음 여부', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363330, 'system_setting', '시스템 설정', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363331, 'buttons.pureBackTop', '맨 위로', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363332, 'appTitle', '웹페이지 제목', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363333, 'menus.pureList', '목록 페이지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363334, 'menus.pureTypeit', '타자기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363335, 'logged_in_user', '로그인된 사용자', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363336, 'search', '검색', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363337, 'userLoginLog_deviceMemory', '메모리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363338, 'menus.pureEmbeddedDoc', '내장 문서', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363339, 'drop_file_here', '파일을 여기로 드래그하세요', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363340, 'delete_warning', '삭제 경고', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363341, 'nickname', '닉네임', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363342, 'dept_deptName', '부서 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363343, 'buttons.pureClickCollapse', '클릭하여 접기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363344, 'resume', '재개', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363345, 'menus.pureSysManagement', '시스템 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363346, 'userLoginLog_width', '뷰포트 너비', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363347, 'inputRuleMustBeEnglish', '영어로 입력해야 합니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363348, 'sex', '성별', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363349, 'allMarkAsRead', '모두 읽음으로 표시', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363350, 'sorryServerError', '죄송합니다, 서버 오류가 발생했습니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363351, 'routerPath', '라우팅 경로', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363352, 'menus.pureSegmented', '세그먼트 컨트롤러', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363353, 'menus.pureLineTree', '트리 연결선', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363354, 'menus.pureSwiper', 'Swiper 플러그인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363355, 'adminUser_username', '사용자 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363356, 'menus.pureDownload', '다운로드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363357, 'required_fields', '필수 항목 작성', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363358, 'i18n_summary', '다국어 상세 설명', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363359, 'adminUser_dept', '부서', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363360, 'menuSearchHistory', '메뉴 검색 기록', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363361, 'quartzExecuteLog_executeResult', '실행 결과', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363362, 'click_to_upload', '파일 업로드 클릭', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363363, 'userLoginLog_token', '토큰', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363364, 'added', '추가됨', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363365, 'assignBatchRolesToRouter', '일괄 역할 할당', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363366, 'animationNotExist', '애니메이션이 존재하지 않습니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363367, 'status.pureNoTodo', '할 일 없음', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686907363368, 'menus.pureHome', '홈', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557634, 'confirmText', '확인 텍스트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557635, 'inputRequestUrlTip', '요청 URL은 \'/\'로 시작해야 합니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557636, 'menuName', '메뉴 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557637, 'login.password', '비밀번호', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557638, 'fixedHeader', '헤더 고정', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557639, 'power_parentId', '권한 상위', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557640, 'menus.pureTableHigh', '고급 사용법', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557641, 'dept_remarks', '비고', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557642, 'warning', '경고', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557643, 'female', '여성', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557644, 'schedulers_jobGroup', '작업 그룹', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557645, 'info', '정보', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557646, 'add', '추가', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557647, 'buttons.pureTagsStyleChromeTip', '구글 스타일, 클래식하고 아름다움', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557648, 'status.pureNoNotify', '알림 없음', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557649, 'buttons.pureTagsStyleSmart', '스마트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557650, 'logged_in', '로그인함', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557651, 'quartzExecuteLog_triggerName', '트리거 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557652, 'emailUsers_isDefault', '기본값 여부', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557653, 'menus.pureEmpty', '레이아웃 없는 페이지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557654, 'menus.pureVideoFrame', '비디오 프레임 캡처-wasm 버전', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557655, 'buttons.pureOpenText', '열기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557656, 'menus.pureRipple', '리플(Ripple)', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557657, 'buttons.reset', '재설정', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557658, 'adminUser_nickname', '닉네임', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557659, 'search.pureTotal', '총', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557660, 'login.purePassWordDifferentReg', '두 비밀번호가 일치하지 않습니다!', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557661, 'success', '성공', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557662, 'login.pureDefinite', '확인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557663, 'panel.pureOverallStyleLightTip', '상쾌한 출발, 편안한 작업 인터페이스', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557664, 'menus.pureText', '텍스트 생략', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557665, 'messageName', '메시지 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557666, 'sorryNoAccess', '죄송합니다, 이 페이지에 접근할 권한이 없습니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557667, 'menuArrowIconNoTransition', '메뉴 화살표 아이콘 전환 효과 없음', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557668, 'assignBatchRolesToRouterTip', '일괄 역할 할당은 이미 할당된 역할을 제거하고 역할을 추가하지 않습니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557669, 'notifyAll', '모두 알림', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557670, 'requestMethod', '요청 방법', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557671, 'for', '위해', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557672, 'back', '뒤로', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557673, 'forced_offline', '강제 오프라인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557674, 'title', '제목', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557675, 'take_back', '회수', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557676, 'content', '내용', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557677, 'stretch', '늘리기 여부', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557678, 'confirm_update_password', '비밀번호 수정을 확인하시겠습니까', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557679, 'emailUsers_password', '비밀번호', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557680, 'pixel', '픽셀', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557681, 'menus.pureColorPicker', '색상 선택기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557682, 'schedulers_cronExpression', 'cron 표현식', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557683, 'menus.pureWatermark', '워터마크', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557684, 'monitor', '시스템 모니터링', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557685, 'userLoginLog_username', '사용자 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686911557686, 'power_powerName', '권한 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946242, 'message', '메시지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946243, 'confirmDelete', '삭제를 확인하시겠습니까', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946244, 'login.pureQRCodeLogin', 'QR 코드 로그인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946245, 'login.purePassWordSureReg', '비밀번호 확인을 입력하세요', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946246, 'modify', '수정', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946247, 'clearAllRolesSelect', '모든 역할 선택 해제', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946248, 'menus.pureMap', '지도', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946249, 'menus.pureOptimize', '디바운스, 스로틀, 복사, 롱 프레스 지시어', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946250, 'i18n.typeName', '유형 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946251, 'menus.pureAnimatecss', 'animate.css 선택기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946252, 'login.pureUsername', '계정', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946253, 'pleaseSelectAnimation', '애니메이션을 선택하세요', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946254, 'no_server', '서비스 없음', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946255, 'clearAllRolesSelectTip', '이 작업은 할당된 메뉴 역할을 모두 제거하며, 확인 후 복구할 수 없습니다. 메뉴 아래 할당된 역할도 모두 제거됩니다!!!', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946256, 'username', '사용자 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946257, 'copyright', '저작권', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946258, 'menus.pureTableEdit', '편집 가능 사용법', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946259, 'select', '선택', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946260, 'epThemeColor', '테마 색상', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946261, 'userLoginLog_type', '작업 유형', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946262, 'sorryPageNotFound', '죄송합니다, 방문하신 페이지가 존재하지 않습니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946263, 'login.pureVerifyCodeCorrectReg', '올바른 인증 코드를 입력하세요', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946264, 'select_icon', '아이콘 선택', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946265, 'batchUpdates', '일괄 업데이트를 확인하시겠습니까?', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946266, 'menus.pureTabs', '탭 작업', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946267, 'buttons.pureTagsStyleSmartTip', '스마트 태그, 재미 추가', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946268, 'system_menu', '시스템 메뉴', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946269, 'dept_parentId', '부서 상위', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946270, 'i18n_type', '다국어 유형', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946271, 'id', '기본 키', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946272, 'emailUsers_smtpAgreement', 'smtp 프로토콜', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946273, 'status.pureNotify', '알림', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946274, 'power_setting', '권한 설정', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946275, 'messageEditing', '메시지 편집', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946276, 'modifyingConfiguration', '구성 수정', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946277, 'download_batch', '일괄 다운로드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946278, 'menus.purePermissionPage', '페이지 권한', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946279, 'login.pureGetVerifyCode', '인증 코드 받기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946280, 'panel.pureCloseSystemSet', '구성 닫기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946281, 'element_plus', 'Element Plus UI', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946282, 'index', '순번', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946283, 'email_login', '이메일 로그인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946284, 'menus.pureCardList', '카드 목록 페이지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946285, 'menus.pureAbout', '정보', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946286, 'table.createUser', '생성 사용자', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946287, 'account_password', '계정 비밀번호', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946288, 'panel.pureStretchCustomTip', '최소 1280, 최대 1600', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946289, '404', '404', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946290, 'deleteBatches', '일괄 삭제', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946291, 'menus.pureCheckButton', '선택 가능 버튼', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946292, 'menuType', '메뉴 유형', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686919946293, 'buttons.pureContentExitFullScreen', '콘텐츠 영역 전체 화면 종료', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334850, 'status', '상태', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334851, 'external_page', '외부 페이지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334852, 'menus.pureVirtualList', '가상 목록', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334853, 'login.pureRegister', '등록', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334854, 'buttons.pureInterfaceDisplay', '인터페이스 표시', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334855, 'userPassword', '사용자 비밀번호', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334856, 'menuIcon_iconCode', '아이콘 클래스 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334857, 'quartzExecuteLog_endTime', '종료 시간', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334858, 'login', '로그인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334859, 'menus.pureLoginLog', '로그인 로그', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334860, 'menus.pureExternalLink', 'vue-pure-admin', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334861, 'userLoginLog_rtt', '왕복 시간', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334862, 'schedulers_jobMethodName', '메서드 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334863, 'menus.pureCountTo', '숫자 애니메이션', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334864, 'tooltipEffect', '도구 설명 효과', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334865, 'menus.pureStatistic', '통계 컴포넌트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334866, 'man', '남성', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334867, 'addMultilingual', '다국어 추가', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334868, 'use_json_update', 'JSON으로 업데이트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334869, 'login.purePassWordReg', '비밀번호를 입력하세요', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334870, 'view_user_info', '사용자 정보 보기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334871, 'schedulersGroup', '작업 스케줄링 그룹', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334872, 'avatar', '아바타', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334873, 'deleteBatchTip', '일괄 삭제를 확인하려면 yes/YES/y/Y를 입력하세요. 이 작업은 되돌릴 수 없습니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334874, 'menu', '메뉴', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334875, 'file_size', '파일 크기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334876, 'menus.pureDebounce', '디바운스', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334877, 'use_excel_update', 'Excel로 업데이트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334878, 'sendNickname', '발신자 닉네임', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334879, 'disable', '비활성화', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334880, 'userLoginLog_secChUaPlatformVersion', '운영 체제 버전', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334881, 'responsiveStorageNameSpace', '반응형 저장소 네임스페이스', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334882, 'panel.pureWeakModel', '색약 모드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334883, 'panel.pureInterfaceDisplay', '인터페이스 표시', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334884, 'editorType', '편집기 유형', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686928334885, 'unfold_all', '모두 펼치기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529153, 'Searching_for_router', '라우팅 검색', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529154, 'panel.pureOverallStyleDarkTip', '달빛 서곡, 밤의 고요한 아름다움에 빠지다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529155, 'showLogo', '로고 표시 여부', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529156, 'menuIcon', '메뉴 아이콘', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529157, 'status.pureLoad', '로딩 중...', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529158, 'files_filepath', '파일 저장 경로', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529159, 'quartzExecuteLog_duration', '실행 시간', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529160, 'swagger', 'swagger', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529161, 'format_error', '형식 오류', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529162, 'Searching_for_roles', '역할 검색', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529163, 'menus.pureAbnormal', '예외 페이지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529164, 'download', '다운로드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529165, 'quartzExecuteLog_jobGroup', '작업 그룹', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529166, 'menus.pureChildMenuOverflow', '메뉴 오버플로우 툴팁 표시', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529167, 'previousMenu', '상위 메뉴', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529168, 'buttons.pureSwitch', '전환', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529169, 'menus.pureResult', '결과 페이지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529170, 'login.loginSuccess', '로그인 성공', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529171, 'personDescription', '개인 상세 정보', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529172, 'all', '전체', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529173, 'table.updateTime', '업데이트 시간', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529174, 'hideTabs', '탭 숨기기 여부', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529175, 'level', '메시지 레벨', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529176, 'menus.pureSelector', '범위 선택기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529177, 'menus.pureMessage', '메시지 알림', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529178, 'sort', '정렬', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529179, 'buttons.pureReload', '다시 로드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529180, 'login.purePrivacyPolicy', '《개인정보 보호정책》', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529181, 'adminUser_password', '비밀번호', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529182, 'doubleCheck', '계속 진행하시겠습니까?!', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529183, 'menus.pureWaterfall', '폭포 스크롤', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529184, 'menus.pureBoard', '아트 보드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529185, 'login.purePassWordUpdateReg', '비밀번호 수정 성공', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529186, 'menus.purePermission', '권한 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529187, 'login.pureVerifyCodeReg', '인증 코드를 입력하세요', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529188, 'emailUsers', '이메일 사용자 구성', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529189, 'menus.pureWavesurfer', '오디오 시각화', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529190, 'login.pureTickPrivacy', '개인정보 보호정책에 동의하세요', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686932529191, 'menus.pureElButton', '버튼', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723457, 'quartzExecuteLog_jobName', '작업 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723458, 'status.systemMessage', '시스템 메시지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723459, 'delete', '삭제', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723460, 'role_description', '역할 상세 정보', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723461, 'formatError', '형식 오류', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723462, 'total', '총계', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723463, 'routerPathTip', '라우팅 경로는 필수 항목이며 \'/\'로 시작해야 합니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723464, 'buttons.pureAccountSettings', '계정 설정', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723465, 'login.getCodeInfo', '초 후 인증 코드 받기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723466, 'extra', '메시지 요약', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723467, 'menus.pureSuccess', '성공 페이지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723468, 'login.getEmailCode', '인증 코드 받기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723469, 'status.pureTodo', '할 일', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723470, 'menus.pureFourZeroFour', '404', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723471, 'menus.pureMenu1-1', '메뉴 1-1', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723472, 'menus.pureUser', '사용자 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723473, 'menus.pureMenu1-2', '메뉴 1-2', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723474, 'menus.pureMenu1-3', '메뉴 1-3', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723475, 'buttons.pureClickExpand', '클릭하여 펼치기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723476, 'user_status', '사용자 상태', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723477, 'menus.pureSchemaForm', '양식', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723478, 'buttons.accountSettings', '계정 설정', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723479, 'buttons.pureCloseAllTabs', '모든 탭 닫기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723480, 'fold_all', '모두 접기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723481, 'buttons.pureLogin', '로그인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723482, 'search.pureHistory', '검색 기록', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723483, 'markAsUnread', '읽지 않음으로 표시', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723484, 'korean', '한국어', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723485, 'menus.pureOperationLog', '작업 로그', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723486, 'panel.pureStretchCustom', '사용자 정의', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723487, 'security_log', '보안 로그', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723488, 'greyStyle', '회색 모드 활성화 여부', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723489, 'system_file', '시스템 파일 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723490, 'menus.purePiniaDoc', 'pinia', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723491, 'bytes', '바이트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723492, 'schedulers_description', '스케줄러 상세 정보', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686936723493, 'iconCode', '아이콘 클래스 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917762, 'adminUser_status', '상태', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917763, 'darkMode', '다크 모드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917764, 'menus.pureBarcode', '바코드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917765, 'knife4j', 'knife4j', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917766, 'menus.pureUpload', '파일 업로드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917767, 'schedulersGroup_description', '작업 스케줄링 상세 정보', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917768, 'user_details', '사용자 상세 정보', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917769, 'op_time', '작업 시간', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917770, 'menus.pureEditor', '편집기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917771, 'addNew', '새로 추가', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917772, 'quartzExecuteLog', '작업 실행 로그', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917773, 'panel.pureOverallStyleLight', '라이트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917774, 'danger', '위험', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917775, 'cover', '커버', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917776, 'userLoginLog_viewportWidth', '뷰포트 너비', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917777, 'panel.pureGreyModel', '회색 모드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917778, 'routerName', '라우팅 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917779, 'menus.pureCollapse', '접기 패널', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917780, 'menus.pureMenus', '다단계 메뉴', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917781, 'panel.pureTagsStyle', '탭 스타일', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917782, 'upload_avatar', '아바타 업로드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917783, 'panel.pureHiddenFooter', '푸터 숨기기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917784, 'adminUser_summary', '요약', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917785, 'sidebarStatus', '사이드바 상태', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917786, 'monitoring', '시스템 모니터링', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917787, 'menus.pureDept', '부서 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917788, 'i18n', '다국어 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917789, 'adminUser_avatar', '아바타', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917790, 'userLoginLog_contentDpr', '장치 픽셀 비율', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917791, 'input', '입력', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917792, 'menus.pureExcel', 'Excel 내보내기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917793, 'login.purePhoneLogin', '휴대폰 로그인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917794, 'power_requestUrl', '요청 URL', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917795, 'i18n.translation', '번역', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917796, 'menuIcon_iconName', '아이콘 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917797, 'emailTemplate_type', '템플릿 유형', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917798, 'update_information', '정보 업데이트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917799, 'userLoginLog_secChUaModel', '장치 모델', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917800, 'update_tip', '데이터 백업을 확인하여 손실을 방지하세요', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917801, 'menus.pureFlowChart', '플로우 차트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917802, 'unread', '읽지 않음', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917803, 'menus.pureSystemMenu', '메뉴 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917804, 'menus.pureTag', '태그', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917805, 'userLoginLog_xRequestedWith', '요청 방식', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917806, 'menus.pureTableBase', '기본 사용법', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917807, 'panel.pureTagsStyleCard', '카드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917808, 'files_fileType', '파일 유형', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917809, 'iconify', 'iconify 아이콘', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917810, 'lastLoginIp', 'IP 주소', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917811, 'default', '기본값', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917812, 'hiddenSideBar', '사이드바 숨기기 여부', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917813, 'assign_roles', '역할 할당', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917814, 'system_i18n', '다국어', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917815, 'download_excel', 'Excel 다운로드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917816, 'menus.pureGuide', '가이드 페이지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917817, 'markdown', 'Markdown', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917818, 'panel.pureTagsStyleChromeTip', '구글 스타일, 클래식하고 아름다움', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917819, 'upload_success', '업로드 성공', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917820, 'menus.pureFourZeroOne', '403', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917821, 'userLoginLog_dpr', '장치 픽셀 비율', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917822, 'menus.pureMenu2', '메뉴 2', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917823, 'email', '이메일', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917824, 'menus.pureMenu1', '메뉴 1', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686940917825, 'role_roleCode', '역할 코드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112066, 'delete_success', '삭제 성공', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112067, 'keepAlive', '활성 상태 유지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112068, 'image_size', '이미지 크기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112069, 'messageReceivingManagement', '메시지 수신 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112070, 'login.pureSmsVerifyCode', 'SMS 인증 코드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112071, 'menus.pureJsonEditor', 'JSON 편집기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112072, 'login.purePhoneCorrectReg', '올바른 휴대폰 번호 형식을 입력하세요', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112073, 'buttons.pureTagsStyleCard', '카드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112074, 'cancel_delete', '삭제 취소', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112075, 'dept', '부서 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112076, 'login.pureSure', '비밀번호 확인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112077, 'login.login', '로그인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112078, 'search.pureEmpty', '검색 결과 없음', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112079, 'confirm', '확인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112080, 'login.pureRememberInfo', '로그인 후 지정된 일수 동안 자동으로 시스템에 로그인됩니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112081, 'readMeDay', '기억하기 기간', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112082, 'menus.pureFormDesign', '양식 디자이너', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112083, 'menus.pureMenuTree', '메뉴 트리 구조', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112084, 'login.purePassWordRuleReg', '비밀번호 형식은 8-18자리 숫자, 문자, 기호 중 두 가지 조합이어야 합니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112085, 'logManagement', '로그 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112086, 'i18n_typeName', '다국어 유형 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112087, 'menus.pureExternalDoc', '외부 문서 링크', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112088, 'update_batches_parent', '상위 일괄 업데이트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112089, 'userLoginLog_ipRegion', 'IP 소재지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112090, 'panel.pureStretchFixedTip', '간결한 페이지, 필요한 정보를 쉽게 찾을 수 있습니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112091, 'menus.pureVxeTable', '가상 스크롤', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112092, 'login.pureBack', '뒤로', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112093, 'view', '보기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112094, 'forcedOffline', '관리자 강제 오프라인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112095, 'systemi18n', '다국어', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112096, 'quartzExecuteLog_jobClassName', '작업 클래스 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112097, 'status.pureMessage', '메시지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112098, 'panel.pureTagsStyleSmart', '스마트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112099, 'menus.pureProgress', '진행 표시줄', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112100, 'menus.pureInfiniteScroll', '테이블 무한 스크롤', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112101, 'login.pureWeChatLogin', '위챗 로그인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112102, 'schedulers_triggerState', '트리거 상태', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112103, 'table.updateUser', '업데이트 사용자', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112104, 'menus.pureLogin', '로그인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112105, 'menus.pureComponents', '컴포넌트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112106, 'iconName', '아이콘 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112107, 'menus.pureCropping', '이미지 자르기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112108, 'dept_manager', '관리자', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686945112109, 'no_data', '데이터 없음', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306370, 'userLoginLog_userId', '사용자 ID', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306371, 'menus.home', '홈', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306372, 'menus.pureUiGradients', '그라데이션 색상', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306373, 'buttons.pureCloseCurrentTab', '현재 탭 닫기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306374, 'menus.purePrint', '인쇄', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306375, 'knife4j_Interface_documentation', 'knife4j 인터페이스 문서', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306376, 'lastLoginIpAddress', '소재지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306377, 'files_downloadCount', '다운로드 횟수', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306378, 'emailTemplate_subject', '제목', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306379, 'buttons.pureConfirm', '확인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306380, 'menus.pureFive', '500', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306381, 'menus.pureSysMonitor', '시스템 모니터링', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306382, 'userLoginLog_ipAddress', 'IP 주소', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306383, 'expires', '만료 시간', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306384, 'more_actions', '추가 작업', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306385, 'hidden', '숨김', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306386, 'submit', '제출', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306387, 'menus.pureMqtt', 'MQTT 클라이언트(mqtt)', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306388, 'show', '표시', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306389, 'description', '상세 정보', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306390, 'system_files', '백엔드 파일 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306391, 'update', '업데이트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306392, 'menus.pureFail', '실패 페이지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306393, 'receivedUserIds', '수신 사용자', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306394, 'userLoginLog', '사용자 로그인 로그', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306395, 'contentTooShortTip', '내용은 30자 이상이어야 합니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306396, 'login.pureThirdLogin', '제3자 로그인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306397, 'scheduler', '예약 작업', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306398, 'download_configuration', '구성 다운로드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306399, 'login.pureInfo', '초 후 다시 받기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306400, 'emailTemplate_templateName', '템플릿 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306401, 'account_management', '계정 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306402, 'continue_adding', '계속 추가', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306403, 'adminUser_email', '이메일', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306404, 'login.pureTip', '스캔 후 \"확인\"을 클릭하면 로그인이 완료됩니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306405, 'userinfo', '사용자 정보', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306406, 'systemCaches', '시스템 캐시', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306407, 'summary', '요약', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306408, 'normal', '정상', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306409, 'menus.purePermissionButton', '버튼 권한', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306410, 'login.pureQQLogin', 'QQ 로그인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306411, 'table.acceptanceTime', '수신 시간', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306412, 'systemManagement', '시스템 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306413, 'update_multilingual', '다국어 업데이트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306414, 'need_number', '숫자 필요', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306415, 'upload_user_avatar_tip', '아바타 업로드 성공 시 자동 저장되지 않습니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306416, 'layout', '애플리케이션 레이아웃', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306417, 'login.pureTest', '모의 테스트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306418, 'webConifg', '웹 구성', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306419, 'adminUser', '백엔드 사용자', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306420, 'external_pages', '외부 페이지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306421, 'appLocale', '로컬 언어', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306422, 'quartzExecuteLog_cronExpression', 'cron 표현식', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306423, 'login.pureVerifyCodeSixReg', '6자리 숫자 인증 코드를 입력하세요', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306424, 'menus.pureContextmenu', '오른쪽 클릭 메뉴', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306425, 'panel.pureMixTip', '혼합 메뉴, 유연하고 다양함', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686949306426, 'externalLink', '외부 링크', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694977, 'panel.pureMultiTagsCache', '탭 지속성', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694978, 'hideFooter', '푸터 숨기기 여부', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694979, 'file_import', '파일 가져오기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694980, 'markAsRead', '읽음으로 표시', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694981, 'login.username', '사용자 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694982, 'files_filename', '파일 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694983, 'menus.pureQrcode', 'QR 코드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694984, 'Interface_documentation', '인터페이스 문서', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694985, 'logout', '로그아웃', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694986, 'menus.pureAble', '기능', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694987, 'menus.pureVideo', '비디오', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694988, 'enable', '활성화됨', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694989, 'login.purePassword', '비밀번호', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694990, 'search.pureDragSort', '(드래그 정렬 가능)', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694991, 'menus.pureSplitPane', '분할 패널', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694992, 'menus.pureColorHuntDoc', '색상 팔레트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694993, 'menus.pureGanttastic', '간트 차트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694994, 'menus.pureIconSelect', '아이콘 선택기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694995, 'buttons.pureTagsStyleChrome', '구글', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694996, 'login.pureWeiBoLogin', '웨이보 로그인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694997, 'emailTemplate', '이메일 템플릿', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694998, 'buttons.pureCloseRightTabs', '오른쪽 탭 닫기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957694999, 'rest_password_tip', '비밀번호를 잊어버리거나 재설정할 경우, 비밀번호 수정 후 로그인 페이지로 이동하여 다시 로그인해야 합니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695000, 'emailUsers_port', '포트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695001, 'phone', '휴대폰 번호', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695002, 'dept_summary', '부서 요약', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695003, 'menus.pureDraggable', '드래그', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695004, 'confirm_update_status', '상태 수정을 확인하시겠습니까', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695005, 'menus.purePinyin', '한어 병음', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695006, 'primary', '기본값', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695007, 'power_powerCode', '권한 코드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695008, 'userLoginLog_userAgent', '사용자 에이전트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695009, 'userLoginLog_secChUaMobile', '모바일 장치 여부', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695010, 'userLoginLog_downlink', '대역폭', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695011, 'menus.pureSystemLog', '시스템 로그', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695012, 'login.emailCode', '인증 코드 입력', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695013, 'emailUsers_email', '이메일', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695014, 'portion', '부분', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695015, 'login.pureReadAccept', '나는 주의 깊게 읽고 동의합니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695016, 'i18n.keyName', '다국어 키', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695017, 'table.operation', '작업', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695018, 'external_chaining', '외부 링크', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695019, 'panel.pureHiddenTags', '탭 숨기기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695020, 'login.pureVerifyCode', '인증 코드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695021, 'cropper_preview_tips', '팁: 오른쪽 클릭으로 기능 메뉴를 열 수 있습니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686957695022, 'weakStyle', '색약 모드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083585, 'theme', '테마', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083586, 'menus.pureTimeline', '타임라인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083587, 'power', '권한 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083588, 'messageManagement', '메시지 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083589, 'menus.purePdf', 'PDF 미리보기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083590, 'menus.pureMenu1-2-1', '메뉴 1-2-1', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083591, 'schedulers_triggerName', '트리거 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083592, 'menus.pureRouterDoc', 'vue-router', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083593, 'menus.pureMenu1-2-2', '메뉴 1-2-2', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083594, 'systemMenuIcon.officialWebsite', '메뉴 아이콘 공식 웹사이트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083595, 'login.pureRegisterSuccess', '등록 성공', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083596, 'login.pureRemember', '일 동안 자동 로그인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083597, 'panel.pureStretchFixed', '고정', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083598, 'menus.pureMenuOverflow', '디렉토리 오버플로우 툴팁 표시', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083599, 'not_added', '추가되지 않음', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083600, 'pure_admin', '백엔드 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083601, 'emailUsers_emailTemplate', '연관 템플릿', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083602, 'login.pureAlipayLogin', '알리페이 로그인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083603, 'menus.pureViteDoc', 'vite', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083604, 'componentPath', '컴포넌트 경로', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083605, 'menus.pureMindMap', '마인드 맵', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083606, 'buttons.pureLoginOut', '시스템 로그아웃', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083607, 'embedded_doc', '내장 문서', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083608, 'menus.pureVueDoc', 'vue3', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083609, 'panel.pureOverallStyleSystemTip', '시간 동기화, 인터페이스가 자연스럽게 조화를 이룹니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083610, 'menus.pureOnlineUser', '온라인 사용자', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083611, 'menus.pureDrawer', '함수형 서랍', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083612, 'buttons.pureOpenSystemSet', '시스템 구성 열기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083613, 'userLoginLog_secChUaPlatform', '운영 체제/플랫폼', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083614, 'panel.pureTagsStyleChrome', '구글', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083615, 'panel.pureStretch', '페이지 너비', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083616, 'adminUser_sex', '성별', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083617, 'login.usernameRegex', '사용자 이름 형식 오류', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083618, 'userLoginLog_secChUaArch', '플랫폼 아키텍처', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083619, 'panel.pureClearCacheAndToLogin', '캐시 지우고 로그인 페이지로 이동', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083620, 'roleCode', '역할 코드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083621, 'emailTemplate_body', '템플릿 내용', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083622, 'menus.purePermissionButtonRouter', '라우팅 버튼 권한 반환', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083623, 'systemMaintenance', '시스템 유지보수', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083624, 'panel.pureVerticalTip', '왼쪽 메뉴, 친숙하고 익숙함', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083625, 'showModel', '표시할 모델', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083626, 'crop_and_upload_avatars', '아바타 자르기 및 업로드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083627, 'visible', '숨김', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083628, 'messageSendManagement', '메시지 발송 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083629, 'login.pureUsernameReg', '계정을 입력하세요', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083630, 'menus.pureSeamless', '끊김 없는 스크롤', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083631, 'richText', '리치 텍스트', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083632, 'external_doc', '외부 문서 링크', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083633, 'pause', '일시 정지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083634, 'panel.pureClearCache', '캐시 지우기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083635, 'menus.pureExternalPage', '외부 페이지', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083636, 'menus.pureSensitive', '민감어 필터링', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083637, 'files', '파일', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083638, 'monitoring_server', '서비스 모니터링', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083639, 'schedulers_jobClassName', '작업 클래스 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083640, 'panel.pureTagsStyleSmartTip', '스마트 태그, 재미 추가', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686966083641, 'admin_user', '사용자 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277889, 'schedulersGroup_groupName', '그룹 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277890, 'buttons.pureCloseOtherTabs', '다른 탭 닫기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277891, 'status.pureNoMessage', '메시지 없음', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277892, 'confirmUpdateConfiguration', '구성 수정을 확인하시겠습니까?', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277893, 'configuration', '시스템 구성', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277894, 'update_success', '수정 성공', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277895, 'schedulers_jobName', '작업 이름', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277896, 'email_user_send_config', '이메일 사용자 발송 구성 관리', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277897, 'routerNameTip', '라우팅 이름은 필수 항목입니다', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277898, 'menus.pureUtilsLink', 'pure-admin-utils', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277899, 'menuIcon_preview', '아이콘 미리보기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277900, 'sendUserId', '발신 사용자', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277901, 'panel.pureTagsStyleCardTip', '카드 태그, 효율적인 탐색', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277902, 'menus.pureDateTimePicker', '날짜 시간 선택기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277903, 'confirm_forcedOffline', '이 사용자를 강제로 오프라인하시겠습니까', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277904, 'menus.pureTailwindcssDoc', 'tailwindcss', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277905, 'menus.pureDanmaku', '탄막', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277906, 'menus.pureDialog', '함수형 대화 상자', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277907, 'menus.pureTable', '테이블', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277908, 'download_json', 'JSON 다운로드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277909, 'confirm_update_sort', '정렬 업데이트를 확인하시겠습니까', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277910, 'panel.pureLayoutModel', '탐색 모드', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277911, 'login.pureLoginSuccess', '로그인 성공', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277912, 'i18n_type_setting', '다국어 유형', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277913, 'menus.pureEpDoc', 'element-plus', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277914, 'panel.pureSystemSet', '시스템 구성', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277915, 'login.pureLogin', '로그인', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277916, 'panel.pureHorizontalTip', '상단 메뉴, 간결한 개요', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277917, 'emailTemplate_emailUser', '이메일 템플릿 사용자', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277918, 'login.pureForget', '비밀번호를 잊으셨나요?', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277919, 'login.purePhoneReg', '휴대폰 번호를 입력하세요', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277920, 'login.pureLoginFail', '로그인 실패', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277921, 'search.pureCollect', '즐겨찾기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277922, 'buttons.pureClose', '닫기', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277923, 'deleteBatchPlaceholder', '확인하려면 yes/YES/y/Y를 입력하세요', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);
INSERT INTO `sys_i18n` VALUES (1918989686970277924, 'reset_passwords', '비밀번호 재설정', '韩语', 1, 1, '2025-05-04 19:22:49', '2025-05-04 19:22:49', 0);

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
INSERT INTO `sys_i18n_type` VALUES (1840386017158090753, 'zh', '简体中文', 1, 1, 1, '2025-05-01 23:08:16', '2024-09-30 05:39:54', 0);
INSERT INTO `sys_i18n_type` VALUES (1840402418253996034, 'en', 'English', 0, 1, 1, '2025-05-01 23:08:21', '2024-09-30 06:45:04', 0);
INSERT INTO `sys_i18n_type` VALUES (1917141005942747137, '韩语', '한국어', 0, 1, 1, '2025-05-01 23:08:28', '2025-04-29 16:56:49', 0);

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
INSERT INTO `sys_menu_icon` VALUES (1918949253637214209, 'material-symbols:login', '登录', '2025-05-04 16:42:09', '2025-05-04 16:42:09', 1, 1, 0);

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
INSERT INTO `sys_message` VALUES (1873378732024107009, '版本更新版本更新', 1, 1851507850609356802, 'http://192.168.3.137:9000/auth-admin/message/2025/05-01/c59f1d79-0957-45ab-b4d0-5bbc0ca260d3.jpg', '新版更新，同步到线上，将仓库中代码打包到线上新版更新，同步到线上，将仓库中代码打包到线上新版更新，同步到线上，将仓库中代码打包到线上新版更新，同步到线上，将仓库中代码打包到线上', 'PHA+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMjI1LCA2MCwgNTcpOyBmb250LXNpemU6IDQ4cHg7Ij48c3Ryb25nPueJiOacrOabtOaWsCAyLjIuMDwvc3Ryb25nPjwvc3Bhbj48L3A+PHA+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMTQ2LCA4NCwgMjIyKTsiPjEuIDwvc3Bhbj48YSBocmVmPSJodHRwOi8vMTI5LjIxMS4zMS41ODozMDAwL2F1dGgvYXV0aC1zZXJ2ZXItamF2YS9jb21taXQvYjJlMmI4MDY5MjRmNDkyYWUyNGIwMzFkODJhNDY5ZmI4MjFkMDcyNCIgdGFyZ2V0PSIiIHN0eWxlPSJ0ZXh0LWFsaWduOiBzdGFydDsiPjxzcGFuIHN0eWxlPSJjb2xvcjogcmdiKDE0NiwgODQsIDIyMik7Ij7nvLrlsJHmm7TmlrDlrprml7bku7vliqHmjqXlj6M8L3NwYW4+PC9hPjwvcD48cD48c3BhbiBzdHlsZT0iY29sb3I6IHJnYigxNDYsIDg0LCAyMjIpOyI+Mi4gPC9zcGFuPjxhIGhyZWY9Imh0dHA6Ly8xMjkuMjExLjMxLjU4OjMwMDAvYXV0aC9hdXRoLXNlcnZlci1qYXZhL2NvbW1pdC82MTUzMzM3NWY4OGUwODFhOGJkZmEyMmVlMjljZmY5NDRjZGM3MjNkIiB0YXJnZXQ9IiIgc3R5bGU9InRleHQtYWxpZ246IHN0YXJ0OyI+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMTQ2LCA4NCwgMjIyKTsiPuS4u+mimOminOiJsua3u+WKoOagoemqjDwvc3Bhbj48L2E+PC9wPjxwPjxzcGFuIHN0eWxlPSJjb2xvcjogcmdiKDE0NiwgODQsIDIyMik7Ij4zLiA8L3NwYW4+PGEgaHJlZj0iaHR0cDovLzEyOS4yMTEuMzEuNTg6MzAwMC9hdXRoL2F1dGgtd2ViL2NvbW1pdC8wNGVmMGY3MDIwNTQ3NTAwMjg2M2YwNmFmMjk3NDU3NjJkYzkxNjVlIiB0YXJnZXQ9IiIgc3R5bGU9InRleHQtYWxpZ246IHN0YXJ0OyI+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMTQ2LCA4NCwgMjIyKTsiPiDmt7vliqDmtojmga/mj5DnpLo76KGo5qC86Led56a75LyY5YyWPC9zcGFuPjwvYT48L3A+PHA+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMTQ2LCA4NCwgMjIyKTsiPjQuIDwvc3Bhbj48YSBocmVmPSJodHRwOi8vMTI5LjIxMS4zMS41ODozMDAwL2F1dGgvYXV0aC13ZWIvY29tbWl0LzZhNzczODIwOTg4ZjA4MTNjMmU3NGY0YjlhMmJhZTQ2NTE0ZmNhNDgiIHRhcmdldD0iIiBzdHlsZT0idGV4dC1hbGlnbjogc3RhcnQ7Ij48c3BhbiBzdHlsZT0iY29sb3I6IHJnYigxNDYsIDg0LCAyMjIpOyI+5pel5b+X6KGo5qC85pi+56S66Zeu6aKYPC9zcGFuPjwvYT48L3A+', 'rich', 'success', '版本更新', '2024-12-29 22:41:10', '2025-05-01 18:16:33', 1, 1, 0);
INSERT INTO `sys_message` VALUES (1877006536699645953, '版本更新 2.4.9', 1, 1851507850609356802, 'http://192.168.3.137:9000/auth-admin/message/2025/05-01/c63efe5e-a1aa-412a-8240-5c5ae701e28c.jpg', '版本更新 2.4.9', 'PHA+PHNwYW4gc3R5bGU9ImNvbG9yOiByZ2IoMjI1LCA2MCwgNTcpOyBmb250LXNpemU6IDQ4cHg7Ij7niYjmnKzmm7TmlrAgMi40Ljk8L3NwYW4+PC9wPjxoMT48c3BhbiBzdHlsZT0iY29sb3I6IHJnYigxNDYsIDg0LCAyMjIpOyI+MS4g5bCG5YmN56uv6YWN572u5paH5Lu25pS+5YWlUmVkaXPkuK3kuI3lho3ku47mlofku7bns7vnu5/or7vlj5Y8L3NwYW4+PC9oMT48aDEgc3R5bGU9ImxpbmUtaGVpZ2h0OiAxLjU7Ij48c3BhbiBzdHlsZT0iY29sb3I6IHJnYigyNTUsIDc3LCA3OSk7IGZvbnQtZmFtaWx5OiDmpbfkvZM7Ij48c3Ryb25nPuWmguaenOWPkeeOsOe9keermeaJk+W8gOeZveWxj+W+iOacieWPr+iDveaYr+WboOS4uuabtOaWsOmAoOaIkOeahO+8jOWboOS4uumcgOimgee7tOaKpOWIoOmZpOS4jemcgOimgeeahOWKn+iDveWPr+iDveS8muWvvOiHtOi/meS4quaDheWGtTwvc3Ryb25nPjwvc3Bhbj48L2gxPg==', 'rich', 'success', '版本更新', '2025-01-08 22:56:46', '2025-05-01 18:06:13', 1, 1, 0);
INSERT INTO `sys_message` VALUES (1917886507814604802, '版本更新版本更新', 1, 1851498066518687745, 'http://192.168.3.137:9000/auth-admin/message/2025/05-01/62a82b29-05e1-4419-9137-25c66a17407c.jpg', '版本更新版本更新版本更新版本更新版本更新版本更新版本更新版本更新版本更新版本更新版本更新版本更新版本', '54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw54mI5pys5pu05paw', 'markdown', 'success', '版本更新', '2025-05-01 18:19:11', '2025-05-02 11:39:54', 1, 1, 0);

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
INSERT INTO `sys_message_received` VALUES (1917883246848102401, 1, 1877006536699645953, 1, '2025-05-01 18:06:13', '2025-05-02 18:59:01', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1917883246848102402, 1849444494908125181, 1877006536699645953, 0, '2025-05-01 18:06:13', '2025-05-01 18:06:13', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1917883246848102403, 1849681227633758210, 1877006536699645953, 0, '2025-05-01 18:06:13', '2025-05-01 18:06:13', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1917883246848102404, 1850075157831454722, 1877006536699645953, 0, '2025-05-01 18:06:13', '2025-05-01 18:06:13', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1917883246848102405, 1850080272764211202, 1877006536699645953, 0, '2025-05-01 18:06:13', '2025-05-01 18:06:13', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1917883246848102406, 1850789068551200769, 1877006536699645953, 0, '2025-05-01 18:06:13', '2025-05-01 18:06:13', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1917885846108622850, 1, 1873378732024107009, 1, '2025-05-01 18:16:33', '2025-05-02 18:58:41', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1917885846108622851, 1849444494908125181, 1873378732024107009, 0, '2025-05-01 18:16:33', '2025-05-01 18:16:33', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1917885846108622852, 1849681227633758210, 1873378732024107009, 0, '2025-05-01 18:16:33', '2025-05-01 18:16:33', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1917885846108622853, 1850080272764211202, 1873378732024107009, 0, '2025-05-01 18:16:33', '2025-05-01 18:16:33', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1917885846108622854, 1850789068551200769, 1873378732024107009, 0, '2025-05-01 18:16:33', '2025-05-01 18:16:33', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1918148413531987969, 1, 1917886507814604802, 1, '2025-05-02 11:39:54', '2025-05-02 18:58:58', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1918148413536182274, 1849444494908125181, 1917886507814604802, 0, '2025-05-02 11:39:54', '2025-05-02 11:39:54', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1918148413536182275, 1849681227633758210, 1917886507814604802, 0, '2025-05-02 11:39:54', '2025-05-02 11:39:54', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1918148413536182276, 1850080272764211202, 1917886507814604802, 0, '2025-05-02 11:39:54', '2025-05-02 11:39:54', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1918148413536182277, 1850789068551200769, 1917886507814604802, 0, '2025-05-02 11:39:54', '2025-05-02 11:39:54', 1, 1, 0);

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
INSERT INTO `sys_permission` VALUES (1916799569992970241, 1916799569930055682, 'user::menuIcon', '系统菜单图标', '/api/menuIcon/**', NULL, '2025-04-28 18:20:05', '2025-05-02 15:34:32', NULL, 1, 0);
INSERT INTO `sys_permission` VALUES (1916799570005553153, 1916799569992970241, 'menuIcon::update', '更新', '/api/menuIcon', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570005553154, 1916799569992970241, 'menuIcon::query', '分页查询', '/api/menuIcon/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570005553155, 1916799569992970241, 'menuIcon::add', '添加', '/api/menuIcon', 'POST', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570005553156, 1916799569992970241, 'menuIcon::delete', '删除', '/api/menuIcon', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570026524674, 1916799570114605057, 'user::routerRole', '路由和角色', '/api/routerRole/**', NULL, '2025-04-28 18:20:05', '2025-05-02 15:34:32', NULL, 1, 0);
INSERT INTO `sys_permission` VALUES (1916799570039107585, 1916799570026524674, 'routerRole::delete', '清除选中菜单所有角色', '/api/routerRole/clearRouterRole', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570055884802, 0, 'user::config', '系统配置', '/api/config/**', '', '2025-04-28 18:20:05', '2025-05-02 20:35:38', NULL, 1849444494908125181, 0);
INSERT INTO `sys_permission` VALUES (1916799570064273409, 1916799570055884802, 'config::update', '更新web配置文件', '/api/config', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570085244929, 0, 'user::messageReceived', '消息接收(用户消息)', '/api/messageReceived/**', NULL, '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570097827841, 1916799570085244929, 'messageReceived::update', '更新', '/api/messageReceived', 'PUT', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570097827842, 1916799570085244929, 'messageReceived::query', '分页查询', '/api/messageReceived/*/*', 'GET', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570097827843, 1916799570085244929, 'messageReceived::delete', '删除', '/api/messageReceived', 'DELETE', '2025-04-28 18:20:05', '2025-04-28 18:20:05', NULL, NULL, 0);
INSERT INTO `sys_permission` VALUES (1916799570114605057, 1916799569930055682, 'user::permission', '系统权限', '/api/permission/**', NULL, '2025-04-28 18:20:05', '2025-05-02 15:34:32', NULL, 1, 0);
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
INSERT INTO `sys_role` VALUES (1, 'admin', '管理员用户', '2025-04-28 17:38:59', '2025-04-29 23:06:13', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1852621694771773442, 'actuator', 'actuator端点可访问', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1915784833780183043, 'page::system::dept', '系统部门', '2025-04-28 17:38:59', '2025-04-29 22:57:54', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1915784833780183044, 'page::system::files', '系统文件', '2025-04-28 17:38:59', '2025-04-28 17:38:59', 1, 1, 0);
INSERT INTO `sys_role` VALUES (1915784833780183045, 'page::system::power', '系统权限', '2025-04-28 17:38:59', '2025-05-02 20:35:30', 1, 1, 0);
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
INSERT INTO `sys_role_permission` VALUES (1916799875044687873, 1915784833780183044, 1916799570341097474, '2025-04-28 18:21:17', '2025-04-28 18:21:17', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799875053076481, 1915784833780183044, 1916799570357874690, '2025-04-28 18:21:17', '2025-04-28 18:21:17', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799875053076482, 1915784833780183044, 1916799570362068994, '2025-04-28 18:21:17', '2025-04-28 18:21:17', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799875053076483, 1915784833780183044, 1916799570362068995, '2025-04-28 18:21:17', '2025-04-28 18:21:17', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799875053076484, 1915784833780183044, 1916799570362068996, '2025-04-28 18:21:17', '2025-04-28 18:21:17', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1916799875053076485, 1915784833780183044, 1916799570362068997, '2025-04-28 18:21:17', '2025-04-28 18:21:17', 1, 1, 0);
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
INSERT INTO `sys_role_permission` VALUES (1917506870714396674, 1915784833780183043, 1916799570462732290, '2025-04-30 17:10:38', '2025-04-30 17:10:38', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1917506870714396675, 1915784833780183043, 1916799570466926594, '2025-04-30 17:10:38', '2025-04-30 17:10:38', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1917506870714396676, 1915784833780183043, 1916799570466926595, '2025-04-30 17:10:38', '2025-04-30 17:10:38', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1917506870714396677, 1915784833780183043, 1916799570466926596, '2025-04-30 17:10:38', '2025-04-30 17:10:38', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1917506870714396678, 1915784833780183043, 1916799570466926597, '2025-04-30 17:10:38', '2025-04-30 17:10:38', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1917817666010955777, 1915786941359206409, 1916799569959415809, '2025-05-01 13:45:38', '2025-05-01 13:45:38', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1917817666010955778, 1915786941359206409, 1916799569967804418, '2025-05-01 13:45:38', '2025-05-01 13:45:38', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1917817666010955779, 1915786941359206409, 1916799569967804420, '2025-05-01 13:45:38', '2025-05-01 13:45:38', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1917817666078064642, 1915786941359206409, 1916799569971998721, '2025-05-01 13:45:38', '2025-05-01 13:45:38', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1917817666078064643, 1915786941359206409, 1916799570487898113, '2025-05-01 13:45:38', '2025-05-01 13:45:38', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1917817666078064644, 1915786941359206409, 1916799570508869634, '2025-05-01 13:45:38', '2025-05-01 13:45:38', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1917817666078064645, 1915786941359206409, 1916799569967804419, '2025-05-01 13:45:38', '2025-05-01 13:45:38', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1917817666078064646, 1915786941359206409, 1916799569930055682, '2025-05-01 13:45:38', '2025-05-01 13:45:38', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1918284418524221441, 1915784833780183045, 1916799570127187969, '2025-05-02 20:40:20', '2025-05-02 20:40:20', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1918284418524221442, 1915784833780183045, 1916799570131382274, '2025-05-02 20:40:20', '2025-05-02 20:40:20', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1918284418524221443, 1915784833780183045, 1916799570131382275, '2025-05-02 20:40:20', '2025-05-02 20:40:20', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1918284418524221444, 1915784833780183045, 1916799570131382277, '2025-05-02 20:40:20', '2025-05-02 20:40:20', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1918284418524221445, 1915784833780183045, 1916799570131382278, '2025-05-02 20:40:20', '2025-05-02 20:40:20', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1918284418524221446, 1915784833780183045, 1916799570139770881, '2025-05-02 20:40:20', '2025-05-02 20:40:20', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1918284418524221447, 1915784833780183045, 1916799570114605057, '2025-05-02 20:40:20', '2025-05-02 20:40:20', 1, 1, 0);
INSERT INTO `sys_role_permission` VALUES (1918284418524221448, 1915784833780183045, 1916799570131382276, '2025-05-02 20:40:20', '2025-05-02 20:40:20', 1, 1, 0);

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
INSERT INTO `sys_router` VALUES (2, 1, '/system/menu', 'MenuManger', '/system/menu/index', NULL, 0, '{\"activePath\":\"\",\"auths\":[],\"fixedTag\":false,\"hiddenTag\":false,\"icon\":\"subway:menu\",\"keepAlive\":false,\"rank\":5,\"roles\":[\"1915784833796960258\",\"1915784833796960259\"],\"showLink\":true,\"showParent\":true,\"title\":\"system_menu\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', NULL, 1, '2025-04-30 17:11:33', '2024-09-29 09:46:31', 0);
INSERT INTO `sys_router` VALUES (1840211412516524034, 1841716459123634177, '/i18n/i18n-setting', 'I18n', '/i18n/i18n-setting/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"clarity:language-solid\",\"keepAlive\":false,\"rank\":5,\"roles\":[\"1916789229485903881\"],\"showLink\":true,\"showParent\":true,\"title\":\"system_i18n\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__fadeOut\"}}', 1, 1, '2025-04-28 18:35:10', '2024-09-29 18:06:05', 0);
INSERT INTO `sys_router` VALUES (1840292695145963522, 1841716459123634177, '/i18n/i18n-type-setting', 'I18nType', '/i18n/i18n-type-setting/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"clarity:language-solid\",\"keepAlive\":false,\"rank\":6,\"roles\":[\"1916789229485903882\"],\"showLink\":true,\"showParent\":true,\"title\":\"i18n_type_setting\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__fadeOut\"}}', 1, 1, '2025-04-28 18:35:16', '2024-09-29 23:29:04', 0);
INSERT INTO `sys_router` VALUES (1841506924681338881, 1844900259930243074, '/configuration/menu-icon', 'MenuIconConfiguration', '/configuration/menu-icon/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"subway:menu\",\"keepAlive\":false,\"rank\":2,\"roles\":[\"1916789229485903873\"],\"showLink\":true,\"showParent\":true,\"title\":\"menuIcon\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-28 18:08:01', '2024-10-03 07:53:59', 0);
INSERT INTO `sys_router` VALUES (1841716459123634177, 0, '/i18n', 'I18nManger', '/i18n', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"material-symbols:language\",\"keepAlive\":false,\"rank\":5,\"roles\":[\"1916789229485903882\",\"1916789229485903881\"],\"showLink\":true,\"showParent\":true,\"title\":\"i18n\",\"transition\":{\"enterTransition\":\"animate__fadeIn\",\"leaveTransition\":\"animate__fadeOut\"}}', 1, 1, '2025-04-28 18:35:00', '2024-10-03 21:46:36', 0);
INSERT INTO `sys_router` VALUES (1841726844983701505, 1, '/system/role', 'RoleManger', '/system/role/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"fluent-mdl2:manager-self-service\",\"keepAlive\":false,\"rank\":2,\"roles\":[\"1915784833780183046\"],\"showLink\":true,\"showParent\":true,\"title\":\"role\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-30 17:11:19', '2024-10-03 22:27:52', 0);
INSERT INTO `sys_router` VALUES (1841750734275416065, 1, '/system/power', 'PermissionManger', '/system/permission/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"oui:app-users-roles\",\"keepAlive\":false,\"rank\":3,\"roles\":[\"1915784833780183045\"],\"showLink\":true,\"showParent\":true,\"title\":\"power\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-30 17:11:24', '2024-10-04 00:02:48', 0);
INSERT INTO `sys_router` VALUES (1841794929635635201, 1844956874037469185, '/element-plus', 'element_plus', '', NULL, 1, '{\"auths\":[],\"fixedTag\":false,\"frameLoading\":true,\"frameSrc\":\"https://element-plus.org/zh-CN/\",\"icon\":\"logos:element\",\"keepAlive\":false,\"rank\":62,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"element_plus\",\"transition\":{\"enterTransition\":\"animate__bounce\",\"leaveTransition\":\"animate__rubberBand\"}}', 1, 1, '2025-04-25 16:34:25', '2024-10-04 02:58:25', 0);
INSERT INTO `sys_router` VALUES (1841796585525985281, 0, '/iframe', 'external_page', '', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"mdi:iframe-outline\",\"keepAlive\":false,\"rank\":8,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"external_page\",\"transition\":{\"enterTransition\":\"animate__rubberBand\",\"leaveTransition\":\"animate__rubberBand\"}}', 1, 1, '2025-04-25 16:34:45', '2024-10-04 03:05:00', 0);
INSERT INTO `sys_router` VALUES (1841796893769580546, 1844956874037469185, '/pure-admin', 'pure_admin', '', NULL, 1, '{\"auths\":[],\"fixedTag\":false,\"frameLoading\":true,\"frameSrc\":\"https://pure-admin.cn/\",\"icon\":\"file-icons:pure\",\"keepAlive\":false,\"rank\":63,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"pure_admin\",\"transition\":{\"enterTransition\":\"animate__shakeX\",\"leaveTransition\":\"animate__jello\"}}', 1, 1, '2025-04-25 16:34:22', '2024-10-04 03:06:13', 0);
INSERT INTO `sys_router` VALUES (1841803086252548097, 1, '/system/admin-user', 'AdminUserManger', '/system/admin-user/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"ic:round-manage-accounts\",\"keepAlive\":false,\"rank\":1,\"roles\":[\"1915786941359206409\"],\"showLink\":true,\"showParent\":true,\"title\":\"admin_user\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-30 17:11:15', '2024-10-04 03:30:49', 0);
INSERT INTO `sys_router` VALUES (1842033245832458241, 1, '/system/dept', 'DeptManger', '/system/dept/index', NULL, 0, '{\"auths\":[],\"icon\":\"grommet-icons:user-manager\",\"keepAlive\":false,\"rank\":4,\"roles\":[\"1915784833780183043\"],\"showLink\":true,\"showParent\":true,\"title\":\"dept\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-30 17:11:29', '2024-10-04 18:45:24', 0);
INSERT INTO `sys_router` VALUES (1843932804747603970, 1, '/system/files', 'FileManger', '/system/files/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"line-md:file-filled\",\"keepAlive\":false,\"rank\":6,\"roles\":[\"1915784833780183044\"],\"showLink\":true,\"showParent\":true,\"title\":\"system_files\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-30 17:11:39', '2024-10-10 00:33:34', 0);
INSERT INTO `sys_router` VALUES (1844276961265557505, 1844900259930243074, '/configuration/email-user', 'EmailUsersConfiguration', '/configuration/email-user/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"ic:baseline-voicemail\",\"keepAlive\":false,\"rank\":3,\"roles\":[\"1916789229485903874\"],\"showLink\":true,\"showParent\":true,\"title\":\"emailUsers\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-28 18:08:09', '2024-10-10 23:21:07', 0);
INSERT INTO `sys_router` VALUES (1844290948342456321, 1844900259930243074, '/configuration/email-template', 'EmailTemplate', '/configuration/email-template/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"entypo:email\",\"keepAlive\":false,\"rank\":5,\"roles\":[\"1916789229485903876\"],\"showLink\":true,\"showParent\":true,\"title\":\"emailTemplate\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-28 18:08:17', '2024-10-11 00:16:42', 0);
INSERT INTO `sys_router` VALUES (1844644093987880962, 0, '/monitor', 'Monitor', '', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"carbon:cloud-monitoring\",\"keepAlive\":false,\"rank\":3,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"monitor\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-26 09:30:47', '2024-10-11 23:39:58', 0);
INSERT INTO `sys_router` VALUES (1844644779039358978, 1844644093987880962, '/monitor/server', 'MonitorServer', '/monitor/server/index', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"mingcute:server-fill\",\"keepAlive\":false,\"rank\":3,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"monitoring_server\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-26 09:30:52', '2024-10-11 23:42:42', 0);
INSERT INTO `sys_router` VALUES (1844900259930243074, 0, '/configuration', 'SystemConfiguration', '', NULL, 0, '{\"auths\":[],\"fixedTag\":false,\"icon\":\"hugeicons:configuration-01\",\"keepAlive\":false,\"rank\":2,\"roles\":[\"1916789229485903873\",\"1916789229485903874\",\"1916789229485903876\"],\"showLink\":true,\"showParent\":true,\"title\":\"configuration\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-04-30 17:13:03', '2024-10-12 16:37:53', 0);
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
INSERT INTO `sys_router` VALUES (1918937765434429441, 1844644093987880962, '/monitor/logged-in', 'MonitorLoggedIn', '/monitor/logged-in/index.vue', '', 0, '{\"activePath\":\"\",\"auths\":[],\"fixedTag\":false,\"frameLoading\":true,\"frameSrc\":\"\",\"hiddenTag\":false,\"icon\":\"material-symbols:login\",\"keepAlive\":false,\"rank\":5,\"roles\":[],\"showLink\":true,\"showParent\":true,\"title\":\"logged_in_user\",\"transition\":{\"enterTransition\":\"\",\"leaveTransition\":\"\"}}', 1, 1, '2025-05-04 19:34:26', '2025-05-04 15:56:30', 0);

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
INSERT INTO `sys_router_role` VALUES (1917507025119309826, 1841803086252548097, 1915786941359206409, '2025-04-30 17:11:15', '2025-04-30 17:11:15', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1917507043867848705, 1841726844983701505, 1915784833780183046, '2025-04-30 17:11:19', '2025-04-30 17:11:19', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1917507061832052738, 1841750734275416065, 1915784833780183045, '2025-04-30 17:11:24', '2025-04-30 17:11:24', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1917507084670038017, 1842033245832458241, 1915784833780183043, '2025-04-30 17:11:29', '2025-04-30 17:11:29', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1917507099316547585, 2, 1915784833796960258, '2025-04-30 17:11:33', '2025-04-30 17:11:33', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1917507099316547586, 2, 1915784833796960259, '2025-04-30 17:11:33', '2025-04-30 17:11:33', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1917507124708864001, 1843932804747603970, 1915784833780183044, '2025-04-30 17:11:39', '2025-04-30 17:11:39', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1917507479093997569, 1844900259930243074, 1916789229485903873, '2025-04-30 17:13:03', '2025-04-30 17:13:03', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1917507479093997570, 1844900259930243074, 1916789229485903874, '2025-04-30 17:13:03', '2025-04-30 17:13:03', 1, 1, 0);
INSERT INTO `sys_router_role` VALUES (1917507479093997571, 1844900259930243074, 1916789229485903876, '2025-04-30 17:13:03', '2025-04-30 17:13:03', 1, 1, 0);

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
INSERT INTO `sys_user` VALUES (1, 'Administrator', 'Administrator', 'admin@qq.com', '123456789', '$2a$10$h5BUwmMaVcEuu7Bz0TPPy.PQV8JP6CFJlbHTgT78G1s0YPIu2kfXe', '/auth-admin/avatar/2025/05-02/68bc367d-0fcf-42be-a548-88a41568e4e8', 1, 'admin 1', '172.18.0.1', '内网IP', 0, '2024-10-24 21:35:03', '2025-05-02 18:59:34', 1, 1, 0);
INSERT INTO `sys_user` VALUES (1849444494908125181, 'bunny', 'bunny', '1319900154@qq.com', '18012062876', '$2a$10$h5BUwmMaVcEuu7Bz0TPPy.PQV8JP6CFJlbHTgT78G1s0YPIu2kfXe', '/auth-admin/avatar/2025/01-17/b3aba651-bfb1-45dd-a470-0bcaad26f6ef', 1, '搜索', '127.0.0.1', '内网IP', 0, '2024-09-26 14:29:33', '2025-05-02 20:40:20', 1849444494908125181, 1, 0);
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
INSERT INTO `sys_user_role` VALUES (1918279827862687745, 1849444494908125181, 1915784833780183045, '2025-05-02 20:22:06', '2025-05-02 20:22:06', 1, 1, 0);
INSERT INTO `sys_user_role` VALUES (1918279827862687746, 1849444494908125181, 1915784833780183046, '2025-05-02 20:22:06', '2025-05-02 20:22:06', 1, 1, 0);

-- ----------------------------
-- View structure for view_qrtz_schedulers
-- ----------------------------
DROP VIEW IF EXISTS `view_qrtz_schedulers`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_qrtz_schedulers` AS select `job`.`job_name` AS `job_name`,`job`.`job_group` AS `job_group`,`job`.`description` AS `description`,`job`.`job_class_name` AS `job_class_name`,`cron`.`cron_expression` AS `cron_expression`,`tri`.`trigger_name` AS `trigger_name`,`tri`.`trigger_state` AS `trigger_state` from ((`qrtz_job_details` `job` join `qrtz_triggers` `tri` on(((`job`.`job_name` = `tri`.`job_name`) and (`job`.`job_group` = `tri`.`job_group`)))) join `qrtz_cron_triggers` `cron` on(((`cron`.`trigger_name` = `tri`.`trigger_name`) and (`cron`.`trigger_group` = `tri`.`job_group`)))) where (`tri`.`trigger_type` = 'CRON');

SET FOREIGN_KEY_CHECKS = 1;
