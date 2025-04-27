package cn.bunny.services.controller.system;

import cn.bunny.domain.system.dto.dept.DeptAddDto;
import cn.bunny.domain.system.dto.dept.DeptDto;
import cn.bunny.domain.system.dto.dept.DeptUpdateDto;
import cn.bunny.domain.system.entity.Dept;
import cn.bunny.domain.system.vo.DeptVo;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.Result;
import cn.bunny.domain.vo.result.ResultCodeEnum;
import cn.bunny.services.service.system.DeptService;
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
 * 部门 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-04 10:39:08
 */
@Tag(name = "系统部门", description = "部门相关接口")
@RestController
@RequestMapping("/api/dept")
public class DeptController {

    @Resource
    private DeptService deptService;

    @Operation(summary = "分页查询部门", description = "分页查询部门")
    @GetMapping("{page}/{limit}")
    public Result<PageResult<DeptVo>> getDeptPage(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            DeptDto dto) {
        Page<Dept> pageParams = new Page<>(page, limit);
        PageResult<DeptVo> pageResult = deptService.getDeptPage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "添加部门", description = "添加部门")
    @PostMapping()
    public Result<String> addDept(@Valid @RequestBody DeptAddDto dto) {
        deptService.addDept(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新部门", description = "更新部门")
    @PutMapping()
    public Result<String> updateDept(@Valid @RequestBody DeptUpdateDto dto) {
        deptService.updateDept(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除部门", description = "删除部门")
    @DeleteMapping()
    public Result<String> deleteDept(@RequestBody List<Long> ids) {
        deptService.deleteDept(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "获取所有部门", description = "获取所有部门")
    @GetMapping("private/getDeptList")
    public Result<List<DeptVo>> getDeptPage() {
        List<DeptVo> voList = deptService.getDeptPage();
        return Result.success(voList);
    }
}
