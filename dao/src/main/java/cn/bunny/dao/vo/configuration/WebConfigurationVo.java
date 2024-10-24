package cn.bunny.dao.vo.configuration;

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
@Schema(name = "WebConfigurationVo对象", title = "前端配置获取返回结果", description = "前端配置获取返回结果")
public class WebConfigurationVo {

    @Schema(name = "Version", description = "应用程序的版本")
    @JSONField(name = "Version")
    private String version;

    @Schema(name = "Title", description = "应用程序的标题")
    @JSONField(name = "Title")
    private String title;

    @Schema(name = "Copyright", description = "版权信息")
    @JSONField(name = "Copyright")
    private String copyright;

    @Schema(name = "FixedHeader", description = "头部是否固定")
    @JSONField(name = "FixedHeader")
    private boolean fixedHeader;

    @Schema(name = "HiddenSideBar", description = "侧边栏是否隐藏")
    @JSONField(name = "HiddenSideBar")
    private boolean hiddenSideBar;

    @Schema(name = "MultiTagsCache", description = "是否缓存多个标签")
    @JSONField(name = "MultiTagsCache")
    private boolean multiTagsCache;

    @Schema(name = "KeepAlive", description = "是否持久化")
    @JSONField(name = "KeepAlive")
    private boolean keepAlive;

    @Schema(name = "Locale", description = "语言类型")
    @JSONField(name = "Locale")
    private String locale;

    @Schema(name = "Layout", description = "应用程序的布局")
    @JSONField(name = "Layout")
    private String layout;

    @Schema(name = "Theme", description = "应用程序的主题")
    @JSONField(name = "Theme")
    private String theme;

    @Schema(name = "DarkMode", description = "是否启用深色模式")
    @JSONField(name = "DarkMode")
    private boolean darkMode;

    @Schema(name = "OverallStyle", description = "应用程序的整体样式")
    @JSONField(name = "OverallStyle")
    private String overallStyle;

    @Schema(name = "Grey", description = "是否启用灰色模式")
    @JSONField(name = "Grey")
    private boolean grey;

    @Schema(name = "Weak", description = "色弱模式")
    @JSONField(name = "Weak")
    private boolean weak;

    @Schema(name = "HideTabs", description = "是否隐藏选项卡")
    @JSONField(name = "HideTabs")
    private boolean hideTabs;

    @Schema(name = "HideFooter", description = "是否隐藏页脚")
    @JSONField(name = "HideFooter")
    private boolean hideFooter;

    @Schema(name = "Stretch", description = "是否拉伸显示")
    @JSONField(name = "Stretch")
    private boolean stretch;

    @Schema(name = "SidebarStatus", description = "侧边栏的状态")
    @JSONField(name = "SidebarStatus")
    private boolean sidebarStatus;

    @Schema(name = "EpThemeColor", description = "主题颜色")
    @JSONField(name = "EpThemeColor")
    private String epThemeColor;

    @Schema(name = "ShowLogo", description = "是否显示logo")
    @JSONField(name = "ShowLogo")
    private boolean showLogo;

    @Schema(name = "ShowModel", description = "要显示的模型")
    @JSONField(name = "ShowModel")
    private String showModel;

    @Schema(name = "MenuArrowIconNoTransition", description = "菜单箭头图标是否没有过渡效果")
    @JSONField(name = "MenuArrowIconNoTransition")
    private boolean menuArrowIconNoTransition;

    @Schema(name = "CachingAsyncRoutes", description = "是否缓存异步路由")
    @JSONField(name = "CachingAsyncRoutes")
    private boolean cachingAsyncRoutes;

    @Schema(name = "TooltipEffect", description = "工具提示的效果")
    @JSONField(name = "TooltipEffect")
    private String tooltipEffect;

    @Schema(name = "ResponsiveStorageNameSpace", description = "响应式存储的命名空间")
    @JSONField(name = "ResponsiveStorageNameSpace")
    private String responsiveStorageNameSpace;

    @Schema(name = "MenuSearchHistory", description = "菜单搜索历史")
    @JSONField(name = "MenuSearchHistory")
    private int menuSearchHistory;

}