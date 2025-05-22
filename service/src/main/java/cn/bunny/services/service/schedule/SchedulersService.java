package cn.bunny.services.service.schedule;

import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.schedule.dto.SchedulersDto;
import cn.bunny.services.domain.schedule.entity.Schedulers;
import cn.bunny.services.domain.schedule.vo.SchedulersVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

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
    PageResult<SchedulersVo> getSchedulersPage(Page<Schedulers> pageParams, SchedulersDto dto);

    /**
     * * 添加Schedulers视图
     *
     * @param dto 添加表单
     */
    void createSchedulers(SchedulersDto dto);

    /**
     * * 暂停Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    void pauseScheduler(SchedulersDto dto);

    /**
     * * 恢复Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    void resumeScheduler(SchedulersDto dto);

    /**
     * * 移出Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    void deleteSchedulers(SchedulersDto dto);

    /**
     * 更新任务
     *
     * @param dto 更新任务表单
     */
    void updateSchedulers(SchedulersDto dto);
}
