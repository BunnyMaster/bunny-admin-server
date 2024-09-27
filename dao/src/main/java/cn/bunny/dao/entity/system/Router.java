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
 * @since 2024-09-28
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_router")
@ApiModel(value = "Router对象", description = "系统菜单表")
public class Router extends BaseEntity {

    @ApiModelProperty("在项目中路径")
    private String path;

    @ApiModelProperty("路由名称")
    private String routeName;

    @ApiModelProperty("父级id")
    private Long parentId;

    @ApiModelProperty("菜单类型 （`0`代表菜单、`1`代表`iframe`、`2`代表外链、`3`代表按钮）")
    private Integer menuType;

    @ApiModelProperty("路由title")
    private String title;

    @ApiModelProperty("图标")
    private String icon;

    @ApiModelProperty("进入动画")
    private String enterTransition;

    @ApiModelProperty("退出动画")
    private String leaveTransition;

    @ApiModelProperty("等级")
    private Integer routerRank;

    @ApiModelProperty("是否显示")
    private Boolean visible;
}
