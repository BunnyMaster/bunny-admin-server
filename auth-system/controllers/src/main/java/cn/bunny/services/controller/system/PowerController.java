package cn.bunny.services.controller.system;

import cn.bunny.domain.system.dto.power.PowerAddDto;
import cn.bunny.domain.system.dto.power.PowerDto;
import cn.bunny.domain.system.dto.power.PowerUpdateBatchByParentIdDto;
import cn.bunny.domain.system.dto.power.PowerUpdateDto;
import cn.bunny.domain.system.entity.Permission;
import cn.bunny.domain.system.vo.PowerVo;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.domain.vo.result.ResultCodeEnum;
import cn.bunny.services.service.system.PowerService;
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
 * 权限 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 16:00:52
 */
@Tag(name = "系统权限", description = "权限相关接口")
@RestController
@RequestMapping("api/power")
public class PowerController {

    @Resource
    private PowerService powerService;

    @Operation(summary = "分页查询权限", description = "分页查询权限")
    @GetMapping("getPowerList/{page}/{limit}")
    public Result<PageResult<PowerVo>> getPowerList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            PowerDto dto) {
        Page<Permission> pageParams = new Page<>(page, limit);
        PageResult<PowerVo> pageResult = powerService.getPowerList(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "获取所有权限", description = "获取所有权限")
    @GetMapping("getAllPowers")
    public Result<List<PowerVo>> getAllPowers() {
        List<PowerVo> voList = powerService.getAllPowers();
        return Result.success(voList);
    }

    @Operation(summary = "添加权限", description = "添加权限")
    @PostMapping("addPower")
    public Result<String> addPower(@Valid @RequestBody PowerAddDto dto) {
        powerService.addPower(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新权限", description = "更新权限")
    @PutMapping("updatePower")
    public Result<Object> updatePower(@Valid @RequestBody PowerUpdateDto dto) {
        powerService.updatePower(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "批量修改权限父级", description = "批量修改权限父级")
    @PutMapping("updateBatchByPowerWithParentId")
    public Result<String> updateBatchByPowerWithParentId(@RequestBody @Valid PowerUpdateBatchByParentIdDto dto) {
        powerService.updateBatchByPowerWithParentId(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除权限", description = "删除权限")
    @DeleteMapping("deletePower")
    public Result<Object> deletePower(@RequestBody List<Long> ids) {
        powerService.deletePower(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

}
