package cn.bunny.services.service;

import cn.bunny.dao.entity.system.Router;
import cn.bunny.dao.vo.router.UserRouterVo;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
 * <p>
 * 服务类
 * </p>
 *
 * @author Bunny
 * @since 2024-09-27
 */
public interface RouterService extends IService<Router> {
    /**
     * * 获取路由内容
     *
     * @return 路遇列表
     */
    List<UserRouterVo> getRouterAsync();
}
