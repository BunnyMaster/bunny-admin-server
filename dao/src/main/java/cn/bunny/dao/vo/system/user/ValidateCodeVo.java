package cn.bunny.dao.vo.system.user;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
@Schema(description = "验证码响应结果实体类")
public class ValidateCodeVo {
    @Schema(description = "验证码key")
    private String codeKey;

    @Schema(description = "验证码value")
    private String codeValue;
}