package cn.bunny.services.mapper;

import cn.bunny.dao.entity.system.UserRole;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Mapper
public interface UserRoleMapper extends BaseMapper<UserRole> {

    /**
     * * 删除这个用户id下所有的角色信息
     *
     * @param userId 用户id
     */
    void deleteBatchIdsWithPhysicsByUserId(Long userId);
}
