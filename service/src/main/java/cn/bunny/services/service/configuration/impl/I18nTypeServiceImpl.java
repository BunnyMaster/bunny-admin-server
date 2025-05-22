package cn.bunny.services.service.configuration.impl;

import cn.bunny.services.domain.common.enums.ResultCodeEnum;
import cn.bunny.services.domain.configuration.dto.I18nTypeDto;
import cn.bunny.services.domain.configuration.entity.I18nType;
import cn.bunny.services.domain.configuration.vo.I18nTypeVo;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.configuration.I18nTypeMapper;
import cn.bunny.services.service.configuration.I18nTypeService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.Caching;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 多语言类型表 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-28
 */
@Service
@Transactional
public class I18nTypeServiceImpl extends ServiceImpl<I18nTypeMapper, I18nType> implements I18nTypeService {
    private static final String CACHE_NAMES = "i18n";

    /**
     * 获取多语言类型
     *
     * @return 多语言类型列表
     */
    @Override
    @Cacheable(cacheNames = CACHE_NAMES, key = "'i18nTypeList'", cacheManager = "cacheManagerWithMouth")
    public List<I18nTypeVo> getI18nTypeList(I18nTypeDto dto) {
        List<I18nType> i18nTypeList = baseMapper.selectListByPage(dto);
        return i18nTypeList.stream().map(i18nType -> {
            I18nTypeVo i18nTypeVo = new I18nTypeVo();
            BeanUtils.copyProperties(i18nType, i18nTypeVo);
            return i18nTypeVo;
        }).toList();
    }

    /**
     * 添加多语言类型
     *
     * @param dto 多语言类型添加
     */
    @Override
    @Caching(evict = {
            @CacheEvict(cacheNames = CACHE_NAMES, key = "'i18nMap'", beforeInvocation = true),
            @CacheEvict(cacheNames = CACHE_NAMES, key = "'i18nTypeList'", beforeInvocation = true),
    })
    public void createI18nType(I18nTypeDto dto) {
        String typeName = dto.getTypeName();
        Boolean isDefault = dto.getIsDefault();
        I18nType i18nType = new I18nType();

        // 查询添加的数据是否之前添加过
        List<I18nType> i18nTypeList = list(Wrappers.<I18nType>lambdaQuery().eq(I18nType::getTypeName, typeName));
        if (!i18nTypeList.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.DATA_EXIST);

        // 如果是默认，将其它内容设为false
        if (isDefault) {
            i18nType.setIsDefault(false);
            update(i18nType, Wrappers.<I18nType>lambdaUpdate().eq(I18nType::getIsDefault, true));
        }

        // 保存数据
        i18nType = new I18nType();
        BeanUtils.copyProperties(dto, i18nType);
        save(i18nType);
    }

    /**
     * 更新多语言类型
     *
     * @param dto 多语言类型更新
     */
    @Override
    @Caching(evict = {
            @CacheEvict(cacheNames = CACHE_NAMES, key = "'i18nMap'", beforeInvocation = true),
            @CacheEvict(cacheNames = CACHE_NAMES, key = "'i18nTypeList'", beforeInvocation = true),
    })
    public void updateI18nType(I18nTypeDto dto) {
        Long id = dto.getId();
        Boolean isDefault = dto.getIsDefault();
        I18nType i18nType = new I18nType();

        // 查询更新的内容是否存在
        I18nType dbI18nType = getOne(Wrappers.<I18nType>lambdaQuery().eq(I18nType::getId, id));
        if (dbI18nType == null) throw new AuthCustomerException(ResultCodeEnum.DATA_NOT_EXIST);

        // 如果是默认，将其它内容设为false
        if (isDefault) {
            i18nType.setIsDefault(false);
            update(i18nType, Wrappers.<I18nType>lambdaUpdate().eq(I18nType::getIsDefault, true));
        }

        // 更新内容
        i18nType = new I18nType();
        BeanUtils.copyProperties(dto, i18nType);
        updateById(i18nType);
    }

    /**
     * 删除多语言类型
     *
     * @param ids 删除id列表
     */
    @Override
    @Caching(evict = {
            @CacheEvict(cacheNames = CACHE_NAMES, key = "'i18nMap'", beforeInvocation = true),
            @CacheEvict(cacheNames = CACHE_NAMES, key = "'i18nTypeList'", beforeInvocation = true),
    })
    public void deleteI18nType(List<Long> ids) {
        // 判断数据请求是否为空
        if (ids.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        removeByIds(ids);
    }
}
