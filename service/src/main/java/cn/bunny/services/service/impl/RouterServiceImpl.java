package cn.bunny.services.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.entity.system.Router;
import cn.bunny.dao.pojo.constant.RedisUserConstant;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.router.RouterMeta;
import cn.bunny.dao.vo.router.UserRouterVo;
import cn.bunny.dao.vo.user.LoginVo;
import cn.bunny.services.mapper.RouterMapper;
import cn.bunny.services.service.RouterService;
import cn.bunny.services.service.process.RouterServiceProcess;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 服务实现类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-27
 */
@Service
@Transactional
public class RouterServiceImpl extends ServiceImpl<RouterMapper, Router> implements RouterService {
    @Autowired
    private RouterServiceProcess routerServiceProcess;
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;

    /**
     * * 获取路由内容
     *
     * @return 路遇列表
     */
    @Override
    public List<UserRouterVo> getRouterAsync() {
        // 当前用户id
        String username = BaseContext.getUsername();

        LoginVo loginVo = (LoginVo) redisTemplate.opsForValue().get(RedisUserConstant.getAdminLoginInfoPrefix(username));
        if (loginVo == null) throw new BunnyException(ResultCodeEnum.FAIL);

        // 角色列表
        List<String> roleList = loginVo.getRoles();
        // 权限列表
        List<String> powerCodeList = loginVo.getPermissions();

        // 路由列表，根据用户角色判断
        List<Router> routerList;

        // 返回路由列表
        List<UserRouterVo> list = new ArrayList<>();

        // 查询用户角色，判断是否是管理员角色
        boolean isAdmin = roleList.stream().anyMatch(authUserRole -> authUserRole.equals("admin"));
        if (isAdmin) {
            routerList = list();
        } else {
            List<Long> routerIds = baseMapper.selectListByUserId(loginVo.getId());
            routerList = baseMapper.selectParentListByRouterId(routerIds);
        }

        // 构建返回路由列表
        List<UserRouterVo> routerVoList = routerList.stream()
                .filter(Router::getVisible)
                .map(router -> {
                    // 复制对象
                    UserRouterVo routerVo = new UserRouterVo();
                    BeanUtils.copyProperties(router, routerVo);
                    routerVo.setPath(router.getPath().trim());

                    // 设置
                    RouterMeta meta = RouterMeta.builder()
                            .rank(router.getRouterRank())
                            .icon(router.getIcon())
                            .title(router.getTitle())
                            .roles(roleList)
                            .auths(powerCodeList).build();
                    routerVo.setMeta(meta);
                    return routerVo;
                }).distinct().toList();

        // 构建树形结构
        routerVoList.forEach(routerVo -> {
            if (routerVo.getParentId() == 0) {
                routerVo.setChildren(routerServiceProcess.handleGetChildrenWIthRouter(routerVo.getId(), routerVoList));
                list.add(routerVo);
            }
        });

        return list;
    }
}
