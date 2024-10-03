package cn.bunny.dao.dto.system.router;

import com.fasterxml.jackson.annotation.JsonProperty;
import io.swagger.annotations.ApiModelProperty;
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
@Schema(name = "RouterManageDto对象", title = "路由添加表单", description = "路由添加表单")
public class RouterAddDto {

    @ApiModelProperty("菜单类型")
    @NotNull(message = "菜单类型不能为空")
    private Integer menuType;

    @ApiModelProperty("父级id")
    private Long parentId;

    @ApiModelProperty("菜单名称")
    @NotBlank(message = "菜单名称不能为空")
    private String title;

    @ApiModelProperty("路由名称")
    @NotBlank(message = "路由名称不能为空")
    @JsonProperty("name")
    private String routeName;

    @ApiModelProperty("在项目中路径")
    @NotBlank(message = "路由路径不能为空")
    private String path;

    @ApiModelProperty("组件位置")
    private String component;

    @ApiModelProperty("等级")
    @JsonProperty("rank")
    private Integer routerRank = 99;

    @ApiModelProperty("重定向")
    private String redirect;

    @ApiModelProperty("图标")
    private String icon;

    @ApiModelProperty("进入动画")
    private String enterTransition;

    @ApiModelProperty("退出动画")
    private String leaveTransition;

    @ApiModelProperty("frame路径")
    private String frameSrc;

    @ApiModelProperty("是否隐藏标签")
    private Boolean hiddenTag = false;

    @ApiModelProperty("是否固定标签")
    private Boolean fixedTag = false;

    @ApiModelProperty("是否显示")
    private Boolean visible = false;

    @ApiModelProperty("是否显示父级")
    private Boolean showParent = false;

}

