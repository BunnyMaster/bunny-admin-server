package cn.bunny.domain.configuration.vo;

import com.alibaba.fastjson2.annotation.JSONField;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "WebConfigurationVo对象", title = "前端配置选项", description = "前端配置选项")
public class WebConfigurationVo {

    @Schema(name = "version", description = "应用程序的版本")
    @JSONField(format = "Version")
    private String version;

    @Schema(name = "title", description = "应用程序的标题")
    @JSONField(format = "Title")
    private String title;

    @Schema(name = "copyright", description = "版权信息")
    @JSONField(format = "Copyright")
    private String copyright;

    @Schema(name = "fixedHeader", description = "头部是否固定")
    @JSONField(format = "FixedHeader")
    private boolean fixedHeader;

    @Schema(name = "hiddenSideBar", description = "侧边栏是否隐藏")
    @JSONField(format = "FixedHeader")
    private boolean hiddenSideBar;

    @Schema(name = "multiTagsCache", description = "是否缓存多个标签")
    @JSONField(format = "FixedHeader")
    private boolean multiTagsCache;

    @Schema(name = "keepAlive", description = "是否持久化")
    @JSONField(format = "FixedHeader")
    private boolean keepAlive;

    @Schema(name = "locale", description = "语言类型")
    @JSONField(format = "Locale")
    private String locale;

    @Schema(name = "layout", description = "应用程序的布局")
    @JSONField(name = "Layout")
    private String layout;

    @Schema(name = "theme", description = "应用程序的主题")
    @JSONField(format = "FixedHeader")
    private String theme;

    @Schema(name = "darkMode", description = "是否启用深色模式")
    @JSONField(format = "FixedHeader")
    private boolean darkMode;

    @Schema(name = "overallStyle", description = "应用程序的整体样式")
    @JSONField(format = "FixedHeader")
    private String overallStyle;

    @Schema(name = "grey", description = "是否启用灰色模式")
    @JSONField(format = "FixedHeader")
    private boolean grey;

    @Schema(name = "weak", description = "色弱模式")
    @JSONField(format = "FixedHeader")
    private boolean weak;

    @Schema(name = "hideTabs", description = "是否隐藏选项卡")
    @JSONField(format = "HideTabs")
    private boolean hideTabs;

    @Schema(name = "hideFooter", description = "是否隐藏页脚")
    @JSONField(format = "HideFooter")
    private boolean hideFooter;

    @Schema(name = "stretch", description = "是否拉伸显示")
    @JSONField(format = "Stretch")
    private boolean stretch;

    @Schema(name = "sidebarStatus", description = "侧边栏的状态")
    @JSONField(format = "SidebarStatus")
    private boolean sidebarStatus;

    @Schema(name = "epThemeColor", description = "主题颜色")
    @JSONField(format = "EpThemeColor")
    private String epThemeColor;

    @Schema(name = "showLogo", description = "是否显示logo")
    @JSONField(format = "ShowLogo")
    private boolean showLogo;

    @Schema(name = "showModel", description = "要显示的模型")
    @JSONField(format = "ShowModel")
    private String showModel;

    @Schema(name = "menuArrowIconNoTransition", description = "菜单箭头图标是否没有过渡效果")
    @JSONField(format = "MenuArrowIconNoTransition")
    private boolean menuArrowIconNoTransition;

    @Schema(name = "cachingAsyncRoutes", description = "是否缓存异步路由")
    @JSONField(format = "CachingAsyncRoutes")
    private boolean cachingAsyncRoutes;

    @Schema(name = "tooltipEffect", description = "工具提示的效果")
    @JSONField(format = "TooltipEffect")
    private String tooltipEffect;

    @Schema(name = "responsiveStorageNameSpace", description = "响应式存储的命名空间")
    @JSONField(format = "ResponsiveStorageNameSpace")
    private String responsiveStorageNameSpace;

    @Schema(name = "responsiveStorageNameSpace", description = "菜单搜索历史")
    @JSONField(format = "MenuSearchHistory")
    private int menuSearchHistory;

}