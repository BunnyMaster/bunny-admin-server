package cn.bunny.domain.views;

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

    @Schema(name = "component", title = "组件位置")
    private String component;

    @Schema(name = "frameSrc", title = "frame路径")
    private String frameSrc;

    @Schema(name = "routeName", title = "路由名称")
    private String routeName;

    @Schema(name = "title", title = "路由title")
    private String title;

    @Schema(name = "menuType", title = "菜单类型")
    private Integer menuType;

    @Schema(name = "icon", title = "图标")
    private String icon;

    @Schema(name = "routerRank", title = "等级")
    private Integer routerRank;

    @Schema(name = "visible", title = "是否显示")
    private Boolean visible;

    @Schema(name = "roleId", title = "角色ID")
    private Long roleId;

    @Schema(name = "roleCode", title = "角色代码")
    private String roleCode;

    @Schema(name = "description", title = "描述")
    private String description;

}