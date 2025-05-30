package cn.bunny.services.service.configuration;


import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.configuration.dto.I18nDto;
import cn.bunny.domain.configuration.dto.I18nUpdateByFileDto;
import cn.bunny.domain.configuration.entity.I18n;
import cn.bunny.domain.configuration.vo.I18nVo;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import org.springframework.http.ResponseEntity;

import java.util.HashMap;
import java.util.List;

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
    HashMap<String, Object> getI18nMap();

    /**
     * * 获取管理多语言列表
     *
     * @return 多语言返回列表
     */
    PageResult<I18nVo> getI18nPage(Page<I18n> pageParams, I18nDto dto);

    /**
     * * 添加多语言
     *
     * @param dto 添加表单
     */
    void createI18n(I18nDto dto);

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

    /**
     * 下载多语言配置
     *
     * @param type 下载类型
     * @return 文件内容
     */
    ResponseEntity<byte[]> downloadI18n(String type);

    /**
     * 用文件更新多语言
     *
     * @param dto 文件更新对象
     */
    void uploadI18nFile(I18nUpdateByFileDto dto);
}