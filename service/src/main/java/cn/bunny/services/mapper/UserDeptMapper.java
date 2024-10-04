package cn.bunny.services.mapper;

import cn.bunny.dao.entity.system.UserDept;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

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

}
