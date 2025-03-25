package cn.bunny.services.service.schedule.impl;

import cn.bunny.dao.dto.quartz.group.SchedulersGroupAddDto;
import cn.bunny.dao.dto.quartz.group.SchedulersGroupDto;
import cn.bunny.dao.dto.quartz.group.SchedulersGroupUpdateDto;
import cn.bunny.dao.entity.quartz.SchedulersGroup;
import cn.bunny.dao.vo.quartz.SchedulersGroupVo;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.services.mapper.SchedulersGroupMapper;
import cn.bunny.services.service.schedule.SchedulersGroupService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 任务调度分组 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-15 20:26:32
 */
@Service
public class SchedulersGroupServiceImpl extends ServiceImpl<SchedulersGroupMapper, SchedulersGroup> implements SchedulersGroupService {

    /**
     * * 任务调度分组 服务实现类
     *
     * @param pageParams 任务调度分组分页查询page对象
     * @param dto        任务调度分组分页查询对象
     * @return 查询分页任务调度分组返回对象
     */
    @Override
    public PageResult<SchedulersGroupVo> getSchedulersGroupList(Page<SchedulersGroup> pageParams, SchedulersGroupDto dto) {
        IPage<SchedulersGroupVo> page = baseMapper.selectListByPage(pageParams, dto);

        return PageResult.<SchedulersGroupVo>builder()
                .list(page.getRecords())
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * * 获取所有任务调度分组
     *
     * @return 获取所有任务分组
     */
    @Override
    @Cacheable(cacheNames = "schedulers", key = "'allSchedulersGroup'", cacheManager = "cacheManagerWithMouth")
    public List<SchedulersGroupVo> getAllSchedulersGroup() {
        return list().stream().map(schedulersGroup -> {
            SchedulersGroupVo schedulersGroupVo = new SchedulersGroupVo();
            BeanUtils.copyProperties(schedulersGroup, schedulersGroupVo);
            return schedulersGroupVo;
        }).toList();
    }

    /**
     * 添加任务调度分组
     *
     * @param dto 任务调度分组添加
     */
    @Override
    @CacheEvict(cacheNames = "schedulers", key = "'allSchedulersGroup'", beforeInvocation = true)
    public void addSchedulersGroup(@Valid SchedulersGroupAddDto dto) {
        // 保存数据
        SchedulersGroup schedulersGroup = new SchedulersGroup();
        BeanUtils.copyProperties(dto, schedulersGroup);
        save(schedulersGroup);
    }

    /**
     * 更新任务调度分组
     *
     * @param dto 任务调度分组更新
     */
    @Override
    @CacheEvict(cacheNames = "schedulers", key = "'allSchedulersGroup'", beforeInvocation = true)
    public void updateSchedulersGroup(@Valid SchedulersGroupUpdateDto dto) {
        // 更新内容
        SchedulersGroup schedulersGroup = new SchedulersGroup();
        BeanUtils.copyProperties(dto, schedulersGroup);
        updateById(schedulersGroup);
    }

    /**
     * 删除|批量删除任务调度分组
     *
     * @param ids 删除id列表
     */
    @Override
    @CacheEvict(cacheNames = "schedulers", key = "'allSchedulersGroup'", beforeInvocation = true)
    public void deleteSchedulersGroup(List<Long> ids) {
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }
}
