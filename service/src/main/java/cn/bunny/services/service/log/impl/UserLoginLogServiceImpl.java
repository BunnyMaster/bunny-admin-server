package cn.bunny.services.service.log.impl;

import cn.bunny.services.context.BaseContext;
import cn.bunny.services.domain.common.model.vo.result.PageResult;
import cn.bunny.services.domain.system.log.dto.UserLoginLogDto;
import cn.bunny.services.domain.system.log.entity.UserLoginLog;
import cn.bunny.services.domain.system.log.vo.UserLoginLogLocalVo;
import cn.bunny.services.domain.system.log.vo.UserLoginLogVo;
import cn.bunny.services.mapper.log.UserLoginLogMapper;
import cn.bunny.services.service.log.UserLoginLogService;
import cn.bunny.services.utils.IpUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * <p>
 * 用户登录日志 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-10-19 01:01:01
 */
@Service
@Transactional
public class UserLoginLogServiceImpl extends ServiceImpl<UserLoginLogMapper, UserLoginLog> implements UserLoginLogService {

    /**
     * * 用户登录日志 服务实现类
     *
     * @param pageParams 用户登录日志分页查询page对象
     * @param dto        用户登录日志分页查询对象
     * @return 查询分页用户登录日志返回对象
     */
    @Override
    public PageResult<UserLoginLogVo> getUserLoginLogPage(Page<UserLoginLog> pageParams, UserLoginLogDto dto) {
        IPage<UserLoginLogVo> page = baseMapper.selectListByPage(pageParams, dto);

        List<UserLoginLogVo> voList = page.getRecords().stream()
                .map(userLoginLog -> {
                    UserLoginLogVo userLoginLogVo = new UserLoginLogVo();
                    BeanUtils.copyProperties(userLoginLog, userLoginLogVo);

                    // 隐藏部分IP地址
                    String ipAddress = userLoginLogVo.getIpAddress();
                    userLoginLogVo.setIpAddress(IpUtil.replaceIp(ipAddress));
                    return userLoginLogVo;
                }).toList();

        return PageResult.<UserLoginLogVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * 删除|批量删除用户登录日志
     *
     * @param ids 删除id列表
     */
    @Override
    public void deleteUserLoginLog(List<Long> ids) {
        removeByIds(ids);
    }

    /**
     * * 获取本地用户登录日志
     *
     * @param pageParams 分页查询内容
     * @return 用户登录日志返回列表
     */
    @Override
    public PageResult<UserLoginLogLocalVo> getUserLoginLogPageByUser(Page<UserLoginLog> pageParams) {
        Long userId = BaseContext.getUserId();
        IPage<UserLoginLog> page = baseMapper.selectListByPageWithLocalUser(pageParams, userId);

        List<UserLoginLogLocalVo> voList = page.getRecords().stream()
                .map(userLoginLog -> {
                    UserLoginLogLocalVo userLoginLogVo = new UserLoginLogLocalVo();
                    BeanUtils.copyProperties(userLoginLog, userLoginLogVo);
                    return userLoginLogVo;
                }).toList();

        return PageResult.<UserLoginLogLocalVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }
}
