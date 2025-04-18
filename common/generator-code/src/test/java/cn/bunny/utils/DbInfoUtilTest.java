package cn.bunny.utils;

import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.entity.TableMetaData;
import lombok.SneakyThrows;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@SpringBootTest
class DbInfoUtilTest {

    String tableName = "sys_i18n";

    @Autowired
    private DbInfoUtil dbInfoUtil;

    @Autowired
    private DataSource dataSource;

    @Test
    void columnInfo() throws SQLException {
        List<ColumnMetaData> columnMetaDataList = dbInfoUtil.columnInfo(tableName);
        columnMetaDataList.forEach(System.out::println);
    }

    @Test
    void dbInfo() throws SQLException {
        TableMetaData tableMetaData = dbInfoUtil.dbInfo(tableName);
        System.out.println(tableMetaData);
    }

    @Test
    void testTableInfo() {
        TableMetaData tableMetaData;

        try (Connection connection = dataSource.getConnection()) {
            DatabaseMetaData metaData = connection.getMetaData();
            ResultSet tables = metaData.getTables(null, null, tableName, new String[]{"TABLE"});

            // 获取表的注释信息
            if (tables.next()) {
                String remarks = tables.getString("REMARKS");
                String tableCat = tables.getString("TABLE_CAT");
                String tableSchem = tables.getString("TABLE_SCHEM");
                String tableType = tables.getString("TABLE_TYPE");
                String typeCat = tables.getString("TYPE_CAT");
                String typeSchem = tables.getString("TYPE_SCHEM");
                String typeName = tables.getString("TYPE_NAME");
                String selfReferencingColName = tables.getString("SELF_REFERENCING_COL_NAME");
                String refGeneration = tables.getString("REF_GENERATION");

                tableMetaData = TableMetaData.builder()
                        .tableName(tableName)
                        .comment(remarks)
                        .tableCat(tableCat)
                        .tableType(tableType)
                        .build();
            } else {
                throw new RuntimeException("数据表不存在");
            }

            System.out.println(tableMetaData);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @SneakyThrows
    @Test
    void getDbTableList() {
        String dbName = "auth_admin";

        try (Connection connection = dataSource.getConnection()) {
            DatabaseMetaData metaData = connection.getMetaData();
            ResultSet tables = metaData.getTables(dbName, null, "%", new String[]{"TABLE"});

            List<String> list = new ArrayList<>();

            while (tables.next()) {
                dbName = tables.getString("TABLE_NAME");
                list.add(dbName);
            }

            System.out.println(list);
        }
    }
}