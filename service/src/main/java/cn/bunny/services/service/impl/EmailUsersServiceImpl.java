package cn.bunny.services.service.impl;

import cn.bunny.dao.dto.system.email.EmailUsersAddDto;
import cn.bunny.dao.dto.system.email.EmailUsersDto;
import cn.bunny.dao.dto.system.email.EmailUsersUpdateDto;
import cn.bunny.dao.entity.system.EmailUsers;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.system.email.EmailUsersVo;
import cn.bunny.services.mapper.EmailUsersMapper;
import cn.bunny.services.service.EmailUsersService;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.validation.Valid;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * <p>
 * 邮箱用户发送配置 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-10 15:19:22
 */
@Service
public class EmailUsersServiceImpl extends ServiceImpl<EmailUsersMapper, EmailUsers> implements EmailUsersService {

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
    public void addEmailUsers(@Valid EmailUsersAddDto dto) {
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
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }
}
