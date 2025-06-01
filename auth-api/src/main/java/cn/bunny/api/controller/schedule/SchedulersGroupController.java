package cn.bunny.api.controller.schedule;

import cn.bunny.core.annotation.PermissionTag;
import cn.bunny.domain.common.ValidationGroups;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.common.model.vo.result.Result;
import cn.bunny.domain.schedule.dto.SchedulersGroupDto;
import cn.bunny.domain.schedule.entity.SchedulersGroup;
import cn.bunny.domain.schedule.vo.SchedulersGroupVo;
import cn.bunny.schedule.service.SchedulersGroupService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * <p>
 * 任务调度分组 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-15 20:26:32
 */
@Tag(name = "任务调度分组" , description = "任务调度分组相关接口" )
@PermissionTag(permission = "schedulersGroup:*" )
@RestController
@RequestMapping("api/schedulers-group" )
public class SchedulersGroupController {

    @Resource
    private SchedulersGroupService schedulersGroupService;

    @Operation(summary = "分页查询任务调度分组" , description = "分页查询任务调度分组" )
    @PermissionTag(permission = "schedulersGroup:query" )
    @GetMapping("{page}/{limit}" )
    public Result<PageResult<SchedulersGroupVo>> getSchedulersGroupPage(
            @Parameter(name = "page" , description = "当前页" , required = true)
            @PathVariable("page" ) Integer page,
            @Parameter(name = "limit" , description = "每页记录数" , required = true)
            @PathVariable("limit" ) Integer limit,
            SchedulersGroupDto dto) {
        Page<SchedulersGroup> pageParams = new Page<>(page, limit);
        PageResult<SchedulersGroupVo> pageResult = schedulersGroupService.getSchedulersGroupPage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "添加任务调度分组" , description = "添加任务调度分组" )
    @PermissionTag(permission = "schedulersGroup:add" )
    @PostMapping()
    public Result<String> createSchedulersGroup(@Validated(ValidationGroups.Add.class) @RequestBody SchedulersGroupDto dto) {
        schedulersGroupService.createSchedulersGroup(dto);
        return Result.success(ResultCodeEnum.CREATE_SUCCESS);
    }

    @Operation(summary = "更新任务调度分组" , description = "更新任务调度分组" )
    @PermissionTag(permission = "schedulersGroup:update" )
    @PutMapping()
    public Result<String> updateSchedulersGroup(@Validated(ValidationGroups.Update.class) @RequestBody SchedulersGroupDto dto) {
        schedulersGroupService.updateSchedulersGroup(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除任务调度分组" , description = "删除任务调度分组" )
    @PermissionTag(permission = "schedulersGroup:delete" )
    @DeleteMapping()
    public Result<String> deleteSchedulersGroup(@RequestBody List<Long> ids) {
        schedulersGroupService.deleteSchedulersGroup(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "获取所有任务调度分组" , description = "获取所有任务调度分组" )
    @PermissionTag(permission = "schedulersGroup:query" )
    @GetMapping("scheduler-groups" )
    public Result<List<SchedulersGroupVo>> getSchedulersGroupList() {
        List<SchedulersGroupVo> voList = schedulersGroupService.getSchedulersGroupList();
        return Result.success(voList);
    }
}
