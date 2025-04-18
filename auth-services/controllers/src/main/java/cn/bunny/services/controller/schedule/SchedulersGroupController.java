package cn.bunny.services.controller.schedule;

import cn.bunny.domain.quartz.dto.SchedulersGroupAddDto;
import cn.bunny.domain.quartz.dto.SchedulersGroupDto;
import cn.bunny.domain.quartz.dto.SchedulersGroupUpdateDto;
import cn.bunny.domain.quartz.entity.SchedulersGroup;
import cn.bunny.domain.quartz.vo.SchedulersGroupVo;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.domain.vo.result.ResultCodeEnum;
import cn.bunny.services.service.schedule.SchedulersGroupService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
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
@Tag(name = "任务调度分组", description = "任务调度分组相关接口")
@RestController
@RequestMapping("api/schedulersGroup")
public class SchedulersGroupController {

    @Resource
    private SchedulersGroupService schedulersGroupService;

    @Operation(summary = "分页查询任务调度分组", description = "分页查询任务调度分组")
    @GetMapping("getSchedulersGroupList/{page}/{limit}")
    public Result<PageResult<SchedulersGroupVo>> getSchedulersGroupList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            SchedulersGroupDto dto) {
        Page<SchedulersGroup> pageParams = new Page<>(page, limit);
        PageResult<SchedulersGroupVo> pageResult = schedulersGroupService.getSchedulersGroupList(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "获取所有任务调度分组", description = "获取所有任务调度分组")
    @GetMapping("getAllSchedulersGroup")
    public Result<List<SchedulersGroupVo>> getAllSchedulersGroup() {
        List<SchedulersGroupVo> voList = schedulersGroupService.getAllSchedulersGroup();
        return Result.success(voList);
    }

    @Operation(summary = "添加任务调度分组", description = "添加任务调度分组")
    @PostMapping("addSchedulersGroup")
    public Result<String> addSchedulersGroup(@Valid @RequestBody SchedulersGroupAddDto dto) {
        schedulersGroupService.addSchedulersGroup(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新任务调度分组", description = "更新任务调度分组")
    @PutMapping("updateSchedulersGroup")
    public Result<String> updateSchedulersGroup(@Valid @RequestBody SchedulersGroupUpdateDto dto) {
        schedulersGroupService.updateSchedulersGroup(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除任务调度分组", description = "删除任务调度分组")
    @DeleteMapping("deleteSchedulersGroup")
    public Result<String> deleteSchedulersGroup(@RequestBody List<Long> ids) {
        schedulersGroupService.deleteSchedulersGroup(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }
}
