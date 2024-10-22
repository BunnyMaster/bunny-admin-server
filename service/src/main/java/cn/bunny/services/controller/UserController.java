package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.user.*;
import cn.bunny.dao.entity.system.AdminUser;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.user.AdminUserVo;
import cn.bunny.dao.vo.system.user.RefreshTokenVo;
import cn.bunny.dao.vo.system.user.UserVo;
import cn.bunny.services.service.UserService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.List;


@Tag(name = "用户信息", description = "用户信息相关接口")
@RestController
@RequestMapping("/admin/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Operation(summary = "分页查询用户信息", description = "分页查询用户信息")
    @GetMapping("getAdminUserList/{page}/{limit}")
    public Mono<Result<PageResult<AdminUserVo>>> getAdminUserList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            AdminUserDto dto) {
        Page<AdminUser> pageParams = new Page<>(page, limit);
        PageResult<AdminUserVo> pageResult = userService.getAdminUserList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }

    @Operation(summary = "获取本地登录用户信息", description = "获取本地登录用户信息")
    @GetMapping("noManage/getUserinfo")
    public Mono<Result<UserVo>> getUserinfo() {
        UserVo vo = userService.getUserinfo();
        return Mono.just(Result.success(vo));
    }

    @Operation(summary = "获取用户信息", description = "获取用户信息")
    @GetMapping("getUserinfoById")
    public Mono<Result<UserVo>> getUserinfoById(Long id) {
        UserVo vo = userService.getUserinfoById(id);
        return Mono.just(Result.success(vo));
    }

    @Operation(summary = "多条件查询用户", description = "多条件查询用户")
    @GetMapping("noManage/queryUser")
    public Mono<Result<List<AdminUserVo>>> queryUser(String keyword) {
        List<AdminUserVo> voList = userService.queryUser(keyword);
        return Mono.just(Result.success(voList));
    }

    @Operation(summary = "更新用户信息", description = "更新用户信息")
    @PutMapping("updateAdminUser")
    public Result<String> updateAdminUser(@Valid @RequestBody AdminUserUpdateDto dto) {
        userService.updateAdminUser(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "修改用户状态", description = "管理员修改用户状态")
    @PutMapping("updateUserStatusByAdmin")
    public Result<String> updateUserStatusByAdmin(@Valid @RequestBody AdminUserUpdateUserStatusDto dto) {
        userService.updateUserStatusByAdmin(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "修改管理员用户密码", description = "管理员修改管理员用户密码")
    @PutMapping("updateUserPasswordByAdmin")
    public Result<String> updateUserPasswordByAdmin(@Valid @RequestBody AdminUserUpdateWithPasswordDto dto) {
        userService.updateUserPasswordByAdmin(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "修改用户头像", description = "管理员修改用户头像")
    @PutMapping("uploadAvatarByAdmin")
    public Result<String> uploadAvatarByAdmin(@Valid UserUpdateWithAvatarDto dto) {
        userService.uploadAvatarByAdmin(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "强制退出", description = "强制退出")
    @PutMapping("forcedOffline")
    public Result<String> forcedOffline(@RequestBody Long id) {
        userService.forcedOffline(id);
        return Result.success();
    }

    @Operation(summary = "登录发送邮件验证码", description = "登录发送邮件验证码")
    @PostMapping("noAuth/sendLoginEmail")
    public Result<String> sendLoginEmail(String email) {
        userService.sendLoginEmail(email);
        return Result.success(ResultCodeEnum.EMAIL_CODE_SEND_SUCCESS);
    }

    @Operation(summary = "刷新token", description = "刷新用户token")
    @PostMapping("noAuth/refreshToken")
    public Result<RefreshTokenVo> refreshToken(@Valid @RequestBody RefreshTokenDto dto) {
        RefreshTokenVo vo = userService.refreshToken(dto);
        return Result.success(vo);
    }

    @Operation(summary = "添加用户信息", description = "添加用户信息")
    @PostMapping("addAdminUser")
    public Result<Object> addAdminUser(@Valid @RequestBody AdminUserAddDto dto) {
        userService.addAdminUser(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "退出登录", description = "退出登录")
    @PostMapping("noManage/logout")
    public Result<String> logout() {
        userService.logout();
        return Result.success(ResultCodeEnum.LOGOUT_SUCCESS);
    }

    @Operation(summary = "删除用户信息", description = "删除用户信息")
    @DeleteMapping("deleteAdminUser")
    public Mono<Result<String>> deleteAdminUser(@RequestBody List<Long> ids) {
        userService.deleteAdminUser(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}