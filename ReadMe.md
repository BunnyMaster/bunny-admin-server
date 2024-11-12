# 感谢

项目由[小铭](https://github.com/xiaoxian521)开源权限模板[Pure-admin](https://pure-admin.github.io/vue-pure-admin/)

Pure-admin文档：https://pure-admin.github.io/pure-admin-doc

项目整体都由此模板开发

# 项目预览

**线上地址**

- 正式线上预览地址：http://bunny-web.site/#/welcome

  - 线上地址目前使用的是90天的SSL证书，可能会提示链接不安全，忽略就好了

- 测试预览地址：http://106.15.251.123/#/welcome
  - 服务器到期时间：12月30日

**打包视频**

https://www.bilibili.com/video/BV1AYm8YSEKY/

**Github地址**

- [前端地址](https://github.com/BunnyMaster/bunny-admin-web.git)
- [后端地址](https://github.com/BunnyMaster/bunny-admin-server)

**Gitee地址**

- [前端地址](https://gitee.com/BunnyBoss/bunny-admin-web)
- [后端地址](https://gitee.com/BunnyBoss/bunny-admin-server)

## 环境搭建

### 安装docker内容

如果使用是centos或者是rocky

```shell
# 更新yum 和 dnf
yum update -y
dnf update -y

# 安装必要依赖
yum install -y yum-utils device-mapper-persistent-data lvm2

# 设置镜像源
sudo yum-config-manager --add-repo http://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
yum list docker-ce --showduplicates | sort -r

# 安装docker
yum -y install docker-ce.x86_64

# 开机启动docker
systemctl enable docker
systemctl start docker
```

### 安装Redis

#### 编写配置文件

```sh
mkdir /bunny/docker_data/my_redis/ -p
vim /bunny/docker_data/my_redis/redis.conf
```

**添加以下内容**

有注释大概率启动不了

```
# bind 127.0.0.1 #注释掉这部分，使redis可以外部访问
daemonize no #用守护线程的方式启动
requirepass 123456
appendonly yes #redis持久化　　默认是no
tcp-keepalive 300 #防止出现远程主机强迫关闭了一个现有的连接的错误 默认是300
```

**删除注释**

```
daemonize no
requirepass 123456
appendonly yes
tcp-keepalive 300
```

#### 启动Redis

```sh
docker pull redis:7.0.10
docker run -p 6379:6379 --name redis_master \
-v /bunny/docker_data/redis_master/redis.conf:/etc/redis/redis.conf \
-v/bunny/docker_data/redis_master/data:/data \
--restart=always -d redis:7.0.10  --appendonly yes
```

### 安装Minio

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

### 安装MySQL

**设置开机启动**

**执行启动3306：**

```sh
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

**执行启动3304：**

其中有创建备份目录

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

**修改密码：**

```sh
docker exec -it mysql_master /bin/bash
mysql -uroot -p02120212
use mysql
ALTER USER 'root'@'%' IDENTIFIED BY "02120212";
FLUSH PRIVILEGES;
```

> my.cnf 配置
>
> ```sql
> [mysqld]
> skip-host-cache
> skip-name-resolve
> secure-file-priv=/var/lib/mysql-files
> user=mysql
>
> # 设置字符集
> character-set-server=utf8mb4
> collation-server=utf8mb4_unicode_ci
>
> # 设置服务器ID（如果是复制集群，确保每个节点的ID唯一）
> server-id=1
>
> # 启用二进制日志
> log-bin=mysql-bin
>
> # 设置表名不区分大小写
> lower_case_table_names = 1
>
> ```

### 数据库文件

在后端文件的根目录中

![image-20241107133345299](http://116.196.101.14:9000/docs/image-20241107133345299.png)

## 后端日志文件

在后端日志文件中，使用了`logback.xml`进行格式化。然而，使用`logback.xml`后，配置文件中指定的日志输出文件位置可能会失效。如果项目是通过Docker部署的，想在宿主机查看日志文件需要进行文件映射。

### 使用SpringBoot

在配置文件中，指定名称和目录路径即可，之后使用docker映射就可以在宿主机看到日志了

如果想要用自带需要删除`logback.xml`文件

```
logging:
  level:
    cn.bunny.service.mapper: warn
    cn.bunny.service.controller: warn
    cn.bunny.service.service: warn
    root: warn
  pattern:
    dateformat: HH:mm:ss:SSS
  file:
    path: "logs/${spring.application.name}"
    name: "logs/${spring.application.name}"
```

### 使用logback.xml

指定目录的位置`<file>D:/logs/${datetime}/auth-server.log</file>`根据你需要的指定

```xml
<!-- 格式化 年-月-日 输出 -->
<timestamp key="datetime" datePattern="yyyy-MM-dd"/>

<appender name="STOUT" class="ch.qos.logback.core.ConsoleAppender">
    <encoder>
        <pattern>
            %cyan([%thread]) %yellow(%-5level) %green(%logger{100}).%boldRed(%method)-%boldMagenta(%line)- %blue(%msg%n)
        </pattern>
    </encoder>
</appender>

<!-- 文件日志 -->
<appender name="FILE" class="ch.qos.logback.core.FileAppender">
    <file>/www/root/server/logs/${datetime}/auth-server.log</file>
    <append>true</append>
    <encoder>
        <pattern>%date{yyyy-MM-dd HH:mm:ss} %-5level %logger{100} %method %line %msg%n</pattern>
        <charset>UTF-8</charset>
    </encoder>
</appender>
```

> 如果按照上面搭建，日志文件会在`/www/root/server/logs`下，即使使Windows系统也会存在，如果docker使用的是文件映射，那么日志文件会在容器相对应的位置

如果开发环境或者其他环境也需要日志，可以根据当前环境进行选择`<springProfile name="prod">`

```xml
<!-- 生产环境 -->
<springProfile name="prod">
    <!-- 日志记录器：业务程序INFO级别  -->
    <logger name="cn.bunny" level="INFO"/>
    <!-- 根日志记录器：INFO级别  -->
    <root level="INFO">
        <appender-ref ref="CONSOLE"/>
        <appender-ref ref="FILE"/>
    </root>
</springProfile>
```

# 项目特点

### 按钮权限显示

如果当前用户在这个页面中只有【添加】和【删除】那么页面按钮中只会显示出【添加按钮】和【删除按钮】

### 去除前后空格

后端配置了自动去除前端传递的空字符串，如果传递的内容前后有空格会自动去除前后的空格

![image-20241105215241811](http://116.196.101.14:9000/docs/image-20241105215241811.png)

代码内容

```java
@ControllerAdvice
public class ControllerStringParamTrimConfig {

    /**
     * 创建 String trim 编辑器
     * 构造方法中 boolean 参数含义为如果是空白字符串,是否转换为null
     * 即如果为true,那么 " " 会被转换为 null,否者为 ""
     */
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        StringTrimmerEditor propertyEditor = new StringTrimmerEditor(false);
        // 为 String 类对象注册编辑器
        binder.registerCustomEditor(String.class, propertyEditor);
    }

    @Bean
    public Jackson2ObjectMapperBuilderCustomizer jackson2ObjectMapperBuilderCustomizer() {
        return jacksonObjectMapperBuilder -> {
            // 为 String 类型自定义反序列化操作
            jacksonObjectMapperBuilder
                    .deserializerByType(String.class, new StdScalarDeserializer<String>(String.class) {
                        @Override
                        public String deserialize(JsonParser jsonParser, DeserializationContext ctx) throws IOException {
                            // 去除全部空格
                            // return StringUtils.trimAllWhitespace(jsonParser.getValueAsString());
                            // 仅去除前后空格
                            return jsonParser.getValueAsString().trim();
                        }
                    });
        };
    }
}
```

### 项目接口和页面

接口地址有两个：

1. knife4j
2. swagger

接口地址://localhost:7070/doc.html#/home

![image-20241105213953503](http://116.196.101.14:9000/docs/image-20241105213953503.png)

swagger接口地址：http://localhost:7070/swagger-ui/index.html

![image-20241105214100720](http://116.196.101.14:9000/docs/image-20241105214100720.png)

前端接口地址：http://localhost:7000/#/welcome

![image-20241105214230389](http://116.196.101.14:9000/docs/image-20241105214230389.png)

## 登录功能

可以选择邮箱登录或者是密码直接登录，两者不互用。

### 账号登录

![image-20241105212146456](http://116.196.101.14:9000/docs/image-20241105212146456.png)

#### 业务需求

- 用户输入用户名和密码进行登录

#### 实现思路

- 用户输入账号和密码和数据库中账号密码进行比对，成功后进行页面跳转
- 如果账户禁用会显示账户已封禁

**后端实现文件位置**

- 拦截请求为`/admin/login`的请求之后进行登录验证的判断

![image-20241105212722043](http://116.196.101.14:9000/docs/image-20241105212722043.png)

### 邮箱登录

![image-20241105212255972](http://116.196.101.14:9000/docs/image-20241105212255972.png)

#### 业务需求

- 用户输入邮箱账号、密码、邮箱验证码之后进行登录

#### 实现思路

- 需要验证用户输入的邮箱格式是否正确。
- 在未输入验证码的情况下输入密码会提示用户，同时后端也会进行验证。如果输入了邮箱验证码但是Redis中不存在或已过期，会提示：邮箱验证码不存在或已过期。
- 之后对邮箱账号和密码进行判断包括邮箱验证码进行判断
- 判断逻辑如下，文件位置如上图所示。

```java
/**
 * * 自定义验证
 * 判断邮箱验证码是否正确
 */
@Override
public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) {
    ObjectMapper objectMapper = new ObjectMapper();
    try {
        loginDto = objectMapper.readValue(request.getInputStream(), LoginDto.class);

        // type不能为空
        String type = loginDto.getType();
        if (!StringUtils.hasText(type)) {
            out(response, Result.error(ResultCodeEnum.REQUEST_IS_EMPTY));
            return null;
        }

        String emailCode = loginDto.getEmailCode();
        String username = loginDto.getUsername();
        String password = loginDto.getPassword();

        // 如果有邮箱验证码，表示是邮箱登录
        if (type.equals("email")) {
            emailCode = emailCode.toLowerCase();
            Object redisEmailCode = redisTemplate.opsForValue().get(RedisUserConstant.getAdminUserEmailCodePrefix(username));
            if (redisEmailCode == null) {
                out(response, Result.error(ResultCodeEnum.EMAIL_CODE_EMPTY));
                return null;
            }

            // 判断用户邮箱验证码是否和Redis中发送的验证码
            if (!emailCode.equals(redisEmailCode.toString().toLowerCase())) {
                out(response, Result.error(ResultCodeEnum.EMAIL_CODE_NOT_MATCHING));
                return null;
            }
        }

        Authentication authenticationToken = new UsernamePasswordAuthenticationToken(username, password);
        return getAuthenticationManager().authenticate(authenticationToken);
    } catch (IOException e) {
        out(response, Result.error(ResultCodeEnum.ILLEGAL_DATA_REQUEST));
        return null;
    }
}
```

## 首页功能

![image-20241105212403630](http://116.196.101.14:9000/docs/image-20241105212403630.png)

功能菜单，首页图表展示部分功能已经由这个模板作者设计好，其中需要注意的是，如果要查看历史消息或者是进入消息页面可以双击![image-20241105213346408](http://116.196.101.14:9000/docs/image-20241105213346408.png)既可进入消息页面

### 消息功能

![image-20241105213539594](http://116.196.101.14:9000/docs/image-20241105213539594-1730813844820-2.png)

#### 业务需求

1. 消息页面的展示，包含删除、批量删除、选中已读和当前页面所有消息都标为已读
2. 当用户对左侧菜单点击时可以过滤出消息内容，展示不同的消息类型

![image-20241105213720011](http://116.196.101.14:9000/docs/image-20241105213720011.png)

3. 可以点击已读和全部进行筛选消息

![image-20241105214342220](http://116.196.101.14:9000/docs/image-20241105214342220.png)

3. 可以根据标题进行搜搜
4. 包含分页

#### 实现思路

1. 显示当前消息类型，用户点击时带参数请求，只带当前消息类型，不默认携带已读状态查询，然后从数据库筛选并返回结果。

2. 点击"已读"选项时，若选择"全部"（之前是设置为undefined，这样就不会携带参数了，但是底下会有警告），现在改为空字符串，后端只需过滤掉空字符串即可。

3. 删除选定数据，若用户选择列表并筛选出所有ID，将数据传递给后端（用户删除为逻辑删除）。

4. 全部标为已读![image-20241106131949217](http://116.196.101.14:9000/docs/image-20241106131949217.png)，类似删除操作，筛选出选中数据的ID，然后传递给后端以标记为已读。

5. 将所有数据标记为已读！当前页面前端使用map提取所有ID，整合成ID列表传递给后端，表示页面上所有数据已读。

6. 输入标题后，随输入变化进行搜索。

**后端代码位置**

![image-20241105213922824](http://116.196.101.14:9000/docs/image-20241105213922824.png)

### 用户管理

![image-20241106002713514](http://116.196.101.14:9000/docs/image-20241106002713514.png)

#### 需求分析

1. 用户操作需要包含CURD的操作
2. 为了方便在用户中需要给出快速禁用当前用户按钮
3. 需要显示用户头像、性别、最后登录的IP地址和归属地
4. 在左侧中需要包含部分查询
5. 可以根据点击的部门查询当前部门下的用户
6. 根据用户可以强制下线、管理员可以修改用户密码、为用户分配角色

![image-20241106002908657](http://116.196.101.14:9000/docs/image-20241106002908657.png)

#### 实现思路

**上传头像**

前端需要剪裁图片内容进行上传，后端将前端上传的头像存储到Minio中，在上传头像中可以有几菜单可以看到功能菜单。

![image-20241106003056116](http://116.196.101.14:9000/docs/image-20241106003056116.png)

右击时可以看到功能菜单，如上传、下载等功能

![image-20241106003154056](http://116.196.101.14:9000/docs/image-20241106003154056.png)

**重置密码**

重置密码需要判断当前用户密码是否是符合指定的密码格式，并且会根据当前输入密码计算得分如果当前密码复杂则得分越高那么密码强度越强

![image-20241106003256994](http://116.196.101.14:9000/docs/image-20241106003256994.png)

重置密码组件在前端的公共组件文件中

![image-20241106003426573](http://116.196.101.14:9000/docs/image-20241106003426573.png)

**分配角色**

- 给用户分配了admin角色后，其他路由绑定和权限设置就不再需要了，因为后端会根据admin角色在前端用户信息中设置通用权限码，如`*`、`*::*`、`*::*::*`，表示前端用户可以访问所有权限并查看所有内容。
- 管理员有权对用户进行角色分配，这涉及到许多操作，包括菜单显示和接口访问权限。角色与权限相关联，角色也与菜单相关联。

- 当用户访问菜单时，会根据其角色看到其所属的菜单内容。随后，角色与权限接口相关联，根据用户的权限来决定是否显示操作按钮。后端会根据用户的权限验证其是否可以访问当前接口。

- 用户登录或刷新页面时会重新获取用户信息，用户信息中包含角色和权限信息。利用角色和权限信息与前端传递的路径进行比对判断，如果用户包含菜单角色，则可以访问。如果用户包含前端路由中的权限，则表示该权限可以访问。后端也会进行权限判断，以防止通过接口文档等方式访问。

- 分配好角色后，菜单会根据当前路由角色匹配用户角色，从而根据用户角色显示相应的菜单内容。

![image-20241106004533031](http://116.196.101.14:9000/docs/image-20241106004533031.png)

### 角色管理

角色管理包含CURD和权限分配操作

![image-20241106132548236](http://116.196.101.14:9000/docs/image-20241106132548236.png)

#### 业务需求

用户对角色进行CURD操作，点击权限设置时让用户分配权限

#### 实现思路

1. 在设计的表中，如果存在相同的角色码，系统会提示用户当前角色已经存在。

![image-20241106132938024](http://116.196.101.14:9000/docs/image-20241106132938024.png)

2. 后端会根据角色的ID分配权限的ID列表。

![image-20241106135600255](http://116.196.101.14:9000/docs/image-20241106135600255.png)

3. 后端在角色权限表中会根据角色的ID分配权限内容。在角色权限表中，会先删除当前角色所有的权限内容，然后再进行权限内容的重新分配。

```java
public void assignPowersToRole(AssignPowersToRoleDto dto) {
    List<Long> powerIds = dto.getPowerIds();
    Long roleId = dto.getRoleId();

    // 删除这个角色下所有权限
    baseMapper.deleteBatchRoleIdsWithPhysics(List.of(roleId));

    // 保存分配数据
    List<RolePower> rolePowerList = powerIds.stream().map(powerId -> {
        RolePower rolePower = new RolePower();
        rolePower.setRoleId(roleId);
        rolePower.setPowerId(powerId);
        return rolePower;
    }).toList();
    saveBatch(rolePowerList);

    // 找到所有和当前更新角色相同的用户
    List<Long> roleIds = userRoleMapper.selectList(Wrappers.<UserRole>lambdaQuery().eq(UserRole::getRoleId, roleId))
            .stream().map(UserRole::getUserId).toList();

    // 根据Id查找所有用户
    List<AdminUser> adminUsers = userMapper.selectList(Wrappers.<AdminUser>lambdaQuery().in(!roleIds.isEmpty(), AdminUser::getId, roleIds));

    // 用户为空时不更新Redis的key
    if (adminUsers.isEmpty()) return;

    // 更新Redis中用户信息
    List<Long> userIds = adminUsers.stream().map(AdminUser::getId).toList();
    roleFactory.updateUserRedisInfo(userIds);
}
```

### 权限管理

![image-20241106135954104](http://116.196.101.14:9000/docs/image-20241106135954104.png)

![image-20241106140006176](http://116.196.101.14:9000/docs/image-20241106140006176.png)

在权限配置中，添加/修改权限时的请求地址为后端接口的请求地址，请求地址使用了【`正则表达式`】判断和【`antpath`】方式填写

> ### 正则表达式
>
> #### 作用和用法：
>
> - **作用**：正则表达式用于描述字符串的特征，可以用来匹配、查找、替换等字符串操作。
> - **用法**：在Java中，可以使用`java.util.regex`包来支持正则表达式的使用。例如，可以使用`Pattern`和`Matcher`类来编译和匹配正则表达式。
>
> #### 示例：
>
> ```java
> // 匹配邮箱地址的正则表达式示例
> String emailRegex = "\\b[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}\\b";
> String email = "example@email.com";
>
> Pattern pattern = Pattern.compile(emailRegex);
> Matcher matcher = pattern.matcher(email);
>
> if (matcher.find()) {
>     System.out.println("Valid email address");
> } else {
>     System.out.println("Invalid email address");
> }
> ```
>
> ### Ant Path
>
> #### 作用和用法：
>
> - **作用**：Ant Path是Spring框架中用来匹配URL路径的一种模式匹配方式，类似于Unix系统中的路径匹配规则。
> - **用法**：在Spring中，Ant Path可以用来匹配URL路径，例如在配置Spring的URL映射时可以使用Ant Path来指定匹配规则。
>
> #### 示例：
>
> ```java
> // Ant Path示例
> String pattern = "/users/*/profile";
> String path = "/users/123/profile";
>
> AntPathMatcher matcher = new AntPathMatcher();
> if (matcher.match(pattern, path)) {
>     System.out.println("Pattern matched!");
> } else {
>     System.out.println("Pattern not matched!");
> }
> ```
>
> Ant Path中支持一些通配符，例如`*`匹配任意字符（除了路径分隔符），`**`匹配任意字符，包括路径分隔符。Ant Path是一种方便的路径匹配方式，可以用来匹配URL路径、文件路径等。

#### 业务需求

1. 对权限表进行CURD操作
2. 在表格中点击新增时，父级id为当前点击行的id

#### 实现思路

点击当前行父级id为当前的行的id

![image-20241106140420845](http://116.196.101.14:9000/docs/image-20241106140420845.png)

#### 权限判断实现方式

##### 后端判断方式

判断权限是否可以访问，后端实现判断逻辑

![image-20241106003921315](http://116.196.101.14:9000/docs/image-20241106003921315.png)

##### 前端判断方式

角色分配方式有下面几种想洗参考：https://pure-admin.github.io/vue-pure-admin/#/permission/button/router，[文档页面](https://pure-admin.github.io/pure-admin-doc/pages/routerMenu/#%E4%B8%BA%E4%BB%80%E4%B9%88%E8%B7%AF%E7%94%B1%E7%9A%84-name-%E5%BF%85%E5%86%99-%E8%80%8C%E4%B8%94%E5%BF%85%E9%A1%BB%E5%94%AF%E4%B8%80)

1. 使用标签方式

![image-20241106004247600](http://116.196.101.14:9000/docs/image-20241106004247600.png)

2. 使用函数方式

![image-20241106004310635](http://116.196.101.14:9000/docs/image-20241106004310635.png)

3. 使用指令方式

![image-20241106005252328](http://116.196.101.14:9000/docs/image-20241106005252328.png)

在前端utils文件夹下有`auth.ts`文件里面包含了权限码信息，如果当前菜单属性中包含这个权限码表示可以访问这个权限

![image-20241106004433489](http://116.196.101.14:9000/docs/image-20241106004433489.png)

![image-20241106004500855](http://116.196.101.14:9000/docs/image-20241106004500855.png)

### 菜单管理

![image-20241106140545328](http://116.196.101.14:9000/docs/image-20241106140545328.png)

### 菜单路由

在做菜单返回时必须要了解角色和权限表

![image-20241105213516679](http://116.196.101.14:9000/docs/image-20241105213516679.png)

#### 需求分析

1. 从数据库中返回出所有的菜单，其中需要整合成前端所要的形式，需要包含`roles`和`auths`，及其其它参数。
2. 用户需要根据自己的角色访问不同的菜单。
3. 如果当前用户不可以访问某些按钮需要隐藏。
4. 用户通过其它手段访问如：swagger、knife4j、apifox、postman这种工具访问需要做权限验证，如果当前用户不满足访问这些接口后端需要拒绝。
5. 如果已经添加了菜单名称、路由等级、路由路径会提示`xxx已存在`![image-20241106132818902](http://116.196.101.14:9000/docs/image-20241106132818902.png)

6. 在数据库中为部分字段建立了唯一索引

![image-20241106132908309](http://116.196.101.14:9000/docs/image-20241106132908309.png)

#### 实现思路

1. 角色和权限哪些可以访问的页面交给前端，在模板中已经设计好，如果用户访问了自己看不到的菜单会出现`403`页面；判断方式是根据后端返回的菜单中如果包含当前用户的角色就表示可以访问当前的菜单，如果用户信息中没有这个角色则表示不可以访问这个页面。
2. 页面是否可以访问只是在操作上，如果用户通过接口访问是阻止不了的，所以这时后端需要在后端中进行判断，当前的访问路径是否是被允许的，也就是这个用户是否有这个权限，权限表设计中包含了请求路径
3. 后端需要判断用户请求这个接口是否有权访问

> 整合成前端格式返回需要递归，后端根据当前用户访问的菜单需要进行递归菜单数据之后返回前端，并将这些菜单绑定的角色放置在`roles`中，之后根据角色查询全新啊相关内容，要将权限内容放置在`auths`中.
>
> 如果包含子菜单需要防止在`children`数组中，后端实现时如果没有子菜单默认是空数组而不是`null`
>
> 大致如下：
>
> ```json
> {
> "menuType": 0,
> "title": "admin_user",
> "path": "/system/admin-user",
> "component": "/system/adminUser/index",
> "meta": {
>     "icon": "ic:round-manage-accounts",
>     "title": "admin_user",
>     "rank": 2,
>     "roles": [
>         "admin",
>         "all_page",
>         "system",
>         "test"
>     ],
>     "auths": [
>         "message::updateMessage",
>         "menuIcon::getMenuIconList",
>         "admin::messageReceived",
>         "config::getWebConfig",
>         "admin::config",
>         "i18n::getI18n",
>         ....
>     ],
>     "frameSrc": ""
> },
> "children": [],
> "id": "1841803086252548097",
> "parentId": "1",
> "name": "admin_user",
> "rank": 2
> }
> ```

### 部门管理

![image-20241106140738517](http://116.196.101.14:9000/docs/image-20241106140738517.png)

![image-20241106140728748](http://116.196.101.14:9000/docs/image-20241106140728748.png)

#### 业务需求

1. 包含CURD
2. 在用户管理中可以选择对应的部门

#### 实现思路

1. CURD接口文件如下

![image-20241106140826034](http://116.196.101.14:9000/docs/image-20241106140826034.png)

2. 管理员为用户分配部门

![image-20241106140942278](http://116.196.101.14:9000/docs/image-20241106140942278.png)

### 菜单图标

![image-20241106141037894](http://116.196.101.14:9000/docs/image-20241106141037894.png)

![image-20241106141102601](http://116.196.101.14:9000/docs/image-20241106141102601.png)

#### 业务需求

1. 用户在菜单中可以选择存储在数据库中的图标内容
2. 包含CURD内容

#### 实现思路

后端需要返回接口格式实体类如下

```java
public class MenuIconVo extends BaseUserVo {

    @Schema(name = "iconCode", title = "icon类名")
    private String iconCode;

    @Schema(name = "iconName", title = "icon 名称")
    private String iconName;

}
```

![image-20241106141521051](http://116.196.101.14:9000/docs/image-20241106141521051.png)

前端封装好的组件

![image-20241106141626697](http://116.196.101.14:9000/docs/image-20241106141626697.png)

### 邮箱相关

#### 业务需求

1. 邮件用户配置CURD
2. 邮件模板CURD
3. 邮件用户中只能有一个是默认的，如果当前修改其它项需要将其它已经启用改为不启用
4. 邮件模板需要绑定邮件用户

### 实现思路

邮件模板中，添加或者修改时前端需要返回所有的邮件模板用户，添加或者修改时将用户ID存储在邮件模板的数据字段中

![image-20241106141920350](http://116.196.101.14:9000/docs/image-20241106141920350.png)

### web配置

![image-20241106142001190](http://116.196.101.14:9000/docs/image-20241106142001190.png)

### 系统监控

#### 服务监控

从SpringBoot的Actuator中获取信息，页面采用响应式

![image-20241106142208794](http://116.196.101.14:9000/docs/image-20241106142208794.png)

#### 系统缓存

当前内容被SpringBoot缓存会显示在这

![image-20241106142253759](http://116.196.101.14:9000/docs/image-20241106142253759.png)

### 定时任务

采用Quarter持久化存储，所有的可以使用的定时任务都在这

![image-20241106142429924](http://116.196.101.14:9000/docs/image-20241106142429924.png)

#### 页面展示

![image-20241106142449033](http://116.196.101.14:9000/docs/image-20241106142449033.png)

![](http://116.196.101.14:9000/docs/image-20241106142449033-1730874298898-1.png)

### 多语言管理

![image-20241106142531047](http://116.196.101.14:9000/docs/image-20241106142531047.png)

![image-20241106142544172](http://116.196.101.14:9000/docs/image-20241106142544172.png)

### 日志管理

![image-20241106142606017](http://116.196.101.14:9000/docs/image-20241106142606017.png)

![image-20241106142614917](http://116.196.101.14:9000/docs/image-20241106142614917.png)

### 消息管理

管理员可以发送消息告诉xxx用户，在主页中会显示![image-20241106142908363](http://116.196.101.14:9000/docs/image-20241106142908363.png)

之后点击时会看到消息封面、标题、简介、消息等级、消息等级内容

![image-20241106142949366](http://116.196.101.14:9000/docs/image-20241106142949366.png)

#### 消息类型

![image-20241106143008098](http://116.196.101.14:9000/docs/image-20241106143008098.png)

包含CURD，用户编辑消息发送时可以在选择

![image-20241106144017015](http://116.196.101.14:9000/docs/image-20241106144017015.png)

同时在用户消息栏中也会显示对应内容

![image-20241106144050996](http://116.196.101.14:9000/docs/image-20241106144050996.png)

前端判断逻辑如下

![image-20241106144146081](http://116.196.101.14:9000/docs/image-20241106144146081.png)

#### 消息编辑

提供md编辑器和富文本编辑器

![image-20241106144223976](http://116.196.101.14:9000/docs/image-20241106144223976.png)

![image-20241106144246068](http://116.196.101.14:9000/docs/image-20241106144246068.png)

消息接受用户，如果不填写表示全部的用户，填写后会根据填写的内容存储在用户接受表中![image-20241106144522442](http://116.196.101.14:9000/docs/image-20241106144522442.png)

![image-20241106144449463](http://116.196.101.14:9000/docs/image-20241106144449463.png)

消息等级是显示消息样式颜色，文字内容为消息简介内容

![image-20241106144407453](http://116.196.101.14:9000/docs/image-20241106144407453.png)

#### 消息接收管理

根据上面所选的接受用户会出现在下面的用户接受表中，可以对当前用户是否已读进行修改

![image-20241106144307885](http://116.196.101.14:9000/docs/image-20241106144307885.png)

#### 消息发送管理

之前编辑过的消息都会在这

![image-20241106144317746](http://116.196.101.14:9000/docs/image-20241106144317746.png)

# 环境部署

使用Docker进行部署，后端接口地址以`/admin`开头，但前端默认请求前缀为`/api`，因此在请求时需要进行替换。详细内容请参考以下【项目部署】说明。

## 前端部署

运行`pnpm build`

dockerfile中暴露端口要和生产环境的端口号保持一致

### 使用http协议

如果不使用https，需要将下面内容注释

![image-20241108152526666](http://116.196.101.14:9000/docs/auth/image-20241108152526666.png)

对外暴露端口改为`80`或者你自己喜欢的端口

![image-20241108154244339](http://116.196.101.14:9000/docs/auth/image-20241108154244339.png)

#### NGINX配置

将NGINX配置修改为以下内容

```nginx
map $http_upgrade $connection_upgrade {
    default upgrade;
    ''      close;
}

server {
     listen 80 ;
     listen       [::]:80;
     server_name localhost;

     location / {
         root   /etc/nginx/html;
         index  index.html index.htm;
         try_files $uri /index.html;
     }

     # 后端跨域请求
     location ~/admin/ {
         proxy_pass http://172.17.0.1:8000;
         proxy_set_header Host $http_host;
         proxy_set_header X-Real-IP $remote_addr;
         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
         proxy_set_header X-Forwarded-Proto $scheme;
     }

     error_page  404              404.html;

     location = /50x.html {
         root   html;
     }
}
```

如果你的暴露的端口和我一样是`80`

![image-20241108154344561](http://116.196.101.14:9000/docs/auth/image-20241108154344561.png)

### 使用https协议

#### 环境准备

需要ssl证书这个是必要的，之后将ssl证书解压

![image-20241108145836035](http://116.196.101.14:9000/docs/auth/image-20241108145836035.png)

解压后放到docker文件下

![image-20241108151141289](http://116.196.101.14:9000/docs/auth/image-20241108151141289.png)

#### 注意事项

在docker文件中需要将证书相关信息复制到docker容器中，名称对应文件下的文件名，如果你想部署名称肯定是不一样的，当然你可以重命名成和我一样的

```dockerfile
# 将自定义的 Nginx 配置文件复制到容器中
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY bunny-web.site.csr /etc/nginx/bunny-web.site.csr
COPY bunny-web.site.key /etc/nginx/bunny-web.site.key
COPY bunny-web.site_bundle.crt /etc/nginx/bunny-web.site_bundle.crt
COPY bunny-web.site_bundle.pem /etc/nginx/bunny-web.site_bundle.pem
```

如果使用的是SSL链接将端口号更改下，改成`443`

![image-20241108151643011](http://116.196.101.14:9000/docs/auth/image-20241108151643011.png)

配置NGINX的配置文件，这些文件内容网上都有可以参看腾讯云文档

- 证书下载和配置方式：https://cloud.tencent.com/document/product/400/4143?from_cn_redirect=1
- NGINX搭建SSL链接：https://cloud.tencent.com/document/product/400/35244

```nginx
map $http_upgrade $connection_upgrade {
    default upgrade;
    ''      close;
}

server {
     #SSL 默认访问端口号为 443
     listen 443 ssl;
     #请填写绑定证书的域名
     server_name localhost;
     #请填写证书文件的相对路径或绝对路径
     ssl_certificate bunny-web.site_bundle.crt;
     #请填写私钥文件的相对路径或绝对路径
     ssl_certificate_key bunny-web.site.key;
     ssl_session_timeout 5m;
     #请按照以下协议配置
     ssl_protocols TLSv1.2 TLSv1.3;
     #请按照以下套件配置，配置加密套件，写法遵循 openssl 标准。
     ssl_ciphers ECDHE-RSA-AES128-GCM-SHA256:HIGH:!aNULL:!MD5:!RC4:!DHE;
     ssl_prefer_server_ciphers on;

     location / {
         root   /etc/nginx/html;
         index  index.html index.htm;
         try_files $uri /index.html;
     }

     # 后端跨域请求
     location ~/admin/ {
         proxy_pass http://172.17.0.1:8000;
         proxy_set_header Host $http_host;
         proxy_set_header X-Real-IP $remote_addr;
         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
         proxy_set_header X-Forwarded-Proto $scheme;
     }

     error_page  404              404.html;

     location = /50x.html {
         root   html;
     }
 }

server {
     listen 80 ;
     listen       [::]:80;
     server_name localhost;
     return 301 https://$host$request_uri;

     location / {
         root   /etc/nginx/html;
         index  index.html index.htm;
         try_files $uri /index.html;
     }

     # 后端跨域请求
     location ~/admin/ {
         proxy_pass http://172.17.0.1:8000;
         proxy_set_header Host $http_host;
         proxy_set_header X-Real-IP $remote_addr;
         proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
         proxy_set_header X-Forwarded-Proto $scheme;
     }

     error_page  404              404.html;

     location = /50x.html {
         root   html;
     }
}
```

#### 运行docker文件

![image-20241108151726981](http://116.196.101.14:9000/docs/auth/image-20241108151726981.png)

![image-20241108151940158](http://116.196.101.14:9000/docs/auth/image-20241108151940158.png)

> 命令预览
>
> ```sh
> docker build -f Dockerfile -t bunny_auth_web:1.0.0 . && docker run -p 80:443 -p 443:443 --name bunny_auth_web --restart always bunny_auth_web:1.0.0
> ```

## 后端部署

开发环境环境：对外暴露的端口是`7070`

生产环境：对外暴露的端口是`8000`

需要先打包，打包完成后会在目录下生成对应的`target`相关文件

```bash
# 开发环境
mvn clean package -Pprod -DskipTests

# 测试环境
mvn clean package -Ptest -DskipTests
```

![image-20241108153705104](http://116.196.101.14:9000/docs/auth/image-20241108153705104.png)

这个文件夹是必须的

![image-20241108153750097](http://116.196.101.14:9000/docs/auth/image-20241108153750097.png)
