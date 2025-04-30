package cn.bunny.services.domain.system.i18n.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "I18nTypeDto对象", title = "多语言类型", description = "多语言类型")
public class I18nTypeDto {

    @Schema(name = "typeName", title = "多语言类型(比如zh,en)")
    private String typeName;

    @Schema(name = "summary", title = "名称解释(比如中文,英文)")
    private String summary;

}