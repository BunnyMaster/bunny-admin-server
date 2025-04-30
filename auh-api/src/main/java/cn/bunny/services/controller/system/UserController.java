package cn.bunny.services.controller.system;

import cn.bunny.services.context.BaseContext;
import cn.bunny.services.domain.common.vo.LoginVo;
import cn.bunny.services.domain.common.vo.result.PageResult;
import cn.bunny.services.domain.common.vo.result.Result;
import cn.bunny.services.domain.common.vo.result.ResultCodeEnum;
import cn.bunny.services.domain.system.system.dto.user.*;
import cn.bunny.services.domain.system.system.entity.AdminUser;
import cn.bunny.services.domain.system.system.vo.user.AdminUserVo;
import cn.bunny.services.domain.system.system.vo.user.RefreshTokenVo;
import cn.bunny.services.domain.system.system.vo.user.UserVo;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.service.system.UserService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;


@Tag(name = "系统用户", description = "用户信息相关接口")
@RestController
@RequestMapping("/api/user")
public class UserController {

    @Resource
    private UserService userService;

    // -----------------------------------------
    // 用户登录和退出
    // -----------------------------------------
    @Operation(summary = "用户登录", description = "前端用户登录")
    @PostMapping("login")
    public Result<LoginVo> login(@Valid @RequestBody LoginDto loginDto) {
        LoginVo loginVo = userService.login(loginDto);
        return Result.success(loginVo);
    }

    @Operation(summary = "登录发送邮件验证码", description = "登录发送邮件验证码")
    @PostMapping("public/sendLoginEmail")
    public Result<String> sendLoginEmail(String email) {
        if (!StringUtils.hasText(email)) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        userService.sendLoginEmail(email);
        return Result.success(ResultCodeEnum.EMAIL_CODE_SEND_SUCCESS);
    }

    @Operation(summary = "刷新token", description = "刷新用户token")
    @PostMapping("private/refreshToken")
    public Result<RefreshTokenVo> refreshToken(@Valid @RequestBody RefreshTokenDto dto) {
        RefreshTokenVo vo = userService.refreshToken(dto);
        return Result.success(vo);
    }

    @Operation(summary = "获取本地登录用户信息", description = "获取用户信息从Redis中获取")
    @GetMapping("private/userinfo")
    public Result<LoginVo> userinfo() {
        LoginVo vo = BaseContext.getLoginVo();
        return Result.success(vo);
    }

    @Operation(summary = "退出登录", description = "退出登录")
    @PostMapping("private/logout")
    public Result<String> logout() {
        userService.logout();
        return Result.success(ResultCodeEnum.LOGOUT_SUCCESS);
    }

    // -----------------------------------------
    // 管理用户CURD
    // -----------------------------------------
    @Operation(summary = "分页查询", description = "分页查询用户信息", tags = "user::query")
    @GetMapping("{page}/{limit}")
    public Result<PageResult<AdminUserVo>> getUserPageByAdmin(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            AdminUserDto dto) {
        Page<AdminUser> pageParams = new Page<>(page, limit);
        PageResult<AdminUserVo> pageResult = userService.getUserPageByAdmin(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "添加", description = "添加用户信息", tags = "user::add")
    @PostMapping()
    public Result<Object> addUserByAdmin(@Valid @RequestBody AdminUserAddDto dto) {
        userService.addUserByAdmin(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新", description = "更新用户信息，需要更新Redis中的内容", tags = "user::update")
    @PutMapping()
    public Result<String> updateUserByAdmin(
            @Valid AdminUserUpdateDto dto,
            @RequestPart(value = "avatar", required = false) MultipartFile avatar) {
        if (avatar != null) {
            dto.setAvatar(avatar);
        }
        userService.updateUserByAdmin(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除用户", description = "删除用户", tags = "user::delete")
    @DeleteMapping()
    public Result<Object> deleteUserByAdmin(@RequestBody List<Long> ids) {
        userService.deleteUserByAdmin(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "根据用户id查询", description = "根据用户ID获取用户信息，不包含Redis中的信息", tags = "user::query")
    @GetMapping("private/getUserinfoById")
    public Result<UserVo> getUserinfoById(Long id) {
        UserVo vo = userService.getUserinfoById(id);
        return Result.success(vo);
    }

    @Operation(summary = "根据用户名查询用户列表", description = "根据用户名查询用户列表", tags = "user::query")
    @GetMapping("private/getUserListByKeyword")
    public Result<List<UserVo>> getUserListByKeyword(String keyword) {
        List<UserVo> voList = userService.getUserListByKeyword(keyword);
        return Result.success(voList);
    }

    @Operation(summary = "强制退出", description = "强制退出", tags = "user::update")
    @PutMapping("forcedOffline")
    public Result<String> forcedOfflineByAdmin(@RequestBody Long id) {
        userService.forcedOfflineByAdmin(id);
        return Result.success();
    }

    // -----------------------------------------
    // 普通用户
    // -----------------------------------------
    @Operation(summary = "更新本地用户信息", description = "更新本地用户信息，需要更新Redis中的内容")
    @PutMapping("private/update/userinfo")
    public Result<String> updateAdminUserByLocalUser(@Valid @RequestBody AdminUserUpdateByLocalUserDto dto) {
        userService.updateAdminUserByLocalUser(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "更新本地用户密码", description = "更新本地用户密码")
    @PutMapping("private/update/password")
    public Result<String> updateUserPasswordByLocalUser(String password) {
        userService.updateUserPasswordByLocalUser(password);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }
}