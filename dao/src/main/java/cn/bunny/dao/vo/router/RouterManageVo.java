package cn.bunny.dao.vo.router;

import cn.bunny.dao.vo.BaseVo;
import com.alibaba.fastjson2.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import jakarta.validation.constraints.NotBlank;
import lombok.*;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ApiModel(value = "RouterControllerVo对象", description = "路由管理端返回对象")
public class RouterManageVo extends BaseVo {

    @ApiModelProperty("父级id")
    @JsonProperty("parentId")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
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
    @NotBlank(message = "路由名称不能为空")
    @JsonProperty("name")
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
    @JsonProperty("rank")
    private Integer routerRank;

    @ApiModelProperty("是否隐藏标签")
    private Boolean hiddenTag;

    @ApiModelProperty("是否固定标签")
    private Boolean fixedTag;

    @ApiModelProperty("是否显示父级")
    private Boolean showParent;

    @ApiModelProperty("是否显示 返给前端为 showLink")
    private Boolean visible;

    @ApiModelProperty("子路由")
    private List<RouterManageVo> children;
}
