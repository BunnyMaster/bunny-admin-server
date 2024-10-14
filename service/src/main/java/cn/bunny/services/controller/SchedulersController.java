package cn.bunny.services.controller;

import cn.bunny.dao.dto.schedulers.SchedulersAddDto;
import cn.bunny.dao.entity.view.Schedulers;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.services.service.SchedulersService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

/**
 * <p>
 * VIEW 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-14
 */
@Tag(name = "定时任务", description = "定时任务相关接口")
@RestController
@RequestMapping("admin/schedulers")
public class SchedulersController {
    @Autowired
    private SchedulersService schedulersService;

    @Operation(summary = "分页查询所有任务", description = "分页查询所有任务")
    @PostMapping("getSchedulerList/{page}/{limit}")
    public Result<PageResult<Schedulers>> getSchedulerList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit) {
        Page<Schedulers> pageParams = new Page<>(page, limit);
        PageResult<Schedulers> pageResult = schedulersService.getSchedulerList(pageParams);
        return Result.success(pageResult);
    }

    @Operation(summary = "添加任务", description = "添加任务")
    @PostMapping("/addScheduler")
    public Result<String> addScheduler(@RequestBody SchedulersAddDto dto) {
        schedulersService.addScheduler(dto);
        return Result.success();
    }
}
