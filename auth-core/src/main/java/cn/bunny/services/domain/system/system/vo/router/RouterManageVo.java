package cn.bunny.services.domain.system.system.vo.router;

import cn.bunny.services.domain.common.vo.BaseUserVo;
import com.alibaba.fastjson2.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import java.util.ArrayList;
import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "RouterControllerVo对象", title = "管理员用户看到菜单内容", description = "管理员用户管理菜单")
public class RouterManageVo extends BaseUserVo {

    @ApiModelProperty("父级id")
    @JsonProperty("parentId")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long parentId;

    @Schema(name = "path", title = "在项目中路径")
    private String path;

    @JsonProperty("name")
    @Schema(name = "routeName", title = "路由名称")
    private String routeName;

    @Schema(name = "redirect", title = "路由重定向")
    private String redirect;

    @Schema(name = "component", title = "组件位置")
    private String component;

    @Schema(name = "menuType", title = "菜单类型")
    private Integer menuType;

    @Schema(name = "title", title = "路由title")
    private String title;

    @Schema(name = "icon", title = "图标")
    private String icon;

    @Schema(name = "showLink", title = "是否显示菜单")
    private Boolean showLink;

    @Schema(name = "showParent", title = "是否显示父级菜单")
    private Boolean showParent;

    @Schema(name = "roles", title = "页面级别权限设置")
    private List<String> roles;

    @Schema(name = "auths", title = "按钮级别权限设置")
    private List<String> auths;

    @Schema(name = "keepAlive", title = "是否缓存该路由页面（开启后，会保存该页面的整体状态，刷新后会清空状态）")
    private Boolean keepAlive;

    @Schema(name = "frameSrc", title = "frame路径")
    private String frameSrc;

    @Schema(name = "frameLoading", title = "等级")
    private Boolean frameLoading;

    @Schema(name = "rank", title = "等级")
    private Integer rank;

    @Schema(name = "hiddenTag", title = "当前菜单名称或自定义信息禁止添加到标签页")
    private Boolean hiddenTag;

    @Schema(name = "fixedTag", title = "固定标签页")
    private Boolean fixedTag;

    @Schema(name = "activePath", title = "将某个菜单激活")
    private String activePath;

    @Schema(name = "enterTransition", title = "入场动画")
    private String enterTransition;

    @Schema(name = "leaveTransition", title = "离场动画")
    private String leaveTransition;

    @ApiModelProperty("子路由")
    private List<RouterManageVo> children = new ArrayList<>();
}
