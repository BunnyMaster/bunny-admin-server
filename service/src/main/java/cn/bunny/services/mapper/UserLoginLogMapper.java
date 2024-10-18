package cn.bunny.services.mapper;

import cn.bunny.dao.entity.log.UserLoginLog;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 用户登录日志 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-18
 */
@Mapper
public interface UserLoginLogMapper extends BaseMapper<UserLoginLog> {

}
