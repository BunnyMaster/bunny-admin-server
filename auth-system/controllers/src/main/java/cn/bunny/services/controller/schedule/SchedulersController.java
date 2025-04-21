package cn.bunny.services.controller.schedule;

import cn.bunny.domain.quartz.vo.SchedulersOperationDto;
import cn.bunny.domain.quartz.dto.SchedulersAddDto;
import cn.bunny.domain.quartz.dto.SchedulersDto;
import cn.bunny.domain.quartz.dto.SchedulersUpdateDto;
import cn.bunny.domain.quartz.entity.Schedulers;
import cn.bunny.domain.quartz.vo.SchedulersVo;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.domain.vo.result.ResultCodeEnum;
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
@Tag(name = "调度任务", description = "调度任务相关接口")
@RestController
@RequestMapping("api/schedulers")
public class SchedulersController {

    @Resource
    private SchedulersService schedulersService;

    @Operation(summary = "分页查询视图", description = "分页查询视图")
    @GetMapping("getSchedulersList/{page}/{limit}")
    public Result<PageResult<SchedulersVo>> getSchedulersList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            SchedulersDto dto) {
        Page<Schedulers> pageParams = new Page<>(page, limit);
        PageResult<SchedulersVo> pageResult = schedulersService.getSchedulersList(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "获取所有可用调度任务", description = "获取所有可用调度任务")
    @GetMapping("noManage/getAllScheduleJobList")
    public Result<List<Map<String, String>>> getAllScheduleJobList() {
        List<Map<String, String>> mapList = schedulersService.getAllScheduleJobList();
        return Result.success(mapList);
    }

    @Operation(summary = "添加任务", description = "添加任务")
    @PostMapping("addSchedulers")
    public Result<Object> addSchedulers(@Valid @RequestBody SchedulersAddDto dto) {
        schedulersService.addSchedulers(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新任务", description = "更新任务")
    @PutMapping("updateSchedulers")
    public Result<String> updateSchedulers(@Valid @RequestBody SchedulersUpdateDto dto) {
        schedulersService.updateSchedulers(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }


    @Operation(summary = "暂停任务", description = "暂停任务")
    @PutMapping("pauseSchedulers")
    public Result<String> pause(@RequestBody SchedulersOperationDto dto) {
        schedulersService.pauseScheduler(dto);
        return Result.success();
    }

    @Operation(summary = "恢复任务", description = "恢复任务")
    @PutMapping("resumeSchedulers")
    public Result<String> resume(@RequestBody SchedulersOperationDto dto) {
        schedulersService.resumeScheduler(dto);
        return Result.success();
    }

    @Operation(summary = "删除任务", description = "删除任务")
    @DeleteMapping("deleteSchedulers")
    public Result<String> deleteSchedulers(@RequestBody SchedulersOperationDto dto) {
        schedulersService.deleteSchedulers(dto);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }
}
