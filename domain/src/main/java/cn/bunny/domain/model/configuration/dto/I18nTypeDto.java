package cn.bunny.domain.model.configuration.dto;

import cn.bunny.domain.common.ValidationGroups;
import io.swagger.v3.oas.annotations.media.Schema;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Schema(name = "I18nTypeDto对象", title = "多语言类型", description = "多语言类型")
public class I18nTypeDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空", groups = {ValidationGroups.Update.class})
    private Long id;

    @Schema(name = "typeName", title = "多语言类型(比如zh,en)")
    @NotBlank(message = "多语言类型不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String typeName;

    @Schema(name = "summary", title = "名称解释(比如中文,英文)")
    @NotBlank(message = "名称解释不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String summary;

    @Schema(name = "isDefault", title = "是否为默认")
    private Boolean isDefault = false;

}