# 自定义验证请求逻辑实现

> [!CAUTION]
>
> 1. 登出操作必须验证身份
> 2. 敏感操作必须显式授权
> 3. 通配符权限需谨慎配置

## 概述

本方案通过实现`AuthorizationManager<RequestAuthorizationContext>`接口，为Spring Security项目提供自定义的JWT验证逻辑，替代默认实现以满足特定业务需求。

## 核心设计原则

1. **差异化验证**：区分不同请求类型的验证需求
2. **性能优化**：通过方法过滤减少权限验证范围
3. **灵活匹配**：支持精确匹配和通配符匹配
4. **特权处理**：管理员特权直接放行机制

## 验证流程设计

### 前置验证阶段
1. **Token验证**
   - 检查请求头是否包含有效Token
   - 验证Token有效期
   - 解析Token获取用户身份信息

2. **用户状态验证**
   - 查询Redis验证登录状态（`LoginVo`）
   - 检查用户账号状态（是否禁用等）
   - 设置用户信息到安全上下文

### 权限验证阶段
1. **特权用户处理**
   - 管理员(admin)直接放行
2. **公共端点处理**
   - 登录端点免验证
   - 登出端点强制验证
   - 配置白名单匹配
3. **细粒度权限验证**
   - 按请求方法(GET/POST等)过滤权限
   - 支持多种URL匹配模式：
     - 精确匹配
     - Ant风格通配符(/*, /**)

## 关键实现逻辑

```java
// 权限验证核心代码片段
permissionList.stream()
    .filter(permission -> {
        // 方法匹配过滤
        String method = permission.getRequestMethod();
        if (StringUtils.hasText(method)) {
            return method.equalsIgnoreCase(requestMethod) 
                || isWildcardPath(requestURI);
        }
        return false;
    })
    .map(Permission::getRequestUrl)
    .filter(Objects::nonNull)
    .anyMatch(url -> matchRequestPath(url, requestURI));
```

**路径匹配策略**：
- 通配符路径(`/*`, `/**`)：使用`AntPathMatcher`
- 精确路径：直接字符串比较

## 异常情况处理

1. **通配符路径特殊情况**
   - 当配置`/**`时需特殊处理
   - 需要同时验证模块前缀和用户权限

2. **方法级控制**
   - 同一URL不同方法需要区分验证
   - 示例：`/api/test/1`的`GET`和`DELETE`方法需要分别授权

## 性能优化建议

1. 缓存用户权限数据
2. 使用布隆过滤器快速判断无效路径
3. 对权限数据建立方法索引
