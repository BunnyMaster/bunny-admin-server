package cn.bunny.system.service.impl;

import cn.bunny.core.exception.AuthCustomerException;
import cn.bunny.core.utils.FileUtil;
import cn.bunny.core.utils.export.ExcelZipExportStrategy;
import cn.bunny.core.utils.export.JsonZipExportStrategy;
import cn.bunny.domain.common.constant.FileType;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.dto.excel.PermissionExcel;
import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.system.dto.PermissionDto;
import cn.bunny.domain.system.dto.PermissionUpdateBatchByParentIdDto;
import cn.bunny.domain.system.entity.Permission;
import cn.bunny.domain.system.vo.PermissionVo;
import cn.bunny.system.core.cache.PermissionExcelListener;
import cn.bunny.system.core.event.UpdateUserinfoByPermissionIdsEvent;
import cn.bunny.system.core.template.PermissionTreeProcessor;
import cn.bunny.system.mapper.PermissionMapper;
import cn.bunny.system.service.PermissionService;
import com.alibaba.excel.EasyExcel;
import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.TypeReference;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.Caching;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.zip.ZipOutputStream;

/**
 * <p>
 * 权限 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 16:00:52
 */
@Service
@Transactional
public class PermissionServiceImpl extends ServiceImpl<PermissionMapper, Permission> implements PermissionService {
    private static final String CACHE_NAMES = "permission";

    @Resource
    private ApplicationEventPublisher applicationEventPublisher;

    /**
     * 将树形结构权限数据扁平化为列表
     *
     * <p>使用递归处理树形结构</p>
     *
     * @param list 树形结构的权限列表，每个节点可能包含children子节点
     * @return 扁平化后的权限列表（
     */
    public static List<PermissionExcel> flattenTree(List<PermissionExcel> list) {
        List<PermissionExcel> result = new ArrayList<>();

        for (PermissionExcel node : list) {
            result.add(node);
            if (node.getChildren() != null && !node.getChildren().isEmpty()) {
                result.addAll(flattenTree(node.getChildren()));
            }
        }

        return result;
    }

    /**
     * * 权限 服务实现类
     *
     * @param pageParams 权限分页查询page对象
     * @param dto        权限分页查询对象
     * @return 查询分页权限返回对象
     */
    @Override
    public PageResult<PermissionVo> getPermissionPage(Page<Permission> pageParams, PermissionDto dto) {
        IPage<PermissionVo> page = baseMapper.selectListByPage(pageParams, dto);

        return PageResult.<PermissionVo>builder()
                .list(page.getRecords())
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 获取所有权限
     *
     * @return 所有权限列表
     */
    @Override
    @Cacheable(cacheNames = CACHE_NAMES, key = "'permissionList'" , cacheManager = "cacheManagerWithMouth" )
    public List<PermissionVo> getPermissionList() {
        List<Permission> permissionList = list();
        return permissionList.stream().map(power -> {
            PermissionVo permissionVo = new PermissionVo();
            BeanUtils.copyProperties(power, permissionVo);
            return permissionVo;
        }).toList();
    }

    /**
     * 添加权限
     *
     * @param dto 权限添加
     */
    @Override
    @Caching(evict = {
            @CacheEvict(cacheNames = CACHE_NAMES, key = "'permissionList'" , beforeInvocation = true),
    })
    public void createPermission(PermissionDto dto) {
        Permission permission = new Permission();
        BeanUtils.copyProperties(dto, permission);
        save(permission);
    }

    /**
     * 更新权限
     *
     * @param dto 权限更新
     */
    @Override
    @Caching(evict = {
            @CacheEvict(cacheNames = CACHE_NAMES, key = "'permissionList'" , beforeInvocation = true),
    })
    public void updatePermission(PermissionDto dto) {
        Long id = dto.getId();
        List<Permission> permissionList = list(Wrappers.<Permission>lambdaQuery().eq(Permission::getId, id));
        if (permissionList.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.DATA_NOT_EXIST);
        if (dto.getId().equals(dto.getParentId())) throw new AuthCustomerException(ResultCodeEnum.ILLEGAL_DATA_REQUEST);

        // 更新内容
        Permission permission = new Permission();
        BeanUtils.copyProperties(dto, permission);
        updateById(permission);

        List<Long> ids = List.of(dto.getId());
        applicationEventPublisher.publishEvent(new UpdateUserinfoByPermissionIdsEvent(this, ids));
    }

    /**
     * 删除|批量删除权限
     * 使用物理删除，数据库中设置了外键检查，会自动删除角色权限关联表中的内容
     *
     * @param ids 删除id列表
     */
    @Override
    @Caching(evict = {
            @CacheEvict(cacheNames = CACHE_NAMES, key = "'permissionList'" , beforeInvocation = true),
    })
    public void deletePermission(List<Long> ids) {
        // 判断数据请求是否为空
        if (ids.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        // 删除缓存中所有这个权限关联的用户，角色和权限信息
        applicationEventPublisher.publishEvent(new UpdateUserinfoByPermissionIdsEvent(this, ids));

        // 删除权限
        removeByIds(ids);
    }

    /**
     * 批量修改权限父级
     *
     * @param dto 批量修改权限表单
     */
    @Override
    @Caching(evict = {
            @CacheEvict(cacheNames = CACHE_NAMES, key = "'permissionList'" , beforeInvocation = true),
    })
    public void updatePermissionListByParentId(PermissionUpdateBatchByParentIdDto dto) {
        List<Long> ids = dto.getIds();
        List<Permission> permissionList = ids.stream().map(id -> {
            Permission permission = new Permission();
            permission.setId(id);
            permission.setParentId(dto.getParentId());
            return permission;
        }).toList();

        // 删除缓存中所有这个权限关联的用户，角色和权限信息
        applicationEventPublisher.publishEvent(new UpdateUserinfoByPermissionIdsEvent(this, ids));

        updateBatchById(permissionList);
    }

    /**
     * 导出权限为Excel
     *
     * @param type 导出类型
     * @return Excel 文件
     */
    @Override
    public ResponseEntity<byte[]> exportPermission(String type) {
        String timeFormat = new SimpleDateFormat("yyyy-MM-dd HH_mm_ss" ).format(new Date());
        String zipFilename = "permission-" + timeFormat + ".zip";

        String dateFormat = new SimpleDateFormat("yyyy-MM-dd" ).format(new Date());
        String filename = "permission-" + dateFormat;

        // 权限列表
        List<PermissionExcel> permissionExcelList = list().stream().map(permission -> {
            PermissionExcel permissionExcel = new PermissionExcel();
            BeanUtils.copyProperties(permission, permissionExcel);

            return permissionExcel;
        }).toList();

        // 构建树型结构
        PermissionTreeProcessor permissionTreeProcessor = new PermissionTreeProcessor();
        List<PermissionExcel> buildTree = permissionTreeProcessor.process(permissionExcelList);

        // 创建btye输出流
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();

        // Zip写入流
        try (ZipOutputStream zipOutputStream = new ZipOutputStream(byteArrayOutputStream)) {
            // 判断导出类型是什么
            if (type.equals(FileType.EXCEL)) {
                ExcelZipExportStrategy excelZipExportStrategy = new ExcelZipExportStrategy(PermissionExcel.class, "permission" );
                excelZipExportStrategy.export(permissionExcelList, zipOutputStream, filename + ".xlsx" );
            } else {
                JsonZipExportStrategy jsonZipExportStrategy = new JsonZipExportStrategy();
                jsonZipExportStrategy.export(buildTree, zipOutputStream, filename + ".json" );
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        // 设置响应头
        HttpHeaders headers = FileUtil.buildHttpHeadersByBinary(zipFilename);
        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(byteArrayOutputStream.toByteArray());
        return new ResponseEntity<>(byteArrayInputStream.readAllBytes(), headers, HttpStatus.OK);
    }

    /**
     * 导入权限
     * 不做任何操作，如果有需要清除所有权限id，或者让用户手动重新登录
     *
     * @param file 导入的Excel
     * @param type 导出类型
     */
    @Override
    @Caching(evict = {
            @CacheEvict(cacheNames = CACHE_NAMES, key = "'permissionList'" , beforeInvocation = true),
    })
    public void importPermission(MultipartFile file, String type) {
        if (file == null) {
            throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);
        }

        try {
            if (type.equals(FileType.EXCEL)) {
                InputStream fileInputStream = file.getInputStream();
                EasyExcel.read(fileInputStream, PermissionExcel.class, new PermissionExcelListener(this)).sheet().doRead();
            } else {
                // 将文件转成字符串
                String json = new String(file.getBytes());
                // 解析文件字符串并转成JSON
                List<PermissionExcel> list = JSON.parseObject(json, new TypeReference<>() {
                });
                // 格式化数据，保存到数据库
                List<PermissionExcel> flattenedTree = flattenTree(list);
                List<Permission> permissionList = flattenedTree.stream().map(permissionExcel -> {
                    Permission permission = new Permission();
                    BeanUtils.copyProperties(permissionExcel, permission);

                    return permission;
                }).toList();

                saveOrUpdateBatch(permissionList);
            }
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * 批量修改权限
     *
     * @param list 权限数组
     */
    @Override
    public void updatePermissionBatch(List<PermissionDto> list) {
        List<Permission> permissionList = list.stream()
                .map(permissionUpdateDto -> {
                    Permission permission = new Permission();
                    BeanUtils.copyProperties(permissionUpdateDto, permission);
                    return permission;
                }).toList();
        saveOrUpdateBatch(permissionList);


        // 删除缓存中所有这个权限关联的用户，角色和权限信息
        List<Long> ids = list.stream().map(PermissionDto::getId).toList();
        applicationEventPublisher.publishEvent(new UpdateUserinfoByPermissionIdsEvent(this, ids));
    }
}
