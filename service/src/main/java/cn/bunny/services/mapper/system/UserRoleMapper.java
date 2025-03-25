package cn.bunny.services.mapper.system;

import cn.bunny.dao.entity.system.UserRole;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

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
     * @param userIds 用户id
     */
    void deleteBatchIdsByUserIdsWithPhysics(List<Long> userIds);

    /**
     * * 根据角色id删除用户和角色
     *
     * @param roleIds 角色id列表
     */
    void deleteBatchIdsByRoleIdsWithPhysics(List<Long> roleIds);

}
