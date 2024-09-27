package cn.bunny.dao.vo.router;

import cn.bunny.dao.vo.BaseVo;
import com.alibaba.fastjson2.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.*;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ApiModel(value = "RouterControllerVo对象", description = "路由管理端返回对象")
public class RouterManageVo extends BaseVo {

    @ApiModelProperty("在项目中路径")
    private String path;

    @ApiModelProperty("路由名称")
    @JsonProperty("name")
    private String routeName;

    @ApiModelProperty("父级id")
    @JsonProperty("parentId")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long parentId;

    @ApiModelProperty("菜单类型")
    private Integer menuType;

    @ApiModelProperty("路由title")
    private String title;

    @ApiModelProperty("图标")
    private String icon;

    @ApiModelProperty("链接地址（需要内嵌的`iframe`链接地址）")
    private String frameSrc;

    @ApiModelProperty("等级")
    @JsonProperty("rank")
    private Integer routerRank;

    @ApiModelProperty("是否显示")
    private Boolean visible;

    @ApiModelProperty("是否显示")
    private Boolean frameLoading;

    @ApiModelProperty("子路由")
    private List<RouterManageVo> children;
}
