package cn.bunny.system.service.impl;

import cn.bunny.core.exception.AuthCustomerException;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.system.dto.DeptDto;
import cn.bunny.domain.system.entity.Dept;
import cn.bunny.domain.system.vo.DeptVo;
import cn.bunny.system.mapper.DeptMapper;
import cn.bunny.system.mapper.UserDeptMapper;
import cn.bunny.system.service.DeptService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    private static final String CACHE_NAMES = "dept";

    @Resource
    private UserDeptMapper userDeptMapper;

    /**
     * * 部门 服务实现类
     *
     * @param pageParams 部门分页查询page对象
     * @param dto        部门分页查询对象
     * @return 查询分页部门返回对象
     */
    @Override
    public PageResult<DeptVo> getDeptPage(Page<Dept> pageParams, DeptDto dto) {
        IPage<DeptVo> page = baseMapper.selectListByPage(pageParams, dto);

        return PageResult.<DeptVo>builder()
                .list(page.getRecords())
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * * 获取所有部门
     *
     * @return 所有部门列表
     */
    @Override
    @Cacheable(cacheNames = CACHE_NAMES, key = "'deptList'" , cacheManager = "cacheManagerWithMouth" )
    public List<DeptVo> getDeptPage() {
        return list().stream().map(dept -> {
            DeptVo deptVo = new DeptVo();
            BeanUtils.copyProperties(dept, deptVo);
            return deptVo;
        }).toList();
    }

    /**
     * 添加部门
     *
     * @param dto 部门添加
     */
    @Override
    @CacheEvict(cacheNames = CACHE_NAMES, key = "'deptList'" , beforeInvocation = true)
    public void createDept(DeptDto dto) {
        // 整理管理者人员
        String mangerList = dto.getManager().stream().map(String::trim).collect(Collectors.joining("," ));

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
    @CacheEvict(cacheNames = CACHE_NAMES, key = "'deptList'" , beforeInvocation = true)
    public void updateDept(DeptDto dto) {
        if (dto.getId().equals(dto.getParentId())) throw new AuthCustomerException(ResultCodeEnum.ILLEGAL_DATA_REQUEST);

        // 将管理员用户逗号分隔
        String mangerList = dto.getManager().stream().map(String::trim).collect(Collectors.joining("," ));

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
    @CacheEvict(cacheNames = CACHE_NAMES, key = "'deptList'" , beforeInvocation = true)
    public void deleteDept(List<Long> ids) {
        // 判断数据请求是否为空
        if (ids.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        // 删除当前部门
        removeByIds(ids);

        // 删除用户部门关联
        userDeptMapper.deleteBatchIdsByDeptIds(ids);
    }
}
