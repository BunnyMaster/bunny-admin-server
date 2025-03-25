package cn.bunny.services.service.configuration.impl;

import cn.bunny.dao.dto.system.email.template.EmailTemplateAddDto;
import cn.bunny.dao.dto.system.email.template.EmailTemplateDto;
import cn.bunny.dao.dto.system.email.template.EmailTemplateUpdateDto;
import cn.bunny.dao.entity.system.EmailTemplate;
import cn.bunny.dao.enums.EmailTemplateEnums;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.email.EmailTemplateVo;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.configuration.EmailTemplateMapper;
import cn.bunny.services.service.configuration.EmailTemplateService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * <p>
 * 邮件模板表 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-10 21:24:08
 */
@Service
@Transactional
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
        IPage<EmailTemplateVo> page = baseMapper.selectListByPage(pageParams, dto);
        List<EmailTemplateVo> emailTemplateVos = page.getRecords().stream()
                .map(emailTemplateVo -> {
                    EmailTemplateVo vo = new EmailTemplateVo();
                    BeanUtils.copyProperties(emailTemplateVo, vo);

                    // 查找枚举内容并设置详情
                    List<EmailTemplateEnums> emailTemplateEnums = Arrays.stream(EmailTemplateEnums.values())
                            .filter(enums -> enums.getType().equals(vo.getType()))
                            .toList();
                    vo.setSummary(emailTemplateEnums.get(0).getSummary());
                    return vo;
                })
                .toList();

        return PageResult.<EmailTemplateVo>builder()
                .list(emailTemplateVos)
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
        String type = dto.getType();

        // 保存数据
        EmailTemplate emailTemplate = new EmailTemplate();
        BeanUtils.copyProperties(dto, emailTemplate);

        // 判断当前类型是否已有默认，如果是不设置为默认直接保存
        if (!dto.getIsDefault()) {
            save(emailTemplate);
            return;
        }

        LambdaQueryWrapper<EmailTemplate> emailTemplateLambdaQueryWrapper = new LambdaQueryWrapper<>();
        emailTemplateLambdaQueryWrapper.eq(EmailTemplate::getType, type);
        emailTemplateLambdaQueryWrapper.eq(EmailTemplate::getIsDefault, Boolean.TRUE);
        List<EmailTemplate> emailTemplateList = list(emailTemplateLambdaQueryWrapper);

        // 更新列表
        List<EmailTemplate> updateList = emailTemplateList.stream().map(template -> template.setIsDefault(false)).toList();
        if (!updateList.isEmpty()) {
            updateBatchById(updateList);
        }
        save(emailTemplate);
    }

    /**
     * 更新邮件模板表
     *
     * @param dto 邮件模板表更新
     */
    @Override
    public void updateEmailTemplate(@Valid EmailTemplateUpdateDto dto) {
        String type = dto.getType();

        // 查询是否有这个模板
        List<EmailTemplate> emailTemplateList = list(Wrappers.<EmailTemplate>lambdaQuery().eq(EmailTemplate::getId, dto.getId()));
        if (emailTemplateList.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.DATA_NOT_EXIST);

        // 更新内容
        EmailTemplate emailTemplate = new EmailTemplate();
        BeanUtils.copyProperties(dto, emailTemplate);

        // 判断当前类型是否已有默认，如果是不设置为默认直接保存
        List<EmailTemplate> updateList = new ArrayList<>();
        if (dto.getIsDefault()) {
            LambdaQueryWrapper<EmailTemplate> emailTemplateLambdaQueryWrapper = new LambdaQueryWrapper<>();
            emailTemplateLambdaQueryWrapper.eq(EmailTemplate::getType, type);
            emailTemplateLambdaQueryWrapper.eq(EmailTemplate::getIsDefault, Boolean.TRUE);

            // 更新数据列表
            List<EmailTemplate> checkEmailTemplateList = list(emailTemplateLambdaQueryWrapper);
            updateList = new ArrayList<>(checkEmailTemplateList.stream().map(template -> template.setIsDefault(false)).toList());
        }

        updateList.add(emailTemplate);
        updateBatchById(updateList);

        // 默认邮件
        List<EmailTemplate> emailTemplates = list(Wrappers.<EmailTemplate>lambdaQuery().eq(EmailTemplate::getType, type));
        List<EmailTemplate> isEmailTemplateListEmpty = emailTemplates.stream().filter(template -> template.getIsDefault().equals(true)).toList();
        if (isEmailTemplateListEmpty.isEmpty()) {
            EmailTemplate template = emailTemplates.get(0);
            template.setIsDefault(Boolean.TRUE);
            updateById(template);
        }
    }

    /**
     * 删除|批量删除邮件模板表
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteEmailTemplate(List<Long> ids) {
        // 判断数据请求是否为空
        if (ids.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        baseMapper.deleteBatchIdsWithPhysics(ids);
    }

    /**
     * * 获取模板类型字段
     *
     * @return 枚举字段列表
     */
    @Override
    public List<Map<String, String>> getEmailTypes() {
        return Arrays.stream(EmailTemplateEnums.values()).map(emailTemplateEnums -> {
            Map<String, String> map = new HashMap<>();
            map.put("key", emailTemplateEnums.getSummary());
            map.put("value", emailTemplateEnums.getType());
            return map;
        }).toList();
    }
}

