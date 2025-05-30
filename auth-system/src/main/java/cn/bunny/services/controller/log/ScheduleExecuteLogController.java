package cn.bunny.services.controller.log;

import cn.bunny.services.aop.annotation.PermissionTag;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.common.model.vo.result.Result;
import cn.bunny.domain.log.dto.ScheduleExecuteLogDto;
import cn.bunny.domain.log.entity.ScheduleExecuteLog;
import cn.bunny.domain.log.vo.ScheduleExecuteLogVo;
import cn.bunny.services.service.log.ScheduleExecuteLogService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 调度任务执行日志表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-18 12:56:39
 */
@Tag(name = "任务调度执行日志", description = "调度任务执行日志相关接口")
@PermissionTag(permission = "scheduleExecuteLog:*")
@RestController
@RequestMapping("api/schedule-execute-log")
public class ScheduleExecuteLogController {

    @Resource
    private ScheduleExecuteLogService scheduleExecuteLogService;

    @Operation(summary = "分页查询任务调度执行日志", description = "分页查询调度任务执行日志")
    @PermissionTag(permission = "scheduleExecuteLog:query")
    @GetMapping("{page}/{limit}")
    public Result<PageResult<ScheduleExecuteLogVo>> getScheduleExecuteLogPage(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            ScheduleExecuteLogDto dto) {
        Page<ScheduleExecuteLog> pageParams = new Page<>(page, limit);
        PageResult<ScheduleExecuteLogVo> pageResult = scheduleExecuteLogService.getScheduleExecuteLogPage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "删除任务调度执行日志", description = "删除调度任务执行日志")
    @PermissionTag(permission = "scheduleExecuteLog:delete")
    @DeleteMapping()
    public Result<String> deleteScheduleExecuteLog(@RequestBody List<Long> ids) {
        scheduleExecuteLogService.deleteScheduleExecuteLog(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }
}
