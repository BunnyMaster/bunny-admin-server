package cn.bunny.services.service.configuration.impl;

import cn.bunny.dao.dto.i18n.I18nAddDto;
import cn.bunny.dao.dto.i18n.I18nDto;
import cn.bunny.dao.dto.i18n.I18nUpdateDto;
import cn.bunny.dao.entity.i18n.I18n;
import cn.bunny.dao.entity.i18n.I18nType;
import cn.bunny.dao.vo.i18n.I18nVo;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.configuration.I18nMapper;
import cn.bunny.services.mapper.configuration.I18nTypeMapper;
import cn.bunny.services.service.configuration.I18nService;
import cn.bunny.services.utils.system.I18nUtil;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Objects;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

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

    private final I18nTypeMapper i18nTypeMapper;

    public I18nServiceImpl(I18nTypeMapper i18nTypeMapper) {
        this.i18nTypeMapper = i18nTypeMapper;
    }

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

        HashMap<String, Object> hashMap = I18nUtil.getMap(i18nList);
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

    /**
     * 下载多语言配置
     *
     * @return 文件内容
     */
    @Override
    public ResponseEntity<byte[]> downloadI18n() {
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        ZipOutputStream zipOutputStream = new ZipOutputStream(byteArrayOutputStream);

        // 查找默认语言内容
        List<I18n> i18nList = list();
        HashMap<String, Object> hashMap = I18nUtil.getMap(i18nList);

        hashMap.forEach((k, v) -> {
            try {
                ZipEntry zipEntry = new ZipEntry(k + ".json");
                zipOutputStream.putNextEntry(zipEntry);

                zipOutputStream.write(JSON.toJSONString(v).getBytes(StandardCharsets.UTF_8));
                zipOutputStream.closeEntry();
            } catch (IOException e) {
                throw new RuntimeException(e);
            }
        });

        try {
            zipOutputStream.close();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        // 设置响应头
        HttpHeaders headers = new HttpHeaders();
        headers.add("Content-Disposition", "attachment; filename=i18n.zip");
        headers.add("Cache-Control", "no-cache, no-store, must-revalidate");
        headers.add("Pragma", "no-cache");
        headers.add("Expires", "0");

        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(byteArrayOutputStream.toByteArray());
        return new ResponseEntity<>(byteArrayInputStream.readAllBytes(), headers, HttpStatus.OK);
    }
}
