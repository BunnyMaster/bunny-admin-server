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
