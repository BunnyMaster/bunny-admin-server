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

 Date: 29/04/2025 17:51:44
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
INSERT INTO `sys_files` VALUES (1917116805584637953, 'avatar', '/auth-admin/avatar/2025/04-29/b85d8959-48d8-44f7-9e0f-bdaca8b1bea4', 384185, 'application/octet-stream', 0, 1, 1, '2025-04-29 15:20:39', '2025-04-29 15:20:39', 0);

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
INSERT INTO `sys_i18n` VALUES (1840622816000196609, 'menus.pureSuccess', '成功页面', 'zh', 1, 1, '2025-04-29 17:06:24', '2024-09-30 21:20:51', 0);
INSERT INTO `sys_i18n` VALUES (1840622816000196610, 'menus.pureInfiniteScroll', '表格无限滚动', 'zh', 1, 1849444494908125181, '2024-10-30 21:17:23', '2024-09-30 21:20:51', 0);
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
INSERT INTO `sys_i18n` VALUES (1840622817359151107, 'menus.pureEmpty', '无Layout页', 'zh', 1, 1, '2024-10-26 15:17:00', '2024-09-30 21:20:51', 0);
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
INSERT INTO `sys_i18n` VALUES (1840631408195518465, 'pleaseSelectAnimation', '请选择动画', 'zh', 1, 1, '2024-10-24 08:11:03', '2024-09-30 21:55:00', 0);
INSERT INTO `sys_i18n` VALUES (1840631437878607873, 'pleaseSelectAnimation', 'Pleaseselectanimation', 'en', 1, 1, '2024-10-24 08:11:08', '2024-09-30 21:55:07', 0);
INSERT INTO `sys_i18n` VALUES (1840631608989433857, 'animationNotExist', '动画不存在', 'zh', 1, 1, '2024-10-24 08:11:57', '2024-09-30 21:55:48', 0);
INSERT INTO `sys_i18n` VALUES (1840631639922425857, 'animationNotExist', 'Animationdoesnotexist', 'en', 1, 1, '2024-10-24 08:12:03', '2024-09-30 21:55:55', 0);
INSERT INTO `sys_i18n` VALUES (1840632122200276994, 'cancel', '取消', 'zh', 1, 1, '2024-09-30 21:57:50', '2024-09-30 21:57:50', 0);
INSERT INTO `sys_i18n` VALUES (1840632142228078593, 'cancel', 'cancel', 'en', 1, 1, '2024-09-30 21:57:55', '2024-09-30 21:57:55', 0);
INSERT INTO `sys_i18n` VALUES (1840632222834212865, 'confirm', 'confirm', 'en', 1, 1, '2024-09-30 21:58:14', '2024-09-30 21:58:14', 0);
INSERT INTO `sys_i18n` VALUES (1840632242182537218, 'confirm', '确定', 'zh', 1, 1, '2024-09-30 21:58:18', '2024-09-30 21:58:18', 0);
INSERT INTO `sys_i18n` VALUES (1840632586597810177, 'sorryNoAccess', '抱歉，你无权访问该页面', 'zh', 1, 1, '2024-10-24 08:12:54', '2024-09-30 21:59:41', 0);
INSERT INTO `sys_i18n` VALUES (1840632615198769153, 'sorryNoAccess', 'Sorry,youdonothaveaccesstothispage', 'en', 1, 1, '2024-10-24 08:12:59', '2024-09-30 21:59:47', 0);
INSERT INTO `sys_i18n` VALUES (1840632848200744961, 'returnToHomepage', '返回首页', 'zh', 1, 1, '2024-10-24 08:14:11', '2024-09-30 22:00:43', 0);
INSERT INTO `sys_i18n` VALUES (1840632875962843138, 'returnToHomepage', 'Returntohomepage', 'en', 1, 1, '2024-10-24 08:14:16', '2024-09-30 22:00:50', 0);
INSERT INTO `sys_i18n` VALUES (1840633021773627394, 'sorryPageNotFound', '抱歉，你访问的页面不存在', 'zh', 1, 1, '2024-10-24 08:16:42', '2024-09-30 22:01:24', 0);
INSERT INTO `sys_i18n` VALUES (1840633050957594626, 'sorryPageNotFound', 'Sorry,thepageyouaretryingtoaccessdoesnotexist', 'en', 1, 1, '2024-10-24 08:16:46', '2024-09-30 22:01:31', 0);
INSERT INTO `sys_i18n` VALUES (1840633244000436225, 'sorryServerError', '抱歉，服务器出错了', 'zh', 1, 1, '2024-10-24 08:15:10', '2024-09-30 22:02:17', 0);
INSERT INTO `sys_i18n` VALUES (1840633267354320897, 'sorryServerError', 'Sorry,therewasaservererror', 'en', 1, 1, '2024-10-24 08:15:15', '2024-09-30 22:02:23', 0);
INSERT INTO `sys_i18n` VALUES (1840633499433549825, 'input', '输入', 'zh', 1, 1, '2024-09-30 22:03:18', '2024-09-30 22:03:18', 0);
INSERT INTO `sys_i18n` VALUES (1840633523756318721, 'input', 'Input', 'en', 1, 1, '2024-09-30 22:03:24', '2024-09-30 22:03:24', 0);
INSERT INTO `sys_i18n` VALUES (1840633757135781889, 'addMultilingual', '添加多语言', 'zh', 1, 1, '2024-10-24 08:15:42', '2024-09-30 22:04:20', 0);
INSERT INTO `sys_i18n` VALUES (1840633786038730754, 'addMultilingual', 'Addmultilingual', 'en', 1, 1, '2024-10-24 08:16:12', '2024-09-30 22:04:27', 0);
INSERT INTO `sys_i18n` VALUES (1840634611121242113, 'search', '搜索', 'zh', 1, 1, '2024-09-30 22:07:43', '2024-09-30 22:07:43', 0);
INSERT INTO `sys_i18n` VALUES (1840634622747852801, 'search', 'search', 'en', 1, 1, '2024-09-30 22:07:46', '2024-09-30 22:07:46', 0);
INSERT INTO `sys_i18n` VALUES (1840635706920910850, 'multilingualManagement', '多语言管理', 'zh', 1, 1, '2024-10-24 08:17:16', '2024-09-30 22:12:05', 0);
INSERT INTO `sys_i18n` VALUES (1840635727644966913, 'multilingualManagement', 'Multilingualmanagement', 'en', 1, 1, '2024-10-24 08:17:21', '2024-09-30 22:12:09', 0);
INSERT INTO `sys_i18n` VALUES (1840635826995445762, 'modify', 'modify', 'en', 1, 1, '2024-09-30 22:12:33', '2024-09-30 22:12:33', 0);
INSERT INTO `sys_i18n` VALUES (1840635859077677057, 'modify', '修改', 'zh', 1, 1, '2024-09-30 22:12:41', '2024-09-30 22:12:41', 0);
INSERT INTO `sys_i18n` VALUES (1840635970096709634, 'addNew', '新增', 'zh', 1, 1, '2024-10-24 08:22:43', '2024-09-30 22:13:07', 0);
INSERT INTO `sys_i18n` VALUES (1840635995648409601, 'addNew', 'Addnew', 'en', 1, 1, '2024-10-24 08:25:31', '2024-09-30 22:13:13', 0);
INSERT INTO `sys_i18n` VALUES (1840636123172028417, 'delete', 'delete', 'en', 1, 1, '2024-09-30 22:13:44', '2024-09-30 22:13:44', 0);
INSERT INTO `sys_i18n` VALUES (1840636143061417986, 'delete', '删除', 'zh', 1, 1, '2024-09-30 22:13:49', '2024-09-30 22:13:49', 0);
INSERT INTO `sys_i18n` VALUES (1840636714942185474, 'confirmDelete', '是否确认删除', 'zh', 1, 1, '2024-10-24 08:19:02', '2024-09-30 22:16:05', 0);
INSERT INTO `sys_i18n` VALUES (1840636746160390146, 'confirmDelete', 'Areyousureyouwanttodelete?', 'en', 1, 1, '2024-10-24 08:19:07', '2024-09-30 22:16:12', 0);
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
INSERT INTO `sys_i18n` VALUES (1840651657141723137, 'nickname', 'nickname', 'en', 1, 1, '2024-10-27 15:59:30', '2024-09-30 23:15:27', 0);
INSERT INTO `sys_i18n` VALUES (1840651675848318978, 'nickname', '昵称', 'zh', 1, 1, '2024-10-27 15:59:33', '2024-09-30 23:15:32', 0);
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
INSERT INTO `sys_i18n` VALUES (1841803192141946881, 'admin_user', '用户管理', 'zh', 1, 1, '2024-11-03 18:58:14', '2024-10-04 03:31:15', 0);
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
INSERT INTO `sys_i18n` VALUES (1841812298995146754, 'adminUser_nickname', '昵称', 'zh', 1, 1, '2024-10-27 15:59:37', '2024-10-04 04:07:26', 0);
INSERT INTO `sys_i18n` VALUES (1841812311011827713, 'adminUser_nickname', 'nickName', 'en', 1, 1, '2024-10-27 15:59:41', '2024-10-04 04:07:29', 0);
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
INSERT INTO `sys_i18n` VALUES (1848192082106814466, 'pause', '暂停', 'zh', 1, 1, '2024-10-21 10:38:25', '2024-10-21 10:38:25', 0);
INSERT INTO `sys_i18n` VALUES (1848192092307361793, 'pause', 'pause', 'en', 1, 1, '2024-10-21 10:38:27', '2024-10-21 10:38:27', 0);
INSERT INTO `sys_i18n` VALUES (1848192113492791298, 'resume', 'resume', 'en', 1, 1, '2024-10-22 22:12:26', '2024-10-21 10:38:32', 0);
INSERT INTO `sys_i18n` VALUES (1848192133197631490, 'resume', '恢复', 'zh', 1, 1, '2024-10-21 10:38:37', '2024-10-21 10:38:37', 0);
INSERT INTO `sys_i18n` VALUES (1848531500831260674, 'buttons.accountSettings', '账户设置', 'zh', 1, 1, '2024-10-22 09:07:09', '2024-10-22 09:07:09', 0);
INSERT INTO `sys_i18n` VALUES (1848531529457385474, 'buttons.accountSettings', 'account settings', 'en', 1, 1, '2024-10-22 09:07:15', '2024-10-22 09:07:15', 0);
INSERT INTO `sys_i18n` VALUES (1848538705588604929, 'back', '返回', 'zh', 1, 1, '2024-10-22 09:35:46', '2024-10-22 09:35:46', 0);
INSERT INTO `sys_i18n` VALUES (1848538717659811842, 'back', 'back', 'en', 1, 1, '2024-10-22 09:35:49', '2024-10-22 09:35:49', 0);
INSERT INTO `sys_i18n` VALUES (1848539705426792450, 'security_log', '安全日志', 'zh', 1, 1, '2024-10-22 09:39:45', '2024-10-22 09:39:45', 0);
INSERT INTO `sys_i18n` VALUES (1848539733557989377, 'security_log', 'security log', 'en', 1, 1, '2024-10-22 09:39:51', '2024-10-22 09:39:51', 0);
INSERT INTO `sys_i18n` VALUES (1848604622649499650, 'userLoginLog_secChUaPlatform', 'system/platform', 'en', 1, 1, '2024-10-22 13:57:42', '2024-10-22 13:57:42', 0);
INSERT INTO `sys_i18n` VALUES (1848606989063233538, 'op_time', '操作时间', 'zh', 1, 1, '2024-10-22 14:07:06', '2024-10-22 14:07:06', 0);
INSERT INTO `sys_i18n` VALUES (1848607007836938242, 'op_time', 'Operation time', 'en', 1, 1, '2024-10-22 14:07:11', '2024-10-22 14:07:11', 0);
INSERT INTO `sys_i18n` VALUES (1848611633965506561, 'update_information', '更新信息', 'zh', 1, 1, '2024-10-22 14:25:34', '2024-10-22 14:25:34', 0);
INSERT INTO `sys_i18n` VALUES (1848611670414008321, 'update_information', 'Update information', 'en', 1, 1, '2024-10-22 14:25:42', '2024-10-22 14:25:42', 0);
INSERT INTO `sys_i18n` VALUES (1848612223139389442, 'required_fields', '填写必填项', 'zh', 1, 1, '2024-10-22 14:27:54', '2024-10-22 14:27:54', 0);
INSERT INTO `sys_i18n` VALUES (1848612250712743938, 'required_fields', 'Fill in the required fields', 'en', 1, 1, '2024-10-22 14:28:01', '2024-10-22 14:28:01', 0);
INSERT INTO `sys_i18n` VALUES (1848617066897817601, 'update_success', '修改成功', 'zh', 1, 1, '2024-10-22 14:47:09', '2024-10-22 14:47:09', 0);
INSERT INTO `sys_i18n` VALUES (1848617096648015873, 'update_success', 'update success', 'en', 1, 1, '2024-10-22 14:47:16', '2024-10-22 14:47:16', 0);
INSERT INTO `sys_i18n` VALUES (1848617300700905474, 'upload_success', '上传成功', 'zh', 1, 1, '2024-10-22 14:48:05', '2024-10-22 14:48:05', 0);
INSERT INTO `sys_i18n` VALUES (1848617326265188353, 'upload_success', 'upload success', 'en', 1, 1, '2024-10-22 14:48:11', '2024-10-22 14:48:11', 0);
INSERT INTO `sys_i18n` VALUES (1848628333414895617, 'upload_user_avatar_tip', 'Uploading a successful avatar will not be saved automatically', 'en', 1, 1, '2024-10-22 15:31:55', '2024-10-22 15:31:55', 0);
INSERT INTO `sys_i18n` VALUES (1848628361030193154, 'upload_user_avatar_tip', '上传头像成功不会自动保存', 'zh', 1, 1, '2024-10-22 15:32:02', '2024-10-22 15:32:02', 0);
INSERT INTO `sys_i18n` VALUES (1848640185628831745, 'rest_password_tip', '忘记密码或重置密码，修改密码后会跳转到登录页重新登录', 'zh', 1, 1, '2024-10-22 16:19:01', '2024-10-22 16:19:01', 0);
INSERT INTO `sys_i18n` VALUES (1848640213290266625, 'rest_password_tip', 'If you forget your password or reset your password, you will be redirected to the login page to log in again', 'en', 1, 1, '2024-10-22 16:19:08', '2024-10-22 16:19:08', 0);
INSERT INTO `sys_i18n` VALUES (1848640501740941313, 'account_management', 'Account Management', 'en', 1, 1, '2024-10-22 16:21:34', '2024-10-22 16:20:16', 0);
INSERT INTO `sys_i18n` VALUES (1848640524042055682, 'account_management', '账户管理', 'zh', 1, 1, '2024-10-22 16:21:37', '2024-10-22 16:20:22', 0);
INSERT INTO `sys_i18n` VALUES (1848640658800848898, 'account_password', '账户密码', 'zh', 1, 1, '2024-10-22 16:20:54', '2024-10-22 16:20:54', 0);
INSERT INTO `sys_i18n` VALUES (1848640703268859906, 'account_password', 'Account Password', 'en', 1, 1, '2024-10-22 16:21:04', '2024-10-22 16:21:04', 0);
INSERT INTO `sys_i18n` VALUES (1848951509522960386, 'forcedOffline', '管理员强制下线', 'zh', 1, 1, '2024-10-23 12:56:06', '2024-10-23 12:56:06', 0);
INSERT INTO `sys_i18n` VALUES (1848951569388261377, 'forcedOffline', 'Admin forced logout', 'en', 1, 1, '2024-10-23 12:56:21', '2024-10-23 12:56:21', 0);
INSERT INTO `sys_i18n` VALUES (1848952613493133314, 'login', '登录', 'zh', 1, 1, '2024-10-23 13:00:30', '2024-10-23 13:00:30', 0);
INSERT INTO `sys_i18n` VALUES (1848952714517139458, 'login', 'sign in', 'en', 1, 1, '2024-10-23 13:00:54', '2024-10-23 13:00:54', 0);
INSERT INTO `sys_i18n` VALUES (1848952788764708866, 'logout', 'log out', 'en', 1, 1, '2024-10-23 13:01:11', '2024-10-23 13:01:11', 0);
INSERT INTO `sys_i18n` VALUES (1848952811984375810, 'logout', '退出', 'zh', 1, 1, '2024-10-23 13:01:17', '2024-10-23 13:01:17', 0);
INSERT INTO `sys_i18n` VALUES (1848989828774572033, 'systemCaches', '系统缓存', 'zh', 1, 1, '2024-10-23 15:28:22', '2024-10-23 15:28:22', 0);
INSERT INTO `sys_i18n` VALUES (1848989851742580737, 'systemCaches', 'system caches', 'en', 1, 1, '2024-10-23 15:28:28', '2024-10-23 15:28:28', 0);
INSERT INTO `sys_i18n` VALUES (1849000567279136770, 'webConifg', 'web配置', 'zh', 1, 1, '2024-10-23 16:11:03', '2024-10-23 16:11:03', 0);
INSERT INTO `sys_i18n` VALUES (1849000598690279426, 'webConifg', 'web config', 'en', 1, 1, '2024-10-23 16:11:10', '2024-10-23 16:11:10', 0);
INSERT INTO `sys_i18n` VALUES (1849009236238581762, 'version', '版本', 'zh', 1, 1, '2024-10-23 16:45:30', '2024-10-23 16:45:30', 0);
INSERT INTO `sys_i18n` VALUES (1849009248158793730, 'version', 'version', 'en', 1, 1, '2024-10-23 16:45:32', '2024-10-23 16:45:32', 0);
INSERT INTO `sys_i18n` VALUES (1849009275564376066, 'appTitle', 'appTitle', 'en', 1, 1, '2024-10-23 16:45:39', '2024-10-23 16:45:39', 0);
INSERT INTO `sys_i18n` VALUES (1849009338537656322, 'appTitle', '网页title', 'zh', 1, 1, '2024-10-23 16:45:54', '2024-10-23 16:45:54', 0);
INSERT INTO `sys_i18n` VALUES (1849009380795269122, 'copyright', '版权', 'zh', 1, 1, '2024-10-23 16:46:04', '2024-10-23 16:46:04', 0);
INSERT INTO `sys_i18n` VALUES (1849009391708848129, 'copyright', 'copyright', 'en', 1, 1, '2024-10-23 16:46:07', '2024-10-23 16:46:07', 0);
INSERT INTO `sys_i18n` VALUES (1849009565843767297, 'fixedHeader', 'fixedHeader', 'en', 1, 1, '2024-10-23 16:46:48', '2024-10-23 16:46:48', 0);
INSERT INTO `sys_i18n` VALUES (1849009595971452930, 'fixedHeader', '固定头', 'zh', 1, 1, '2024-10-23 16:46:55', '2024-10-23 16:46:55', 0);
INSERT INTO `sys_i18n` VALUES (1849009676065882114, 'keepAlive', '保持存活', 'zh', 1, 1, '2024-10-23 16:47:14', '2024-10-23 16:47:14', 0);
INSERT INTO `sys_i18n` VALUES (1849009684353826817, 'keepAlive', 'keepAlive', 'en', 1, 1, '2024-10-23 16:47:16', '2024-10-23 16:47:16', 0);
INSERT INTO `sys_i18n` VALUES (1849009746450497537, 'tooltipEffect', '工具提示的效果', 'zh', 1, 1, '2024-10-23 16:47:31', '2024-10-23 16:47:31', 0);
INSERT INTO `sys_i18n` VALUES (1849009759222153218, 'tooltipEffect', 'tooltipEffect', 'en', 1, 1, '2024-10-23 16:47:34', '2024-10-23 16:47:34', 0);
INSERT INTO `sys_i18n` VALUES (1849009792185188353, 'hiddenSideBar', 'hiddenSideBar', 'en', 1, 1, '2024-10-23 16:47:42', '2024-10-23 16:47:42', 0);
INSERT INTO `sys_i18n` VALUES (1849009828570775554, 'hiddenSideBar', '侧边栏是否隐藏', 'zh', 1, 1, '2024-10-23 16:47:51', '2024-10-23 16:47:51', 0);
INSERT INTO `sys_i18n` VALUES (1849009880538202114, 'multiTagsCache', '是否缓存多个标签', 'zh', 1, 1, '2024-10-23 16:48:03', '2024-10-23 16:48:03', 0);
INSERT INTO `sys_i18n` VALUES (1849009891091070978, 'multiTagsCache', 'multiTagsCache', 'en', 1, 1, '2024-10-23 16:48:06', '2024-10-23 16:48:06', 0);
INSERT INTO `sys_i18n` VALUES (1849009925140430850, 'layout', 'layout', 'en', 1, 1, '2024-10-23 16:48:14', '2024-10-23 16:48:14', 0);
INSERT INTO `sys_i18n` VALUES (1849009957990219778, 'layout', '应用程序的布局', 'zh', 1, 1, '2024-10-23 16:48:22', '2024-10-23 16:48:22', 0);
INSERT INTO `sys_i18n` VALUES (1849009996519096321, 'theme', '主题', 'zh', 1, 1, '2024-10-23 16:48:31', '2024-10-23 16:48:31', 0);
INSERT INTO `sys_i18n` VALUES (1849010005675261953, 'theme', 'theme', 'en', 1, 1, '2024-10-23 16:48:33', '2024-10-23 16:48:33', 0);
INSERT INTO `sys_i18n` VALUES (1849010029062701058, 'menuSearchHistory', 'menuSearchHistory', 'en', 1, 1, '2024-10-23 16:48:39', '2024-10-23 16:48:39', 0);
INSERT INTO `sys_i18n` VALUES (1849010060951994370, 'menuSearchHistory', '菜单搜索历史', 'zh', 1, 1, '2024-10-23 16:48:46', '2024-10-23 16:48:46', 0);
INSERT INTO `sys_i18n` VALUES (1849010105759744001, 'responsiveStorageNameSpace', 'responsiveStorageNameSpace', 'en', 1, 1, '2024-10-23 16:48:57', '2024-10-23 16:48:57', 0);
INSERT INTO `sys_i18n` VALUES (1849010135665131521, 'responsiveStorageNameSpace', '响应式存储的命名空间', 'zh', 1, 1, '2024-10-23 16:49:04', '2024-10-23 16:49:04', 0);
INSERT INTO `sys_i18n` VALUES (1849010233992200194, 'appLocale', '本地语言', 'zh', 1, 1, '2024-10-23 16:49:27', '2024-10-23 16:49:27', 0);
INSERT INTO `sys_i18n` VALUES (1849010253801897986, 'appLocale', 'local', 'en', 1, 1, '2024-10-23 16:49:32', '2024-10-23 16:49:32', 0);
INSERT INTO `sys_i18n` VALUES (1849010284172853249, 'menuArrowIconNoTransition', 'menuArrowIconNoTransition', 'en', 1, 1, '2024-10-23 16:49:39', '2024-10-23 16:49:39', 0);
INSERT INTO `sys_i18n` VALUES (1849010311356137474, 'menuArrowIconNoTransition', '菜单箭头图标是否没有过渡效果', 'zh', 1, 1, '2024-10-23 16:49:46', '2024-10-23 16:49:46', 0);
INSERT INTO `sys_i18n` VALUES (1849010354033180673, 'showModel', 'showModel', 'en', 1, 1, '2024-10-23 16:49:56', '2024-10-23 16:49:56', 0);
INSERT INTO `sys_i18n` VALUES (1849010381354876929, 'showModel', '要显示的模型', 'zh', 1, 1, '2024-10-23 16:50:03', '2024-10-23 16:50:03', 0);
INSERT INTO `sys_i18n` VALUES (1849010414687010818, 'epThemeColor', 'epThemeColor', 'en', 1, 1, '2024-10-23 16:50:10', '2024-10-23 16:50:10', 0);
INSERT INTO `sys_i18n` VALUES (1849010438401605633, 'epThemeColor', '主题颜色', 'zh', 1, 1, '2024-10-23 16:50:16', '2024-10-23 16:50:16', 0);
INSERT INTO `sys_i18n` VALUES (1849010483863666689, 'stretch', '是否拉伸', 'zh', 1, 1, '2024-10-23 16:50:27', '2024-10-23 16:50:27', 0);
INSERT INTO `sys_i18n` VALUES (1849010493573480449, 'stretch', 'stretch', 'en', 1, 1, '2024-10-23 16:50:29', '2024-10-23 16:50:29', 0);
INSERT INTO `sys_i18n` VALUES (1849010518923853826, 'hideFooter', 'hideFooter', 'en', 1, 1, '2024-10-23 16:50:35', '2024-10-23 16:50:35', 0);
INSERT INTO `sys_i18n` VALUES (1849010551685562369, 'hideFooter', '是否隐藏页脚', 'zh', 1, 1, '2024-10-23 16:50:43', '2024-10-23 16:50:43', 0);
INSERT INTO `sys_i18n` VALUES (1849010581867773954, 'hideTabs', 'hideTabs', 'en', 1, 1, '2024-10-23 16:50:50', '2024-10-23 16:50:50', 0);
INSERT INTO `sys_i18n` VALUES (1849010607037792258, 'hideTabs', '是否隐藏选项卡', 'zh', 1, 1, '2024-10-23 16:50:56', '2024-10-23 16:50:56', 0);
INSERT INTO `sys_i18n` VALUES (1849010638327300097, 'greyStyle', 'greyStyle', 'en', 1, 1, '2024-10-23 16:51:04', '2024-10-23 16:51:04', 0);
INSERT INTO `sys_i18n` VALUES (1849010689938210818, 'greyStyle', '是否启用灰色模式', 'zh', 1, 1, '2024-10-23 16:51:16', '2024-10-23 16:51:16', 0);
INSERT INTO `sys_i18n` VALUES (1849010744212504578, 'darkMode', '暗色主题', 'zh', 1, 1, '2024-10-23 16:51:29', '2024-10-23 16:51:29', 0);
INSERT INTO `sys_i18n` VALUES (1849010753117011970, 'darkMode', 'darkMode', 'en', 1, 1, '2024-10-23 16:51:31', '2024-10-23 16:51:31', 0);
INSERT INTO `sys_i18n` VALUES (1849010829583368194, 'weakStyle', '色弱模式', 'zh', 1, 1, '2024-10-24 08:22:22', '2024-10-23 16:51:49', 0);
INSERT INTO `sys_i18n` VALUES (1849010843059666945, 'weakStyle', 'Thro mode', 'en', 1, 1, '2024-10-23 16:51:53', '2024-10-23 16:51:53', 0);
INSERT INTO `sys_i18n` VALUES (1849010966376398850, 'overallStyle', 'The overall style of the application', 'en', 1, 1, '2024-10-23 16:52:22', '2024-10-23 16:52:22', 0);
INSERT INTO `sys_i18n` VALUES (1849010990967603201, 'overallStyle', '应用程序的整体样式', 'zh', 1, 1, '2024-10-23 16:52:28', '2024-10-23 16:52:28', 0);
INSERT INTO `sys_i18n` VALUES (1849011073599586305, 'sidebarStatus', '侧边栏的状态', 'zh', 1, 1, '2024-10-23 16:52:48', '2024-10-23 16:52:48', 0);
INSERT INTO `sys_i18n` VALUES (1849011109737709570, 'sidebarStatus', 'Sidebar status', 'en', 1, 1, '2024-10-23 16:52:56', '2024-10-23 16:52:56', 0);
INSERT INTO `sys_i18n` VALUES (1849011196694020098, 'showLogo', '是否显示logo', 'zh', 1, 1, '2024-10-23 16:53:17', '2024-10-23 16:53:17', 0);
INSERT INTO `sys_i18n` VALUES (1849011218173050882, 'showLogo', 'Whether to display logo or not', 'en', 1, 1, '2024-10-23 16:53:22', '2024-10-23 16:53:22', 0);
INSERT INTO `sys_i18n` VALUES (1849011314667208706, 'cachingAsyncRoutes', '是否缓存异步路由', 'zh', 1, 1, '2024-10-23 16:53:45', '2024-10-23 16:53:45', 0);
INSERT INTO `sys_i18n` VALUES (1849011341619806209, 'cachingAsyncRoutes', 'Whether asynchronous routes should be cached', 'en', 1, 1, '2024-10-23 16:53:51', '2024-10-23 16:53:51', 0);
INSERT INTO `sys_i18n` VALUES (1849259394197078017, 'modifyingConfiguration', 'Modifying configuration', 'en', 1, 1, '2024-10-24 09:19:32', '2024-10-24 09:19:32', 0);
INSERT INTO `sys_i18n` VALUES (1849259429144018946, 'modifyingConfiguration', '修改配置', 'zh', 1, 1, '2024-10-24 09:19:40', '2024-10-24 09:19:40', 0);
INSERT INTO `sys_i18n` VALUES (1849279592950132738, 'confirmUpdateConfiguration', '确认修改配置吗？', 'zh', 1, 1, '2024-10-24 10:39:48', '2024-10-24 10:39:48', 0);
INSERT INTO `sys_i18n` VALUES (1849279642635857922, 'confirmUpdateConfiguration', 'Are you sure to change the configuration?', 'en', 1, 1, '2024-10-24 10:39:59', '2024-10-24 10:39:59', 0);
INSERT INTO `sys_i18n` VALUES (1849413883044634625, 'deleteBatchTip', '输入 yes/YES/y/Y 来确认批量删除，此操作不可逆', 'zh', 1, 1, '2024-10-24 19:33:25', '2024-10-24 19:33:25', 0);
INSERT INTO `sys_i18n` VALUES (1849413913029713922, 'deleteBatchTip', 'Enter yes/YES/y/Y to confirm the batch deletion; this operation is not reversible', 'en', 1, 1, '2024-10-24 19:33:32', '2024-10-24 19:33:32', 0);
INSERT INTO `sys_i18n` VALUES (1849416399593480194, 'deleteBatchPlaceholder', '输入 yes/YES/y/Y 来确认', 'zh', 1, 1, '2024-10-24 19:43:25', '2024-10-24 19:43:25', 0);
INSERT INTO `sys_i18n` VALUES (1849416428479651841, 'deleteBatchPlaceholder', 'Type yes/YES/y/Y to confirm', 'en', 1, 1, '2024-10-24 19:43:32', '2024-10-24 19:43:32', 0);
INSERT INTO `sys_i18n` VALUES (1849428393092521985, 'confirmText', '确认文字', 'zh', 1, 1, '2024-10-24 20:31:04', '2024-10-24 20:31:04', 0);
INSERT INTO `sys_i18n` VALUES (1849428407277658113, 'confirmText', 'confirmText', 'en', 1, 1, '2024-10-24 20:31:08', '2024-10-24 20:31:08', 0);
INSERT INTO `sys_i18n` VALUES (1850061137300516865, 'assignBatchRolesToRouter', '批量分配角色', 'zh', 1, 1, '2024-10-26 14:25:22', '2024-10-26 14:25:22', 0);
INSERT INTO `sys_i18n` VALUES (1850061144988676097, 'assignBatchRolesToRouter', 'assignBatchRolesToRouter', 'en', 1, 1, '2024-10-26 14:25:24', '2024-10-26 14:25:24', 0);
INSERT INTO `sys_i18n` VALUES (1850068922373324801, 'clearAllRolesSelect', '清除选中所以角色', 'zh', 1, 1, '2024-10-26 14:56:18', '2024-10-26 14:56:18', 0);
INSERT INTO `sys_i18n` VALUES (1850068935086260226, 'clearAllRolesSelect', 'clearAllRolesSelect', 'en', 1, 1, '2024-10-26 14:56:21', '2024-10-26 14:56:21', 0);
INSERT INTO `sys_i18n` VALUES (1850071107320528898, 'batchUpdates', '确认批量更新吗？', 'zh', 1, 1, '2024-10-26 15:05:38', '2024-10-26 15:04:59', 0);
INSERT INTO `sys_i18n` VALUES (1850071126647881730, 'batchUpdates', 'Confirm batch update?', 'en', 1, 1, '2024-10-26 15:05:48', '2024-10-26 15:05:04', 0);
INSERT INTO `sys_i18n` VALUES (1850537850115551234, 'assignBatchRolesToRouterTip', '批量分配角色，会清除已分配的角色并不会追加角色', 'zh', 1, 1, '2024-10-27 21:59:39', '2024-10-27 21:59:39', 0);
INSERT INTO `sys_i18n` VALUES (1850537862069317634, 'assignBatchRolesToRouterTip', 'Bulk role allocation clears allocated roles and does not append them', 'en', 1, 1, '2024-10-27 21:59:42', '2024-10-27 21:59:42', 0);
INSERT INTO `sys_i18n` VALUES (1850538229314187265, 'clearAllRolesSelectTip', '此操作会清除已经分配的菜单角色，如果确认此操作不可恢复，菜单下分配好的角色也将清除！！！', 'zh', 1, 1, '2024-10-27 22:01:10', '2024-10-27 22:01:10', 0);
INSERT INTO `sys_i18n` VALUES (1850538260247179265, 'clearAllRolesSelectTip', 'This ACTION WILL CLEAR THE ASSIGNED MENU ROLES, AND IF IT IS CONFIRMED THAT THIS action is not recoverable, THE assigned ROLES under the MENU will also BE CLEARED!!', 'en', 1, 1, '2024-10-27 22:01:17', '2024-10-27 22:01:17', 0);
INSERT INTO `sys_i18n` VALUES (1850538413012119553, 'doubleCheck', '再次确认是否继续？！', 'zh', 1, 1, '2024-10-27 22:01:54', '2024-10-27 22:01:54', 0);
INSERT INTO `sys_i18n` VALUES (1850538424236077057, 'doubleCheck', 'Reconfirm whether to proceed? !', 'en', 1, 1, '2024-10-27 22:01:56', '2024-10-27 22:01:56', 0);
INSERT INTO `sys_i18n` VALUES (1850725393391861762, 'formatError', '格式错误', 'zh', 1, 1, '2024-10-28 10:24:53', '2024-10-28 10:24:53', 0);
INSERT INTO `sys_i18n` VALUES (1850725445812273154, 'formatError', 'format error', 'en', 1, 1, '2024-10-28 10:25:06', '2024-10-28 10:25:06', 0);
INSERT INTO `sys_i18n` VALUES (1850726499895394305, 'inputRequestUrlTip', '请求URL需要以 \'/\' 开头', 'zh', 1, 1, '2024-10-28 10:31:21', '2024-10-28 10:29:17', 0);
INSERT INTO `sys_i18n` VALUES (1850726525979770881, 'inputRequestUrlTip', 'The request URL needs to start with /', 'en', 1, 1, '2024-10-28 10:29:23', '2024-10-28 10:29:23', 0);
INSERT INTO `sys_i18n` VALUES (1851491960106991617, 'systemMaintenance', '系统维护', 'zh', 1, 1, '2024-10-30 13:10:57', '2024-10-30 13:10:57', 0);
INSERT INTO `sys_i18n` VALUES (1851492000112263169, 'systemMaintenance', 'System maintenance', 'en', 1, 1, '2024-10-30 13:11:07', '2024-10-30 13:11:07', 0);
INSERT INTO `sys_i18n` VALUES (1851492027681423362, 'message', 'message', 'en', 1, 1, '2024-10-30 13:11:13', '2024-10-30 13:11:13', 0);
INSERT INTO `sys_i18n` VALUES (1851492057712640001, 'message', '消息', 'zh', 1, 1, '2024-10-30 13:13:10', '2024-10-30 13:11:20', 0);
INSERT INTO `sys_i18n` VALUES (1851492097386561537, 'messageType', '消息类型', 'zh', 1, 1, '2024-10-30 13:11:30', '2024-10-30 13:11:30', 0);
INSERT INTO `sys_i18n` VALUES (1851492131775660034, 'messageType', 'Message type', 'en', 1, 1, '2024-10-30 13:11:38', '2024-10-30 13:11:38', 0);
INSERT INTO `sys_i18n` VALUES (1851492181570437122, 'messageEditing', '消息编辑', 'zh', 1, 1, '2024-10-30 13:12:23', '2024-10-30 13:11:50', 0);
INSERT INTO `sys_i18n` VALUES (1851492279528407042, 'messageEditing', 'Message editing', 'en', 1, 1, '2024-10-30 13:12:13', '2024-10-30 13:12:13', 0);
INSERT INTO `sys_i18n` VALUES (1851494301438787586, 'messageName', '消息名称', 'zh', 1, 1, '2024-10-30 13:20:15', '2024-10-30 13:20:15', 0);
INSERT INTO `sys_i18n` VALUES (1851494334632509441, 'messageName', 'Message name', 'en', 1, 1, '2024-10-30 13:20:23', '2024-10-30 13:20:23', 0);
INSERT INTO `sys_i18n` VALUES (1851494378836279298, 'status', 'status', 'en', 1, 1, '2024-10-30 13:20:34', '2024-10-30 13:20:34', 0);
INSERT INTO `sys_i18n` VALUES (1851494407244300289, 'status', '状态', 'zh', 1, 1, '2024-10-30 13:20:40', '2024-10-30 13:20:40', 0);
INSERT INTO `sys_i18n` VALUES (1851494457517228034, 'summary', '简介', 'zh', 1, 1, '2024-10-30 13:20:52', '2024-10-30 13:20:52', 0);
INSERT INTO `sys_i18n` VALUES (1851494470104334337, 'summary', 'summary', 'en', 1, 1, '2024-10-30 13:20:55', '2024-10-30 13:20:55', 0);
INSERT INTO `sys_i18n` VALUES (1851495879549861890, 'messageManagement', '消息管理', 'zh', 1, 1, '2024-10-30 13:26:31', '2024-10-30 13:26:31', 0);
INSERT INTO `sys_i18n` VALUES (1851495907009970177, 'messageManagement', 'Message management', 'en', 1, 1, '2024-10-30 13:26:38', '2024-10-30 13:26:38', 0);
INSERT INTO `sys_i18n` VALUES (1851497115611250690, 'inputRuleMustBeEnglish', 'Must be in English', 'en', 1, 1, '2024-10-30 13:31:26', '2024-10-30 13:31:26', 0);
INSERT INTO `sys_i18n` VALUES (1851497146254835713, 'inputRuleMustBeEnglish', '必须是英文', 'zh', 1, 1, '2024-10-30 13:31:33', '2024-10-30 13:31:33', 0);
INSERT INTO `sys_i18n` VALUES (1851527530992570370, 'messageReceivingManagement', '消息接收管理', 'zh', 1, 1, '2024-10-30 15:32:18', '2024-10-30 15:32:18', 0);
INSERT INTO `sys_i18n` VALUES (1851527562919612418, 'messageReceivingManagement', 'Message receiving management', 'en', 1, 1, '2024-10-30 15:32:25', '2024-10-30 15:32:25', 0);
INSERT INTO `sys_i18n` VALUES (1851527646004580353, 'title', '标题', 'zh', 1, 1, '2024-10-30 15:32:45', '2024-10-30 15:32:45', 0);
INSERT INTO `sys_i18n` VALUES (1851527654917476354, 'title', 'title', 'en', 1, 1, '2024-10-30 15:32:47', '2024-10-30 15:32:47', 0);
INSERT INTO `sys_i18n` VALUES (1851527923755614209, 'receivedUserIds', '接收用户', 'zh', 1, 1, '2024-11-03 19:58:19', '2024-10-30 15:33:51', 0);
INSERT INTO `sys_i18n` VALUES (1851527955930120193, 'receivedUserIds', 'Receiving user', 'en', 1, 1, '2024-11-03 19:58:25', '2024-10-30 15:33:59', 0);
INSERT INTO `sys_i18n` VALUES (1851528262814748674, 'editorType', '编辑器类型', 'zh', 1, 1, '2024-10-30 15:35:12', '2024-10-30 15:35:12', 0);
INSERT INTO `sys_i18n` VALUES (1851528302648053762, 'editorType', 'Editor type', 'en', 1, 1, '2024-10-30 15:35:22', '2024-10-30 15:35:22', 0);
INSERT INTO `sys_i18n` VALUES (1851528373724729345, 'sendUserId', '发送用户', 'zh', 1, 1, '2024-10-30 15:35:39', '2024-10-30 15:35:39', 0);
INSERT INTO `sys_i18n` VALUES (1851528404821299201, 'sendUserId', 'Sending user', 'en', 1, 1, '2024-10-30 15:35:46', '2024-10-30 15:35:46', 0);
INSERT INTO `sys_i18n` VALUES (1851528474304139266, 'sendNickname', '发送人昵称', 'zh', 1, 1, '2024-10-30 22:59:27', '2024-10-30 15:36:03', 0);
INSERT INTO `sys_i18n` VALUES (1851528512757518337, 'sendNickname', 'Sender\'s nickname', 'en', 1, 1, '2024-10-30 22:59:30', '2024-10-30 15:36:12', 0);
INSERT INTO `sys_i18n` VALUES (1851528557150031873, 'content', 'content', 'en', 1, 1, '2024-10-30 15:36:22', '2024-10-30 15:36:22', 0);
INSERT INTO `sys_i18n` VALUES (1851528578150912002, 'content', '内容', 'zh', 1, 1, '2024-10-30 15:36:27', '2024-10-30 15:36:27', 0);
INSERT INTO `sys_i18n` VALUES (1851529217761300482, 'readAlready', '已读', 'zh', 1, 1, '2024-10-30 15:39:00', '2024-10-30 15:39:00', 0);
INSERT INTO `sys_i18n` VALUES (1851529229681512449, 'readAlready', 'Read already', 'en', 1, 1, '2024-10-30 15:39:03', '2024-10-30 15:39:03', 0);
INSERT INTO `sys_i18n` VALUES (1851529307041255425, 'unread', 'unread', 'en', 1, 1, '2024-10-30 15:39:21', '2024-10-30 15:39:21', 0);
INSERT INTO `sys_i18n` VALUES (1851529389513854977, 'unread', '未读', 'zh', 1, 1, '2024-10-30 15:39:41', '2024-10-30 15:39:41', 0);
INSERT INTO `sys_i18n` VALUES (1851541880478334978, 'markdown', 'Markdown', 'zh', 1, 1, '2024-10-30 16:30:02', '2024-10-30 16:29:19', 0);
INSERT INTO `sys_i18n` VALUES (1851541892528570369, 'markdown', 'markdown', 'en', 1, 1, '2024-10-30 16:29:22', '2024-10-30 16:29:22', 0);
INSERT INTO `sys_i18n` VALUES (1851541925034426369, 'richText', 'rich Text', 'en', 1, 1, '2024-10-30 16:29:30', '2024-10-30 16:29:30', 0);
INSERT INTO `sys_i18n` VALUES (1851541959117340674, 'richText', '富文本', 'zh', 1, 1, '2024-10-30 16:29:38', '2024-10-30 16:29:38', 0);
INSERT INTO `sys_i18n` VALUES (1851542964726890497, 'notifyAll', '通知全部', 'zh', 1, 1, '2024-10-30 16:33:37', '2024-10-30 16:33:37', 0);
INSERT INTO `sys_i18n` VALUES (1851543006175002625, 'notifyAll', 'Notify all', 'en', 1, 1, '2024-10-30 16:33:47', '2024-10-30 16:33:47', 0);
INSERT INTO `sys_i18n` VALUES (1851543703914250242, 'receivedUserIdTip', '不填表示通知全部', 'zh', 1, 1, '2024-10-30 16:36:34', '2024-10-30 16:36:34', 0);
INSERT INTO `sys_i18n` VALUES (1851543737414156289, 'receivedUserIdTip', 'Not filling in means full notice', 'en', 1, 1, '2024-10-30 16:36:42', '2024-10-30 16:36:42', 0);
INSERT INTO `sys_i18n` VALUES (1851547966476341249, 'all', 'all', 'en', 1, 1, '2024-10-30 16:53:30', '2024-10-30 16:53:30', 0);
INSERT INTO `sys_i18n` VALUES (1851547989595344898, 'all', '全部', 'zh', 1, 1, '2024-10-30 16:53:35', '2024-10-30 16:53:35', 0);
INSERT INTO `sys_i18n` VALUES (1851650770400485377, 'portion', 'portion', 'en', 1, 1, '2024-10-30 23:42:00', '2024-10-30 23:42:00', 0);
INSERT INTO `sys_i18n` VALUES (1851650831280807937, 'portion', '部分', 'zh', 1, 1, '2024-10-30 23:42:15', '2024-10-30 23:42:15', 0);
INSERT INTO `sys_i18n` VALUES (1851853259248640001, 'submit', '提交', 'zh', 1, 1, '2024-10-31 13:06:37', '2024-10-31 13:06:37', 0);
INSERT INTO `sys_i18n` VALUES (1851853271131103233, 'submit', 'submit', 'en', 1, 1, '2024-10-31 13:06:40', '2024-10-31 13:06:40', 0);
INSERT INTO `sys_i18n` VALUES (1851855115702116354, 'isRead', '是否已读', 'zh', 1, 1, '2024-10-31 13:14:00', '2024-10-31 13:14:00', 0);
INSERT INTO `sys_i18n` VALUES (1851855140209434626, 'isRead', 'Yes or no read', 'en', 1, 1, '2024-10-31 13:14:06', '2024-10-31 13:14:06', 0);
INSERT INTO `sys_i18n` VALUES (1851883424527818753, 'contentTooShortTip', '内容不能少于30字', 'zh', 1, 1, '2024-10-31 15:06:29', '2024-10-31 15:06:29', 0);
INSERT INTO `sys_i18n` VALUES (1851883450444423170, 'contentTooShortTip', 'It should not be less than 30 words', 'en', 1, 1, '2024-10-31 15:06:36', '2024-10-31 15:06:36', 0);
INSERT INTO `sys_i18n` VALUES (1851907457675939841, 'status.systemMessage', '系统消息', 'zh', 1, 1, '2024-10-31 16:41:59', '2024-10-31 16:41:59', 0);
INSERT INTO `sys_i18n` VALUES (1851907489737199617, 'status.systemMessage', 'System messages', 'en', 1, 1, '2024-10-31 16:42:07', '2024-10-31 16:42:07', 0);
INSERT INTO `sys_i18n` VALUES (1851988026428567553, 'cover', '封面', 'zh', 1, 1, '2024-10-31 22:02:08', '2024-10-31 22:02:08', 0);
INSERT INTO `sys_i18n` VALUES (1851988034808786945, 'cover', 'cover', 'en', 1, 1, '2024-10-31 22:02:10', '2024-10-31 22:02:10', 0);
INSERT INTO `sys_i18n` VALUES (1852361464670449665, 'level', '消息等级', 'zh', 1, 1, '2024-11-01 22:46:03', '2024-11-01 22:46:03', 0);
INSERT INTO `sys_i18n` VALUES (1852361496383582209, 'level', 'Message level', 'en', 1, 1, '2024-11-01 22:46:11', '2024-11-01 22:46:11', 0);
INSERT INTO `sys_i18n` VALUES (1852361567787413505, 'extra', '消息简介', 'zh', 1, 1, '2024-11-01 22:46:28', '2024-11-01 22:46:28', 0);
INSERT INTO `sys_i18n` VALUES (1852361590180802561, 'extra', 'Message Introduction', 'en', 1, 1, '2024-11-01 22:46:33', '2024-11-01 22:46:33', 0);
INSERT INTO `sys_i18n` VALUES (1852361618530103298, 'warning', 'warning', 'en', 1, 1, '2024-11-01 22:46:40', '2024-11-01 22:46:40', 0);
INSERT INTO `sys_i18n` VALUES (1852361651090485249, 'warning', '警告', 'zh', 1, 1, '2024-11-01 22:46:47', '2024-11-01 22:46:47', 0);
INSERT INTO `sys_i18n` VALUES (1852361722246852610, 'info', '信息', 'zh', 1, 1, '2024-11-01 22:47:04', '2024-11-01 22:47:04', 0);
INSERT INTO `sys_i18n` VALUES (1852361733844103170, 'info', 'info', 'en', 1, 1, '2024-11-01 22:47:07', '2024-11-01 22:47:07', 0);
INSERT INTO `sys_i18n` VALUES (1852361749279141889, 'success', 'success', 'en', 1, 1, '2024-11-01 22:47:11', '2024-11-01 22:47:11', 0);
INSERT INTO `sys_i18n` VALUES (1852361765678870529, 'success', '成功', 'zh', 1, 1, '2024-11-01 22:47:15', '2024-11-01 22:47:15', 0);
INSERT INTO `sys_i18n` VALUES (1852361790999883778, 'primary', '默认', 'zh', 1, 1, '2024-11-01 22:47:21', '2024-11-01 22:47:21', 0);
INSERT INTO `sys_i18n` VALUES (1852361805264711681, 'primary', 'primary', 'en', 1, 1, '2024-11-01 22:47:24', '2024-11-01 22:47:24', 0);
INSERT INTO `sys_i18n` VALUES (1852361819751837698, 'danger', 'danger', 'en', 1, 1, '2024-11-01 22:47:28', '2024-11-01 22:47:28', 0);
INSERT INTO `sys_i18n` VALUES (1852361840417173506, 'danger', '危险', 'zh', 1, 1, '2024-11-01 22:47:33', '2024-11-01 22:47:33', 0);
INSERT INTO `sys_i18n` VALUES (1852361927209906177, 'systemManagement', '系统管理', 'zh', 1, 1, '2024-11-01 22:47:53', '2024-11-01 22:47:53', 0);
INSERT INTO `sys_i18n` VALUES (1852361962697912321, 'systemManagement', 'System administration', 'en', 1, 1, '2024-11-01 22:48:02', '2024-11-01 22:48:02', 0);
INSERT INTO `sys_i18n` VALUES (1852362015051214849, 'logManagement', '日志管理', 'zh', 1, 1, '2024-11-01 22:48:14', '2024-11-01 22:48:14', 0);
INSERT INTO `sys_i18n` VALUES (1852362023934750722, 'logManagement', 'Log management', 'en', 1, 1, '2024-11-01 22:48:16', '2024-11-01 22:48:16', 0);
INSERT INTO `sys_i18n` VALUES (1852364306420461569, 'markAsRead', '标为已读', 'zh', 1, 1, '2024-11-01 22:57:21', '2024-11-01 22:57:21', 0);
INSERT INTO `sys_i18n` VALUES (1852364324300779522, 'markAsRead', 'Mark as read', 'en', 1, 1, '2024-11-01 22:57:25', '2024-11-01 22:57:25', 0);
INSERT INTO `sys_i18n` VALUES (1852364394765086721, 'allMarkAsRead', 'All are marked as read', 'en', 1, 1, '2024-11-01 22:57:42', '2024-11-01 22:57:42', 0);
INSERT INTO `sys_i18n` VALUES (1852364418441932802, 'allMarkAsRead', '全部标为已读', 'zh', 1, 1, '2024-11-01 22:57:47', '2024-11-01 22:57:47', 0);
INSERT INTO `sys_i18n` VALUES (1852390523211198465, 'table.acceptanceTime', '接收时间', 'zh', 1, 1, '2024-11-02 00:41:31', '2024-11-02 00:41:31', 0);
INSERT INTO `sys_i18n` VALUES (1852390547722711042, 'table.acceptanceTime', 'Time of reception', 'en', 1, 1, '2024-11-02 00:41:37', '2024-11-02 00:41:37', 0);
INSERT INTO `sys_i18n` VALUES (1852757728830517250, 'receivedUserNickname', '收信人昵称', 'zh', 1, 1, '2024-11-03 01:00:40', '2024-11-03 01:00:40', 0);
INSERT INTO `sys_i18n` VALUES (1852757760694644738, 'receivedUserNickname', 'The recipient\'s nickname', 'en', 1, 1, '2024-11-03 01:00:47', '2024-11-03 01:00:47', 0);
INSERT INTO `sys_i18n` VALUES (1853083669255512066, 'messageSendManagement', '消息发送管理', 'zh', 1, 1, '2024-11-03 22:35:50', '2024-11-03 22:35:50', 0);
INSERT INTO `sys_i18n` VALUES (1853083699110567937, 'messageSendManagement', 'Message sending management', 'en', 1, 1, '2024-11-03 22:35:57', '2024-11-03 22:35:57', 0);
INSERT INTO `sys_i18n` VALUES (1853113898342653954, 'markAsUnread', '标为未读', 'zh', 1, 1, '2024-11-04 00:35:57', '2024-11-04 00:35:57', 0);
INSERT INTO `sys_i18n` VALUES (1853113928394842113, 'markAsUnread', 'Mark as unread', 'en', 1, 1, '2024-11-04 00:36:04', '2024-11-04 00:36:04', 0);
INSERT INTO `sys_i18n` VALUES (1853127712534519810, 'deleteBatches', '批量删除', 'zh', 1, 1, '2024-11-04 01:32:24', '2024-11-04 01:30:51', 0);
INSERT INTO `sys_i18n` VALUES (1853127795963420674, 'deleteBatches', 'Bulk deletion', 'en', 1, 1, '2024-11-04 01:32:26', '2024-11-04 01:31:11', 0);
INSERT INTO `sys_i18n` VALUES (1853466635869700097, 'userPassword', '用户的密码', 'zh', 1, 1, '2024-11-04 23:57:36', '2024-11-04 23:57:36', 0);
INSERT INTO `sys_i18n` VALUES (1853466663711490049, 'userPassword', 'user\'s password', 'en', 1, 1, '2024-11-04 23:57:43', '2024-11-04 23:57:43', 0);
INSERT INTO `sys_i18n` VALUES (1853466873653182466, 'for', '为', 'zh', 1, 1, '2024-11-04 23:58:33', '2024-11-04 23:58:33', 0);
INSERT INTO `sys_i18n` VALUES (1853466889734144001, 'for', 'for', 'en', 1, 1, '2024-11-04 23:58:37', '2024-11-04 23:58:37', 0);
INSERT INTO `sys_i18n` VALUES (1853467508360429570, 'menu', '菜单', 'zh', 1, 1, '2024-11-05 00:01:04', '2024-11-05 00:01:04', 0);
INSERT INTO `sys_i18n` VALUES (1853467519102042114, 'menu', 'menu', 'en', 1, 1, '2024-11-05 00:01:07', '2024-11-05 00:01:07', 0);
INSERT INTO `sys_i18n` VALUES (1853467640455839746, 'externalLink', '外链', 'zh', 1, 1, '2024-11-05 00:01:36', '2024-11-05 00:01:36', 0);
INSERT INTO `sys_i18n` VALUES (1853467661154729985, 'externalLink', 'External link', 'en', 1, 1, '2024-11-05 00:01:41', '2024-11-05 00:01:41', 0);
INSERT INTO `sys_i18n` VALUES (1853467803857534978, 'menuName', '菜单名称', 'zh', 1, 1, '2024-11-05 00:02:15', '2024-11-05 00:02:15', 0);
INSERT INTO `sys_i18n` VALUES (1853467829300183041, 'menuName', 'Menu name', 'en', 1, 1, '2024-11-05 00:02:21', '2024-11-05 00:02:21', 0);
INSERT INTO `sys_i18n` VALUES (1853467938486304769, 'menuType', '菜单类型', 'zh', 1, 1, '2024-11-05 00:02:47', '2024-11-05 00:02:47', 0);
INSERT INTO `sys_i18n` VALUES (1853467968857260033, 'menuType', 'Menu type', 'en', 1, 1, '2024-11-05 00:02:54', '2024-11-05 00:02:54', 0);
INSERT INTO `sys_i18n` VALUES (1853468044291817474, 'path', '路由路径', 'zh', 1, 1, '2024-11-05 00:03:12', '2024-11-05 00:03:12', 0);
INSERT INTO `sys_i18n` VALUES (1853468126722473986, 'routerPath', 'Routing path', 'en', 1, 1, '2024-11-05 00:03:32', '2024-11-05 00:03:32', 0);
INSERT INTO `sys_i18n` VALUES (1853468153557630977, 'routerPath', '路由路径', 'zh', 1, 1, '2024-11-05 00:03:38', '2024-11-05 00:03:38', 0);
INSERT INTO `sys_i18n` VALUES (1853468276027113474, 'componentPath', '组件路径', 'zh', 1, 1, '2024-11-05 00:04:07', '2024-11-05 00:04:07', 0);
INSERT INTO `sys_i18n` VALUES (1853468291839639553, 'componentPath', 'Component path', 'en', 1, 1, '2024-11-05 00:04:11', '2024-11-05 00:04:11', 0);
INSERT INTO `sys_i18n` VALUES (1853468393769615362, 'sort', '排序', 'zh', 1, 1, '2024-11-05 00:04:36', '2024-11-05 00:04:36', 0);
INSERT INTO `sys_i18n` VALUES (1853468404729331713, 'sort', 'sort', 'en', 1, 1, '2024-11-05 00:04:38', '2024-11-05 00:04:38', 0);
INSERT INTO `sys_i18n` VALUES (1853468489982754818, 'visible', '隐藏', 'zh', 1, 1, '2024-11-05 00:04:58', '2024-11-05 00:04:58', 0);
INSERT INTO `sys_i18n` VALUES (1853468505661063169, 'visible', 'visible', 'en', 1, 1, '2024-11-05 00:05:02', '2024-11-05 00:05:02', 0);
INSERT INTO `sys_i18n` VALUES (1853468649345335298, 'menuNameTip', '菜单名称为必填项', 'zh', 1, 1, '2024-11-05 00:05:36', '2024-11-05 00:05:36', 0);
INSERT INTO `sys_i18n` VALUES (1853468672053297154, 'menuNameTip', 'The menu name is mandatory', 'en', 1, 1, '2024-11-05 00:05:42', '2024-11-05 00:05:42', 0);
INSERT INTO `sys_i18n` VALUES (1853468775853932546, 'routerNameTip', '路由名称为必填项', 'zh', 1, 1, '2024-11-05 00:06:07', '2024-11-05 00:06:07', 0);
INSERT INTO `sys_i18n` VALUES (1853468808808579074, 'routerNameTip', 'The route name is mandatory', 'en', 1, 1, '2024-11-05 00:06:14', '2024-11-05 00:06:14', 0);
INSERT INTO `sys_i18n` VALUES (1853469015663263746, 'routerPathTip', '路由路径为必填项且为\"/\"开头', 'zh', 1, 1, '2024-11-05 00:07:04', '2024-11-05 00:07:04', 0);
INSERT INTO `sys_i18n` VALUES (1853469047363813377, 'routerPathTip', 'The route path is mandatory and starts with a slash', 'en', 1, 1, '2024-11-05 00:07:11', '2024-11-05 00:07:11', 0);
INSERT INTO `sys_i18n` VALUES (1853469506262614017, 'update', '更新', 'zh', 1, 1, '2024-11-05 00:09:01', '2024-11-05 00:09:01', 0);
INSERT INTO `sys_i18n` VALUES (1853469520422584321, 'update', 'update', 'en', 1, 1, '2024-11-05 00:09:04', '2024-11-05 00:09:04', 0);
INSERT INTO `sys_i18n` VALUES (1853470034904301569, 'previousMenu', '上级菜单', 'zh', 1, 1, '2024-11-05 00:11:07', '2024-11-05 00:11:07', 0);
INSERT INTO `sys_i18n` VALUES (1853470072325881858, 'previousMenu', 'previous menu', 'en', 1, 1, '2024-11-05 00:11:16', '2024-11-05 00:11:16', 0);
INSERT INTO `sys_i18n` VALUES (1853470365352542209, 'routerName', '路由名称', 'zh', 1, 1, '2024-11-05 00:12:26', '2024-11-05 00:12:26', 0);
INSERT INTO `sys_i18n` VALUES (1853470446734622721, 'routerName', 'Route name', 'en', 1, 1, '2024-11-05 00:12:45', '2024-11-05 00:12:45', 0);
INSERT INTO `sys_i18n` VALUES (1853471662109704193, 'index', '序号', 'zh', 1, 1, '2024-11-05 00:17:35', '2024-11-05 00:17:35', 0);
INSERT INTO `sys_i18n` VALUES (1853471674294157314, 'index', 'index', 'en', 1, 1, '2024-11-05 00:17:38', '2024-11-05 00:17:38', 0);
INSERT INTO `sys_i18n` VALUES (1917143695099785217, 'download_excel', '下载Excel', 'zh', 1, 1, '2025-04-29 17:07:30', '2025-04-29 17:07:30', 0);
INSERT INTO `sys_i18n` VALUES (1917143727949574145, 'download_excel', 'Download Excel', 'en', 1, 1, '2025-04-29 17:07:38', '2025-04-29 17:07:38', 0);
INSERT INTO `sys_i18n` VALUES (1917143780537757698, 'use_json_update', 'Use Json Update', 'en', 1, 1, '2025-04-29 17:07:51', '2025-04-29 17:07:51', 0);
INSERT INTO `sys_i18n` VALUES (1917143819595116546, 'use_json_update', '使用JSON更新', 'zh', 1, 1, '2025-04-29 17:08:00', '2025-04-29 17:08:00', 0);
INSERT INTO `sys_i18n` VALUES (1917143856072978433, 'file_import', '文件导入', 'zh', 1, 1, '2025-04-29 17:08:09', '2025-04-29 17:08:09', 0);
INSERT INTO `sys_i18n` VALUES (1917143907268653058, 'file_import', 'FIle Import', 'en', 1, 1, '2025-04-29 17:08:21', '2025-04-29 17:08:21', 0);
INSERT INTO `sys_i18n` VALUES (1917143998033391618, 'download_configuration', '下载配置', 'zh', 1, 1, '2025-04-29 17:08:43', '2025-04-29 17:08:43', 0);
INSERT INTO `sys_i18n` VALUES (1917144046456631298, 'download_configuration', 'Download Configuration', 'en', 1, 1, '2025-04-29 17:08:54', '2025-04-29 17:08:54', 0);
INSERT INTO `sys_i18n` VALUES (1917144132137873410, 'use_excel_update', '使用Excel更新', 'zh', 1, 1, '2025-04-29 17:09:15', '2025-04-29 17:09:15', 0);
INSERT INTO `sys_i18n` VALUES (1917144165214154754, 'use_excel_update', 'Use Excel Update', 'en', 1, 1, '2025-04-29 17:09:22', '2025-04-29 17:09:22', 0);
INSERT INTO `sys_i18n` VALUES (1917144211540242434, 'download_json', '下载JSON', 'zh', 1, 1, '2025-04-29 17:09:34', '2025-04-29 17:09:34', 0);
INSERT INTO `sys_i18n` VALUES (1917144244520054786, 'download_json', 'Download JSON', 'en', 1, 1, '2025-04-29 17:09:41', '2025-04-29 17:09:41', 0);
INSERT INTO `sys_i18n` VALUES (1917144445657903105, 'update_tip', '更新时确保数据备份，以免丢失', 'zh', 1, 1, '2025-04-29 17:10:29', '2025-04-29 17:10:29', 0);
INSERT INTO `sys_i18n` VALUES (1917144490054610946, 'update_tip', 'Make sure your data is backed up when updating to avoid loss', 'en', 1, 1, '2025-04-29 17:10:40', '2025-04-29 17:10:40', 0);
INSERT INTO `sys_i18n` VALUES (1917147541561765890, 'requestMethod', '请求方法', 'zh', 1, 1, '2025-04-29 17:22:47', '2025-04-29 17:22:47', 0);
INSERT INTO `sys_i18n` VALUES (1917147595525681153, 'requestMethod', 'Request Method', 'en', 1, 1, '2025-04-29 17:23:00', '2025-04-29 17:23:00', 0);

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
INSERT INTO `sys_i18n_type` VALUES (1917141005942747137, '韩语', 'hy', 0, 1, 1, '2025-04-29 16:56:49', '2025-04-29 16:56:49', 0);

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
INSERT INTO `sys_message_received` VALUES (1873378732309319681, 1, 1873378732024107009, 1, '2024-12-29 22:41:10', '2025-04-29 17:22:10', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1873378732321902593, 1849444494908125181, 1873378732024107009, 0, '2024-12-29 22:41:10', '2025-04-29 15:04:51', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1873378732326096897, 1849681227633758210, 1873378732024107009, 0, '2024-12-29 22:41:10', '2025-04-29 15:04:51', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1873378732326096898, 1850075157831454722, 1873378732024107009, 0, '2024-12-29 22:41:10', '2025-04-29 15:04:51', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1873378732330291202, 1850080272764211202, 1873378732024107009, 0, '2024-12-29 22:41:10', '2025-04-29 15:04:51', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1873378732330291203, 1850789068551200769, 1873378732024107009, 0, '2024-12-29 22:41:10', '2025-04-29 15:04:51', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1877006536917749761, 1, 1877006536699645953, 1, '2025-01-08 22:56:46', '2025-04-29 17:22:23', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1877006536921944066, 1849444494908125181, 1877006536699645953, 0, '2025-01-08 22:56:46', '2025-04-29 15:04:51', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1877006536926138370, 1849681227633758210, 1877006536699645953, 0, '2025-01-08 22:56:46', '2025-04-29 15:04:51', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1877006536930332673, 1850075157831454722, 1877006536699645953, 0, '2025-01-08 22:56:46', '2025-04-29 15:04:51', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1877006536930332674, 1850080272764211202, 1877006536699645953, 0, '2025-01-08 22:56:46', '2025-04-29 15:04:51', 1, 1, 0);
INSERT INTO `sys_message_received` VALUES (1877006536934526977, 1850789068551200769, 1877006536699645953, 0, '2025-01-08 22:56:46', '2025-04-29 15:04:51', 1, 1, 0);

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
INSERT INTO `sys_user` VALUES (1, 'Administrator', 'Administrator', 'admin@qq.com', '123456789', '$2a$10$h5BUwmMaVcEuu7Bz0TPPy.PQV8JP6CFJlbHTgT78G1s0YPIu2kfXe', '/auth-admin/avatar/2025/04-29/b85d8959-48d8-44f7-9e0f-bdaca8b1bea4', 1, 'admin 1', '127.0.0.1', '内网IP', 0, '2024-10-24 21:35:03', '2025-04-29 17:51:32', 1, NULL, 0);
INSERT INTO `sys_user` VALUES (1849444494908125181, 'bunny', 'bunny', '1319900154@qq.com', '18012062876', '$2a$10$h5BUwmMaVcEuu7Bz0TPPy.PQV8JP6CFJlbHTgT78G1s0YPIu2kfXe', '/auth-admin/avatar/2025/01-17/b3aba651-bfb1-45dd-a470-0bcaad26f6ef', 1, '搜索', '127.0.0.1', '内网IP', 0, '2024-09-26 14:29:33', NULL, 0, NULL, 0);
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
