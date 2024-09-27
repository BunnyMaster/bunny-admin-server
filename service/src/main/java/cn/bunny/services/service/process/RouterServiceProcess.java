package cn.bunny.services.service.process;

import cn.bunny.dao.vo.common.TreeSelectVo;
import cn.bunny.dao.vo.router.RouterControllerVo;
import cn.bunny.dao.vo.router.UserRouterVo;
import org.jetbrains.annotations.NotNull;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class RouterServiceProcess {

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

    /**
     * * 递归调用设置管理子路由
     *
     * @param nodeId   主键
     * @param nodeList 返回VO列表
     * @return 返回路由列表
     */
    public List<RouterControllerVo> handleGetChildrenWithRouterControllerVo(Long nodeId, List<RouterControllerVo> nodeList) {
        return nodeList.stream()
                .filter(node -> node.getParentId().equals(nodeId))
                .peek(node -> node.setChildren(handleGetChildrenWithRouterControllerVo(node.getId(), nodeList)))
                .toList();
    }

    /**
     * * 整理树形结构
     *
     * @param nodeId   节点ID
     * @param nodeList 节点列表
     * @return 树形列表
     */
    public List<TreeSelectVo> handleGetTreeSelectList(Object nodeId, @NotNull List<TreeSelectVo> nodeList) {
        // 使用 Stream API 找到所有子节点
        return nodeList.stream()
                .filter(node -> node.getParentId().equals(nodeId))
                .peek(node -> node.setChildren(handleGetTreeSelectList(node.getValue(), nodeList)))
                .toList();
    }
}
