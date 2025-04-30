package cn.bunny.services.domain.system.system.vo.router;

import cn.bunny.services.domain.common.model.vo.BaseUserVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(name = "RouterVo对象", title = "Router返回对象,含用户名等继承 BaseUserVo", description = "Router返回对象包含用户名等返回信息")
public class RouterVo extends BaseUserVo {

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

}