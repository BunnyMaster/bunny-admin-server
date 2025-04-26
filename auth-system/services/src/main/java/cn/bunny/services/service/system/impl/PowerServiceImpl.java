package cn.bunny.services.service.system.impl;

import cn.bunny.domain.system.dto.power.PowerAddDto;
import cn.bunny.domain.system.dto.power.PowerDto;
import cn.bunny.domain.system.dto.power.PowerUpdateBatchByParentIdDto;
import cn.bunny.domain.system.dto.power.PowerUpdateDto;
import cn.bunny.domain.system.entity.Permission;
import cn.bunny.domain.system.vo.PowerVo;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.ResultCodeEnum;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.system.PermissionMapper;
import cn.bunny.services.mapper.system.RolePermissionMapper;
import cn.bunny.services.service.system.PowerService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 权限 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 16:00:52
 */
@Service
@Transactional
public class PowerServiceImpl extends ServiceImpl<PermissionMapper, Permission> implements PowerService {

    @Resource
    private RolePermissionMapper rolePermissionMapper;

    /**
     * * 权限 服务实现类
     *
     * @param pageParams 权限分页查询page对象
     * @param dto        权限分页查询对象
     * @return 查询分页权限返回对象
     */
    @Override
    public PageResult<PowerVo> getPowerList(Page<Permission> pageParams, PowerDto dto) {
        IPage<PowerVo> page = baseMapper.selectListByPage(pageParams, dto);

        return PageResult.<PowerVo>builder()
                .list(page.getRecords())
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * * 获取所有权限
     *
     * @return 所有权限列表
     */
    @Override
    @Cacheable(cacheNames = "power", key = "'allPower'", cacheManager = "cacheManagerWithMouth")
    public List<PowerVo> getAllPowers() {
        List<Permission> permissionList = list();
        return permissionList.stream().map(power -> {
            PowerVo powerVo = new PowerVo();
            BeanUtils.copyProperties(power, powerVo);
            return powerVo;
        }).toList();
    }

    /**
     * 添加权限
     *
     * @param dto 权限添加
     */
    @Override
    @CacheEvict(cacheNames = "power", key = "'allPower'", beforeInvocation = true)
    public void addPower(@Valid PowerAddDto dto) {
        // 添加权限时确保权限码和请求地址是唯一的
        LambdaQueryWrapper<Permission> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Permission::getPowerCode, dto.getPowerCode())
                .or()
                .eq(Permission::getRequestUrl, dto.getRequestUrl());
        List<Permission> permissionList = list(wrapper);
        if (!permissionList.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.DATA_EXIST);

        // 保存数据
        Permission permission = new Permission();
        BeanUtils.copyProperties(dto, permission);
        save(permission);
    }

    /**
     * 更新权限
     *
     * @param dto 权限更新
     */
    @Override
    @CacheEvict(cacheNames = "power", key = "'allPower'", beforeInvocation = true)
    public void updatePower(@Valid PowerUpdateDto dto) {
        Long id = dto.getId();
        List<Permission> permissionList = list(Wrappers.<Permission>lambdaQuery().eq(Permission::getId, id));
        if (permissionList.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.DATA_NOT_EXIST);
        if (dto.getId().equals(dto.getParentId())) throw new AuthCustomerException(ResultCodeEnum.ILLEGAL_DATA_REQUEST);

        // 更新内容
        Permission permission = new Permission();
        BeanUtils.copyProperties(dto, permission);
        updateById(permission);
    }

    /**
     * 删除|批量删除权限
     *
     * @param ids 删除id列表
     */
    @Override
    @CacheEvict(cacheNames = "power", key = "'allPower'", beforeInvocation = true)
    public void deletePower(List<Long> ids) {
        // 判断数据请求是否为空
        if (ids.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        // 删除权限
        baseMapper.deleteBatchIdsWithPhysics(ids);

        // 删除角色部门相关
        rolePermissionMapper.deleteBatchPowerIdsWithPhysics(ids);
    }

    /**
     * * 批量修改权限父级
     *
     * @param dto 批量修改权限表单
     */
    @Override
    @CacheEvict(cacheNames = "power", key = "'allPower'", beforeInvocation = true)
    public void updateBatchByPowerWithParentId(PowerUpdateBatchByParentIdDto dto) {
        List<Permission> permissionList = dto.getIds().stream().map(id -> {
            Permission permission = new Permission();
            permission.setId(id);
            permission.setParentId(dto.getParentId());
            return permission;
        }).toList();

        updateBatchById(permissionList);
    }
}
