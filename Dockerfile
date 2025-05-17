FROM openjdk:24-ea-17-jdk-oraclelinux9
LABEL maintainer="server"

#系统编码
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# 设置时区，构建镜像时执行的命令
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone

# 设定工作目录
WORKDIR /home/server

# 复制jar包
COPY target/*.jar /home/server/app.jar

# 程序内部挂在目录
VOLUME /usr/bin/docker
VOLUME ["/var/run/docker.sock"]
VOLUME /etc/docker/daemon.json
VOLUME ["/www/root/backup"]
VOLUME ["/www/root/server"]

# 启动容器时的进程
ENTRYPOINT ["java","-jar","/home/server/app.jar"]

#暴露 8000 端口
EXPOSE 8000
EXPOSE 7070

# 生产环境
# mvn clean package -Pprod -DskipTests

# 测试环境
# mvn clean package -Ptest -DskipTests

