package cn.bunny.services.mapper;

import cn.bunny.dao.entity.system.MessageReceived;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * <p>
 * Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-31
 */
@Mapper
public interface MessageReceivedMapper extends BaseMapper<MessageReceived> {

    /**
     * 根据发送者id批量删除消息接受者
     *
     * @param userIds 发送用户ID
     */
    void deleteBatchIdsWithPhysics(List<Long> userIds);

    /**
     * 根据消息Id物理删除接受者消息
     *
     * @param ids 消息id
     */
    void deleteBatchIdsByMessageIdsWithPhysics(List<Long> ids);
}
