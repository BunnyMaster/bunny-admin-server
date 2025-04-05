package cn.bunny.dao.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class GeneratorVo {

    /* 生成的代码 */
    private String code;

    /* 表名 */
    private String tableName;

    /* 注释内容 */
    private String comment;

    /* 生成类型路径 */
    private String path;
}
