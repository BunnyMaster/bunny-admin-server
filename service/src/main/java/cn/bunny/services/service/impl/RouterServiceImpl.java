package cn.bunny.services.service.impl;

import cn.bunny.common.service.context.BaseContext;
import cn.bunny.common.service.exception.BunnyException;
import cn.bunny.dao.dto.system.router.RouterAddDto;
import cn.bunny.dao.dto.system.router.RouterManageDto;
import cn.bunny.dao.dto.system.router.RouterUpdateDto;
import cn.bunny.dao.entity.system.Router;
import cn.bunny.dao.pojo.constant.RedisUserConstant;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.router.RouterManageVo;
import cn.bunny.dao.vo.system.router.RouterMeta;
import cn.bunny.dao.vo.system.router.UserRouterVo;
import cn.bunny.dao.vo.system.user.LoginVo;
import cn.bunny.services.factory.RouterServiceFactory;
import cn.bunny.services.mapper.RouterMapper;
import cn.bunny.services.security.custom.CustomCheckIsAdmin;
import cn.bunny.services.service.RouterService;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.toolkit.Wrappers;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import java.util.ArrayList;
import java.util.Comparator;
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
    private RouterServiceFactory routerServiceFactory;

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
        boolean isAdmin = CustomCheckIsAdmin.checkAdmin(roleList, loginVo);
        if (isAdmin) routerList = list();
        else {
            List<Long> routerIds = baseMapper.selectListByUserId(loginVo.getId());
            routerList = baseMapper.selectParentListByRouterId(routerIds);
        }

        // 构建返回路由列表
        List<UserRouterVo> routerVoList = routerList.stream()
                .sorted(Comparator.comparing(Router::getRouterRank))
                .filter(Router::getVisible)
                .map(router -> {
                    // 复制对象
                    UserRouterVo routerVo = new UserRouterVo();
                    BeanUtils.copyProperties(router, routerVo);

                    // 设置
                    RouterMeta meta = RouterMeta.builder()
                            .frameSrc(router.getFrameSrc())
                            .rank(router.getRouterRank())
                            .icon(router.getIcon())
                            .title(router.getTitle())
                            .roles(roleList)
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
        Router router = getOne(Wrappers.<Router>lambdaQuery().eq(Router::getPath, dto.getPath()));
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
        Router router = getOne(Wrappers.<Router>lambdaQuery().eq(Router::getId, dto.getId()));

        // 判断更新数据是否存在
        if (router == null) throw new BunnyException(ResultCodeEnum.DATA_NOT_EXIST);

        // 判断更新数据id和父级id是否重复
        if (dto.getId().equals(dto.getParentId())) throw new BunnyException(ResultCodeEnum.ILLEGAL_DATA_REQUEST);

        router = new Router();
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

        baseMapper.deleteBatchIdsWithPhysics(ids);
    }
}
