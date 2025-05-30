package cn.bunny.services.controller.configuration;

import cn.bunny.services.aop.annotation.PermissionTag;
import cn.bunny.domain.common.ValidationGroups;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.domain.common.model.vo.result.PageResult;
import cn.bunny.domain.common.model.vo.result.Result;
import cn.bunny.domain.configuration.dto.EmailTemplateDto;
import cn.bunny.domain.configuration.entity.EmailTemplate;
import cn.bunny.domain.configuration.vo.EmailTemplateVo;
import cn.bunny.services.service.configuration.EmailTemplateService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.annotation.Resource;
import org.springframework.validation.annotation.Validated;
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
@PermissionTag(permission = "emailTemplate:*")
@RestController
@RequestMapping("api/email-template")
public class EmailTemplateController {

    @Resource
    private EmailTemplateService emailTemplateService;

    @Operation(summary = "分页查询邮件模板", description = "分页查询邮件模板")
    @PermissionTag(permission = "emailTemplate:query")
    @GetMapping("{page}/{limit}")
    public Result<PageResult<EmailTemplateVo>> getEmailTemplatePage(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            EmailTemplateDto dto) {
        Page<EmailTemplate> pageParams = new Page<>(page, limit);
        PageResult<EmailTemplateVo> pageResult = emailTemplateService.getEmailTemplatePage(pageParams, dto);
        return Result.success(pageResult);
    }

    @Operation(summary = "添加邮件模板", description = "添加邮件模板")
    @PermissionTag(permission = "emailTemplate:add")
    @PostMapping()
    public Result<String> createEmailTemplate(@Validated(ValidationGroups.Add.class) @RequestBody EmailTemplateDto dto) {
        emailTemplateService.createEmailTemplate(dto);
        return Result.success(ResultCodeEnum.CREATE_SUCCESS);
    }

    @Operation(summary = "更新邮件模板", description = "更新邮件模板")
    @PermissionTag(permission = "emailTemplate:update")
    @PutMapping()
    public Result<String> updateEmailTemplate(@Validated(ValidationGroups.Update.class) @RequestBody EmailTemplateDto dto) {
        emailTemplateService.updateEmailTemplate(dto);
        return Result.success(ResultCodeEnum.UPDATE_SUCCESS);
    }

    @Operation(summary = "删除邮件模板", description = "删除邮件模板")
    @PermissionTag(permission = "emailTemplate:delete")
    @DeleteMapping()
    public Result<String> deleteEmailTemplate(@RequestBody List<Long> ids) {
        emailTemplateService.deleteEmailTemplate(ids);
        return Result.success(ResultCodeEnum.DELETE_SUCCESS);
    }

    @Operation(summary = "全部邮件类型列表", description = "获取全部邮件类型列表")
    @GetMapping("private")
    public Result<List<Map<String, String>>> getEmailTypeList() {
        List<Map<String, String>> list = emailTemplateService.getEmailTypeList();
        return Result.success(list);
    }
}
