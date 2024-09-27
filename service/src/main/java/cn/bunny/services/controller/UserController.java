package cn.bunny.services.controller;

import cn.bunny.dao.dto.user.RefreshTokenDto;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.user.RefreshTokenVo;
import cn.bunny.services.service.UserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;


@Tag(name = "系统用户", description = "系统用户相关接口")
@RestController
@RequestMapping("/admin/user")
public class UserController {

    @Autowired
    private UserService userService;

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

    @Operation(summary = "退出登录", description = "退出登录")
    @PostMapping("logout")
    public Result<String> logout() {
        userService.logout();
        return Result.success(ResultCodeEnum.LOGOUT_SUCCESS);
    }
}