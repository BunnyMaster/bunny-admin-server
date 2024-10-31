package cn.bunny.services.service.impl;

import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.dto.system.rolePower.power.PowerAddDto;
import cn.bunny.dao.dto.system.rolePower.power.PowerDto;
import cn.bunny.dao.dto.system.rolePower.power.PowerUpdateBatchByParentIdDto;
import cn.bunny.dao.dto.system.rolePower.power.PowerUpdateDto;
import cn.bunny.dao.entity.system.Power;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.rolePower.PowerVo;
import cn.bunny.services.mapper.PowerMapper;
import cn.bunny.services.mapper.RolePowerMapper;
import cn.bunny.services.service.PowerService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
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
public class PowerServiceImpl extends ServiceImpl<PowerMapper, Power> implements PowerService {

    @Autowired
    private RolePowerMapper rolePowerMapper;

    /**
     * * 权限 服务实现类
     *
     * @param pageParams 权限分页查询page对象
     * @param dto        权限分页查询对象
     * @return 查询分页权限返回对象
     */
    @Override
    public PageResult<PowerVo> getPowerList(Page<Power> pageParams, PowerDto dto) {
        // 分页查询菜单图标
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
        List<Power> powerList = list();
        return powerList.stream().map(power -> {
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
        LambdaQueryWrapper<Power> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(Power::getPowerCode, dto.getPowerCode())
                .or()
                .eq(Power::getRequestUrl, dto.getRequestUrl());
        List<Power> powerList = list(wrapper);
        if (!powerList.isEmpty()) throw new BunnyException(ResultCodeEnum.DATA_EXIST);

        // 保存数据
        Power power = new Power();
        BeanUtils.copyProperties(dto, power);
        save(power);
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
        List<Power> powerList = list(Wrappers.<Power>lambdaQuery().eq(Power::getId, id));
        if (powerList.isEmpty()) throw new BunnyException(ResultCodeEnum.DATA_NOT_EXIST);
        if (dto.getId().equals(dto.getParentId())) throw new BunnyException(ResultCodeEnum.ILLEGAL_DATA_REQUEST);

        // 更新内容
        Power power = new Power();
        BeanUtils.copyProperties(dto, power);
        updateById(power);
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
        if (ids.isEmpty()) throw new BunnyException(ResultCodeEnum.REQUEST_IS_EMPTY);

        // 删除权限
        baseMapper.deleteBatchIdsWithPhysics(ids);

        // 删除角色部门相关
        rolePowerMapper.deleteBatchPowerIdsWithPhysics(ids);
    }

    /**
     * * 批量修改权限父级
     *
     * @param dto 批量修改权限表单
     */
    @Override
    @CacheEvict(cacheNames = "power", key = "'allPower'", beforeInvocation = true)
    public void updateBatchByPowerWithParentId(PowerUpdateBatchByParentIdDto dto) {
        List<Power> powerList = dto.getIds().stream().map(id -> {
            Power power = new Power();
            power.setId(id);
            power.setParentId(dto.getParentId());
            return power;
        }).toList();

        updateBatchById(powerList);
    }
}
