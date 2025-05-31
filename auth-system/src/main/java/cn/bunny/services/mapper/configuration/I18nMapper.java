package cn.bunny.services.mapper.configuration;

import cn.bunny.domain.model.configuration.dto.I18nDto;
import cn.bunny.domain.model.configuration.entity.I18n;
import cn.bunny.domain.model.configuration.vo.I18nVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

/**
 * <p>
 * 多语言表 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-09-28
 */
@Mapper
public interface I18nMapper extends BaseMapper<I18n> {

    /**
     * * 分页查询多语言内容
     *
     * @param pageParams 分页想去
     * @param dto        路由查询表单
     * @return 分页结果
     */
    IPage<I18nVo> selectListByPage(@Param("page") Page<I18n> pageParams, @Param("dto") I18nDto dto);

}
