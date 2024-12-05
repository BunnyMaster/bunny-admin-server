package cn.bunny.services.service.impl;

import cn.bunny.common.service.exception.AuthCustomerException;
import cn.bunny.dao.dto.i18n.I18nAddDto;
import cn.bunny.dao.dto.i18n.I18nDto;
import cn.bunny.dao.dto.i18n.I18nUpdateDto;
import cn.bunny.dao.entity.i18n.I18n;
import cn.bunny.dao.entity.i18n.I18nType;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.i18n.I18nVo;
import cn.bunny.services.mapper.I18nMapper;
import cn.bunny.services.mapper.I18nTypeMapper;
import cn.bunny.services.service.I18nService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
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
@Transactional
public class I18nServiceImpl extends ServiceImpl<I18nMapper, I18n> implements I18nService {

    @Autowired
    private I18nTypeMapper i18nTypeMapper;

    /**
     * * 获取多语言内容
     *
     * @return 多语言返回内容
     */
    @Override
    @Cacheable(cacheNames = "i18n", key = "'i18n'", cacheManager = "cacheManagerWithMouth")
    public HashMap<String, Object> getI18n() {
        // 查找默认语言内容
        I18nType i18nType = i18nTypeMapper.selectOne(Wrappers.<I18nType>lambdaQuery().eq(I18nType::getIsDefault, true));
        List<I18n> i18nList = list();

        // 整理集合
        Map<String, Map<String, String>> map = i18nList.stream()
                .collect(Collectors.groupingBy(
                        I18n::getTypeName,
                        Collectors.toMap(I18n::getKeyName, I18n::getTranslation)));

        // 返回集合
        HashMap<String, Object> hashMap = new HashMap<>(map);
        hashMap.put("local", Objects.requireNonNull(i18nType.getTypeName(), "zh"));
        return hashMap;
    }

    /**
     * * 获取管理多语言列表
     *
     * @return 多语言返回列表
     */
    @Override
    public PageResult<I18nVo> getI18nList(Page<I18n> pageParams, I18nDto dto) {
        IPage<I18nVo> page = baseMapper.selectListByPage(pageParams, dto);

        return PageResult.<I18nVo>builder()
                .list(page.getRecords())
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
    @CacheEvict(cacheNames = "i18n", key = "'i18n'", beforeInvocation = true)
    public void addI18n(@Valid I18nAddDto dto) {
        String keyName = dto.getKeyName();
        String typeName = dto.getTypeName();

        // 查询数据是否存在
        List<I18n> i18nList = list(Wrappers.<I18n>lambdaQuery().eq(I18n::getKeyName, keyName).eq(I18n::getTypeName, typeName));
        if (!i18nList.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.DATA_EXIST);

        // 保存内容
        I18n i18n = new I18n();
        BeanUtils.copyProperties(dto, i18n);
        save(i18n);
    }

    /**
     * * 更新多语言
     *
     * @param dto 更新表单
     */
    @Override
    @CacheEvict(cacheNames = "i18n", key = "'i18n'", beforeInvocation = true)
    public void updateI18n(@Valid I18nUpdateDto dto) {
        Long id = dto.getId();

        // 查询数据是否存在
        List<I18n> i18nList = list(Wrappers.<I18n>lambdaQuery().eq(I18n::getId, id));
        if (i18nList.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.DATA_NOT_EXIST);

        // 保存内容
        I18n i18n = new I18n();
        BeanUtils.copyProperties(dto, i18n);
        updateById(i18n);
    }

    /**
     * * 删除多语言类型
     *
     * @param ids 删除id列表
     */
    @Override
    @CacheEvict(cacheNames = "i18n", key = "'i18n'", beforeInvocation = true)
    public void deleteI18n(List<Long> ids) {
        // 判断数据请求是否为空
        if (ids.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        baseMapper.deleteBatchIdsWithPhysics(ids);
    }
}
