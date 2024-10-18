package cn.bunny.services.service.impl;

import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.dto.system.email.user.EmailUserUpdateStatusDto;
import cn.bunny.dao.dto.system.email.user.EmailUsersAddDto;
import cn.bunny.dao.dto.system.email.user.EmailUsersDto;
import cn.bunny.dao.dto.system.email.user.EmailUsersUpdateDto;
import cn.bunny.dao.entity.system.EmailUsers;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.email.EmailUsersVo;
import cn.bunny.services.factory.EmailFactory;
import cn.bunny.services.mapper.EmailUsersMapper;
import cn.bunny.services.service.EmailUsersService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
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

    @Autowired
    private EmailFactory emailFactory;

    /**
     * * 邮箱用户发送配置 服务实现类
     *
     * @param pageParams 邮箱用户发送配置分页查询page对象
     * @param dto        邮箱用户发送配置分页查询对象
     * @return 查询分页邮箱用户发送配置返回对象
     */
    @Override
    public PageResult<EmailUsersVo> getEmailUsersList(Page<EmailUsers> pageParams, EmailUsersDto dto) {
        // 分页查询菜单图标
        IPage<EmailUsers> page = baseMapper.selectListByPage(pageParams, dto);

        List<EmailUsersVo> voList = page.getRecords().stream().map(emailUsers -> {
            EmailUsersVo emailUsersVo = new EmailUsersVo();
            BeanUtils.copyProperties(emailUsers, emailUsersVo);
            return emailUsersVo;
        }).toList();

        return PageResult.<EmailUsersVo>builder()
                .list(voList)
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
        // 判断邮箱是否添加
        List<EmailUsers> emailUsersList = list(Wrappers.<EmailUsers>lambdaQuery().eq(EmailUsers::getEmail, dto.getEmail()));
        if (!emailUsersList.isEmpty()) throw new BunnyException(ResultCodeEnum.EMAIL_EXIST);

        // 更新邮箱默认状态
        emailFactory.updateEmailUserDefault(dto.getIsDefault());

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
        emailFactory.updateEmailUserDefault(dto.getIsDefault());

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
        if (ids.isEmpty()) throw new BunnyException(ResultCodeEnum.REQUEST_IS_EMPTY);

        baseMapper.deleteBatchIdsWithPhysics(ids);
    }

    /**
     * * 更新邮箱用户状态
     *
     * @param dto 邮箱用户更新状态表单
     */
    @Override
    public void updateEmailUserStatus(EmailUserUpdateStatusDto dto) {
        // 更新邮箱默认状态
        emailFactory.updateEmailUserDefault(dto.getIsDefault());

        EmailUsers emailUsers = new EmailUsers();
        BeanUtils.copyProperties(dto, emailUsers);
        updateById(emailUsers);
    }

    /**
     * * 获取所有邮箱配置用户
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
}
