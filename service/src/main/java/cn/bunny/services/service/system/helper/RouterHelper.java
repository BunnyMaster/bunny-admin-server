package cn.bunny.services.service.system.helper;

import cn.bunny.services.context.BaseContext;
import cn.bunny.services.domain.system.system.entity.RouterRole;
import cn.bunny.services.domain.system.system.entity.router.Router;
import cn.bunny.services.domain.system.system.entity.router.RouterMeta;
import cn.bunny.services.domain.system.system.views.ViewRolePermission;
import cn.bunny.services.domain.system.system.views.ViewRouterRole;
import cn.bunny.services.domain.system.system.vo.router.WebUserRouterVo;
import cn.bunny.services.service.system.RouterRoleService;
import com.alibaba.fastjson2.JSON;
import jakarta.annotation.Resource;
import lombok.extern.slf4j.Slf4j;
import org.jetbrains.annotations.NotNull;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import java.util.*;

@Slf4j
@Component
public class RouterHelper {
    @Resource
    private RouterRoleService routerRoleService;

    /**
     * 递归调用设置子路由
     *
     * @param id                  主键
     * @param webUserRouterVoList 返回VO列表
     * @return 返回路由列表
     */
    public List<WebUserRouterVo> buildTreeSetChildren(Long id, @NotNull List<WebUserRouterVo> webUserRouterVoList) {
        List<WebUserRouterVo> list = new ArrayList<>();
        for (WebUserRouterVo webUserRouterVo : webUserRouterVoList) {
            if (webUserRouterVo.getParentId().equals(id)) {
                webUserRouterVo.setChildren(buildTreeSetChildren(webUserRouterVo.getId(), webUserRouterVoList));
                list.add(webUserRouterVo);
            }
        }

        return list;
    }

    /**
     * 保存路由角色关联关系
     *
     * <p>将路由的权限角色配置保存到数据库</p>
     *
     * @param meta 路由元数据，包含角色配置信息
     * @param id   路由ID
     */
    public void insertRouterRoleAndPermission(RouterMeta meta, Long id) {
        List<String> roles = meta.getRoles();

        // 插入新的角色信息
        List<RouterRole> routerRoleList = roles.stream().map(role -> {
            RouterRole routerRole = new RouterRole();
            routerRole.setRouterId(id);
            routerRole.setRoleId(Long.valueOf(role));
            return routerRole;
        }).toList();
        routerRoleService.saveBatch(routerRoleList);
    }

    /**
     * 构建前端可访问的路由列表
     *
     * <p>处理流程：</p>
     * <ol>
     *   <li>检查当前用户是否为管理员（拥有全部权限）</li>
     *   <li>转换路由基础信息</li>
     *   <li>处理路由元数据（meta）</li>
     *   <li>设置路由关联的角色信息</li>
     *   <li>设置路由关联的权限信息</li>
     *   <li>按rank排序返回</li>
     * </ol>
     * <a href="https://pure-admin.cn/pages/routerMenu/#%E8%B7%AF%E7%94%B1%E5%92%8C%E8%8F%9C%E5%8D%95%E9%85%8D%E7%BD%AE">
     * 路由结构参考这个文档
     * </a>
     *
     * @param routerList         所有路由列表
     * @param routerRoleList     路由-角色关联Map（key: 路由ID, value: 角色列表）
     * @param rolePermissionList 角色-权限关联Map（key: 角色ID, value: 权限列表）
     * @return 前端可访问的路由列表（包含完整的权限信息）
     */
    @NotNull
    public List<WebUserRouterVo> getWebUserRouterVos(List<Router> routerList, Map<Long, List<ViewRouterRole>> routerRoleList, Map<Long, List<ViewRolePermission>> rolePermissionList) {
        // 检查当前是否是 admin 用户
        List<String> roles = BaseContext.getLoginVo().getRoles();
        List<String> allAuths = !RoleServiceHelper.checkAdmin(roles) ? new ArrayList<>() : List.of("*:*:*", "*:*", "*", "admin");

        // 查询路由所有数据，整理前端需要的路和、角色、权限
        return routerList.stream().map(view -> {
                    // 前端需要的格式路由
                    WebUserRouterVo webUserRouterVo = new WebUserRouterVo();

                    // 复制数据库中信息到新路由中
                    BeanUtils.copyProperties(view, webUserRouterVo);

                    // 整理前端需要格式的路由 meta
                    String meta = view.getMeta();
                    RouterMeta routerMeta;

                    // 如果么meta存在，将其转成 RouterMeta 而不是 JSON/字符串
                    if (StringUtils.hasText(meta)) {
                        routerMeta = JSON.parseObject(meta, RouterMeta.class);
                        webUserRouterVo.setMeta(routerMeta);
                    } else {
                        // 不存在时不能为 null 将路由名称设置为title
                        routerMeta = new RouterMeta();
                        routerMeta.setTitle(view.getRouteName());
                        webUserRouterVo.setMeta(routerMeta);
                    }

                    // 路由路由和橘色 设置角色信息，防止为空报错，最后添加 roles
                    List<String> roleCodeList = new ArrayList<>(allAuths);
                    if (!routerRoleList.isEmpty()) {
                        // 找到当前路由下的角色信息
                        List<String> list = routerRoleList.getOrDefault(view.getId(), Collections.emptyList()).stream()
                                .map(ViewRouterRole::getRoleCode).toList();

                        // 将角色码添加到角色列表
                        roleCodeList.addAll(list);
                    }
                    webUserRouterVo.getMeta().setRoles(roleCodeList);

                    // 角色和权限 设置权限信息，最后添加权限信息 auth/permission
                    List<String> permissionList = new ArrayList<>(allAuths);
                    if (!rolePermissionList.isEmpty()) {
                        // 找到当前路由下所有的角色id，之后根据 角色和权限查找 角色对应的权限
                        List<Long> roleIds = routerRoleList.getOrDefault(view.getId(), Collections.emptyList()).stream()
                                .map(ViewRouterRole::getRoleId).toList();

                        // 根据角色id找到所有权限
                        List<String> list = roleIds.stream()
                                .map(roleId -> {
                                    List<ViewRolePermission> viewRolePermissions = rolePermissionList.get(roleId);

                                    // 根据角色id查找权限，且角色和权限存在
                                    if (roleId != null && viewRolePermissions != null && !viewRolePermissions.isEmpty()) {
                                        return viewRolePermissions.stream().map(ViewRolePermission::getPowerCode).toList();
                                    }

                                    // 未找到返回 空字符串
                                    return List.of("");
                                })
                                // 将二维数组转成一维数组
                                .flatMap(List::stream)
                                // 过滤掉为空的字符串
                                .filter(StringUtils::hasText)
                                .distinct()
                                .toList();
                        permissionList.addAll(list);
                    }
                    webUserRouterVo.getMeta().setAuths(permissionList);

                    return webUserRouterVo;
                })
                .sorted(Comparator.comparing(routerVo -> routerVo.getMeta().getRank()))
                .toList();
    }
}
