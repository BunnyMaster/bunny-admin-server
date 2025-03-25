package cn.bunny.services.mapper.configuration;

import cn.bunny.dao.dto.i18n.I18nTypeDto;
import cn.bunny.dao.entity.i18n.I18nType;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 多语言类型表 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-09-28
 */
@Mapper
public interface I18nTypeMapper extends BaseMapper<I18nType> {

    /**
     * 物理删除多语言类型
     *
     * @param ids 删除 id 列表
     */
    void deleteBatchIdsWithPhysics(List<Long> ids);

    /**
     * 多语言类型查询
     *
     * @param dto 多语言类型查询
     * @return 多语言类型列表
     */
    List<I18nType> selectListByPage(@Param("dto") I18nTypeDto dto);
}
