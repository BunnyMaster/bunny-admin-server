package cn.bunny.services.controller;

import cn.bunny.dao.dto.schedulers.SchedulersAddDto;
import cn.bunny.dao.dto.schedulers.SchedulersDto;
import cn.bunny.dao.dto.schedulers.SchedulersOperationDto;
import cn.bunny.dao.entity.schedulers.Schedulers;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.schedulers.SchedulersVo;
import cn.bunny.services.service.SchedulersService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

/**
 * <p>
 * Schedulers视图表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-15 16:35:10
 */
@Tag(name = "Schedulers视图", description = "Schedulers视图相关接口")
@RestController
@RequestMapping("admin/schedulers")
public class SchedulersController {

    @Autowired
    private SchedulersService schedulersService;

    @Operation(summary = "分页查询Schedulers视图", description = "分页查询Schedulers视图")
    @GetMapping("getSchedulersList/{page}/{limit}")
    public Mono<Result<PageResult<SchedulersVo>>> getSchedulersList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            SchedulersDto dto) {
        Page<Schedulers> pageParams = new Page<>(page, limit);
        PageResult<SchedulersVo> pageResult = schedulersService.getSchedulersList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }

    @Operation(summary = "添加Schedulers任务", description = "添加Schedulers任务")
    @PostMapping("addSchedulers")
    public Mono<Result<String>> addSchedulers(@Valid @RequestBody SchedulersAddDto dto) {
        schedulersService.addSchedulers(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "暂停Schedulers任务", description = "暂停任务")
    @PutMapping("/pauseScheduler")
    public Result<String> pause(@RequestBody SchedulersOperationDto dto) {
        schedulersService.pauseScheduler(dto);
        return Result.success();
    }

    @Operation(summary = "恢复Schedulers任务", description = "恢复任务")
    @PutMapping("/resumeScheduler")
    public Result<String> resume(@RequestBody SchedulersOperationDto dto) {
        schedulersService.resumeScheduler(dto);
        return Result.success();
    }

    @Operation(summary = "删除Schedulers任务", description = "删除任务")
    @DeleteMapping("/deleteSchedulers")
    public Mono<Result<Object>> deleteSchedulers(@RequestBody SchedulersOperationDto dto) {
        schedulersService.deleteSchedulers(dto);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
