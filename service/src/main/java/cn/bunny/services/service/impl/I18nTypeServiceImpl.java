package cn.bunny.services.service.impl;

import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.dto.i18n.I18nTypeAddDto;
import cn.bunny.dao.dto.i18n.I18nTypeUpdateDto;
import cn.bunny.dao.entity.i18n.I18nType;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.i18n.I18nTypeVo;
import cn.bunny.services.mapper.I18nTypeMapper;
import cn.bunny.services.service.I18nTypeService;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
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

    /**
     * 获取多语言类型
     *
     * @return 多语言类型列表
     */
    @Override
    public List<I18nTypeVo> getI18nTypeList() {
        return list().stream().map(i18nType -> {
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
    public void addI18nType(I18nTypeAddDto dto) {
        String typeName = dto.getTypeName();
        Boolean isDefault = dto.getIsDefault();
        I18nType i18nType = new I18nType();

        // 查询添加的数据是否之前添加过
        List<I18nType> i18nTypeList = list(Wrappers.<I18nType>lambdaQuery().eq(I18nType::getTypeName, typeName));
        if (!i18nTypeList.isEmpty()) throw new BunnyException(ResultCodeEnum.DATA_EXIST);

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
    public void updateI18nType(I18nTypeUpdateDto dto) {
        Long id = dto.getId();
        Boolean isDefault = dto.getIsDefault();
        I18nType i18nType = new I18nType();

        // 查询更新的内容是否存在
        List<I18nType> i18nTypeList = list(Wrappers.<I18nType>lambdaQuery().eq(I18nType::getId, id));
        if (i18nTypeList.isEmpty()) throw new BunnyException(ResultCodeEnum.DATA_NOT_EXIST);

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
    public void deleteI18nType(List<Long> ids) {
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }
}