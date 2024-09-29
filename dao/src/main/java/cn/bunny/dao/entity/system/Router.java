package cn.bunny.dao.entity.system;

import cn.bunny.dao.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
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
@ApiModel(value = "Router对象", description = "系统菜单表")
public class Router extends BaseEntity {

    @ApiModelProperty("父级id")
    private Long parentId;

    @ApiModelProperty("在项目中路径")
    private String path;

    @ApiModelProperty("组件位置")
    private String component;

    @ApiModelProperty("frame路径")
    private String frameSrc;

    @ApiModelProperty("重定向")
    private String redirect;

    @ApiModelProperty("路由名称")
    private String routeName;

    @ApiModelProperty("路由title")
    private String title;

    @ApiModelProperty("菜单类型")
    private Integer menuType;

    @ApiModelProperty("图标")
    private String icon;

    @ApiModelProperty("进入动画")
    private String enterTransition;

    @ApiModelProperty("退出动画")
    private String leaveTransition;

    @ApiModelProperty("等级")
    private Integer routerRank;

    @ApiModelProperty("是否隐藏标签")
    private Boolean hiddenTag;

    @ApiModelProperty("是否固定标签")
    private Boolean fixedTag;

    @ApiModelProperty("是否显示父级")
    private Boolean showParent;

    @ApiModelProperty("是否显示 返给前端为 showLink")
    private Boolean visible;

}
