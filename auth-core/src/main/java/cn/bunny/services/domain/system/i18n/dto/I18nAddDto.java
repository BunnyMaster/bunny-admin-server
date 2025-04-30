package cn.bunny.services.domain.system.i18n.dto;

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
@Schema(name = "I18nAddDto对象", title = "多语言添加", description = "多语言添加")
public class I18nAddDto {

    @Schema(name = "keyName", title = "多语言key")
    @NotBlank(message = "多语言key不能为空")
    private String keyName;

    @Schema(name = "translation", title = "多语言翻译名称")
    @NotBlank(message = "多语言翻译名称不能为空")
    private String translation;

    @Schema(name = "typeName", title = "多语言类型名称")
    @NotBlank(message = "多语言类型名称不能为空")
    private String typeName;

}

