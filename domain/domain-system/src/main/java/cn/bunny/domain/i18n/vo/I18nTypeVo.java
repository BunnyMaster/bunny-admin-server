package cn.bunny.domain.i18n.vo;

import cn.bunny.domain.vo.BaseUserVo;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.*;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Schema(name = "I18nVo对象", title = "多语言返回内容", description = "多语言返回内容")
public class I18nTypeVo extends BaseUserVo {

    @Schema(name = "typeName", title = "多语言类型(比如zh,en)")
    private String typeName;

    @Schema(name = "summary", title = "名称解释(比如中文,英文)")
    private String summary;

    @Schema(name = "isDefault", title = "是否为默认")
    private Boolean isDefault;

}


