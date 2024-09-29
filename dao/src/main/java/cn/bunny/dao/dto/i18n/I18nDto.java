package cn.bunny.dao.dto.i18n;

import io.swagger.v3.oas.annotations.media.Schema;
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

    @Schema(name = "keyName", title = "多语言key")
    private Integer keyName;

    @Schema(name = "translation", title = "多语言翻译名称")
    private String translation;

}