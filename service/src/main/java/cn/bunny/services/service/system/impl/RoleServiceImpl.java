package cn.bunny.services.service.system.impl;

import cn.bunny.services.domain.common.model.dto.excel.RoleExcel;
import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.common.model.vo.result.ResultCodeEnum;
import cn.bunny.services.domain.system.system.dto.role.RoleAddDto;
import cn.bunny.services.domain.system.system.dto.role.RoleDto;
import cn.bunny.services.domain.system.system.dto.role.RoleUpdateDto;
import cn.bunny.services.domain.system.system.entity.Role;
import cn.bunny.services.domain.system.system.entity.UserRole;
import cn.bunny.services.domain.system.system.vo.RoleVo;
import cn.bunny.services.excel.RoleExcelListener;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.system.RoleMapper;
import cn.bunny.services.mapper.system.RolePermissionMapper;
import cn.bunny.services.mapper.system.RouterRoleMapper;
import cn.bunny.services.mapper.system.UserRoleMapper;
import cn.bunny.services.service.system.RoleService;
import cn.bunny.services.service.system.helper.role.RoleUpdatedEvent;
import cn.bunny.services.utils.FileUtil;
import com.alibaba.excel.EasyExcel;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
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
import java.util.Date;
import java.util.List;
import java.util.zip.ZipEntry;
import java.util.zip.ZipOutputStream;

/**
 * <p>
 * 角色 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 14:26:24
 */
@Service
@Transactional
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements RoleService {

    @Resource
    private UserRoleMapper userRoleMapper;

    @Resource
    private RolePermissionMapper rolePermissionMapper;

    @Resource
    private RouterRoleMapper routerRoleMapper;

    @Resource
    private ApplicationEventPublisher eventPublisher;

    /**
     * * 角色 服务实现类
     *
     * @param pageParams 角色分页查询page对象
     * @param dto        角色分页查询对象
     * @return 查询分页角色返回对象
     */
    @Override
    public PageResult<RoleVo> getRolePage(Page<Role> pageParams, RoleDto dto) {
        IPage<RoleVo> page = baseMapper.selectListByPage(pageParams, dto);

        return PageResult.<RoleVo>builder()
                .list(page.getRecords())
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * * 获取所有角色
     *
     * @return 所有角色列表
     */
    @Override
    @Cacheable(cacheNames = "role", key = "'roleList'", cacheManager = "cacheManagerWithMouth")
    public List<RoleVo> roleList() {
        return list().stream().map(role -> {
            RoleVo roleVo = new RoleVo();
            BeanUtils.copyProperties(role, roleVo);
            return roleVo;
        }).toList();
    }

    /**
     * 使用Excel导出导出角色列表
     *
     * @return Excel
     */
    @Override
    public ResponseEntity<byte[]> exportByExcel() {
        String timeFormat = new SimpleDateFormat("yyyy-MM-dd HH_mm_ss").format(new Date());
        String zipFilename = "role-" + timeFormat + ".zip";

        String dateFormat = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String filename = "role-" + dateFormat + ".xlsx";

        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        try (ZipOutputStream zipOutputStream = new ZipOutputStream(byteArrayOutputStream)) {

            List<RoleExcel> list = list().stream().map(role -> {
                RoleExcel roleExcel = new RoleExcel();
                BeanUtils.copyProperties(role, roleExcel);

                roleExcel.setId(role.getId().toString());
                return roleExcel;
            }).toList();

            // 创建临时ByteArrayOutputStream
            ByteArrayOutputStream excelOutputStream = new ByteArrayOutputStream();

            ZipEntry zipEntry = new ZipEntry(filename);
            zipOutputStream.putNextEntry(zipEntry);

            // 先写入到临时流
            EasyExcel.write(excelOutputStream, RoleExcel.class).sheet("role").doWrite(list);
            zipOutputStream.write(excelOutputStream.toByteArray());
            zipOutputStream.closeEntry();

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        // 设置响应头
        HttpHeaders headers = FileUtil.buildHttpHeadersByBinary(zipFilename);

        ByteArrayInputStream byteArrayInputStream = new ByteArrayInputStream(byteArrayOutputStream.toByteArray());
        return new ResponseEntity<>(byteArrayInputStream.readAllBytes(), headers, HttpStatus.OK);
    }

    /**
     * 使用Excel更新角色列表
     *
     * @param file Excel文件
     */
    @Override
    @CacheEvict(cacheNames = "role", key = "'roleList'", beforeInvocation = true)
    public void updateRoleByFile(MultipartFile file) {
        if (file == null) {
            throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);
        }

        InputStream fileInputStream;
        try {
            fileInputStream = file.getInputStream();
            EasyExcel.read(fileInputStream, RoleExcel.class, new RoleExcelListener(this)).sheet().doRead();
        } catch (IOException e) {
            throw new AuthCustomerException(ResultCodeEnum.UPLOAD_ERROR);
        }
    }

    /**
     * 添加角色
     *
     * @param dto 角色添加
     */
    @Override
    @CacheEvict(cacheNames = "role", key = "'roleList'", beforeInvocation = true)
    public void addRole(@Valid RoleAddDto dto) {
        Role role = new Role();
        BeanUtils.copyProperties(dto, role);
        save(role);
    }

    /**
     * 更新角色
     *
     * @param dto 角色更新
     */
    @Override
    @CacheEvict(cacheNames = "role", key = "'roleList'", beforeInvocation = true)
    public void updateRole(@Valid RoleUpdateDto dto) {
        // 查询更新的角色是否存在
        List<Role> roleList = list(Wrappers.<Role>lambdaQuery().eq(Role::getId, dto.getId()));
        if (roleList.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.DATA_NOT_EXIST);

        // 更新内容
        Role role = new Role();
        BeanUtils.copyProperties(dto, role);
        updateById(role);

        // 找到所有和当前更新角色相同的用户，并更新Redis中用户信息
        List<Long> userIds = userRoleMapper.selectList(Wrappers.<UserRole>lambdaQuery().eq(UserRole::getRoleId, dto.getId()))
                .stream().map(UserRole::getUserId).toList();
        // TODO 1
        // roleUtil.updateUserRedisInfo(userIds);
        // 发布角色更新事件
        eventPublisher.publishEvent(new RoleUpdatedEvent(this, dto.getId()));
    }


    /**
     * 删除|批量删除角色
     *
     * @param ids 删除id列表
     */
    @Override
    @CacheEvict(cacheNames = "role", key = "'roleList'", beforeInvocation = true)
    public void deleteRole(List<Long> ids) {
        // 判断数据请求是否为空
        if (ids.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        // 删除角色
        removeByIds(ids);

        // 删除角色权限相关
        rolePermissionMapper.deleteBatchRoleIds(ids);

        // 删除角色和用户相关
        userRoleMapper.deleteBatchIdsByRoleIds(ids);

        // 删除角色和路由相关
        routerRoleMapper.deleteBatchIdsByRoleIds(ids);
    }
}
