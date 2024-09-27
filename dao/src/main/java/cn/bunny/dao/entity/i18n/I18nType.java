package cn.bunny.dao.entity.i18n;

import cn.bunny.dao.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

@Getter
@Setter
@Accessors(chain = true)
@TableName("i18n_type")
@Schema(name = "I18nType", title = "多语言类型表", description = "多语言类型表")
public class I18nType extends BaseEntity {

    @Schema(name = "languageName", title = "语言名称")
    private String languageName;

    @Schema(name = "summary", title = "语言名")
    private String summary;

    @Schema(name = "isDefault", title = "是否作为默认语言")
    private Byte isDefault;
}