package cn.bunny.services.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.dto.system.router.RouterAddDto;
import cn.bunny.dao.dto.system.router.RouterManageDto;
import cn.bunny.dao.dto.system.router.RouterUpdateByIdWithRankDto;
import cn.bunny.dao.dto.system.router.RouterUpdateDto;
import cn.bunny.dao.entity.system.Role;
import cn.bunny.dao.entity.system.Router;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.view.ViewRolePower;
import cn.bunny.dao.view.ViewRouterRole;
import cn.bunny.dao.vo.system.router.RouterManageVo;
import cn.bunny.dao.vo.system.router.RouterMeta;
import cn.bunny.dao.vo.system.router.UserRouterVo;
import cn.bunny.services.factory.RouterServiceFactory;
import cn.bunny.services.mapper.RoleMapper;
import cn.bunny.services.mapper.RolePowerMapper;
import cn.bunny.services.mapper.RouterMapper;
import cn.bunny.services.mapper.RouterRoleMapper;
import cn.bunny.services.security.custom.CustomCheckIsAdmin;
import cn.bunny.services.service.RouterService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.*;
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
    @Autowired
    private RouterServiceFactory routerServiceFactory;

    @Autowired
    private RoleMapper roleMapper;

    @Autowired
    private RouterRoleMapper routerRoleMapper;

    @Autowired
    private RolePowerMapper rolePowerMapper;

    /**
     * * 获取路由内容
     *
     * @return 路遇列表
     */
    @Override
    public List<UserRouterVo> getRouterAsync() {
        // 根据用户ID查询角色数据
        Long userId = BaseContext.getUserId();

        // 查询角色信息
        List<Role> roleList;
        List<String> userRoleCodeList;
        if (userId.equals(1L)) {
            userRoleCodeList = List.of("admin");
        } else {
            roleList = roleMapper.selectListByUserId(userId);
            userRoleCodeList = roleList.stream().map(Role::getRoleCode).toList();
        }

        // 如果没有分配角色直接返回空数组
        if (userRoleCodeList.isEmpty()) return new ArrayList<>();

        // 返回路由列表
        List<UserRouterVo> list = new ArrayList<>();

        // 查询用户角色，判断是否是管理员角色
        boolean isAdmin = CustomCheckIsAdmin.checkAdmin(userRoleCodeList);

        // 查询路由和角色对应关系
        List<ViewRouterRole> routerRoleList = routerRoleMapper.viewRouterRolesWithAll();
        Map<Long, List<String>> routerIdWithRoleCodeMap = routerRoleList.stream()
                .collect(Collectors.groupingBy(
                        ViewRouterRole::getRouterId,
                        Collectors.mapping(ViewRouterRole::getRoleCode, Collectors.toUnmodifiableList())
                ));

        // 角色和权限对应关系
        List<ViewRolePower> rolePowerList = rolePowerMapper.viewRolePowerWithAll();
        Map<String, Set<String>> roleCodeWithPowerCodeMap = rolePowerList.stream()
                .collect(Collectors.groupingBy(
                        ViewRolePower::getRoleCode,
                        Collectors.mapping(ViewRolePower::getPowerCode, Collectors.toUnmodifiableSet())
                ));

        // 查询所有路由内容
        List<Router> routerList = list();

        // 构建返回路由列表
        List<UserRouterVo> routerVoList = routerList.stream()
                .sorted(Comparator.comparing(Router::getRouterRank))
                .filter(Router::getVisible)
                .map(router -> {
                    // 角色码列表
                    List<String> roleCodeList;

                    // 权限码列表
                    List<String> powerCodeList;

                    // 判断是否是admin
                    if (isAdmin) {
                        roleCodeList = userRoleCodeList;
                        powerCodeList = List.of("*", "*::*", "*::*::*");
                    } else {
                        roleCodeList = routerIdWithRoleCodeMap.getOrDefault(router.getId(), Collections.emptyList());
                        powerCodeList = roleCodeList.stream()
                                .map(roleCodeWithPowerCodeMap::get)
                                .filter(Objects::nonNull)
                                .flatMap(Set::stream)
                                .collect(Collectors.toUnmodifiableSet())
                                .stream().toList();
                    }

                    // 复制对象
                    UserRouterVo routerVo = new UserRouterVo();
                    BeanUtils.copyProperties(router, routerVo);

                    // 设置
                    RouterMeta meta = RouterMeta.builder()
                            .frameSrc(router.getFrameSrc())
                            .rank(router.getRouterRank())
                            .icon(router.getIcon())
                            .title(router.getTitle())
                            .roles(roleCodeList)
                            .auths(powerCodeList)
                            .build();

                    routerVo.setMeta(meta);
                    return routerVo;
                }).distinct().toList();

        // 构建树形结构
        routerVoList.forEach(routerVo -> {
            if (routerVo.getParentId() == 0) {
                routerVo.setChildren(routerServiceFactory.handleGetChildrenWIthRouter(routerVo.getId(), routerVoList));
                list.add(routerVo);
            }
        });

        return list;
    }

    /**
     * * 管理菜单列表
     *
     * @param pageParams 分页想去
     * @param dto        路由查询表单
     * @return 系统菜单表分页
     */
    @Override
    public PageResult<RouterManageVo> getMenusByPage(Page<Router> pageParams, RouterManageDto dto) {
        IPage<Router> page = baseMapper.selectListByPage(pageParams, dto);

        // 构建返回对象
        List<RouterManageVo> voList = page.getRecords().stream()
                .map(router -> {
                    RouterManageVo routerManageVo = new RouterManageVo();
                    BeanUtils.copyProperties(router, routerManageVo);
                    return routerManageVo;
                })
                .sorted(Comparator.comparing(RouterManageVo::getRouterRank))
                .toList();

        return PageResult.<RouterManageVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }

    /**
     * * 管理菜单列表
     *
     * @return 系统菜单表
     */
    @Override
    public List<RouterManageVo> getMenusList(RouterManageDto dto) {
        LambdaQueryWrapper<Router> lambdaQueryWrapper = new LambdaQueryWrapper<>();
        lambdaQueryWrapper.like(StringUtils.hasText(dto.getTitle()), Router::getTitle, dto.getTitle());
        lambdaQueryWrapper.eq(dto.getVisible() != null, Router::getVisible, dto.getVisible());

        return list(lambdaQueryWrapper).stream()
                .map(router -> {
                    RouterManageVo routerManageVo = new RouterManageVo();
                    BeanUtils.copyProperties(router, routerManageVo);
                    return routerManageVo;
                })
                .sorted(Comparator.comparing(RouterManageVo::getRouterRank))
                .toList();
    }

    /**
     * * 添加路由菜单
     *
     * @param dto 添加菜单表单
     */
    @Override
    public void addMenu(RouterAddDto dto) {
        // 查找是否添加过路由名称
        Router router = getOne(Wrappers.<Router>lambdaQuery()
                .eq(Router::getRouteName, dto.getRouteName())
                .or()
                .eq(Router::getPath, dto.getPath()));
        if (router != null) throw new BunnyException(ResultCodeEnum.DATA_EXIST);

        // 添加路由
        router = new Router();
        BeanUtils.copyProperties(dto, router);

        save(router);
    }

    /**
     * * 更新路由菜单
     *
     * @param dto 更新表单
     */
    @Override
    public void updateMenu(RouterUpdateDto dto) {
        LambdaQueryWrapper<Router> wrapper = new LambdaQueryWrapper<>();
        wrapper.ne(Router::getId, dto.getId())
                .and(qw -> qw.eq(Router::getRouteName, dto.getRouteName())
                        .or()
                        .eq(Router::getPath, dto.getPath()));
        List<Router> routerList = list(wrapper);

        // 判断更新数据是否存在
        if (!routerList.isEmpty()) throw new BunnyException(ResultCodeEnum.DATA_EXIST);

        // 如果设置的不是外部页面
        if (!dto.getMenuType().equals(2)) dto.setFrameSrc("");

        Router router = new Router();
        BeanUtils.copyProperties(dto, router);
        updateById(router);
    }

    /**
     * * 删除路由菜单
     *
     * @param ids 删除id列表
     */
    @Override
    public void deletedMenuByIds(List<Long> ids) {
        // 判断数据请求是否为空
        if (ids.isEmpty()) throw new BunnyException(ResultCodeEnum.REQUEST_IS_EMPTY);

        // 查找子级菜单，一起删除
        List<Long> longList = list(Wrappers.<Router>lambdaQuery().in(Router::getParentId, ids)).stream().map(Router::getId).toList();
        ids.addAll(longList);

        // // 逻辑删除
        // removeBatchByIds(ids);

        // 物理删除
        baseMapper.deleteBatchIdsWithPhysics(ids);
    }

    /**
     * * 快速更新菜单排序
     *
     * @param dto 根据菜单Id更新菜单排序
     */
    @Override
    public void updateMenuByIdWithRank(RouterUpdateByIdWithRankDto dto) {
        Router router = getOne(Wrappers.<Router>lambdaQuery().eq(Router::getId, dto.getId()));

        // 判断更新数据是否存在
        if (router == null) throw new BunnyException(ResultCodeEnum.DATA_NOT_EXIST);

        // 更新排序
        router = new Router();
        router.setId(dto.getId());
        router.setRouterRank(dto.getRouterRank());
        updateById(router);
    }
}
