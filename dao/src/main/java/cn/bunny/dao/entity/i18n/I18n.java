package cn.bunny.dao.entity.i18n;

import cn.bunny.dao.entity.BaseEntity;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
@Schema(name = "I18n对象", title = "多语言表", description = "多语言表")
public class I18n extends BaseEntity {

    @Schema(name = "typeId", title = "语言类型id")
    private Long typeId;

    @Schema(name = "keyName", title = "多语言key")
    private String keyName;

    @Schema(name = "summary", title = "翻译")
    private String summary;
}