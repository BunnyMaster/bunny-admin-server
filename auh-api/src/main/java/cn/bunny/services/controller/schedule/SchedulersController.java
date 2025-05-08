package cn.bunny.services.controller.schedule;

import cn.bunny.services.aop.scanner.QuartzSchedulersScanner;
import cn.bunny.services.domain.common.enums.ResultCodeEnum;
import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.common.model.vo.result.Result;
import cn.bunny.services.domain.system.quartz.dto.SchedulersAddDto;
import cn.bunny.services.domain.system.quartz.dto.SchedulersDto;
import cn.bunny.services.domain.system.quartz.dto.SchedulersUpdateDto;
import cn.bunny.services.domain.system.quartz.entity.Schedulers;
import cn.bunny.services.domain.system.quartz.vo.SchedulersVo;
import cn.bunny.services.service.schedule.SchedulersService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * Schedulers视图 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-15 16:35:10
 */
@Tag(name = "任务调度", description = "调度任务相关接口")
@RestController
@RequestMapping("api/schedulers")
public class SchedulersController {

    @Resource
    private SchedulersService schedulersService;

    @Operation(summary = "分页查询任务调度", description = "分页查询任务执行", tags = "schedulers::query")
    @GetMapping("{page}/{limit}")
    public Result<PageResult<SchedulersVo>> getSchedulersPage(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            SchedulersDto dto) {
        Page<Schedulers> pageParams = new Page<>(page, limit);
        PageResult<SchedulersVo> pageResult = schedulersService.getSchedulersPage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "添加任务调度", description = "添加任务", tags = "schedulers::add")
    @PostMapping()
    public Result<Object> addSchedulers(@Valid @RequestBody SchedulersAddDto dto) {
        schedulersService.addSchedulers(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新任务调度", description = "更新任务", tags = "schedulers::update")
    @PutMapping()
    public Result<String> updateSchedulers(@Valid @RequestBody SchedulersUpdateDto dto) {
        schedulersService.updateSchedulers(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "暂停任务调度", description = "暂停任务", tags = "schedulers::update")
    @PutMapping("pause")
    public Result<String> pause(@RequestBody SchedulersUpdateDto dto) {
        schedulersService.pauseScheduler(dto);
        return Result.success();
    }

    @Operation(summary = "恢复任务调度", description = "恢复任务", tags = "schedulers::update")
    @PutMapping("resume")
    public Result<String> resume(@RequestBody SchedulersUpdateDto dto) {
        schedulersService.resumeScheduler(dto);
        return Result.success();
    }

    @Operation(summary = "删除任务调度", description = "删除任务", tags = "schedulers::delete")
    @DeleteMapping()
    public Result<String> deleteSchedulers(@RequestBody SchedulersUpdateDto dto) {
        schedulersService.deleteSchedulers(dto);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "获取所有可用调度任务", description = "获取所有可用调度任务", tags = "schedulers::query")
    @GetMapping("private")
    public Result<List<Map<String, String>>> getScheduleJobList() {
        List<Map<String, String>> mapList = QuartzSchedulersScanner.getScheduleJobList();
        return Result.success(mapList);
    }
}
