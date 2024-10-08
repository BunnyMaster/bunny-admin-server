package cn.bunny.dao.dto.system.rolePower;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "PowerAddDto对象", title = "权限", description = "权限管理")
public class PowerAddDto {

    @Schema(name = "parentId", title = "父级id")
    private Long parentId;

    @Schema(name = "parentId", title = "权限编码")
    @NotBlank(message = "权限编码 不能为空")
    private String powerCode;

    @Schema(name = "powerName", title = "权限名称")
    @NotBlank(message = "权限名称 不能为空")
    private String powerName;

    @Schema(name = "requestUrl", title = "请求路径")
    private String requestUrl;

}

