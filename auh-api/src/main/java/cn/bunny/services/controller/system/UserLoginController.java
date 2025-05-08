package cn.bunny.services.controller.system;

import cn.bunny.services.context.BaseContext;
import cn.bunny.services.domain.common.enums.ResultCodeEnum;
import cn.bunny.services.domain.common.model.vo.LoginVo;
import cn.bunny.services.domain.common.model.vo.result.Result;
import cn.bunny.services.domain.system.system.dto.user.AdminUserUpdateByLocalUserDto;
import cn.bunny.services.domain.system.system.dto.user.LoginDto;
import cn.bunny.services.domain.system.system.dto.user.RefreshTokenDto;
import cn.bunny.services.domain.system.system.vo.user.RefreshTokenVo;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.service.system.UserLoginService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

@Tag(name = "普通用户登录", description = "用户登录相关接口")
@RestController
@RequestMapping("/api/user")
public class UserLoginController {

    @Resource
    private UserLoginService userLoginService;

    @Operation(summary = "普通用户登录", description = "前端用户登录")
    @PostMapping("login")
    public Result<LoginVo> login(@Valid @RequestBody LoginDto loginDto) {
        LoginVo loginVo = userLoginService.login(loginDto);
        return Result.success(loginVo);
    }

    @Operation(summary = "普通用户登录发送邮件验证码", description = "登录发送邮件验证码")
    @PostMapping("public/sendLoginEmail")
    public Result<String> sendLoginEmail(String email) {
        if (!StringUtils.hasText(email)) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        userLoginService.sendLoginEmail(email);
        return Result.success(ResultCodeEnum.EMAIL_CODE_SEND_SUCCESS);
    }

    @Operation(summary = "普通用户登录刷新token", description = "刷新用户token")
    @PostMapping("private/refreshToken")
    public Result<RefreshTokenVo> refreshToken(@Valid @RequestBody RefreshTokenDto dto) {
        RefreshTokenVo vo = userLoginService.refreshToken(dto);
        return Result.success(vo);
    }

    @Operation(summary = "获取本地登录用户信息", description = "获取用户信息从Redis中获取")
    @GetMapping("private/userinfo")
    public Result<LoginVo> userinfo() {
        LoginVo vo = BaseContext.getLoginVo();
        return Result.success(vo);
    }

    @Operation(summary = "普通用户登录退出登录", description = "退出登录")
    @PostMapping("private/logout")
    public Result<String> logout() {
        userLoginService.logout();
        return Result.success(ResultCodeEnum.LOGOUT_SUCCESS);
    }

    @Operation(summary = "更新本地用户信息", description = "更新本地用户信息，需要更新Redis中的内容")
    @PutMapping("private/update/userinfo")
    public Result<String> updateAdminUserByLocalUser(@Valid @RequestBody AdminUserUpdateByLocalUserDto dto) {
        userLoginService.updateAdminUserByLocalUser(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "更新本地用户密码", description = "更新本地用户密码")
    @PutMapping("private/update/password")
    public Result<String> updateUserPasswordByLocalUser(String password) {
        userLoginService.updateUserPasswordByLocalUser(password);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }
}
