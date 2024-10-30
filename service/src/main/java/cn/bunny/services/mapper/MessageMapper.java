package cn.bunny.services.mapper;

import cn.bunny.dao.entity.system.Message;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * <p>
 * 系统消息 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30
 */
@Mapper
public interface MessageMapper extends BaseMapper<Message> {

}
