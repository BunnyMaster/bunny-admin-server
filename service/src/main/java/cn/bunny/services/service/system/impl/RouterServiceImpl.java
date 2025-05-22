package cn.bunny.services.service.system.impl;

import cn.bunny.services.core.utils.RouterServiceHelper;
import cn.bunny.services.domain.common.enums.ResultCodeEnum;
import cn.bunny.services.domain.system.dto.RouterDto;
import cn.bunny.services.domain.system.entity.router.Router;
import cn.bunny.services.domain.system.entity.router.RouterMeta;
import cn.bunny.services.domain.system.entity.router.RouterMetaTransition;
import cn.bunny.services.domain.system.views.ViewRolePermission;
import cn.bunny.services.domain.system.views.ViewRouterRole;
import cn.bunny.services.domain.system.vo.router.RouterManageVo;
import cn.bunny.services.domain.system.vo.router.RouterVo;
import cn.bunny.services.domain.system.vo.router.WebUserRouterVo;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.system.RolePermissionMapper;
import cn.bunny.services.mapper.system.RouterMapper;
import cn.bunny.services.mapper.system.RouterRoleMapper;
import cn.bunny.services.service.system.RouterService;
import com.alibaba.fastjson2.JSON;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

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
    private static final String CACHE_NAMES = "router";

    @Resource
    private RouterRoleMapper routerRoleMapper;

    @Resource
    private RouterServiceHelper routerServiceHelper;

    @Resource
    private RolePermissionMapper rolePermissionMapper;

    /**
     * 获取路由内容
     *
     * @return 路遇列表
     */
    @Override
    public List<WebUserRouterVo> routerAsync() {
        // 返回路由列表
        List<WebUserRouterVo> voList = new ArrayList<>();

        // 当前的所有的路由列表
        List<Router> routerList = list();

        // 查询路由角色列表
        Map<Long, List<ViewRouterRole>> routerRoleList = routerRoleMapper.selectRouterRoleList().stream()
                .collect(Collectors.groupingBy(ViewRouterRole::getRouterId, Collectors.toList()));

        // 查询角色和权限列表，根据角色id获取对应权限
        Map<Long, List<ViewRolePermission>> rolePermissionList = rolePermissionMapper.viewRolePowerWithAll().stream()
                .collect(Collectors.groupingBy(ViewRolePermission::getRoleId, Collectors.toList()));

        // 整理web用户所能看到的路由列表，并检查当前用户是否是admin
        List<WebUserRouterVo> webUserRouterVoList = routerServiceHelper.getWebUserRouterVos(routerList, routerRoleList, rolePermissionList);

        // 添加 admin 管理路由权限
        webUserRouterVoList.forEach(routerVo -> {
            // 递归添加路由节点
            if (routerVo.getParentId() == 0) {
                routerVo.setChildren(routerServiceHelper.buildTreeSetChildren(routerVo.getId(), webUserRouterVoList));
                voList.add(routerVo);
            }
        });

        return voList;
    }

    /**
     * 管理菜单列表
     *
     * @return 系统菜单表
     */
    @Override
    @Cacheable(cacheNames = CACHE_NAMES, key = "'routerList'", cacheManager = "cacheManagerWithMouth")
    public List<RouterManageVo> routerList() {
        // 查询菜单路由
        List<RouterVo> routerList = baseMapper.selectRouterList();

        return routerList.stream().map(router -> {
                    // 管理路由
                    RouterManageVo routerManageVo = new RouterManageVo();
                    BeanUtils.copyProperties(router, routerManageVo);

                    // 将字符串JSON转成实体类，需要判断 meta和transition 是否存在
                    String meta = router.getMeta();
                    if (StringUtils.hasText(meta)) {
                        // 路由 Meta
                        RouterMeta routerMeta = JSON.parseObject(meta, RouterMeta.class);
                        BeanUtils.copyProperties(routerMeta, routerManageVo);

                        // 路由动画
                        RouterMetaTransition transition = routerMeta.getTransition();
                        if (transition != null) {
                            BeanUtils.copyProperties(transition, routerManageVo);
                        }
                    }
                    return routerManageVo;
                })
                .sorted(Comparator.comparing(RouterManageVo::getRank))
                .toList();
    }

    /**
     * 添加路由菜单
     *
     * @param dto 添加菜单表单
     */
    @Override
    @CacheEvict(cacheNames = CACHE_NAMES, key = "'routerList'", beforeInvocation = true)
    public void createRouter(RouterDto dto) {
        // 添加路由
        Router router = new Router();
        BeanUtils.copyProperties(dto, router);

        // 将 meta转成json
        RouterMeta meta = dto.getMeta();
        String jsonString = JSON.toJSONString(meta);
        router.setMeta(jsonString);

        // 将数据提出role 和 power 存储到数据库
        Long id = router.getId();
        routerServiceHelper.insertRouterRoleAndPermission(meta, id);

        // 添加路由
        save(router);
    }

    /**
     * * 更新路由菜单
     *
     * @param dto 更新表单
     */
    @Override
    @CacheEvict(cacheNames = CACHE_NAMES, key = "'routerList'", beforeInvocation = true)
    public void updateRouter(RouterDto dto) {
        // 更新路由
        Router router = new Router();
        BeanUtils.copyProperties(dto, router);

        // 将前端meta转成JSON 存储到数据库
        RouterMeta meta = dto.getMeta();
        String jsonString = JSON.toJSONString(meta);
        router.setMeta(jsonString);

        Long id = router.getId();
        // 先删除路由和角色下所有内容
        routerRoleMapper.deleteBatchIdsByRouterIds(List.of(id));

        // 将数据提出role 和 power 存储到数据库
        routerServiceHelper.insertRouterRoleAndPermission(meta, id);

        // 更新路由信息
        updateById(router);
    }

    /**
     * * 删除路由菜单
     *
     * @param ids 删除id列表
     */
    @Override
    @CacheEvict(cacheNames = CACHE_NAMES, key = "'routerList'", beforeInvocation = true)
    public void deletedRouterByIds(List<Long> ids) {
        // 判断数据请求是否为空
        if (ids.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        // 查找子级菜单，一起删除
        List<Long> longList = list(Wrappers.<Router>lambdaQuery().in(Router::getParentId, ids)).stream().map(Router::getId).toList();
        ids.addAll(longList);

        removeBatchByIds(ids);
    }
}
