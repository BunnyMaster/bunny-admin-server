package cn.bunny.services.service.impl;

import cn.bunny.dao.dto.system.dept.DeptAddDto;
import cn.bunny.dao.dto.system.dept.DeptDto;
import cn.bunny.dao.dto.system.dept.DeptUpdateDto;
import cn.bunny.dao.entity.system.Dept;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.dept.DeptVo;
import cn.bunny.services.mapper.DeptMapper;
import cn.bunny.services.mapper.UserDeptMapper;
import cn.bunny.services.service.DeptService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 部门 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-04 10:39:08
 */
@Service
@Transactional
public class DeptServiceImpl extends ServiceImpl<DeptMapper, Dept> implements DeptService {

    @Autowired
    private UserDeptMapper userDeptMapper;

    /**
     * * 部门 服务实现类
     *
     * @param pageParams 部门分页查询page对象
     * @param dto        部门分页查询对象
     * @return 查询分页部门返回对象
     */
    @Override
    public PageResult<DeptVo> getDeptList(Page<Dept> pageParams, DeptDto dto) {
        // 分页查询菜单图标
        IPage<Dept> page = baseMapper.selectListByPage(pageParams, dto);

        List<DeptVo> voList = page.getRecords().stream().map(Dept -> {
            DeptVo DeptVo = new DeptVo();
            BeanUtils.copyProperties(Dept, DeptVo);
            return DeptVo;
        }).toList();

        return PageResult.<DeptVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 添加部门
     *
     * @param dto 部门添加
     */
    @Override
    public void addDept(@Valid DeptAddDto dto) {
        // 保存数据
        Dept dept = new Dept();
        BeanUtils.copyProperties(dto, dept);
        save(dept);
    }

    /**
     * 更新部门
     *
     * @param dto 部门更新
     */
    @Override
    public void updateDept(@Valid DeptUpdateDto dto) {
        // 更新内容
        Dept dept = new Dept();
        BeanUtils.copyProperties(dto, dept);
        updateById(dept);
    }

    /**
     * 删除|批量删除部门
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteDept(List<Long> ids) {
        // 删除当前部门
        baseMapper.deleteBatchIdsWithPhysics(ids);
        // 删除用户部门关联
        userDeptMapper.deleteBatchIdsByDeptIdWithPhysics(ids);
    }
}
