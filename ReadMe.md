# 搭建后端运行环境

1. 需要JDK17
2. MySQL
3. Redis
4. Minion

## 下载JDK17

不喜欢JDK17可以自己将版本修改

官网：https://www.oracle.com/java/technologies/javase/jdk17-archive-downloads.html

## 搭建MySQL

使用docker，开发环境端口号为3304，生产环境为3306
数据使用不区分大小写，因为涉及到quartz，但是quartz默认数据库名称包括表名都是大写的，我不喜欢，所以就设置了此项。

### 生产环境MySQL搭建

- 将之前的MySQL移除，名称为master【确保你的master没有或者不重要，以防不小心删除重要数据】

```shell
docker stop master
docker rm master

docker run --name master -p 3306:3306 \
-v /bunny/docker_data/mysql/master/etc/my.cnf:/etc/my.cnf \
-v /bunny/docker_data/mysql/master/data:/var/lib/mysql \
--restart=always --privileged=true \
   -e MYSQL_ROOT_PASSWORD=02120212 \
   -e TZ=Asia/Shanghai \
   mysql:8.0.33 --lower-case-table-names=1
```

### 开发环境搭建

```shell
docker stop slave_3304
docker rm slave_3304

docker run --name slave_3304 -p 3304:3306 \
   -v /bunny/docker_data/mysql/slave_3304/etc/my.cnf:/etc/my.cnf \
   -v /bunny/docker_data/mysql/slave_3304/data:/var/lib/mysql \
   --restart=always --privileged=true \
   -e MYSQL_ROOT_PASSWORD=02120212 \
   -e TZ=Asia/Shanghai \
   mysql:8.0.33 --lower-case-table-names=1
```

### 修改密码

 ```shell
docker exec -it mysql_master /bin/bash
mysql -uroot -p02120212
use mysql
ALTER USER 'root'@'%' IDENTIFIED BY "02120212";
FLUSH PRIVILEGES;
 ```

### my.cnf 配置

```shell
[mysqld]
datadir=/var/lib/mysql
socket=/var/lib/mysql/mysql.sock
skip-host-cache
skip-name-resolve
secure-file-priv=/var/lib/mysql-files

# 设置字符集
character-set-server=utf8mb4
collation-server=utf8mb4_unicode_ci

# 设置服务器ID（如果是复制集群，确保每个节点的ID唯一）
server-id=1

# 启用二进制日志
log-bin=mysql-bin

# 设置表名不区分大小写
lower_case_table_names = 1

[client]
socket=/var/run/mysqld/mysqld.sock
```

## 安装Redis

### 配置文件

```
daemonize no 
requirepass 123456
appendonly yes
tcp-keepalive 300
```

### 运行Redis

```shell
docker pull redis:7.0.10
docker run -p 6379:6379 --name redis_master \
-v /bunny/docker_data/redis_master/redis.conf:/etc/redis/redis.conf \
-v/bunny/docker_data/redis_master/data:/data \
--restart=always -d redis:7.0.10  --appendonly yes
```

## 安装Minio

```sh
docker run -d \
  -p 9000:9000 \
  -p 9090:9090 \
  --name minio_master --restart=always \
  -v /bunny/docker/minio/data:/data \
  -e "MINIO_ROOT_USER=bunny" \
  -e "MINIO_ROOT_PASSWORD=02120212" \
  minio/minio server /data --console-address ":9090"
```

# Quartz 方法

## TriggerBuilder

`TriggerBuilder` 是一个用于构建 `Trigger` 实例的类。它提供了一系列方法来设置触发器的各种属性。以下是一些常用的方法：

1. `withIdentity(String name, String group)` 或 `withIdentity(TriggerKey triggerKey)`：设置触发器的名称和组名。

2. `startAt(Date startTime)`：设置触发器首次触发的时间。

3. `endAt(Date endTime)`：设置触发器最后一次触发的时间。

4. `withSchedule(ScheduleBuilder scheduleBuilder)`：设置触发器的调度计划，可以是简单重复、按日历重复等。

5. `forJob(JobKey jobKey)` 或 `forJob(String jobName, String jobGroup)`：指定触发器关联的作业（Job）。

6. `usingJobData(String key, String value)`：为触发器添加自定义数据。

7. `modifiedByCalendar(String calName)`：指定一个日历，用于修改触发器的触发时间。

8. `build()`：构建并返回最终的 `Trigger` 实例。

9. `withDescription(String description)`：为触发器设置描述信息。

10. `usingJobData(JobDataMap jobData)`：使用 `JobDataMap` 为触发器设置多个作业数据。

11. `withPriority(int priority)`：设置触发器的优先级。

12. `replaceTriggerKey(TriggerKey oldKey, TriggerKey newKey)`：替换触发器的键值。

## JobBuilder

`JobBuilder` 类用于构建 `JobDetail` 实例，它定义了要执行的作业（Job）的属性。以下是一些常用的方法：

1. `withIdentity(String name, String group)` 或 `withIdentity(JobKey jobKey)`：设置作业的名称和组名。

2. `storeDurably()`：当作业没有触发器时，仍然允许作业被存储。这对于持久作业（即不被触发器触发，但可以手动调度的作业）很有用。

3. `requestRecovery()`：指示Quartz在作业执行失败或调度器重启时尝试恢复作业。

4. `usingJobData(JobDataMap jobData)`：为作业添加自定义数据。

5. `usingJobData(String key, String value)`：为作业添加单个自定义数据。

6. `ofType(Class<? extends Job> jobClass)`：指定作业的类型（实现 `Job` 接口的类）。

7. `build()`：构建并返回最终的 `JobDetail` 实例。

8. `withDescription(String description)`：为作业设置描述信息。

9. `usingJobData(JobDataMap jobData, boolean merge)`：添加自定义数据，并指定是否与现有的 `JobDataMap` 合并。

10. `build()`：构建并返回最终的 `JobDetail` 实例。

# 展望未来

## 定时任务加入

数据备份：根据数据的重要性和变化频率，定时备份数据库或文件系统。例如，每晚备份数据库，或者在数据变更达到一定量后触发备份。

系统维护：包括软件更新、系统清理、磁盘碎片整理等，这些任务可能在系统负载较低的时段执行。

监控报告：定时生成系统或网络的使用报告、性能报告等，用于分析和审计。

内容更新：对于网站或应用，定时更新内容，如新闻网站定时更新新闻，天气应用定时更新天气信息。

缓存清理：定期清理缓存文件，以释放存储空间和提高系统性能。

日志轮转：自动归档和压缩旧的日志文件，以便于管理和分析。

邮件发送：定时发送邮件，如账单、通知、营销邮件等。

资源调度：在云计算环境中，根据需求动态调整资源分配，如自动扩展或缩减服务器实例。

数据同步：在多个系统或数据库之间定时同步数据，保持数据一致性。

安全扫描：定期执行安全扫描，检测系统漏洞或异常行为。

任务调度：在工作流管理系统中，根据预设的规则和条件动态触发任务。

库存管理：在电子商务或仓库管理中，定时检查库存水平，自动触发补货或调整价格。

广告轮播：在广告系统中，定时更换展示的广告内容。

用户行为分析：定时收集和分析用户行为数据，用于改进产品或服务。

健康检查：对关键系统组件进行定时健康检查，确保系统稳定运行。