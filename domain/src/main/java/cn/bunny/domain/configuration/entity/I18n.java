package cn.bunny.domain.configuration.entity;

import cn.bunny.domain.common.model.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;
import lombok.Setter;
import lombok.experimental.Accessors;

/**
 * <p>
 * 多语言表
 * </p>
 *
 * @author Bunny
 * @since 2024-09-28
 */
@Getter
@Setter
@Accessors(chain = true)
@TableName("sys_i18n")
@Schema(name = "I18n对象", title = "多语言", description = "多语言管理")
public class I18n extends BaseEntity {

    @Schema(name = "keyName", title = "多语言key")
    private String keyName;

    @Schema(name = "translation", title = "多语言翻译名称")
    private String translation;

    @Schema(name = "typeName", title = "多语言类型id")
    private String typeName;

    @Schema(name = "isDeleted", title = "是否被删除")
    @TableField(exist = false)
    private Boolean isDeleted;

}
