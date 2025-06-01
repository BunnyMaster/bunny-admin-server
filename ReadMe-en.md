# BunnyAuth Dynamic Permission Control Introduction

![GitHub Stars](https://img.shields.io/github/stars/BunnyMaster/bunny-admin-server?style=social)  ![GitHub forks](https://img.shields.io/github/forks/BunnyMaster/bunny-admin-server)  ![GitHub contributors](https://img.shields.io/github/contributors/BunnyMaster/bunny-admin-server)  <img alt="GitHub License" src="https://img.shields.io/github/license/BunnyMaster/bunny-admin-server">  ![GitHub top language](https://img.shields.io/github/languages/top/BunnyMaster/bunny-admin-server)  ![GitHub Repo Size](https://img.shields.io/github/repo-size/BunnyMaster/bunny-admin-server)  

> [!IMPORTANT]  
>
> Open-source permission template: [Pure-admin](https://pure-admin.github.io/vue-pure-admin/)  
>
> **Pure-admin Documentation**: https://pure-admin.github.io/pure-admin-doc  
>
> **Default Credentials**  
>
> The project includes a default administrator with user `id` `1` in the database:  
>
> Username: `Administrator`  
>
> Password: `admin123`  

> [!WARNING]  
>
> If the password for the administrator [`Administrator`] is incorrect during initial login:  
>
> Locate the `sys_user` table in the database and replace the password for `Administrator` with the following:  
>
> `$2a$10$h5BUwmMaVcEuu7Bz0TPPy.PQV8JP6CFJlbHTgT78G1s0YPIu2kfXe`  

Flexible permission control with multi-platform file upload support.

## 📽️ Video Tutorials

**Introduction Videos**  

- [RBAC URL Permission Database and Backend Design](https://www.bilibili.com/video/BV1nGVazrEKf/)  
- [Bunny-Admin Configuration Guide](https://www.bilibili.com/video/BV177VazMEiM/)  
- [Bunny-Admin User Operations](https://www.bilibili.com/video/BV1B7VazME72/)  
- [Bunny-Admin Role Permissions](https://www.bilibili.com/video/BV1ELVazzEnC/)  
- [Bunny-Admin Remaining Business Logic](https://www.bilibili.com/video/BV1ELVazzE7S/)  
- [Code Generator](https://www.bilibili.com/video/BV1d4Lxz9E3j/?vd_source=d42b5b664efb958be39eef8ee1196a7e)  

**GitHub Repositories**  

- Permission Backend: https://github.com/BunnyMaster/bunny-admin-server  
- Permission Frontend: https://github.com/BunnyMaster/bunny-admin-web  
- Code Generator: https://github.com/BunnyMaster/generator-code-server  

**Gitee Repositories**  

- Permission Backend: https://gitee.com/BunnyBoss/bunny-admin-server  
- Permission Frontend: https://gitee.com/BunnyBoss/bunny-admin-web  
- Code Generator: https://gitee.com/BunnyBoss/generator-code-server  

## 🚀 Project Overview

A modern dynamic permission control system based on Spring Security 6, providing a complete RBAC permission management solution. Supports frontend-backend separation architecture and flexible fine-grained permission control.

## 😋 Controller Annotation Guide

The project is URL-based for easy permission interface definition. Permissions can be added or deleted via URLs, even if the interface does not exist in the project.  

For example, if a role needs access to all interfaces under `dept`, the URL can be written as `api/dept/**`. For specific interfaces like `/api/dept/aaa/bbb`, the URL can be customized accordingly.  

For paginated queries with URL parameters, use `/api/dept/*/*` for flexible permission control.  

In scenarios where interfaces directly represent permissions, manually adding each URL is tedious. Instead, Swagger annotations and the custom `PermissionTag` annotation can be used. Reflection-based permission addition is also supported. Refer to the `ReadMe` in the controller directory for details.

## ✨ Major Updates

### Core Improvements

**v4.0.0**  

- **Complete Refactoring**: Backend interfaces, entity classes, and frontend optimizations.  
- **Batch Operations Support**:  
  - ✅ Menu Management: Enhanced attribute content.  
  - ✅ Permission Management: JSON/Excel import/export.  
  - ✅ Role Management: Excel batch updates.  
  - ✅ Multi-language Configuration: JSON/Excel updates (full replacement mode).  

**v4.0.1**  

- File system supports multiple platforms with manual configuration.  
- Reference documentation: https://x-file-storage.xuyanwu.cn/#/  
- File deletion and download require implementing the `FileRecorder` interface. The code and controllers are in the `file` directory. Modify as needed based on the [x-file-storage] documentation.  

## 🧠 Usage Tips

> [!TIP]  
>
> Multi-language Usage Tips:  
>
> While direct JSON file manipulation may be challenging for some users, JSON offers unique advantages in multi-language projects:  
>
> 1. Structured format for easy AI parsing.  
> 2. Efficient translation workflow:  
>    - Developers only need to complete the Chinese version.  
>    - Upload JSON to AI translation tools.  
>    - Simple commands generate English/Traditional Chinese/Korean versions.  
> 3. Saves significant development time with a "write once, adapt for multiple languages" approach.  

## 🔐 Permission Control System

![image-20250428225337843](./images/image-20250428225337843-1745854181492-5.png)  

### Access Rules Configuration

Configured via `WebSecurityConfig`:  

| Path Type         | Example           | Access Requirement | Configuration Method            |
| ----------------- | ----------------- | ------------------ | ------------------------------- |
| Public Interface  | `/api/public/**`  | No authentication  | Path contains `public` keyword  |
| Private Interface | `/api/private/**` | Requires login     | Path contains `private` keyword |

### Path Matching Strategy

```java
public static String[] annotations = { ... };

// Configuration Example
http.authorizeHttpRequests(auth -> auth
    .authorizeHttpRequests(authorize -> authorize
    .requestMatchers(annotations).permitAll()
);
```

### Maven Project Structure

```
bunny-auth/
├── auth-system   # System Module
├── core-common   # Core and base...
│   ├── context   # Context
│   └── exception # Exception
│   └── ......    # And more...
├── domain        # Domain
└─services		  # Service and Mapper 
```

## 🛠️ Use Cases

### 1. Frontend-Only Control Mode

Frontend details: https://pure-admin.cn/pages/RBAC/#%E5%A6%82%E4%BD%95%E9%85%8D%E7%BD%AE  

![image-20250428230444403](./images/image-20250428230444403-1745854157395-3.png)  

- **Page Control**:  
  1. Assign roles to route menus.  
  2. Assign roles to users.  
- **Button Control**:  
  ```ts
  // Frontend Permission Codes
  const auth = {
    add: ['i18nType::add'],
    update: ['i18nType::update'],
    delete: ['i18nType::delete'],
  };
  ```

### 2. Backend-Only Control Mode

- Interface-level permissions: For pagination, use `/api/permission/*/*`.  

  ```java
  @Tag(name = "System Permissions")
  @PermissionTag(permission = "permission::*")
  @RestController
  @RequestMapping("api/permission")
  public class PermissionController {
      @Operation(summary = "Pagination Query")
      @PermissionTag(permission = "permission::query")
      @GetMapping("{page}/{limit}")
      public Result<PageResult<PermissionVo>> getPermissionPage(
          @PathVariable Integer page,
          @PathVariable Integer limit) {
          // ...
      }
  }
  ```

### 3. Full-Stack Control Mode

Combine the above two approaches.  

## 🛡️ Security Configuration

### Path Matching Strategy

AntPath details: https://juejin.cn/spost/7498247273660743732  

| Pattern         | Example         | Description             |
| --------------- | --------------- | ----------------------- |
| Exact Match     | `/api/user`     | Matches exact path      |
| Single Wildcard | `/api/user/*`   | Matches single level    |
| Multi Wildcard  | `/api/user/**`  | Matches multiple levels |
| Method Specific | `GET /api/user` | Matches HTTP method     |

## 🧰 Technology Stack

### 😄 Frontend  

- Vue 3 + PureAdmin Template  
- Custom Permission Components  
- Internationalization Support  

### 😃 Backend  

- Spring Boot 3 + Spring Security 6  
- JDK 17  
- MySQL + Redis + MinIO  
- Swagger + Knife4j Documentation  

### 😀 Development Environment  

Docker startup varies by version:  

```bash
# Start dependency services with one command
docker-compose up -d
# For newer Docker versions
docker compose up -d
```

## 📚 Best Practices  

1. **Annotation Standards**:  
   ```java
   @Tag(name = "Module Name", description = "Module Description")
   @Operation(summary = "Interface Summary", tags = {"Permission Code"})
   // Or
   @Operation(summary = "Interface Summary", tags = "Permission Code")
   ```
2. **Permission Code Design**:  
   - Module::Operation (e.g., `user::create`).  
   - Hierarchical design (e.g., `system:user:update`).  
3. **Batch Operations**:  
   - Manage permissions via Excel/JSON.  
   - Regularly backup permission configurations.  

## 🌟 Project Advantages  

1. **True Dynamic Control** – No hardcoded permission logic.  
2. **Flexible Data Import** – Supports multiple file formats.  
3. **Fine-Grained Control** – Multi-level permissions from pages to buttons.  
4. **Modern Tech Stack** – Based on the latest Spring ecosystem.  
5. **Out-of-the-Box** – Complete Docker deployment solution.  

## 📌 Notes  

1. Multi-language updates fully replace existing configurations.  
2. Disable Swagger endpoints in production.  
3. Use Excel for complex permission management.  

## 📈 Future Plans  

None at the moment.  

## 📏 Frontend-Backend Interface Standards  

### 🌐 Frontend Example Standards  

| **Action**   | **API Layer** | **Pinia Layer** |
| :----------- | :------------ | :-------------- |
| Query Single | `getUser`     | `loadUser`      |
| Query List   | `getUserList` | `loadUserList`  |
| Pagination   | `getUserPage` | `fetchUserPage` |
| Add Data     | `createUser`  | `addUser`       |
| Update Data  | `updateUser`  | `editUser`      |
| Delete Data  | `deleteUser`  | `removeUser`    |

### 🛟 Backend Interface Example Standards  

Follows RESTful standards.  

| **Action**   | **RESTful**                 |
| :----------- | :-------------------------- |
| Query List   | `GET /users`                |
| Pagination   | `GET /users/{page}/{limit}` |
| Query Single | `GET /users/{id}`           |
| Add          | `POST /users`               |
| Update       | `PUT /users/{id}`           |
| Delete       | `DELETE /users/{id}`        |

![wx_alipay](./images/wx_alipay.png)