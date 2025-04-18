package cn.bunny;


import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.entity.TableMetaData;
import cn.bunny.utils.ConvertUtil;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.springframework.boot.test.context.SpringBootTest;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@SpringBootTest
public class JDBCTest {

    DatabaseMetaData metaData;

    private final DataSource dataSource;

    public JDBCTest(DataSource dataSource) {
        this.dataSource = dataSource;
    }


    @BeforeEach
    public void setUp() throws Exception {
        try (Connection connection = dataSource.getConnection()) {
            metaData = connection.getMetaData();
        }
    }

    @Test
    void testComment() throws SQLException {
        String tableName = "sys_i18n";
        TableMetaData tableMetaData;
        ResultSet tables = metaData.getTables(null, null, tableName, new String[]{"TABLE"});

        // 获取表的注释信息
        if (tables.next()) {
            String remarks = tables.getString("REMARKS");
            String tableCat = tables.getString("TABLE_CAT");

            tableMetaData = TableMetaData.builder()
                    .tableName(tableName)
                    .comment(remarks)
                    .tableCat(tableCat)
                    .build();

            System.out.println(tableMetaData);
        }
    }

    @Test
    void testAllTableComment() throws SQLException {
        ResultSet tables = metaData.getTables(null, null, "%", new String[]{"TABLE"});
        List<TableMetaData> list = new ArrayList<>();

        while (tables.next()) {
            String tableName = tables.getString("TABLE_NAME");
            String remarks = tables.getString("REMARKS");
            String tableCat = tables.getString("TABLE_CAT");

            TableMetaData tableMetaData = TableMetaData.builder()
                    .tableName(tableName).comment(remarks)
                    .tableCat(tableCat)
                    .build();
            list.add(tableMetaData);
        }

        System.out.println(list);
    }

    @Test
    void testColumnInfo() throws SQLException {
        List<ColumnMetaData> columns = new ArrayList<>();

        try (ResultSet columnsRs = metaData.getColumns(null, null, "sys_i18n", null)) {
            while (columnsRs.next()) {
                ColumnMetaData column = new ColumnMetaData();
                column.setColumnName(columnsRs.getString("COLUMN_NAME"));
                column.setFieldName(ConvertUtil.convertToCamelCase(column.getColumnName()));
                column.setJdbcType(columnsRs.getString("TYPE_NAME"));
                column.setJavaType(ConvertUtil.convertToJavaType(column.getJdbcType()));
                column.setComment(columnsRs.getString("REMARKS"));

                columns.add(column);
                System.out.println(column);
            }
        }

        System.out.println(columns);
    }
}
