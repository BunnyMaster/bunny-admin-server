package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.email.user.EmailUserUpdateStatusDto;
import cn.bunny.dao.dto.system.email.user.EmailUsersAddDto;
import cn.bunny.dao.dto.system.email.user.EmailUsersDto;
import cn.bunny.dao.dto.system.email.user.EmailUsersUpdateDto;
import cn.bunny.dao.entity.system.EmailUsers;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.email.EmailUsersVo;
import cn.bunny.services.service.EmailUsersService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 邮箱用户发送配置 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-10 15:19:22
 */
@Tag(name = "邮箱用户发送配置", description = "邮箱用户发送配置相关接口")
@RestController
@RequestMapping("api/emailUsers")
public class EmailUsersController {

    @Autowired
    private EmailUsersService emailUsersService;

    @Operation(summary = "分页查询邮箱用户发送配置", description = "分页查询邮箱用户发送配置")
    @GetMapping("getEmailUsersList/{page}/{limit}")
    public Mono<Result<PageResult<EmailUsersVo>>> getEmailUsersList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            EmailUsersDto dto) {
        Page<EmailUsers> pageParams = new Page<>(page, limit);
        PageResult<EmailUsersVo> pageResult = emailUsersService.getEmailUsersList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }

    @Operation(summary = "获取所有邮箱配置用户", description = "获取所有邮箱配置用户")
    @GetMapping("noManage/getAllMailboxConfigurationUsers")
    public Mono<Result<List<Map<String, String>>>> getAllMailboxConfigurationUsers() {
        List<Map<String, String>> list = emailUsersService.getAllMailboxConfigurationUsers();
        return Mono.just(Result.success(list));
    }

    @Operation(summary = "添加邮箱用户发送配置", description = "添加邮箱用户发送配置")
    @PostMapping("addEmailUsers")
    public Mono<Result<String>> addEmailUsers(@Valid @RequestBody EmailUsersAddDto dto) {
        emailUsersService.addEmailUsers(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "更新邮箱用户发送配置", description = "更新邮箱用户发送配置")
    @PutMapping("updateEmailUsers")
    public Mono<Result<String>> updateEmailUsers(@Valid @RequestBody EmailUsersUpdateDto dto) {
        emailUsersService.updateEmailUsers(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "更新邮箱用户状态", description = "更新邮箱用户状态")
    @PutMapping("updateEmailUserStatus")
    public Result<String> updateEmailUserStatus(@Valid @RequestBody EmailUserUpdateStatusDto dto) {
        emailUsersService.updateEmailUserStatus(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除邮箱用户", description = "删除邮箱用户")
    @DeleteMapping("deleteEmailUsers")
    public Mono<Result<String>> deleteEmailUsers(@RequestBody List<Long> ids) {
        emailUsersService.deleteEmailUsers(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
