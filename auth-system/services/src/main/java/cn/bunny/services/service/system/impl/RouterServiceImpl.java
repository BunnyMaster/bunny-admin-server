package cn.bunny.services.service.system.impl;

import cn.bunny.domain.system.dto.router.RouterAddDto;
import cn.bunny.domain.system.dto.router.RouterManageDto;
import cn.bunny.domain.system.dto.router.RouterUpdateByIdWithRankDto;
import cn.bunny.domain.system.dto.router.RouterUpdateDto;
import cn.bunny.domain.system.entity.Role;
import cn.bunny.domain.system.entity.Router;
import cn.bunny.domain.system.vo.router.RouterManageVo;
import cn.bunny.domain.system.vo.router.RouterMeta;
import cn.bunny.domain.system.vo.router.UserRouterVo;
import cn.bunny.domain.views.ViewRolePower;
import cn.bunny.domain.views.ViewRouterRole;
import cn.bunny.domain.vo.result.PageResult;
import cn.bunny.domain.vo.result.ResultCodeEnum;
import cn.bunny.services.context.BaseContext;
import cn.bunny.services.exception.AuthCustomerException;
import cn.bunny.services.mapper.system.RoleMapper;
import cn.bunny.services.mapper.system.RolePowerMapper;
import cn.bunny.services.mapper.system.RouterMapper;
import cn.bunny.services.mapper.system.RouterRoleMapper;
import cn.bunny.services.service.system.RouterService;
import cn.bunny.services.utils.system.RoleUtil;
import cn.bunny.services.utils.system.RouterServiceUtil;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import jakarta.annotation.Resource;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    @Resource
    private RouterServiceUtil routerServiceUtil;

    @Resource
    private RoleMapper roleMapper;

    @Resource
    private RouterRoleMapper routerRoleMapper;

    @Resource
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
        boolean isAdmin = RoleUtil.checkAdmin(userRoleCodeList);

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
                routerVo.setChildren(routerServiceUtil.handleGetChildrenWIthRouter(routerVo.getId(), routerVoList));
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
        IPage<RouterManageVo> page = baseMapper.selectListByPage(pageParams, dto);

        // 构建返回对象
        List<RouterManageVo> voList = page.getRecords().stream()
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
        List<RouterManageVo> list = baseMapper.selectAllList(dto);
        return list.stream()
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
        // 添加路由
        Router router = new Router();
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
        // 查询当前路由和父级路由
        Router routerParent = getOne(Wrappers.<Router>lambdaQuery().eq(Router::getId, dto.getParentId()));

        // 设置路由等级需要大于或等于父级的路由等级
        if (routerParent != null && (dto.getRouterRank() < routerParent.getRouterRank())) {
            throw new AuthCustomerException(ResultCodeEnum.ROUTER_RANK_NEED_LARGER_THAN_THE_PARENT);
        }

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
        if (ids.isEmpty()) throw new AuthCustomerException(ResultCodeEnum.REQUEST_IS_EMPTY);

        // 查找子级菜单，一起删除
        List<Long> longList = list(Wrappers.<Router>lambdaQuery().in(Router::getParentId, ids)).stream().map(Router::getId).toList();
        ids.addAll(longList);

        // 逻辑删除
        removeBatchByIds(ids);

        // // 物理删除
        // baseMapper.deleteBatchIdsWithPhysics(ids);
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
        if (router == null) throw new AuthCustomerException(ResultCodeEnum.DATA_NOT_EXIST);

        // 查询当前路由和父级路由
        Router routerParent = getOne(Wrappers.<Router>lambdaQuery().eq(Router::getId, router.getParentId()));

        // 设置路由等级需要大于或等于父级的路由等级
        if (routerParent != null && (dto.getRouterRank() < routerParent.getRouterRank())) {
            throw new AuthCustomerException(ResultCodeEnum.ROUTER_RANK_NEED_LARGER_THAN_THE_PARENT);
        }

        // 更新排序
        router = new Router();
        router.setId(dto.getId());
        router.setRouterRank(dto.getRouterRank());
        updateById(router);
    }
}
