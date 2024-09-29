package cn.bunny.services.service;

import cn.bunny.dao.dto.i18n.I18nDto;
import cn.bunny.dao.entity.i18n.I18n;
import cn.bunny.dao.entity.system.MenuIcon;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.i18n.I18nVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 多语言表 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-28
 */
public interface I18nService extends IService<I18n> {

    /**
     * * 获取多语言内容
     *
     * @return 多语言返回内容
     */
    Map<String, Map<String, String>> getI18n();

    /**
     * * 获取管理多语言列表
     *
     * @return 多语言返回列表
     */
    PageResult<I18nVo> getI18nList(Page<MenuIcon> pageParams, I18nDto dto);

    /**
     * * 添加多语言
     *
     * @param dto 添加表单
     */
    void addI18n(I18nDto dto);

    /**
     * * 更新多语言
     *
     * @param dto 更新表单
     */
    void updateI18n(I18nDto dto);

    /**
     * * 删除多语言类型
     *
     * @param ids 删除id列表
     */
    void deleteI18n(List<Long> ids);
}
