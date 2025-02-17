package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.dept.DeptAddDto;
import cn.bunny.dao.dto.system.dept.DeptDto;
import cn.bunny.dao.dto.system.dept.DeptUpdateDto;
import cn.bunny.dao.entity.system.Dept;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.DeptVo;
import cn.bunny.services.service.DeptService;
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

    @Autowired
    private DeptService deptService;

    @Operation(summary = "分页查询部门", description = "分页查询部门")
    @GetMapping("getDeptList/{page}/{limit}")
    public Mono<Result<PageResult<DeptVo>>> getDeptList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            DeptDto dto) {
        Page<Dept> pageParams = new Page<>(page, limit);
        PageResult<DeptVo> pageResult = deptService.getDeptList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }

    @Operation(summary = "获取所有部门", description = "获取所有部门")
    @GetMapping("noManage/getAllDeptList")
    public Mono<Result<List<DeptVo>>> getAllDeptList() {
        List<DeptVo> voList = deptService.getAllDeptList();
        return Mono.just(Result.success(voList));
    }

    @Operation(summary = "添加部门", description = "添加部门")
    @PostMapping("addDept")
    public Mono<Result<String>> addDept(@Valid @RequestBody DeptAddDto dto) {
        deptService.addDept(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "更新部门", description = "更新部门")
    @PutMapping("updateDept")
    public Mono<Result<String>> updateDept(@Valid @RequestBody DeptUpdateDto dto) {
        deptService.updateDept(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "删除部门", description = "删除部门")
    @DeleteMapping("deleteDept")
    public Mono<Result<String>> deleteDept(@RequestBody List<Long> ids) {
        deptService.deleteDept(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
