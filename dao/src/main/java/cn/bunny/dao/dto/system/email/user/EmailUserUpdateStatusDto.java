package cn.bunny.dao.dto.system.email.user;

import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "EmailUserUpdateStatusDto对象", title = "邮箱用户更新状态", description = "邮箱用户更新状态表单")
public class EmailUserUpdateStatusDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空")
    private Long id;

    @Schema(name = "isDefault", title = "是否为默认邮件")
    private Boolean isDefault;

}