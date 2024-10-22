# 接口说明

## 请求接口

请求接口都是`/admin`前缀，部分接口会被忽略，忽略接口看下面。

所有分页请求内容都是通过路径传参方式

请求时需要带有token，只要前端在请求头中添加`token:内容`即可

采用SpringSecurity验证

## 接口忽略

### SpringSecurity接口忽略

这是相关拦截请求内容，如果要访问接口必须携带token，但是有些接口是不需要token的，不需要token就配置在这里。但是放在这里后，如果用户请求的地址是被忽略的，那么也就拿不到token也就拿不到登录相关信息。

获取用户自身的登录请求是不需要携带用户Id，只要有token去解析即可。

```java
// 排出鉴定路径
@Bean
public WebSecurityCustomizer webSecurityCustomizer() {
    String[] annotations = {
            "/", "/ws/**",
            "/*/*/noAuth/**", "/*/noAuth/**", "/noAuth/**",
            "/media.ico", "/favicon.ico", "*.html", "/webjars/**", "/v3/api-docs/**", "swagger-ui/**",
            "/*/files/**",
            "/error", "/*/i18n/getI18n",
    };
    return web -> web.ignoring().requestMatchers(annotations)
            .requestMatchers(RegexRequestMatcher.regexMatcher(".*\\.(css|js)$"));
}
```

![image-20241022095731221](./data/images/image-20241022095731221.png)

有些会被忽略的接口，凡是带有`noAuth`都是不需要验证的，但是要注意一点，不需要验证但是后端需要拿到登录相关信息是拿不到的。

![image-20241022095311658](./data/images/image-20241022095311658.png)

我是将用户相关请求使用SpringSecurity进行拦截，如果有相关匹配路径那么就会被拦截，此时接口参数中会带有token内容，拿到token进行解析，之后取出相关用户信息，比如用户Id、username等。

将这些信息拿出来后放到ThreadLocal中，存储在线程中，如果微服务中需要需要放在请求头中，因为微服务不在同一个线程中。这个操作适合单体或者是微服务中不需要请求其它微服务的方式。

![image-20241022095641040](./data/images/image-20241022095641040.png)

### 不需要管理接口

请求是会有不需要登录就能访问的接口，也需要不要被管理的接口

## 验证码验证忽略

为了公网上的展示，如果需要获取验证码比较的麻烦，如果你的需求和我一样那么可以在这里放开这些注释

![image-20241022100317018](./data/images/image-20241022100317018.png)

# 搭建后端环境

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
   -v /bunny/docker_data/mysql/slave_3304/backup:\
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
skip-host-cache
skip-name-resolve
secure-file-priv=/var/lib/mysql-files
user=mysql

# 设置字符集
character-set-server=utf8mb4
collation-server=utf8mb4_unicode_ci

# 设置服务器ID（如果是复制集群，确保每个节点的ID唯一）
server-id=1

# 启用二进制日志
log-bin=mysql-bin

# 设置表名不区分大小写
lower_case_table_names = 1
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

# 动态定时任务

使用`Quartz `数据存储在数据库中持久化存储.

所有的Quartz内容都放在这个目录中，因为前端需要知道有哪些定时任务，这时候又不能将数据添加到数据库中，如果以后需要更多的定时任务那么需要再数据库中添加，这样做很麻烦。

我们可以通过反射只要约定好内容，通过反射扫描的方式来获取这些可以使用的定时任务，反射的注解是这个：`@QuartzSchedulers(type = "test", description = "JobHello任务内容")`

![image-20241022101534393](./data/images/image-20241022101534393.png)

## 注解说明

扫描注解包，可以通过依赖注入的方式使用

![image-20241022102210149](./data/images/image-20241022102210149.png)

类型注解存放位置在下面。

![image-20241022101742586](./data/images/image-20241022101742586.png)

获取所有可用定时任务

![image-20241022102510646](data/images/image-20241022102510646.png)

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
