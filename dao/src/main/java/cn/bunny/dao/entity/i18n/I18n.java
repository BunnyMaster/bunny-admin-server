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
@ApiModel(value = "I18n对象", description = "多语言表")
public class I18n extends BaseEntity {

    @ApiModelProperty("多语言key")
    private Integer keyName;

    @ApiModelProperty("多语言翻译名称")
    private String translation;

    @ApiModelProperty("多语言类型id")
    private Long typeId;

}
