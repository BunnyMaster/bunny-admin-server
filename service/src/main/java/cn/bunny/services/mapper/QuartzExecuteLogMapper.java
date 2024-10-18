package cn.bunny.services.mapper;

import cn.bunny.dao.dto.quartz.executeLog.QuartzExecuteLogDto;
import cn.bunny.dao.entity.quartz.QuartzExecuteLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 调度任务执行日志 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-18 12:56:39
 */
@Mapper
public interface QuartzExecuteLogMapper extends BaseMapper<QuartzExecuteLog> {

    /**
     * * 分页查询调度任务执行日志内容
     *
     * @param pageParams 调度任务执行日志分页参数
     * @param dto        调度任务执行日志查询表单
     * @return 调度任务执行日志分页结果
     */
    IPage<QuartzExecuteLog> selectListByPage(@Param("page") Page<QuartzExecuteLog> pageParams, @Param("dto") QuartzExecuteLogDto dto);

    /**
     * 物理删除调度任务执行日志
     *
     * @param ids 删除 id 列表
     */
    void deleteBatchIdsWithPhysics(List<Long> ids);
}
