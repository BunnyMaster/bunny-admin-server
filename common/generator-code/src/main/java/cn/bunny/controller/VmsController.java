package cn.bunny.controller;

import cn.bunny.dao.dto.VmsArgumentDto;
import cn.bunny.dao.result.Result;
import cn.bunny.dao.vo.GeneratorVo;
import cn.bunny.service.VmsService;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@Tag(name = "生成器", description = "代码生成器接口")
@RestController
@RequestMapping("/api/vms")
public class VmsController {

    private final VmsService vmsService;

    public VmsController(VmsService vmsService) {
        this.vmsService = vmsService;
    }

    @Operation(summary = "生成控制器", description = "生成控制器代码")
    @PostMapping("generator")
    public Result<List<GeneratorVo>> generator(@Valid @RequestBody VmsArgumentDto dto) {
        List<GeneratorVo> list = vmsService.generator(dto);
        return Result.success(list);
    }
}
