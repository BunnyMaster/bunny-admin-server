Github地址

- [前端地址](https://github.com/BunnyMaster/bunny-admin-web.git)
- [后端地址](https://github.com/BunnyMaster/bunny-admin-server)

Gitee地址

- [前端地址](https://gitee.com/BunnyBoss/bunny-admin-web)
- [后端地址](https://gitee.com/BunnyBoss/bunny-admin-server)

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

## 配置相关

### docker文件

```dockerfile
# 使用官方的 Nginx 镜像作为基础镜像
FROM nginx

# 删除默认的 Nginx 配置文件
RUN rm /etc/nginx/conf.d/default.conf

# 将自定义的 Nginx 配置文件复制到容器中
COPY nginx.conf /etc/nginx/conf.d/default.conf

# 设置时区，构建镜像时执行的命令
RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN echo "Asia/Shanghai" > /etc/timezone

# 创建一个目录来存放前端项目文件
WORKDIR /usr/share/nginx/html

# 将前端项目打包文件复制到 Nginx 的默认静态文件目录
COPY dist/ /usr/share/nginx/html
# 复制到nginx目录下
COPY dist/ /etc/nginx/html

# 暴露 Nginx 的默认端口
EXPOSE 80

# 自动启动 Nginx
CMD ["nginx", "-g", "daemon off;"]
```

### NGINX文件

在请求中会使用代理所以会拿不到用户真实的IP地址，素以在要NGINX侠做下面的配置，这样用户在访问时就可以拿到真实的IP了

```nginx
proxy_set_header X-Real-IP $remote_addr;
proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
proxy_set_header X-Forwarded-Proto $scheme;
```

#### 如果需要使用https协议

```dockerfile
COPY bunny-web.site.csr /etc/nginx/bunny-web.site.csr
COPY bunny-web.site.key /etc/nginx/bunny-web.site.key
COPY bunny-web.site_bundle.crt /etc/nginx/bunny-web.site_bundle.crt
COPY bunny-web.site_bundle.pem /etc/nginx/bunny-web.site_bundle.pem
```

NGINX的文件

```nginx
map $http_upgrade $connection_upgrade {
    default upgrade;
    ''      close;
}

server {
    listen       80;
    listen       [::]:80;
    server_name  localhost;

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

## 项目部署

使用WebStorm进行项目部署，项目上线时默认端口为80。因此，Docker默认暴露的IP端口也应为80，NGINX中默认暴露的端口也是80，三者应一一对应。

若无法下载，请先使用pnpm下载。若不需使用pnpm，请删除或修改相应内容。

![image-20241026025057129](http://116.196.101.14:9000/docs/auth/undefinedimage-20241026025057129.png)

### docker配置

![image-20241026024116090](http://116.196.101.14:9000/docs/auth/undefinedimage-20241026024116090.png)

### 配置环境

设置启动端口号和项目地址机器后端请求地址

![image-20241026024813858](http://116.196.101.14:9000/docs/auth/undefinedimage-20241026024813858.png)

#### 配置线上环境

设置项目启动端口号，线上环境默认请求路径为`/admin`，需在NGINX中将访问请求前缀更改为`/admin`。

![image-20241026024940747](http://116.196.101.14:9000/docs/auth/undefinedimage-20241026024940747.png)

![image-20241026024243785](http://116.196.101.14:9000/docs/auth/undefinedimage-20241026024243785.png)

#### 配置开发环境

开发环境默认IP为7000，若与本地项目端口冲突，请修改。后端请求地址为7070。

前端设置的请求前缀为`/api`，但后端接受的前缀为`/admin`，因此需在服务中修改此内容。

![image-20241026024318644](http://116.196.101.14:9000/docs/auth/undefinedimage-20241026024318644.png)

**修改请求路径**

![image-20241026031651591](http://116.196.101.14:9000/docs/auth/undefinedimage-20241026031651591.png)

### 部署命令

```bash
docker build -f Dockerfile -t bunny_auth_web:1.0.0 . && docker run -p 80:80 --name bunny_auth_web --restart always bunny_auth_web:1.0.0
```
