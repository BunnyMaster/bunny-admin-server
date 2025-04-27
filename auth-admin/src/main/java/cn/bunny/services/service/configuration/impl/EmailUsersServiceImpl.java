package cn.bunny.services.service.configuration.impl;

import cn.bunny.domain.email.dto.EmailUsersAddDto;
import cn.bunny.domain.email.dto.EmailUsersDto;
import cn.bunny.domain.email.dto.EmailUsersUpdateDto;
import cn.bunny.domain.email.entity.EmailUsers;
import cn.bunny.domain.email.vo.EmailUsersVo;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.ResultCodeEnum;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.configuration.EmailUsersMapper;
import cn.bunny.services.service.configuration.EmailUsersService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * <p>
 * 邮箱用户发送配置 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-10 15:19:22
 */
@Service
@Transactional
public class EmailUsersServiceImpl extends ServiceImpl<EmailUsersMapper, EmailUsers> implements EmailUsersService {

    @Resource
    private EmailUsersMapper emailUsersMapper;

    /**
     * 邮箱用户发送配置 服务实现类
     *
     * @param pageParams 邮箱用户发送配置分页查询page对象
     * @param dto        邮箱用户发送配置分页查询对象
     * @return 查询分页邮箱用户发送配置返回对象
     */
    @Override
    public PageResult<EmailUsersVo> getEmailUserPage(Page<EmailUsers> pageParams, EmailUsersDto dto) {
        IPage<EmailUsersVo> page = baseMapper.selectListByPage(pageParams, dto);

        return PageResult.<EmailUsersVo>builder()
                .list(page.getRecords())
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 添加邮箱用户发送配置
     *
     * @param dto 邮箱用户发送配置添加
     */
    @Override
    public void addEmailUsers(EmailUsersAddDto dto) {
        // 更新邮箱默认状态
        updateEmailUserDefault(dto.getIsDefault());

        // 保存数据
        EmailUsers emailUsers = new EmailUsers();
        BeanUtils.copyProperties(dto, emailUsers);
        save(emailUsers);
    }


    /**
     * 更新邮箱用户发送配置
     *
     * @param dto 邮箱用户发送配置更新
     */
    @Override
    public void updateEmailUsers(@Valid EmailUsersUpdateDto dto) {
        // 更新邮箱默认状态
        updateEmailUserDefault(dto.getIsDefault());

        // 更新内容
        EmailUsers emailUsers = new EmailUsers();
        BeanUtils.copyProperties(dto, emailUsers);
        updateById(emailUsers);
    }

    /**
     * 删除|批量删除邮箱用户发送配置
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteEmailUsers(List<Long> ids) {
        // 判断数据请求是否为空
        if (ids.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        removeByIds(ids);
    }

    /**
     * 获取所有邮箱配置用户
     *
     * @return 邮件用户列表
     */
    @Override
    public List<Map<String, String>> getAllMailboxConfigurationUsers() {
        return list().stream().map(emailUsers -> {
            Map<String, String> map = new HashMap<>();
            map.put("key", emailUsers.getEmail());
            map.put("value", emailUsers.getId().toString());
            return map;
        }).toList();
    }

    /**
     * 判断邮箱是否添加
     *
     * @param isDefault 邮箱是否为默认
     */
    public void updateEmailUserDefault(Boolean isDefault) {
        EmailUsers emailUsers = new EmailUsers();
        // 判断状态，如果是默认将所有的内容都设为false
        if (isDefault) {
            emailUsers.setIsDefault(false);
            emailUsersMapper.update(emailUsers, Wrappers.<EmailUsers>lambdaUpdate().eq(EmailUsers::getIsDefault, true));
        }
    }
}
