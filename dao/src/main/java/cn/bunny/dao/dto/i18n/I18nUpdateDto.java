package cn.bunny.dao.dto.i18n;

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
@Schema(name = "I18nUpdateDto对象", title = "多语言更新", description = "多语言更新")
public class I18nUpdateDto {

    @Schema(name = "id", title = "主键")
    @NotNull(message = "id不能为空")
    private Long id;

    @Schema(name = "keyName", title = "多语言key")
    @NotBlank(message = "多语言key不能为空")
    @NotNull(message = "多语言key不能为空")
    private String keyName;

    @Schema(name = "translation", title = "多语言翻译名称")
    @NotBlank(message = "多语言翻译名称不能为空")
    @NotNull(message = "多语言翻译名称不能为空")
    private String translation;


    @Schema(name = "typeId", title = "多语言类型id")
    private Long typeId;

}