package cn.bunny.domain.configuration.vo;

import cn.bunny.domain.common.model.vo.BaseUserVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "I18nVo对象", title = "多语言返回内容", description = "多语言返回内容")
public class I18nVo extends BaseUserVo {

    @Schema(name = "keyName", title = "多语言key")
    private String keyName;

    @Schema(name = "translation", title = "多语言翻译名称")
    private String translation;

    @Schema(name = "typeName", title = "多语言类型id")
    private String typeName;

}


