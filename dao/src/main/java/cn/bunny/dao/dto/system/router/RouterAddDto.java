package cn.bunny.dao.dto.system.router;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Max;
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
@Schema(name = "RouterManageDto对象", title = "路由添加表单", description = "路由添加表单")
public class RouterAddDto {

    @Schema(name = "menuType", title = "菜单类型")
    @NotNull(message = "菜单类型不能为空")
    private Integer menuType;

    @Schema(name = "parentId", title = "父级id")
    private Long parentId;

    @Schema(name = "title", title = "路由title")
    @NotNull(message = "菜单名称不能为空")
    @NotBlank(message = "菜单名称不能为空")
    private String title;

    @Schema(name = "routeName", title = "路由名称")
    @JsonProperty("name")
    @NotBlank(message = "路由名称不能为空")
    @NotNull(message = "路由名称不能为空")
    private String routeName;

    @Schema(name = "path", title = "在项目中路径")
    @NotBlank(message = "路由路径不能为空")
    @NotNull(message = "路由路径不能为空")
    private String path;

    @Schema(name = "component", title = "组件位置")
    private String component;

    @Schema(name = "routerRank", title = "等级")
    @JsonProperty("rank")
    @NotNull(message = "菜单排序不能为空")
    @Max(value = 999, message = "不能超过999")
    private Integer routerRank = 99;

    @Schema(name = "icon", title = "图标")
    private String icon;

    @Schema(name = "frameSrc", title = "frame路径")
    private String frameSrc;

    @Schema(name = "visible", title = "是否显示")
    private Boolean visible = false;

}

