package cn.bunny.dao.vo.system.router;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ApiModel(value = "UserRouterMetaVo对象", description = "系统属性内容")
public class RouterMeta {

    @ApiModelProperty(value = "图标")
    private String icon;

    @ApiModelProperty(value = "标题")
    private String title;

    @ApiModelProperty(value = "排序权重")
    private Integer rank;

    @ApiModelProperty(value = "角色列表")
    private List<String> roles;

    @ApiModelProperty(value = "权限列表")
    private List<String> auths;

    @ApiModelProperty("frame路径")
    private String frameSrc;

}
