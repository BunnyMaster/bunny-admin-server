package cn.bunny.services.service.schedule.impl;

import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.schedule.dto.SchedulersGroupDto;
import cn.bunny.services.domain.schedule.entity.SchedulersGroup;
import cn.bunny.services.domain.schedule.vo.SchedulersGroupVo;
import cn.bunny.services.mapper.schedule.SchedulersGroupMapper;
import cn.bunny.services.service.schedule.SchedulersGroupService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
@Transactional
public class SchedulersGroupServiceImpl extends ServiceImpl<SchedulersGroupMapper, SchedulersGroup> implements SchedulersGroupService {

    /**
     * * 任务调度分组 服务实现类
     *
     * @param pageParams 任务调度分组分页查询page对象
     * @param dto        任务调度分组分页查询对象
     * @return 查询分页任务调度分组返回对象
     */
    @Override
    public PageResult<SchedulersGroupVo> getSchedulersGroupPage(Page<SchedulersGroup> pageParams, SchedulersGroupDto dto) {
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
    public List<SchedulersGroupVo> getSchedulersGroupList() {
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
    public void createSchedulersGroup(SchedulersGroupDto dto) {
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
    public void updateSchedulersGroup(SchedulersGroupDto dto) {
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
    public void deleteSchedulersGroup(List<Long> ids) {
        removeByIds(ids);
    }
}
