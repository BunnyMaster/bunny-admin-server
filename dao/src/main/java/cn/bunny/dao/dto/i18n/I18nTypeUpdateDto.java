package cn.bunny.dao.dto.i18n;

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
@Schema(name = "I18nTypeUpdateDto对象", title = "多语言类型更新", description = "多语言类型更新内容")
public class I18nTypeUpdateDto {

    @Schema(name = "id", title = "主键")
    @NotBlank(message = "id不能为空")
    private Long id;
    
    @Schema(name = "typeName", title = "多语言类型(比如zh,en)")
    @NotBlank(message = "多语言类型不能为空")
    private String typeName;

    @Schema(name = "summary", title = "名称解释(比如中文,英文)")
    @NotBlank(message = "名称解释不能为空")
    private String summary;

    @Schema(name = "isDefault", title = "是否为默认")
    private Boolean isDefault = false;

}