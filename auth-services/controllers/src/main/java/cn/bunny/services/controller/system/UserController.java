package cn.bunny.services.controller.system;

import cn.bunny.domain.system.dto.user.*;
import cn.bunny.domain.system.entity.AdminUser;
import cn.bunny.domain.system.vo.user.*;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.domain.vo.result.ResultCodeEnum;
import cn.bunny.services.service.system.UserService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

import java.util.List;


@Tag(name = "用户信息", description = "用户信息相关接口")
@RestController
@RequestMapping("/api/user")
public class UserController {

    @Resource
    private UserService userService;

    @Operation(summary = "分页查询用户信息", description = "分页查询用户信息")
    @GetMapping("getAdminUserList/{page}/{limit}")
    public Result<PageResult<AdminUserVo>> getAdminUserList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            AdminUserDto dto) {
        Page<AdminUser> pageParams = new Page<>(page, limit);
        PageResult<AdminUserVo> pageResult = userService.getAdminUserList(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "获取本地登录用户信息", description = "获取用户信息从Redis中获取")
    @GetMapping("noManage/getUserinfo")
    public Result<LoginVo> getUserinfo() {
        LoginVo vo = userService.getUserinfo();
        return Result.success(vo);
    }

    @Operation(summary = "获取用户信息", description = "根据用户ID获取用户信息，不包含Redis中的信息")
    @GetMapping("getUserinfoById")
    public Result<UserVo> getUserinfoById(Long id) {
        UserVo vo = userService.getUserinfoById(id);
        return Result.success(vo);
    }

    @Operation(summary = "多条件查询用户", description = "多条件查询用户")
    @GetMapping("noManage/queryUser")
    public Result<List<SearchUserinfoVo>> queryUser(String keyword) {
        List<SearchUserinfoVo> voList = userService.queryUser(keyword);
        return Result.success(voList);
    }

    @Operation(summary = "更新用户信息", description = "更新用户信息，需要更新Redis中的内容")
    @PutMapping("updateAdminUser")
    public Result<String> updateAdminUser(@Valid @RequestBody AdminUserUpdateDto dto) {
        userService.updateAdminUser(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "更新本地用户信息", description = "更新本地用户信息，需要更新Redis中的内容")
    @PutMapping("noManage/updateAdminUserByLocalUser")
    public Result<String> updateAdminUserByLocalUser(@Valid @RequestBody AdminUserUpdateByLocalUserDto dto) {
        userService.updateAdminUserByLocalUser(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "更新本地用户密码", description = "更新本地用户密码")
    @PutMapping("noManage/updateUserPasswordByLocalUser")
    public Result<String> updateUserPasswordByLocalUser(String password) {
        userService.updateUserPasswordByLocalUser(password);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "管理员修改用户密码", description = "管理员修改管理员用户密码")
    @PutMapping("updateUserPasswordByAdmin")
    public Result<String> updateUserPasswordByAdmin(@Valid @RequestBody AdminUserUpdateWithPasswordDto dto) {
        userService.updateUserPasswordByAdmin(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "修改用户状态", description = "管理员修改用户状态")
    @PutMapping("updateUserStatusByAdmin")
    public Result<String> updateUserStatusByAdmin(@Valid @RequestBody AdminUserUpdateUserStatusDto dto) {
        userService.updateUserStatusByAdmin(dto);
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
    @PostMapping("noManage/refreshToken")
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

    @Operation(summary = "删除用户", description = "删除用户")
    @DeleteMapping("deleteAdminUser")
    public Result<Object> deleteAdminUser(@RequestBody List<Long> ids) {
        userService.deleteAdminUser(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }
}