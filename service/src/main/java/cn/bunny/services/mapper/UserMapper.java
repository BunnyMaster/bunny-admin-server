package cn.bunny.services.mapper;

import cn.bunny.dao.entity.system.AdminUser;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 用户信息 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Mapper
public interface UserMapper extends BaseMapper<AdminUser> {

}
