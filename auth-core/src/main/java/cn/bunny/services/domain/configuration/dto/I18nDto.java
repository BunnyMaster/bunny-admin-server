package cn.bunny.services.domain.configuration.dto;

import cn.bunny.services.domain.common.ValidationGroups;
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
@Schema(name = "I18nDto对象", title = "多语言分页查询", description = "多语言分页查询")
public class I18nDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空", groups = {ValidationGroups.Update.class})
    private Long id;

    @Schema(name = "keyName", title = "多语言key")
    @NotBlank(message = "多语言key不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String keyName;

    @Schema(name = "translation", title = "多语言翻译名称")
    @NotBlank(message = "多语言翻译名称不能为空", groups = {ValidationGroups.Add.class, ValidationGroups.Update.class})
    private String translation;

    @Schema(name = "typeName", title = "多语言类型名称")
    @NotBlank(message = "多语言类型名称不能为空", groups = {ValidationGroups.Add.class})
    private String typeName;

}

