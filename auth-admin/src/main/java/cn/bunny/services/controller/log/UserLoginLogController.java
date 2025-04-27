package cn.bunny.services.controller.log;

import cn.bunny.domain.log.dto.UserLoginLogDto;
import cn.bunny.domain.log.entity.UserLoginLog;
import cn.bunny.domain.log.vo.UserLoginLogLocalVo;
import cn.bunny.domain.log.vo.UserLoginLogVo;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.domain.vo.result.ResultCodeEnum;
import cn.bunny.services.service.log.UserLoginLogService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 用户登录日志表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-19 01:01:01
 */
@Tag(name = "用户登录日志", description = "用户登录日志相关接口")
@RestController
@RequestMapping("api/userLoginLog")
public class UserLoginLogController {

    @Resource
    private UserLoginLogService userLoginLogService;

    @Operation(summary = "分页查询", description = "分页查询用户登录日志")
    @GetMapping("{page}/{limit}")
    public Result<PageResult<UserLoginLogVo>> getUserLoginLogPage(
            @Parameter(name = "page", description = "当前页", required = true) @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true) @PathVariable("limit") Integer limit,
            UserLoginLogDto dto) {
        Page<UserLoginLog> pageParams = new Page<>(page, limit);
        PageResult<UserLoginLogVo> pageResult = userLoginLogService.getUserLoginLogPage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "删除", description = "删除用户登录日志")
    @DeleteMapping()
    public Result<Object> deleteUserLoginLog(@RequestBody List<Long> ids) {
        userLoginLogService.deleteUserLoginLog(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "分页查询本地用户登录日志", description = "分页查询本地用户登录日志")
    @GetMapping("private/{page}/{limit}")
    public Result<PageResult<UserLoginLogLocalVo>> getUserLoginLogPageByUser(
            @Parameter(name = "page", description = "当前页", required = true) @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true) @PathVariable("limit") Integer limit) {
        Page<UserLoginLog> pageParams = new Page<>(page, limit);
        PageResult<UserLoginLogLocalVo> voPageResult = userLoginLogService.getUserLoginLogPageByUser(pageParams);
        return Result.success(voPageResult);
    }
}
