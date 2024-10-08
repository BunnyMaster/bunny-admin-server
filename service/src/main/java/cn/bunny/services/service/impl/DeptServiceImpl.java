package cn.bunny.services.service.impl;

import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.dto.system.dept.DeptAddDto;
import cn.bunny.dao.dto.system.dept.DeptDto;
import cn.bunny.dao.dto.system.dept.DeptUpdateDto;
import cn.bunny.dao.entity.system.Dept;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.dept.DeptVo;
import cn.bunny.services.mapper.DeptMapper;
import cn.bunny.services.mapper.UserDeptMapper;
import cn.bunny.services.service.DeptService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

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

        List<DeptVo> voList = page.getRecords().stream().map(dept -> {
            // 将数据库中管理员取出
            List<String> mangerList = Arrays.stream(dept.getManager().split(",")).map(String::trim).toList();

            DeptVo deptVo = new DeptVo();
            BeanUtils.copyProperties(dept, deptVo);
            deptVo.setManager(mangerList);
            return deptVo;
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
    public void addDept(DeptAddDto dto) {
        // 整理管理者人员
        String mangerList = dto.getManager().stream().map(String::trim).collect(Collectors.joining(","));

        // 保存数据
        Dept dept = new Dept();
        BeanUtils.copyProperties(dto, dept);
        dept.setManager(mangerList);

        save(dept);
    }

    /**
     * 更新部门
     *
     * @param dto 部门更新
     */
    @Override
    public void updateDept(DeptUpdateDto dto) {
        // 判断所更新的部门是否存在
        String mangerList = dto.getManager().stream().map(String::trim).collect(Collectors.joining(","));
        if (dto.getId().equals(dto.getParentId())) throw new BunnyException(ResultCodeEnum.ILLEGAL_DATA_REQUEST);

        // 更新内容
        Dept dept = new Dept();
        BeanUtils.copyProperties(dto, dept);
        dept.setManager(mangerList);

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

    /**
     * * 获取所有部门
     *
     * @return 所有部门列表
     */
    @Override
    public List<DeptVo> getAllDeptList() {
        return list().stream().map(dept -> {
            DeptVo deptVo = new DeptVo();
            BeanUtils.copyProperties(dept, deptVo);
            return deptVo;
        }).toList();
    }
}
