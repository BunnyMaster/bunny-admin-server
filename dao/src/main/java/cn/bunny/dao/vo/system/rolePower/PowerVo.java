package cn.bunny.dao.vo.system.rolePower;

import cn.bunny.dao.vo.BaseVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "PowerVo对象", title = "权限", description = "权限管理")
public class PowerVo extends BaseVo {

    @Schema(name = "parentId", title = "父级id")
    private Long parentId;

    @Schema(name = "parentId", title = "权限编码")
    private String powerCode;

    @Schema(name = "powerName", title = "权限名称")
    private String powerName;

    @Schema(name = "requestUrl", title = "请求路径")
    private String requestUrl;

}