package cn.bunny.schedule.service;

import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.schedule.dto.SchedulersGroupDto;
import cn.bunny.domain.schedule.entity.SchedulersGroup;
import cn.bunny.domain.schedule.vo.SchedulersGroupVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 任务调度分组 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-15 20:26:32
 */
public interface SchedulersGroupService extends IService<SchedulersGroup> {

    /**
     * * 获取任务调度分组列表
     *
     * @return 任务调度分组返回列表
     */
    PageResult<SchedulersGroupVo> getSchedulersGroupPage(Page<SchedulersGroup> pageParams, SchedulersGroupDto dto);

    /**
     * * 添加任务调度分组
     *
     * @param dto 添加表单
     */
    void createSchedulersGroup(SchedulersGroupDto dto);

    /**
     * * 更新任务调度分组
     *
     * @param dto 更新表单
     */
    void updateSchedulersGroup(SchedulersGroupDto dto);

    /**
     * * 删除|批量删除任务调度分组类型
     *
     * @param ids 删除id列表
     */
    void deleteSchedulersGroup(List<Long> ids);

    /**
     * * 获取所有任务调度分组
     *
     * @return 获取所有任务分组
     */
    List<SchedulersGroupVo> getSchedulersGroupList();
}
