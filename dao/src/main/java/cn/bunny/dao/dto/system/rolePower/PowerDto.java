package cn.bunny.dao.dto.system.rolePower;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "PowerDto对象", title = "权限", description = "权限管理")
public class PowerDto {

    @Schema(name = "parentId", title = "权限编码")
    private String powerCode;

    @Schema(name = "powerName", title = "权限名称")
    private String powerName;

    @Schema(name = "requestUrl", title = "请求路径")
    private String requestUrl;

}

