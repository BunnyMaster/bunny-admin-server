package cn.bunny.services.domain.system.system.vo;

import cn.bunny.services.domain.common.model.vo.BaseUserVo;
import com.alibaba.fastjson2.annotation.JSONField;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.ser.std.ToStringSerializer;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "PowerVo对象", title = "权限", description = "权限管理")
public class PermissionVo extends BaseUserVo {

    @Schema(name = "parentId", title = "父级id")
    @JsonFormat(shape = JsonFormat.Shape.STRING)
    @JSONField(serializeUsing = ToStringSerializer.class)
    private Long parentId;

    @Schema(name = "parentId", title = "权限编码")
    private String powerCode;

    @Schema(name = "powerName", title = "权限名称")
    private String powerName;

    @Schema(name = "requestUrl", title = "请求路径")
    private String requestUrl;

    @Schema(name = "requestMethod", title = "请求路径")
    private String requestMethod;

    @Schema(name = "children", title = "子级")
    private List<PermissionVo> children;

}