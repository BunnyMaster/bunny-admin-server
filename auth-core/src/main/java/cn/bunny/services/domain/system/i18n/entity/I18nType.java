package cn.bunny.services.domain.system.i18n.entity;

import cn.bunny.services.domain.common.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 多语言类型表
 * </p>
 *
 * @author Bunny
 * @since 2024-09-28
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_i18n_type")
@Schema(name = "I18nType对象", title = "多语言类型表", description = "多语言类型表")
public class I18nType extends BaseEntity {

    @Schema(name = "typeName", title = "多语言类型(比如zh,en)")
    private String typeName;

    @Schema(name = "summary", title = "名称解释(比如中文,英文)")
    private String summary;

    @Schema(name = "isDefault", title = "是否为默认")
    private Boolean isDefault;

    @Schema(name = "isDeleted", title = "是否被删除")
    @TableField(exist = false)
    private Boolean isDeleted;

}
