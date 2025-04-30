package cn.bunny.utils;

import cn.bunny.dao.entity.TableMetaData;
import lombok.SneakyThrows;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

@SpringBootTest
class DatabaseInfoCoreTest {

    String tableName = "sys_i18n";

    @Autowired
    private DataSource dataSource;


    @Test
    void testTableInfoMetaData() {
        TableMetaData tableMetaData;

        try (Connection connection = dataSource.getConnection()) {
            DatabaseMetaData metaData = connection.getMetaData();
            ResultSet tables = metaData.getTables(null, null, tableName, new String[]{"TABLE"});

            // 获取表的注释信息
            if (tables.next()) {
                String remarks = tables.getString("REMARKS");
                String tableCat = tables.getString("TABLE_CAT");
                String tableType = tables.getString("TABLE_TYPE");

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