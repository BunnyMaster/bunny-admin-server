package cn.bunny.controller;

import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.vo.TableInfoVo;
import cn.bunny.service.TableService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Tag(name = "表控制器" , description = "代码生成器接口" )
@RestController
@RequestMapping("/api" )
public class TableController {

    private final TableService tableService;

    public TableController(TableService tableService) {
        this.tableService = tableService;
    }

    @Operation(summary = "获取所有表" , description = "获取所有表" )
    @GetMapping("getAllTableMetaData" )
    public List<TableInfoVo> getAllTableMetaData() {
        return tableService.getAllTableMetaData();
    }

    @Operation(summary = "获取表属性" , description = "获取表属性" )
    @GetMapping("getTableMetaData" )
    public TableInfoVo getTableMetaData(String tableName) {
        return tableService.getTableMetaData(tableName);
    }

    @Operation(summary = "获取列属性" , description = "获取列属性" )
    @GetMapping("getColumnInfo" )
    public List<ColumnMetaData> getColumnInfo(String tableName) {
        return tableService.getColumnInfo(tableName);
    }
}
