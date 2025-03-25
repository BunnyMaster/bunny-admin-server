package cn.bunny.services.mapper.schedule;

import cn.bunny.dao.dto.quartz.schedule.SchedulersDto;
import cn.bunny.dao.entity.quartz.Schedulers;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * Schedulers视图 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-15 16:35:10
 */
@Mapper
public interface SchedulersMapper extends BaseMapper<Schedulers> {

    /**
     * * 分页查询Schedulers视图内容
     *
     * @param pageParams Schedulers视图分页参数
     * @param dto        Schedulers视图查询表单
     * @return Schedulers视图分页结果
     */
    IPage<Schedulers> selectListByPage(@Param("page") Page<Schedulers> pageParams, @Param("dto") SchedulersDto dto);
}
