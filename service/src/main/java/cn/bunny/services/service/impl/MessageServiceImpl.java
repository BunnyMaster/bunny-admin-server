package cn.bunny.services.service.impl;

import cn.bunny.dao.entity.system.Message;
import cn.bunny.services.mapper.MessageMapper;
import cn.bunny.services.service.MessageService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 系统消息 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-30
 */
@Service
public class MessageServiceImpl extends ServiceImpl<MessageMapper, Message> implements MessageService {

}
