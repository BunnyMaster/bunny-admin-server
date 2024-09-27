package cn.bunny.dao.entity.system;

import cn.bunny.dao.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_router")
@ApiModel(value = "Router对象", description = "系统菜单表")
public class Router extends BaseEntity {
    @ApiModelProperty("在项目中路径")
    private String routerPath;

    @ApiModelProperty("路由名称")
    private String routeName;

    @ApiModelProperty("父级id")
    private Long parentId;

    @ApiModelProperty("路由title")
    private String title;

    @ApiModelProperty("图标")
    private String icon;

    @ApiModelProperty("等级")
    private Integer routerRank;

    @ApiModelProperty("是否显示")
    private Boolean visible;
}