package cn.bunny.dao.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ColumnMetaData {

    /* 列名称 */
    private String columnName;

    /* 字段名称 */
    private String fieldName;

    /* 数据库字段类型 */
    private String jdbcType;

    /* Java类型 */
    private String javaType;

    /* Javascript类型 */
    private String javascriptType;

    /* 是否为主键 */
    private Boolean isPrimaryKey;

    /* 字段注释 */
    private String comment;

}