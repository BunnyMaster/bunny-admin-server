FROM openjdk:21
MAINTAINER bunny

#系统编码
ENV LANG=C.UTF-8 LC_ALL=C.UTF-8

# 设置时区，构建镜像时执行的命令
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone

# 设定工作目录
WORKDIR /home/bunny

# 复制jar包
COPY target/*.jar /home/bunny/app.jar

#启动容器时的进程
ENTRYPOINT ["java","-jar","/home/bunny/app.jar"]

#暴露 8800 端口
EXPOSE 7070

# mvn clean package -Pprod  -DskipTests