package cn.bunny.services.service.configuration.impl;

import cn.bunny.domain.entity.BaseEntity;
import cn.bunny.domain.i18n.dto.I18nAddDto;
import cn.bunny.domain.i18n.dto.I18nDto;
import cn.bunny.domain.i18n.dto.I18nUpdateByFileDto;
import cn.bunny.domain.i18n.dto.I18nUpdateDto;
import cn.bunny.domain.i18n.entity.I18n;
import cn.bunny.domain.i18n.entity.I18nType;
import cn.bunny.domain.i18n.vo.I18nVo;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.ResultCodeEnum;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.configuration.I18nMapper;
import cn.bunny.services.mapper.configuration.I18nTypeMapper;
import cn.bunny.services.service.configuration.I18nService;
import cn.bunny.services.utils.system.I18nUtil;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.TypeReference;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

    @Resource
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
        try (ZipOutputStream zipOutputStream = new ZipOutputStream(byteArrayOutputStream)) {

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

    /**
     * 用文件更新多语言
     *
     * @param dto 文件更新对象
     */
    @Override
    @CacheEvict(cacheNames = "i18n", key = "'i18n'", beforeInvocation = true)
    public void updateI18nByFile(I18nUpdateByFileDto dto) {
        String type = dto.getType();
        MultipartFile file = dto.getFile();

        // 判断是否有这个语言的key
        List<I18nType> i18nTypeList = i18nTypeMapper.selectList(Wrappers.<I18nType>lambdaQuery().eq(I18nType::getTypeName, type));
        if (i18nTypeList.isEmpty() && !file.isEmpty()) {
            throw new AuthCustomerException(ResultCodeEnum.DATA_NOT_EXIST);
        }

        try {
            // 内容是否为空
            String content = new String(file.getBytes());
            if (StringUtils.isEmpty(content)) {
                throw new AuthCustomerException(ResultCodeEnum.DATA_NOT_EXIST);
            }

            // 内容存在，删除这个数据库中所有关于这个key的多语言
            Map<String, Object> parseObject = JSON.parseObject(content, new TypeReference<>() {
            });
            List<I18n> i18nList = baseMapper.selectList(Wrappers.<I18n>lambdaQuery().eq(I18n::getTypeName, type));
            List<Long> ids = i18nList.stream().map(BaseEntity::getId).toList();
            if (!ids.isEmpty()) {
                baseMapper.deleteBatchIdsWithPhysics(ids);
            }

            // 存入内容
            i18nList = parseObject.entrySet().stream().map(item -> {
                String key = item.getKey();
                String value = item.getValue().toString();

                I18n i18n = new I18n();
                i18n.setTypeName(type);
                i18n.setKeyName(key);
                i18n.setTranslation(value);
                return i18n;
            }).toList();
            saveBatch(i18nList);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
}
