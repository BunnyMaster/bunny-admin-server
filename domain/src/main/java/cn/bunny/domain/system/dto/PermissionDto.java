package cn.bunny.domain.system.dto;

import cn.bunny.domain.common.ValidationGroups;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "PowerDto对象", title = "权限分页查询", description = "权限管理")
public class PermissionDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空", groups = {ValidationGroups.Update.class})
    private Long id;

    @Schema(name = "parentId", title = "父级id")
    private Long parentId;

    @Schema(name = "parentId", title = "权限编码")
    @NotBlank(message = "权限编码 不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String powerCode;

    @Schema(name = "powerName", title = "权限名称")
    @NotBlank(message = "权限名称 不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String powerName;

    @Schema(name = "requestUrl", title = "请求路径")
    private String requestUrl;

    @Schema(name = "requestMethod", title = "请求方法")
    private String requestMethod;

}

