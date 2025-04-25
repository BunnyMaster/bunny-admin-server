package cn.bunny.domain.system.views;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_router_role")
@Schema(name = "RouterRoleViewRouterRole象", title = "路由角色关系视图", description = "路由角色关系视图")
public class ViewRouterRole {

    @Schema(name = "routerId", title = "路由ID")
    private Long routerId;

    @Schema(name = "parentId", title = "父级id")
    private Long parentId;

    @Schema(name = "path", title = "在项目中路径")
    private String path;

    @Schema(name = "routeName", title = "路由名称")
    private String routeName;

    @Schema(name = "redirect", title = "路由重定向")
    private String redirect;

    @Schema(name = "component", title = "组件位置")
    private String component;

    @Schema(name = "menuType", title = "菜单类型")
    private Integer menuType;

    @Schema(name = "meta", title = "路由meta")
    private String meta;

    @Schema(name = "roleId", title = "角色ID")
    private Long roleId;

    @Schema(name = "roleCode", title = "角色代码")
    private String roleCode;

    @Schema(name = "description", title = "描述")
    private String description;

}