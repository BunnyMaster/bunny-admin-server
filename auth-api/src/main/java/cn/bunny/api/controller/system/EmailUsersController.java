package cn.bunny.api.controller.system;

import cn.bunny.core.annotation.PermissionTag;
import cn.bunny.domain.common.ValidationGroups;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.common.model.vo.result.Result;
import cn.bunny.domain.system.dto.EmailUsersDto;
import cn.bunny.domain.system.entity.EmailUsers;
import cn.bunny.domain.system.vo.EmailUsersVo;
import cn.bunny.system.service.EmailUsersService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

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
@Tag(name = "邮箱用户配置" , description = "邮箱用户发送配置相关接口" )
@PermissionTag(permission = "emailUsers:*" )
@RestController
@RequestMapping("api/email-users" )
public class EmailUsersController {

    @Resource
    private EmailUsersService emailUsersService;

    @Operation(summary = "分页查询邮箱用户配置" , description = "分页查询邮箱用户配置" )
    @PermissionTag(permission = "emailUsers:query" )
    @GetMapping("{page}/{limit}" )
    public Result<PageResult<EmailUsersVo>> getEmailUserPage(
            @Parameter(name = "page" , description = "当前页" , required = true)
            @PathVariable("page" ) Integer page,
            @Parameter(name = "limit" , description = "每页记录数" , required = true)
            @PathVariable("limit" ) Integer limit,
            EmailUsersDto dto) {
        Page<EmailUsers> pageParams = new Page<>(page, limit);
        PageResult<EmailUsersVo> pageResult = emailUsersService.getEmailUserPage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "添加邮箱用户配置" , description = "添加邮箱用户配置" )
    @PermissionTag(permission = "emailUsers:add" )
    @PostMapping()
    public Result<String> createEmailUsers(@Validated(ValidationGroups.Add.class) @RequestBody EmailUsersDto dto) {
        emailUsersService.createEmailUsers(dto);
        return Result.success(ResultCodeEnum.CREATE_SUCCESS);
    }

    @Operation(summary = "更新邮箱用户配置" , description = "更新邮箱用户配置" )
    @PermissionTag(permission = "emailUsers:update" )
    @PutMapping()
    public Result<String> updateEmailUsers(@Validated(ValidationGroups.Update.class) @RequestBody EmailUsersDto dto) {
        emailUsersService.updateEmailUsers(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除邮箱用户配置" , description = "删除邮箱用户配置" )
    @PermissionTag(permission = "emailUsers:delete" )
    @DeleteMapping()
    public Result<String> deleteEmailUsers(@RequestBody List<Long> ids) {
        emailUsersService.deleteEmailUsers(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "全部邮箱用户配置" , description = "获取全部邮箱用户配置" )
    @GetMapping("private" )
    public Result<List<Map<String, String>>> getEmailUserList() {
        List<Map<String, String>> list = emailUsersService.getAllMailboxConfigurationUsers();
        return Result.success(list);
    }
}
