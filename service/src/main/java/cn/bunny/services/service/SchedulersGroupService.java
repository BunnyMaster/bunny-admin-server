package cn.bunny.services.service;

import cn.bunny.dao.dto.schedulers.SchedulersGroupAddDto;
import cn.bunny.dao.dto.schedulers.SchedulersGroupDto;
import cn.bunny.dao.dto.schedulers.SchedulersGroupUpdateDto;
import cn.bunny.dao.entity.schedulers.SchedulersGroup;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.schedulers.SchedulersGroupVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

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
    PageResult<SchedulersGroupVo> getSchedulersGroupList(Page<SchedulersGroup> pageParams, SchedulersGroupDto dto);

    /**
     * * 添加任务调度分组
     *
     * @param dto 添加表单
     */
    void addSchedulersGroup(@Valid SchedulersGroupAddDto dto);

    /**
     * * 更新任务调度分组
     *
     * @param dto 更新表单
     */
    void updateSchedulersGroup(@Valid SchedulersGroupUpdateDto dto);

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
    List<SchedulersGroupVo> getAllSchedulersGroup();
}
