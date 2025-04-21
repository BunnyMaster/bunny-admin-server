package cn.bunny.services.mapper.system;

import cn.bunny.domain.system.entity.UserDept;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * <p>
 * 部门用户关系表 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-04
 */
@Mapper
public interface UserDeptMapper extends BaseMapper<UserDept> {

    /**
     * * 根据部门id删除部门用户
     *
     * @param deptIds 部门id列表
     */
    void deleteBatchIdsByDeptIdWithPhysics(List<Long> deptIds);

    /**
     * * 根据用户id删除用户部门
     *
     * @param userIds 用户id列表
     */
    void deleteBatchIdsByUserIdWithPhysics(List<Long> userIds);
}
