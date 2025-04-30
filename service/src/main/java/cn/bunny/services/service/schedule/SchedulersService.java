package cn.bunny.services.service.schedule;

import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.system.quartz.dto.SchedulersAddDto;
import cn.bunny.services.domain.system.quartz.dto.SchedulersDto;
import cn.bunny.services.domain.system.quartz.dto.SchedulersUpdateDto;
import cn.bunny.services.domain.system.quartz.entity.Schedulers;
import cn.bunny.services.domain.system.quartz.vo.SchedulersVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;

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
    void addSchedulers(@Valid SchedulersAddDto dto);

    /**
     * * 暂停Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    void pauseScheduler(SchedulersUpdateDto dto);

    /**
     * * 恢复Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    void resumeScheduler(SchedulersUpdateDto dto);

    /**
     * * 移出Schedulers任务
     *
     * @param dto Schedulers公共操作表单
     */
    void deleteSchedulers(SchedulersUpdateDto dto);

    /**
     * 更新任务
     *
     * @param dto 更新任务表单
     */
    void updateSchedulers(SchedulersUpdateDto dto);
}
