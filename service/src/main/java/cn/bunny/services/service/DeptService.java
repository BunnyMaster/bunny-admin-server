package cn.bunny.services.service;

import cn.bunny.dao.dto.system.dept.DeptAddDto;
import cn.bunny.dao.dto.system.dept.DeptDto;
import cn.bunny.dao.dto.system.dept.DeptUpdateDto;
import cn.bunny.dao.entity.system.Dept;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.dept.DeptVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

import java.util.List;

/**
 * <p>
 * 部门 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-04 10:39:08
 */
public interface DeptService extends IService<Dept> {

    /**
     * * 获取部门列表
     *
     * @return 部门返回列表
     */
    PageResult<DeptVo> getDeptList(Page<Dept> pageParams, DeptDto dto);

    /**
     * * 添加部门
     *
     * @param dto 添加表单
     */
    void addDept(@Valid DeptAddDto dto);

    /**
     * * 更新部门
     *
     * @param dto 更新表单
     */
    void updateDept(@Valid DeptUpdateDto dto);

    /**
     * * 删除|批量删除部门类型
     *
     * @param ids 删除id列表
     */
    void deleteDept(List<Long> ids);
}
