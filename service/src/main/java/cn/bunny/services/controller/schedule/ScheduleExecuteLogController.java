package cn.bunny.services.controller.schedule;

import cn.bunny.dao.dto.log.ScheduleExecuteLogDto;
import cn.bunny.dao.entity.log.ScheduleExecuteLog;
import cn.bunny.dao.vo.log.QuartzExecuteLogVo;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.services.service.schedule.ScheduleExecuteLogService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.List;

/**
 * <p>
 * 调度任务执行日志表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-18 12:56:39
 */
@Tag(name = "调度任务执行日志", description = "调度任务执行日志相关接口")
@RestController
@RequestMapping("api/quartzExecuteLog")
public class ScheduleExecuteLogController {

    @Autowired
    private ScheduleExecuteLogService scheduleExecuteLogService;

    @Operation(summary = "分页查询调度任务执行日志", description = "分页查询调度任务执行日志")
    @GetMapping("getQuartzExecuteLogList/{page}/{limit}")
    public Mono<Result<PageResult<QuartzExecuteLogVo>>> getQuartzExecuteLogList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            ScheduleExecuteLogDto dto) {
        Page<ScheduleExecuteLog> pageParams = new Page<>(page, limit);
        PageResult<QuartzExecuteLogVo> pageResult = scheduleExecuteLogService.getQuartzExecuteLogList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }

    @Operation(summary = "删除调度任务执行日志", description = "删除调度任务执行日志")
    @DeleteMapping("deleteQuartzExecuteLog")
    public Mono<Result<String>> deleteQuartzExecuteLog(@RequestBody List<Long> ids) {
        scheduleExecuteLogService.deleteQuartzExecuteLog(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
