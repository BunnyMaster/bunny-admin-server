package cn.bunny.services.service.impl;

import cn.bunny.dao.entity.system.EmailTemplate;
import cn.bunny.services.mapper.EmailTemplateMapper;
import cn.bunny.services.service.EmailTemplateService;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-26
 */
@Service
public class EmailTemplateServiceImpl extends ServiceImpl<EmailTemplateMapper, EmailTemplate> implements EmailTemplateService {

}
