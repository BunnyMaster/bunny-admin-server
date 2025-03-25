package cn.bunny.dao.dto.system.configuration;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Pattern;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Schema(name = "WebConfiguration对象", title = "前端配置选项", description = "前端配置选项")
public class WebConfigurationDto {

    @Schema(name = "Version", description = "应用程序的版本")
    @NotBlank(message = "应用程序的版本不能为空")
    @NotNull(message = "应用程序的版本不能为空")
    private String version;

    @Schema(name = "Title", description = "应用程序的标题")
    @NotBlank(message = "应用程序的标题不能为空")
    @NotNull(message = "应用程序的标题不能为空")
    private String title;

    @Schema(name = "Copyright", description = "版权信息")
    @NotBlank(message = "版权信息不能为空")
    @NotNull(message = "版权信息不能为空")
    private String copyright;

    @Schema(name = "FixedHeader", description = "头部是否固定")
    @NotNull(message = "头部是否固定不能为空")
    private boolean fixedHeader;

    @Schema(name = "HiddenSideBar", description = "侧边栏是否隐藏")
    @NotNull(message = "侧边栏是否隐藏不能为空")
    private boolean hiddenSideBar;

    @Schema(name = "MultiTagsCache", description = "是否缓存多个标签")
    @NotNull(message = "是否缓存多个标签不能为空")
    private boolean multiTagsCache;

    @Schema(name = "KeepAlive", description = "是否持久化")
    @NotNull(message = "持久化不能为空")
    private boolean keepAlive;

    @Schema(name = "Locale", description = "语言类型")
    @NotBlank(message = "语言类型不能为空")
    @NotNull(message = "语言类型不能为空")
    private String locale;

    @Schema(name = "Layout", description = "应用程序的布局")
    @NotBlank(message = "应用程序的布局不能为空")
    @NotNull(message = "应用程序的布局不能为空")
    private String layout;

    @Schema(name = "Theme", description = "应用程序的主题")
    @NotBlank(message = "管理者不能为空")
    @NotNull(message = "管理者不能为空")
    private String theme;

    @Schema(name = "DarkMode", description = "是否启用深色模式")
    @NotNull(message = "darkMode不能为空")
    private boolean darkMode;

    @Schema(name = "OverallStyle", description = "应用程序的整体样式")
    @NotBlank(message = "整体样式不能为空")
    @NotNull(message = "整体样式不能为空")
    private String overallStyle;

    @Schema(name = "Grey", description = "是否启用灰色模式")
    @NotNull(message = "是否启用灰色模式不能为空")
    private boolean grey;

    @Schema(name = "Weak", description = "色弱模式")
    @NotNull(message = "色弱模式不能为空")
    private boolean weak;

    @Schema(name = "HideTabs", description = "是否隐藏选项卡")
    @NotNull(message = "是否隐藏选项卡不能为空")
    private boolean hideTabs;

    @Schema(name = "HideFooter", description = "是否隐藏页脚")
    @NotNull(message = "是否隐藏页脚不能为空")
    private boolean hideFooter;

    @Schema(name = "Stretch", description = "是否拉伸显示")
    @NotNull(message = "是否拉伸不能为空")
    private boolean stretch;

    @Schema(name = "SidebarStatus", description = "侧边栏的状态")
    @NotNull(message = "侧边栏的状态不能为空")
    private boolean sidebarStatus;

    @Schema(name = "EpThemeColor", description = "主题颜色")
    @Pattern(regexp = "^#([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$", message = "主题色不是Hash值")
    @NotNull(message = "主题颜色不能为空")
    private String epThemeColor;

    @Schema(name = "ShowLogo", description = "是否显示logo")
    @NotNull(message = "是否显示logo不能为空")
    private boolean showLogo;

    @Schema(name = "ShowModel", description = "要显示的模型")
    @NotBlank(message = "showModel不能为空")
    @NotNull(message = "showModel不能为空")
    private String showModel;

    @Schema(name = "MenuArrowIconNoTransition", description = "菜单箭头图标是否没有过渡效果")
    @NotNull(message = "过渡效果不能为空")
    private boolean menuArrowIconNoTransition;

    @Schema(name = "CachingAsyncRoutes", description = "是否缓存异步路由")
    @NotNull(message = "缓存异步路由不能为空")
    private boolean cachingAsyncRoutes;

    @Schema(name = "TooltipEffect", description = "工具提示的效果")
    @NotBlank(message = "工具提示不能为空")
    @NotNull(message = "工具提示不能为空")
    private String tooltipEffect;

    @Schema(name = "ResponsiveStorageNameSpace", description = "响应式存储的命名空间")
    @NotBlank(message = "响应式存储的命名空间不能为空")
    @NotNull(message = "响应式存储的命名空间不能为空")
    private String responsiveStorageNameSpace;

    @Schema(name = "MenuSearchHistory", description = "菜单搜索历史")
    @NotNull(message = "菜单搜索历史不能为空")
    @Min(value = 1, message = "菜单搜索历史必须大于等于1")
    private int menuSearchHistory;

}
