package cn.bunny.services.domain.system.system.entity.router;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;

import java.util.ArrayList;
import java.util.List;

@Getter
@Setter
@Schema(name = "RouterMeta对象", title = "系统菜单属性", description = "系统菜单属性")
public class RouterMeta {

    @Schema(name = "title", title = "路由title")
    private String title = "";

    @Schema(name = "icon", title = "图标")
    private String icon;

    @Schema(name = "showLink", title = "是否显示菜单")
    private Boolean showLink = true;

    @Schema(name = "showParent", title = "是否显示父级菜单")
    private Boolean showParent = true;

    @Schema(name = "roles", title = "页面级别权限设置")
    private List<String> roles = new ArrayList<>();

    @Schema(name = "auths", title = "按钮级别权限设置")
    private List<String> auths = new ArrayList<>();

    @Schema(name = "keepAlive", title = "是否缓存该路由页面（开启后，会保存该页面的整体状态，刷新后会清空状态）")
    private Boolean keepAlive;

    @Schema(name = "frameSrc", title = "frame路径")
    private String frameSrc;

    @Schema(name = "frameLoading", title = "等级")
    private Boolean frameLoading;

    @Schema(name = "rank", title = "等级")
    private Integer rank;

    @Schema(name = "fixedTag", title = "固定标签页")
    private Boolean fixedTag;

    @Schema(name = "hiddenTag", title = "当前菜单名称或自定义信息禁止添加到标签页")
    private Boolean hiddenTag;

    @Schema(name = "activePath", title = "将某个菜单激活")
    private String activePath;

    @Schema(name = "transition", title = "页面加载动画")
    private RouterMetaTransition transition;

}


