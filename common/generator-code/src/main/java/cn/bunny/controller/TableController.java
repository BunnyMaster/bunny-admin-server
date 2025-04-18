package cn.bunny.controller;

import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.result.Result;
import cn.bunny.dao.vo.TableInfoVo;
import cn.bunny.service.TableService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.stream.Collectors;

@Tag(name = "数据库表控制器", description = "数据库表信息接口")
@RestController
@RequestMapping("/api/table")
public class TableController {

    private final TableService tableService;

    public TableController(TableService tableService) {
        this.tableService = tableService;
    }

    @Operation(summary = "数据库所有的表", description = "获取[当前/所有]数据库表")
    @GetMapping("getDbTables")
    public Result<List<TableInfoVo>> getDbTables(String dbName) {
        List<TableInfoVo> list = tableService.getDbTables(dbName);
        return Result.success(list);
    }

    @Operation(summary = "所有的数据库", description = "所有的数据库")
    @GetMapping("getDbList")
    public Result<List<TableInfoVo>> getDbList() {
        List<TableInfoVo> allDb = tableService.getDbTables(null);

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

    @Operation(summary = "获取表属性", description = "获取表属性")
    @GetMapping("getTableMetaData")
    public Result<TableInfoVo> getTableMetaData(String tableName) {
        TableInfoVo tableMetaData = tableService.getTableMetaData(tableName);
        return Result.success(tableMetaData);
    }

    @Operation(summary = "获取列属性", description = "获取列属性")
    @GetMapping("getColumnInfo")
    public Result<List<ColumnMetaData>> getColumnInfo(String tableName) {
        List<ColumnMetaData> columnInfo = tableService.getColumnInfo(tableName);
        return Result.success(columnInfo);
    }
}
