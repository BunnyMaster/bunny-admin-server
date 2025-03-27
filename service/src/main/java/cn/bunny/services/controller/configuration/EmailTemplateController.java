package cn.bunny.services.controller.configuration;

import cn.bunny.dao.dto.system.email.template.EmailTemplateAddDto;
import cn.bunny.dao.dto.system.email.template.EmailTemplateDto;
import cn.bunny.dao.dto.system.email.template.EmailTemplateUpdateDto;
import cn.bunny.dao.entity.system.EmailTemplate;
import cn.bunny.dao.vo.result.PageResult;
import cn.bunny.dao.vo.result.Result;
import cn.bunny.dao.vo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.email.EmailTemplateVo;
import cn.bunny.services.service.configuration.EmailTemplateService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

/**
 * <p>
 * 邮件模板 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-10 21:24:08
 */
@Tag(name = "邮件模板", description = "邮件模板相关接口")
@RestController
@RequestMapping("api/emailTemplate")
public class EmailTemplateController {

    private final EmailTemplateService emailTemplateService;

    public EmailTemplateController(EmailTemplateService emailTemplateService) {
        this.emailTemplateService = emailTemplateService;
    }

    @Operation(summary = "分页查询邮件模板", description = "分页查询邮件模板")
    @GetMapping("getEmailTemplateList/{page}/{limit}")
    public Result<PageResult<EmailTemplateVo>> getEmailTemplateList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            EmailTemplateDto dto) {
        Page<EmailTemplate> pageParams = new Page<>(page, limit);
        PageResult<EmailTemplateVo> pageResult = emailTemplateService.getEmailTemplateList(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "获取邮件模板类型字段", description = "获取邮件模板类型字段")
    @GetMapping("getEmailTypes")
    public Result<List<Map<String, String>>> getEmailTypes() {
        List<Map<String, String>> list = emailTemplateService.getEmailTypes();
        return Result.success(list);
    }

    @Operation(summary = "添加邮件模板", description = "添加邮件模板")
    @PostMapping("addEmailTemplate")
    public Result<String> addEmailTemplate(@Valid @RequestBody EmailTemplateAddDto dto) {
        emailTemplateService.addEmailTemplate(dto);
        return Result.success(ResultCodeEnum.ADD_SUCCESS);
    }

    @Operation(summary = "更新邮件模板", description = "更新邮件模板")
    @PutMapping("updateEmailTemplate")
    public Result<String> updateEmailTemplate(@Valid @RequestBody EmailTemplateUpdateDto dto) {
        emailTemplateService.updateEmailTemplate(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除邮件模板", description = "删除邮件模板")
    @DeleteMapping("deleteEmailTemplate")
    public Result<String> deleteEmailTemplate(@RequestBody List<Long> ids) {
        emailTemplateService.deleteEmailTemplate(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }
}
