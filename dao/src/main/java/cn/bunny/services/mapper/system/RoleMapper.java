package cn.bunny.services.mapper.system;

import cn.bunny.services.domain.system.system.dto.role.RoleDto;
import cn.bunny.services.domain.system.system.entity.Role;
import cn.bunny.services.domain.system.system.vo.RoleVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * <p>
 * 角色 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-03 14:26:24
 */
@Mapper
public interface RoleMapper extends BaseMapper<Role> {

    /**
     * * 分页查询角色内容
     *
     * @param pageParams 角色分页参数
     * @param dto        角色查询表单
     * @return 角色分页结果
     */
    IPage<RoleVo> selectListByPage(@Param("page") Page<Role> pageParams, @Param("dto") RoleDto dto);

    /**
     * * 根据用户id查询当前用户所有角色
     *
     * @param userId 用户id
     */
    List<Role> selectListByUserId(long userId);

    /**
     * * 根据用户Id列表查询用户角色
     *
     * @param ids 用户Id列表
     * @return 角色列表
     */
    List<Role> selectListByUserIds(List<Long> ids);
}
