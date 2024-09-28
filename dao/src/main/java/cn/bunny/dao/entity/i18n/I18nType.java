package cn.bunny.dao.entity.i18n;

import cn.bunny.dao.entity.BaseEntity;
import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
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
@ApiModel(value = "I18nType对象", description = "多语言类型表")
public class I18nType extends BaseEntity {

    @ApiModelProperty("多语言类型(比如zh,en)")
    private String typeName;

    @ApiModelProperty("名称解释(比如中文,英文)")
    private String summary;

}
