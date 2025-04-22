package cn.bunny.controller;

import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.entity.DatabaseInfoMetaData;
import cn.bunny.dao.result.Result;
import cn.bunny.dao.vo.TableInfoVo;
import cn.bunny.service.TableService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@Tag(name = "数据库表控制器", description = "数据库表信息接口")
@RestController
@RequestMapping("/api/table")
public class TableController {

    @Value("${bunny.master.database}")
    private String currentDatabase;

    @Resource
    private TableService tableService;

    @Operation(summary = "当前数据库信息", description = "当前连接的数据库信息")
    @GetMapping("databaseInfoMetaData")
    public Result<DatabaseInfoMetaData> databaseInfoMetaData() {
        DatabaseInfoMetaData databaseInfoMetaData = tableService.databaseInfoMetaData();
        return Result.success(databaseInfoMetaData);
    }

    @Operation(summary = "当前配置的数据库", description = "当前配置的数据库")
    @GetMapping("currentDatabaseName")
    public Result<String> getCurrentDatabaseName() {
        return Result.success(currentDatabase);
    }

    @Operation(summary = "数据库所有的表", description = "获取[当前/所有]数据库表")
    @GetMapping("databaseTableList")
    public Result<List<TableInfoVo>> databaseTableList(String dbName) {
        List<TableInfoVo> list = tableService.databaseTableList(dbName);
        return Result.success(list);
    }

    @Operation(summary = "所有的数据库名称", description = "当前数据库所有的数据库名称")
    @GetMapping("databaseList")
    public Result<List<TableInfoVo>> databaseList() {
        List<TableInfoVo> allDb = tableService.databaseTableList(null);

        // 将当前数据库表分组，以数据库名称为key
        List<TableInfoVo> list = allDb.stream()
                .collect(Collectors.groupingBy(TableInfoVo::getTableCat))
                .values().stream()
                .map(tableInfoVos -> {
                    TableInfoVo tableInfoVo = tableInfoVos.get(0);
                    tableInfoVo.setTableName(null);
                    return tableInfoVo;
                }).toList();

        return Result.success(list);
    }

    @Operation(summary = "表属性", description = "获取当前查询表属性")
    @GetMapping("tableMetaData")
    public Result<TableInfoVo> tableMetaData(String tableName) {
        TableInfoVo tableMetaData = tableService.tableMetaData(tableName);
        return Result.success(tableMetaData);
    }

    @Operation(summary = "表的列属性", description = "获取当前查询表中列属性")
    @GetMapping("tableColumnInfo")
    public Result<List<ColumnMetaData>> tableColumnInfo(String tableName) {
        List<ColumnMetaData> columnInfo = tableService.tableColumnInfo(tableName);
        return Result.success(columnInfo);
    }
}
