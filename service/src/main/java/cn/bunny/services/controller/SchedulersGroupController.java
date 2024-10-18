package cn.bunny.services.controller;

import cn.bunny.dao.dto.quartz.scheduleGroup.SchedulersGroupAddDto;
import cn.bunny.dao.dto.quartz.scheduleGroup.SchedulersGroupDto;
import cn.bunny.dao.dto.quartz.scheduleGroup.SchedulersGroupUpdateDto;
import cn.bunny.dao.entity.quartz.SchedulersGroup;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.quartz.SchedulersGroupVo;
import cn.bunny.services.service.SchedulersGroupService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.List;

/**
 * <p>
 * 任务调度分组 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-15 20:26:32
 */
@Tag(name = "任务调度分组", description = "任务调度分组相关接口")
@RestController
@RequestMapping("admin/schedulersGroup")
public class SchedulersGroupController {

    @Autowired
    private SchedulersGroupService schedulersGroupService;

    @Operation(summary = "分页查询任务调度分组", description = "分页查询任务调度分组")
    @GetMapping("getSchedulersGroupList/{page}/{limit}")
    public Mono<Result<PageResult<SchedulersGroupVo>>> getSchedulersGroupList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            SchedulersGroupDto dto) {
        Page<SchedulersGroup> pageParams = new Page<>(page, limit);
        PageResult<SchedulersGroupVo> pageResult = schedulersGroupService.getSchedulersGroupList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }

    @Operation(summary = "获取所有任务调度分组", description = "获取所有任务调度分组")
    @GetMapping("getAllSchedulersGroup")
    public Mono<Result<List<SchedulersGroupVo>>> getAllSchedulersGroup() {
        List<SchedulersGroupVo> voList = schedulersGroupService.getAllSchedulersGroup();
        return Mono.just(Result.success(voList));
    }

    @Operation(summary = "添加任务调度分组", description = "添加任务调度分组")
    @PostMapping("addSchedulersGroup")
    public Mono<Result<String>> addSchedulersGroup(@Valid @RequestBody SchedulersGroupAddDto dto) {
        schedulersGroupService.addSchedulersGroup(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "更新任务调度分组", description = "更新任务调度分组")
    @PutMapping("updateSchedulersGroup")
    public Mono<Result<String>> updateSchedulersGroup(@Valid @RequestBody SchedulersGroupUpdateDto dto) {
        schedulersGroupService.updateSchedulersGroup(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "删除任务调度分组", description = "删除任务调度分组")
    @DeleteMapping("deleteSchedulersGroup")
    public Mono<Result<String>> deleteSchedulersGroup(@RequestBody List<Long> ids) {
        schedulersGroupService.deleteSchedulersGroup(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
