package cn.bunny.services.service;

import cn.bunny.dao.dto.schedulers.SchedulersAddDto;
import cn.bunny.dao.dto.schedulers.SchedulersDto;
import cn.bunny.dao.dto.schedulers.SchedulersOperationDto;
import cn.bunny.dao.dto.schedulers.SchedulersUpdateDto;
import cn.bunny.dao.entity.schedulers.ViewSchedulers;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.schedulers.SchedulersVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

import java.util.List;

/**
 * <p>
 * Schedulers视图 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-14 20:59:25
 */
public interface SchedulersService extends IService<ViewSchedulers> {

    /**
     * * 获取Schedulers视图列表
     *
     * @return Schedulers视图返回列表
     */
    PageResult<SchedulersVo> getSchedulersList(Page<ViewSchedulers> pageParams, SchedulersDto dto);

    /**
     * * 添加Schedulers视图
     *
     * @param dto 添加表单
     */
    void addSchedulers(@Valid SchedulersAddDto dto);

    /**
     * * 更新Schedulers视图
     *
     * @param dto 更新表单
     */
    void updateSchedulers(@Valid SchedulersUpdateDto dto);

    /**
     * * 删除|批量删除Schedulers视图类型
     *
     * @param ids 删除id列表
     */
    void deleteSchedulers(List<Long> ids);

    /**
     * * 暂停Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    void pauseScheduler(SchedulersOperationDto dto);

    /**
     * * 恢复Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    void resumeScheduler(SchedulersOperationDto dto);

    /**
     * * 移出Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    void removeScheduler(SchedulersOperationDto dto);
}
