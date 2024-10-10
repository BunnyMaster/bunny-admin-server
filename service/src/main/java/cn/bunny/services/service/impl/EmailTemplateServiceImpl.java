package cn.bunny.services.service.impl;

import cn.bunny.dao.dto.system.email.EmailTemplateAddDto;
import cn.bunny.dao.dto.system.email.EmailTemplateDto;
import cn.bunny.dao.dto.system.email.EmailTemplateUpdateDto;
import cn.bunny.dao.entity.system.EmailTemplate;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.email.EmailTemplateVo;
import cn.bunny.services.mapper.EmailTemplateMapper;
import cn.bunny.services.service.EmailTemplateService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 邮件模板表 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-10 21:24:08
 */
@Service
public class EmailTemplateServiceImpl extends ServiceImpl<EmailTemplateMapper, EmailTemplate> implements EmailTemplateService {

    /**
     * * 邮件模板表 服务实现类
     *
     * @param pageParams 邮件模板表分页查询page对象
     * @param dto        邮件模板表分页查询对象
     * @return 查询分页邮件模板表返回对象
     */
    @Override
    public PageResult<EmailTemplateVo> getEmailTemplateList(Page<EmailTemplate> pageParams, EmailTemplateDto dto) {
        // 分页查询菜单图标
        IPage<EmailTemplate> page = baseMapper.selectListByPage(pageParams, dto);

        List<EmailTemplateVo> voList = page.getRecords().stream().map(emailTemplate -> {
            EmailTemplateVo emailTemplateVo = new EmailTemplateVo();
            BeanUtils.copyProperties(emailTemplate, emailTemplateVo);
            return emailTemplateVo;
        }).toList();

        return PageResult.<EmailTemplateVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 添加邮件模板表
     *
     * @param dto 邮件模板表添加
     */
    @Override
    public void addEmailTemplate(@Valid EmailTemplateAddDto dto) {
        // 保存数据
        EmailTemplate emailTemplate = new EmailTemplate();
        BeanUtils.copyProperties(dto, emailTemplate);
        save(emailTemplate);
    }

    /**
     * 更新邮件模板表
     *
     * @param dto 邮件模板表更新
     */
    @Override
    public void updateEmailTemplate(@Valid EmailTemplateUpdateDto dto) {
        // 更新内容
        EmailTemplate emailTemplate = new EmailTemplate();
        BeanUtils.copyProperties(dto, emailTemplate);
        updateById(emailTemplate);
    }

    /**
     * 删除|批量删除邮件模板表
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteEmailTemplate(List<Long> ids) {
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }
}
