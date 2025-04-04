package cn.bunny.controller;

import cn.bunny.dao.entity.ColumnMetaData;
import cn.bunny.dao.vo.TableInfoVo;
import cn.bunny.service.TableService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

@Controller
public class IndexController {

    private final TableService tableService;

    public IndexController(TableService tableService) {
        this.tableService = tableService;
    }

    @GetMapping("/" )
    public String index(Model model) {
        List<TableInfoVo> list = tableService.getAllTableMetaData();
        model.addAttribute("list" , list);

        return "index";
    }

    @GetMapping("/preview/{tableName}" )
    public String preview(Model model, @PathVariable String tableName) {
        TableInfoVo tableMetaData = tableService.getTableMetaData(tableName);
        List<ColumnMetaData> columnInfo = tableService.getColumnInfo(tableName);

        model.addAttribute("tableMetaData" , tableMetaData);
        model.addAttribute("columnInfo" , columnInfo);

        return "preview";
    }

    @GetMapping("/generator/{tableName}" )
    public String generator(Model model, @PathVariable String tableName) {
        TableInfoVo tableMetaData = tableService.getTableMetaData(tableName);
        List<ColumnMetaData> columnInfo = tableService.getColumnInfo(tableName);

        model.addAttribute("tableMetaData" , tableMetaData);
        model.addAttribute("columnInfo" , columnInfo);

        return "generator";
    }
}
