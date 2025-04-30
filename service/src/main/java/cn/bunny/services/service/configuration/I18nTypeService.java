package cn.bunny.services.service.configuration;

import cn.bunny.services.domain.system.i18n.dto.I18nTypeAddDto;
import cn.bunny.services.domain.system.i18n.dto.I18nTypeDto;
import cn.bunny.services.domain.system.i18n.dto.I18nTypeUpdateDto;
import cn.bunny.services.domain.system.i18n.entity.I18nType;
import cn.bunny.services.domain.system.i18n.vo.I18nTypeVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 多语言类型表 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-28
 */
public interface I18nTypeService extends IService<I18nType> {

    /**
     * 获取多语言类型
     *
     * @return 多语言类型列表
     */
    List<I18nTypeVo> getI18nTypeList(I18nTypeDto dto);

    /**
     * 添加多语言类型
     *
     * @param dto 多语言类型添加
     */
    void addI18nType(I18nTypeAddDto dto);

    /**
     * 更新多语言类型
     *
     * @param dto 多语言类型更新
     */
    void updateI18nType(I18nTypeUpdateDto dto);

    /**
     * 删除多语言类型
     *
     * @param ids 删除id列表
     */
    void deleteI18nType(List<Long> ids);
}
