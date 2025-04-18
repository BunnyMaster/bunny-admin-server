package cn.bunny.services.service.configuration;

import cn.bunny.domain.i18n.dto.I18nAddDto;
import cn.bunny.domain.i18n.dto.I18nDto;
import cn.bunny.domain.i18n.dto.I18nUpdateByFileDto;
import cn.bunny.domain.i18n.dto.I18nUpdateDto;
import cn.bunny.domain.i18n.entity.I18n;
import cn.bunny.domain.i18n.vo.I18nVo;
import cn.bunny.domain.vo.result.PageResult;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.IService;
import jakarta.validation.Valid;
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
    HashMap<String, Object> getI18n();

    /**
     * * 获取管理多语言列表
     *
     * @return 多语言返回列表
     */
    PageResult<I18nVo> getI18nList(Page<I18n> pageParams, I18nDto dto);

    /**
     * * 添加多语言
     *
     * @param dto 添加表单
     */
    void addI18n(@Valid I18nAddDto dto);

    /**
     * * 更新多语言
     *
     * @param dto 更新表单
     */
    void updateI18n(@Valid I18nUpdateDto dto);

    /**
     * * 删除多语言类型
     *
     * @param ids 删除id列表
     */
    void deleteI18n(List<Long> ids);

    /**
     * 下载多语言配置
     *
     * @return 文件内容
     */
    ResponseEntity<byte[]> downloadI18n();

    /**
     * 用文件更新多语言
     *
     * @param dto 文件更新对象
     */
    void updateI18nByFile(@Valid I18nUpdateByFileDto dto);
}