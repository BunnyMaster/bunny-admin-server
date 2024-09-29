package cn.bunny.services.mapper;

import cn.bunny.dao.entity.i18n.I18nType;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

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
}
