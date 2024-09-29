package cn.bunny.services.service.impl;

import cn.bunny.dao.dto.i18n.I18nDto;
import cn.bunny.dao.entity.i18n.I18n;
import cn.bunny.dao.entity.i18n.I18nWithI18nType;
import cn.bunny.dao.entity.system.MenuIcon;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.i18n.I18nVo;
import cn.bunny.services.mapper.I18nMapper;
import cn.bunny.services.service.I18nService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

/**
 * <p>
 * 多语言表 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-28
 */
@Service
public class I18nServiceImpl extends ServiceImpl<I18nMapper, I18n> implements I18nService {

    /**
     * * 获取多语言内容
     *
     * @return 多语言返回内容
     */
    @Override
    public Map<String, Map<String, String>> getI18n() {
        List<I18nWithI18nType> i18nWithI18nTypes = baseMapper.selectListWithI18nType();
        return i18nWithI18nTypes.stream()
                .collect(Collectors.groupingBy(I18nWithI18nType::getTypeName, Collectors.toMap(I18nWithI18nType::getKeyName, I18nWithI18nType::getSummary)));
    }

    /**
     * * 获取管理多语言列表
     *
     * @return 多语言返回列表
     */
    @Override
    public PageResult<I18nVo> getI18nList(Page<MenuIcon> pageParams, I18nDto dto) {
        IPage<I18n> page = baseMapper.selectListByPage(pageParams, dto);

        List<I18nVo> i18nVoList = page.getRecords().stream().map(i18n -> {
            I18nVo i18nVo = new I18nVo();
            BeanUtils.copyProperties(i18n, i18nVo);
            return i18nVo;
        }).toList();
        return PageResult.<I18nVo>builder()
                .list(i18nVoList)
                .pageSize(page.getSize())
                .pageNo(page.getCurrent())
                .total(page.getTotal())
                .build();
    }

    /**
     * * 添加多语言
     *
     * @param dto 添加表单
     */
    @Override
    public void addI18n(I18nDto dto) {

    }

    /**
     * * 更新多语言
     *
     * @param dto 更新表单
     */
    @Override
    public void updateI18n(I18nDto dto) {

    }

    /**
     * * 删除多语言类型
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteI18n(List<Long> ids) {

    }
}
