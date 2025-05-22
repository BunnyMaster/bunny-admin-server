package cn.bunny.services.controller.system;

import cn.bunny.services.aop.annotation.PermissionTag;
import cn.bunny.services.domain.common.enums.ResultCodeEnum;
import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.common.model.vo.result.Result;
import cn.bunny.services.domain.system.dto.user.AdminUserAddDto;
import cn.bunny.services.domain.system.dto.user.AdminUserDto;
import cn.bunny.services.domain.system.dto.user.AdminUserUpdateDto;
import cn.bunny.services.domain.system.entity.AdminUser;
import cn.bunny.services.domain.system.vo.user.AdminUserVo;
import cn.bunny.services.domain.system.vo.user.UserVo;
import cn.bunny.services.service.system.UserService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;


@Tag(name = "用户", description = "用户信息相关接口")
@PermissionTag(permission = "user:*")
@RestController
@RequestMapping("/api/user")
public class UserController {

    @Resource
    private UserService userService;

    @Operation(summary = "分页查询用户", description = "分页查询用户信息")
    @PermissionTag(permission = "user:query")
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

    @Operation(summary = "添加用户", description = "添加用户信息")
    @PermissionTag(permission = "user:add")
    @PostMapping()
    public Result<Object> addUserByAdmin(@Valid @RequestBody AdminUserAddDto dto) {
        userService.addUserByAdmin(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新用户", description = "更新用户信息，需要更新Redis中的内容")
    @PermissionTag(permission = "user:update")
    @PutMapping()
    public Result<String> updateUserByAdmin(@Valid AdminUserUpdateDto dto,
                                            @RequestPart(value = "avatar", required = false) MultipartFile avatar) {
        if (avatar != null) dto.setAvatar(avatar);

        userService.updateUserByAdmin(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除用户", description = "删除用户")
    @PermissionTag(permission = "user:delete")
    @DeleteMapping()
    public Result<Object> deleteUserByAdmin(@RequestBody List<Long> ids) {
        userService.deleteUserByAdmin(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "根据用户id查询用户", description = "根据用户ID获取用户信息，不包含Redis中的信息")
    @GetMapping("private/users/{id}")
    public Result<UserVo> getUserinfoById(@PathVariable Long id) {
        UserVo vo = userService.getUserinfoById(id);
        return Result.success(vo);
    }

    @Operation(summary = "根据关键字查询用户", description = "根据用户名查询用户列表")
    @GetMapping("private/users/search")
    public Result<List<UserVo>> getUserListByKeyword(String keyword) {
        List<UserVo> voList = userService.getUserListByKeyword(keyword);
        return Result.success(voList);
    }

    @Operation(summary = "强制退出用户", description = "强制退出")
    @PermissionTag(permission = "user:update")
    @PutMapping("{id}/force-logout")
    public Result<String> forcedOfflineByAdmin(@PathVariable Long id) {
        userService.forcedOfflineByAdmin(id);
        return Result.success();
    }

    @Operation(summary = "已登录用户", description = "查询缓存中已登录用户")
    @PermissionTag(permission = "user:query")
    @GetMapping("/users/logged-in/{page}/{limit}")
    public Result<PageResult<UserVo>> getCacheUserPage(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit) {
        Page<AdminUser> pageParams = new Page<>(page, limit);
        PageResult<UserVo> pageResult = userService.getCacheUserPage(pageParams);
        return Result.success(pageResult);
    }

}