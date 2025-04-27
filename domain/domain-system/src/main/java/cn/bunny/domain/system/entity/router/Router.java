package cn.bunny.domain.system.entity.router;

import cn.bunny.domain.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 系统菜单表
 * </p>
 *
 * @author Bunny
 * @since 2024-09-29
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_router")
@Schema(name = "Router对象", title = "系统菜单表", description = "系统菜单表")
public class Router extends BaseEntity {

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

    @Schema(name = "isDeleted", title = "是否被删除")
    private Boolean isDeleted;

}

