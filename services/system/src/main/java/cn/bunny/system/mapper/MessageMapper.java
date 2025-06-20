package cn.bunny.system.mapper;

import cn.bunny.domain.system.dto.MessageDto;
import cn.bunny.domain.system.entity.Message;
import cn.bunny.domain.system.vo.MessageDetailVo;
import cn.bunny.domain.system.vo.MessageReceivedWithMessageVo;
import cn.bunny.domain.system.vo.MessageReceivedWithUserVo;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

/**
 * <p>
 * 系统消息 Mapper 接口
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30 15:19:56
 */
@Mapper
public interface MessageMapper extends BaseMapper<Message> {

    /**
     * 根据消息id查询消息详情
     *
     * @param id 消息id
     * @return 消息返回对象
     */
    MessageDetailVo selectMessageVoById(Long id);

    /**
     * 根据消息id获取接收人信息
     *
     * @param messageId 消息id
     * @return 消息接收人用户名等信息
     */
    List<MessageReceivedWithUserVo> selectUserinfoListByMessageId(Long messageId);

    /**
     * 分页查询发送消息
     *
     * @param pageParams 分页参数
     * @param dto        查询表单
     * @return 系统消息返回列表
     */
    IPage<MessageReceivedWithMessageVo> selectListByPage(Page<Message> pageParams, MessageDto dto);
}
