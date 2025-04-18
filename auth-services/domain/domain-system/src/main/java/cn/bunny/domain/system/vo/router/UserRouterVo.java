package cn.bunny.domain.system.vo.router;

import com.alibaba.fastjson2.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ApiModel(value = "UserRouterVo对象", description = "系统菜单表")
public class UserRouterVo {

    @Schema(name = "id", title = "主键")
    @JsonProperty("id")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long id;

    @ApiModelProperty("菜单类型")
    private Integer menuType;

    @ApiModelProperty("父级id")
    @JsonProperty("parentId")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long parentId;

    @ApiModelProperty("菜单名称")
    private String title;

    @ApiModelProperty("路由名称")
    @JsonProperty("name")
    private String routeName;

    @ApiModelProperty("在项目中路径")
    private String path;

    @ApiModelProperty("组件位置")
    private String component;

    @ApiModelProperty("等级")
    @JsonProperty("rank")
    private Integer routerRank;

    @ApiModelProperty("路由Meta")
    private RouterMeta meta;

    @ApiModelProperty("子路由")
    private List<UserRouterVo> children;
}
