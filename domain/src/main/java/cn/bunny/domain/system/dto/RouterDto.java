package cn.bunny.domain.system.dto;

import cn.bunny.domain.common.ValidationGroups;
import cn.bunny.domain.system.entity.router.RouterMeta;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "RouterManageDto对象", title = "添加路由", description = "添加路由")
public class RouterDto {

    @Schema(name = "id", title = "唯一标识")
    @NotNull(message = "id不能为空", groups = {ValidationGroups.Update.class})
    private Long id;

    @Schema(name = "parentId", title = "父级id")
    private Long parentId;

    @Schema(name = "path", title = "在项目中路径")
    @NotBlank(message = "路由路径不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String path;

    @Schema(name = "routeName", title = "路由名称")
    @NotBlank(message = "路由名称不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String routeName;

    @Schema(name = "redirect", title = "路由重定向")
    private String redirect;

    @Schema(name = "component", title = "组件位置")
    private String component;

    @Schema(name = "menuType", title = "菜单类型")
    @NotNull(message = "菜单类型不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private Integer menuType;

    @Schema(name = "meta", title = "菜单meta")
    private RouterMeta meta;

}

