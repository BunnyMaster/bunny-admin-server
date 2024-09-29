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
@TableName("sys_i18n")
@Schema(name = "I18nWithI18nType对象", title = "多语言和多语言类型", description = "多语言和多语言类型内容")
public class I18nWithI18nType extends BaseEntity {

    @Schema(name = "keyName", title = "多语言key")
    private String keyName;

    @Schema(name = "translation", title = "多语言翻译名称")
    private String translation;

    @Schema(name = "typeName", title = "多语言类型(比如zh,en)")
    private String typeName;

    @Schema(name = "summary", title = "名称解释(比如中文,英文)")
    private String summary;

}