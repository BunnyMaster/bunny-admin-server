package cn.bunny.dao.vo.i18n;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "I18nVo对象", title = "多语言返回内容", description = "多语言返回内容")
public class I18nVo {

    @Schema(name = "keyName", title = "多语言key")
    private Integer keyName;

    @Schema(name = "translation", title = "多语言翻译名称")
    private String translation;

    @Schema(name = "typeId", title = "多语言类型id")
    private Long typeId;

}


