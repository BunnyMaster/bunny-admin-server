package cn.bunny.dao.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class DatabaseInfoMetaData {

    /* 数据库产品名称 */
    private String databaseProductName;

    /* 数据库产品版本 */
    private String databaseProductVersion;

    /* 驱动名称 */
    private String driverName;

    /* 数据库驱动版本 */
    private String driverVersion;

    /* 数据链接url */
    private String url;

    /* 数据库用户 */
    private String username;
}