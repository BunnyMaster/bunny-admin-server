package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.rolePower.PowerAddDto;
import cn.bunny.dao.dto.system.rolePower.PowerDto;
import cn.bunny.dao.dto.system.rolePower.PowerUpdateBatchByParentIdDto;
import cn.bunny.dao.dto.system.rolePower.PowerUpdateDto;
import cn.bunny.dao.entity.system.Power;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.rolePower.PowerVo;
import cn.bunny.services.service.PowerService;
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
 * 权限表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 16:00:52
 */
@Tag(name = "权限", description = "权限相关接口")
@RestController
@RequestMapping("admin/power")
public class PowerController {

    @Autowired
    private PowerService powerService;

    @Operation(summary = "分页查询权限", description = "分页查询权限")
    @GetMapping("getPowerList/{page}/{limit}")
    public Mono<Result<PageResult<PowerVo>>> getPowerList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            PowerDto dto) {
        Page<Power> pageParams = new Page<>(page, limit);
        PageResult<PowerVo> pageResult = powerService.getPowerList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }

    @Operation(summary = "获取所有权限", description = "获取所有权限")
    @GetMapping("getAllPowers")
    public Mono<Result<List<PowerVo>>> getAllPowers() {
        List<PowerVo> voList = powerService.getAllPowers();
        return Mono.just(Result.success(voList));
    }

    @Operation(summary = "添加权限", description = "添加权限")
    @PostMapping("addPower")
    public Mono<Result<String>> addPower(@Valid @RequestBody PowerAddDto dto) {
        powerService.addPower(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "更新权限", description = "更新权限")
    @PutMapping("updatePower")
    public Mono<Result<String>> updatePower(@Valid @RequestBody PowerUpdateDto dto) {
        powerService.updatePower(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "批量修改权限父级", description = "批量修改权限父级")
    @PutMapping("updateBatchByPowerWithParentId")
    public Mono<Result<String>> updateBatchByPowerWithParentId(@RequestBody @Valid PowerUpdateBatchByParentIdDto dto) {
        powerService.updateBatchByPowerWithParentId(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "删除权限", description = "删除权限")
    @DeleteMapping("deletePower")
    public Mono<Result<String>> deletePower(@RequestBody List<Long> ids) {
        powerService.deletePower(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }

}
