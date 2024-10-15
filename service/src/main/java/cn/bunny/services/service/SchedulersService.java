package cn.bunny.services.service;

import cn.bunny.dao.dto.schedulers.SchedulersAddDto;
import cn.bunny.dao.dto.schedulers.SchedulersDto;
import cn.bunny.dao.dto.schedulers.SchedulersOperationDto;
import cn.bunny.dao.entity.schedulers.Schedulers;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.schedulers.SchedulersVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * Schedulers视图 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-15 16:35:10
 */
public interface SchedulersService extends IService<Schedulers> {

    /**
     * * 获取Schedulers视图列表
     *
     * @return Schedulers视图返回列表
     */
    PageResult<SchedulersVo> getSchedulersList(Page<Schedulers> pageParams, SchedulersDto dto);

    /**
     * * 添加Schedulers视图
     *
     * @param dto 添加表单
     */
    void addSchedulers(@Valid SchedulersAddDto dto);

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
    void deleteSchedulers(SchedulersOperationDto dto);

    /**
     * * 获取所有可用调度任务
     *
     * @return 所有调度任务内容
     */
    List<Map<String, String>> getAllScheduleJobList();
}
