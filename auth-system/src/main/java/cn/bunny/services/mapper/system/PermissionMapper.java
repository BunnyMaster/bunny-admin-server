package cn.bunny.services.mapper.system;

import cn.bunny.domain.system.dto.PermissionDto;
import cn.bunny.domain.system.entity.Permission;
import cn.bunny.domain.system.vo.PermissionVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 权限 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 16:00:52
 */
@Mapper
public interface PermissionMapper extends BaseMapper<Permission> {

    /**
     * * 分页查询权限内容
     *
     * @param pageParams 权限分页参数
     * @param dto        权限查询表单
     * @return 权限分页结果
     */
    IPage<PermissionVo> selectListByPage(@Param("page") Page<Permission> pageParams, @Param("dto") PermissionDto dto);

    /**
     * * 根据用户id查询当前用户所有权限
     *
     * @param userId 用户id
     */
    List<Permission> selectListByUserId(long userId);

}
