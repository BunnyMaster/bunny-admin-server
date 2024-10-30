package cn.bunny.services.factory;

import cn.bunny.dao.vo.system.router.UserRouterVo;
import org.jetbrains.annotations.NotNull;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class RouterServiceFactory {

    /**
     * * 递归调用设置子路由
     *
     * @param id           主键
     * @param routerVoList 返回VO列表
     * @return 返回路由列表
     */
    public List<UserRouterVo> handleGetChildrenWIthRouter(Long id, @NotNull List<UserRouterVo> routerVoList) {
        List<UserRouterVo> list = new ArrayList<>();
        for (UserRouterVo routerVo : routerVoList) {
            if (routerVo.getParentId().equals(id)) {
                routerVo.setChildren(handleGetChildrenWIthRouter(routerVo.getId(), routerVoList));
                list.add(routerVo);
            }
        }

        return list;
    }
}
