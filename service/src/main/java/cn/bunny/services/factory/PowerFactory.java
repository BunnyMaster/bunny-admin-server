package cn.bunny.services.factory;

import cn.bunny.dao.vo.system.rolePower.PowerVo;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class PowerFactory {


    /**
     * * 构建权限树形结构
     *
     * @param id          节点ID
     * @param powerVoList 节点列表
     * @return 树形列表
     */
    public List<PowerVo> handlePowerVoChildren(Long id, List<PowerVo> powerVoList) {
        return powerVoList.stream()
                .filter(powerVo -> powerVo.getParentId().equals(id))
                .peek(powerVo -> powerVo.setChildren(handlePowerVoChildren(powerVo.getId(), powerVoList)))
                .toList();
    }
}
