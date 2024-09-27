package cn.bunny.services.mapper;

import cn.bunny.dao.entity.system.EmailUsers;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 邮箱发送表 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Mapper
public interface EmailUsersMapper extends BaseMapper<EmailUsers> {

}
