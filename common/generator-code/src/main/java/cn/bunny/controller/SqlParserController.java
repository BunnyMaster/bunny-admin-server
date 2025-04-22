package cn.bunny.controller;

import cn.bunny.core.SqlParserCore;
import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.result.Result;
import cn.bunny.dao.vo.TableInfoVo;
import cn.bunny.service.SqlParserService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Tag(name = "解析SQL", description = "解析SQL接口")
@RestController
@RequestMapping("/api/sqlParser")
public class SqlParserController {

    @Resource
    private SqlParserService sqlParserService;

    @Operation(summary = "解析SQL成表信息", description = "解析SQL成表信息")
    @PostMapping("tableInfo")
    public Result<TableInfoVo> tableInfo(String sql) {
        TableInfoVo vo = sqlParserService.tableInfo(sql);
        return Result.success(vo);
    }

    @Operation(summary = "解析SQL成列数据", description = "解析SQL成列数据")
    @PostMapping("columnMetaData")
    public Result<List<ColumnMetaData>> columnMetaData(String sql) {
        List<ColumnMetaData> vo = SqlParserCore.parserColumnInfo(sql);
        return Result.success(vo);
    }
}
