package cn.bunny.services.controller.log;

import cn.bunny.dao.dto.log.UserLoginLogDto;
import cn.bunny.dao.entity.log.UserLoginLog;
import cn.bunny.dao.vo.log.UserLoginLogLocalVo;
import cn.bunny.dao.vo.log.UserLoginLogVo;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.services.service.log.UserLoginLogService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

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

    private final UserLoginLogService userLoginLogService;

    public UserLoginLogController(UserLoginLogService userLoginLogService) {
        this.userLoginLogService = userLoginLogService;
    }

    @Operation(summary = "分页查询用户登录日志", description = "分页查询用户登录日志")
    @GetMapping("getUserLoginLogList/{page}/{limit}")
    public Result<PageResult<UserLoginLogVo>> getUserLoginLogList(
            @Parameter(name = "page", description = "当前页", required = true) @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true) @PathVariable("limit") Integer limit,
            UserLoginLogDto dto) {
        Page<UserLoginLog> pageParams = new Page<>(page, limit);
        PageResult<UserLoginLogVo> pageResult = userLoginLogService.getUserLoginLogList(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "获取本地用户登录日志", description = "获取本地用户登录日志")
    @GetMapping("noManage/getUserLoginLogListByLocalUser/{page}/{limit}")
    public Result<PageResult<UserLoginLogLocalVo>> getUserLoginLogListByLocalUser(
            @Parameter(name = "page", description = "当前页", required = true) @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true) @PathVariable("limit") Integer limit) {
        Page<UserLoginLog> pageParams = new Page<>(page, limit);
        PageResult<UserLoginLogLocalVo> voPageResult = userLoginLogService.getUserLoginLogListByLocalUser(pageParams);
        return Result.success(voPageResult);
    }

    @Operation(summary = "删除用户登录日志", description = "删除用户登录日志")
    @DeleteMapping("deleteUserLoginLog")
    public Mono<Result<String>> deleteUserLoginLog(@RequestBody List<Long> ids) {
        userLoginLogService.deleteUserLoginLog(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
