package cn.bunny.services.service.impl;

import cn.bunny.dao.dto.system.rolePower.PowerAddDto;
import cn.bunny.dao.dto.system.rolePower.PowerDto;
import cn.bunny.dao.dto.system.rolePower.PowerUpdateDto;
import cn.bunny.dao.entity.system.Power;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.rolePower.PowerVo;
import cn.bunny.services.factory.PowerFactory;
import cn.bunny.services.mapper.PowerMapper;
import cn.bunny.services.service.PowerService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
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
public class PowerServiceImpl extends ServiceImpl<PowerMapper, Power> implements PowerService {

    private final PowerFactory powerFactory;

    public PowerServiceImpl(PowerFactory powerFactory) {
        this.powerFactory = powerFactory;
    }

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
        IPage<Power> page = baseMapper.selectListByPage(pageParams, dto);

        List<PowerVo> voList = page.getRecords().stream().map(Power -> {
            PowerVo PowerVo = new PowerVo();
            BeanUtils.copyProperties(Power, PowerVo);
            return PowerVo;
        }).toList();

        return PageResult.<PowerVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 添加权限
     *
     * @param dto 权限添加
     */
    @Override
    public void addPower(@Valid PowerAddDto dto) {
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
    public void updatePower(@Valid PowerUpdateDto dto) {
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
    public void deletePower(List<Long> ids) {
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }

    /**
     * * 获取所有权限
     *
     * @return 所有权限列表
     */
    @Override
    public List<PowerVo> getAllPowers() {
        List<Power> powerList = list();
        ArrayList<PowerVo> powerVos = new ArrayList<>();

        // 构建返回波对象
        List<PowerVo> powerVoList = powerList.stream().map(power -> {
            PowerVo powerVo = new PowerVo();
            BeanUtils.copyProperties(power, powerVo);
            return powerVo;
        }).toList();

        powerVoList.stream()
                .filter(power -> power.getParentId() == 0)
                .forEach(powerVo -> {
                    powerVo.setChildren(powerFactory.handlePowerVoChildren(powerVo.getId(), powerVoList));
                    powerVos.add(powerVo);
                });
        return powerVos;
    }
}
