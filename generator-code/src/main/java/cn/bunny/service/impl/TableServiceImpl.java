package cn.bunny.service.impl;

import cn.bunny.core.DatabaseInfoCore;
import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.entity.DatabaseInfoMetaData;
import cn.bunny.dao.entity.TableMetaData;
import cn.bunny.dao.vo.TableInfoVo;
import cn.bunny.service.TableService;
import jakarta.annotation.Resource;
import lombok.SneakyThrows;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class TableServiceImpl implements TableService {

    @Resource
    private DatabaseInfoCore databaseInfoCore;

    /**
     * 获取表属性
     *
     * @param tableName 表名称
     * @return 表属性
     */
    @SneakyThrows
    @Override
    public TableInfoVo tableMetaData(String tableName) {
        TableInfoVo tableInfoVo = new TableInfoVo();

        TableMetaData tableMetaData = databaseInfoCore.tableInfoMetaData(tableName);
        BeanUtils.copyProperties(tableMetaData, tableInfoVo);

        return tableInfoVo;
    }

    /**
     * 获取[当前/所有]数据库表
     *
     * @return 所有表信息
     */
    @SneakyThrows
    @Override
    public List<TableInfoVo> databaseTableList(String dbName) {
        List<TableMetaData> allTableInfo = databaseInfoCore.databaseTableList(dbName);

        return allTableInfo.stream().map(tableMetaData -> {
            TableInfoVo tableInfoVo = new TableInfoVo();
            BeanUtils.copyProperties(tableMetaData, tableInfoVo);

            return tableInfoVo;
        }).toList();
    }

    /**
     * 获取当前表的列属性
     *
     * @param tableName 表名称
     * @return 当前表所有的列内容
     */
    @SneakyThrows
    @Override
    public List<ColumnMetaData> tableColumnInfo(String tableName) {
        return databaseInfoCore.tableColumnInfo(tableName);
    }

    /**
     * 数据库所有的信息
     *
     * @return 当前连接的数据库信息属性
     */
    @SneakyThrows
    @Override
    public DatabaseInfoMetaData databaseInfoMetaData() {
        return databaseInfoCore.databaseInfoMetaData();
    }
}
