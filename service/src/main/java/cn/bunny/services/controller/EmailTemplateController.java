package cn.bunny.services.controller;

import cn.bunny.dao.dto.system.email.EmailTemplateAddDto;
import cn.bunny.dao.dto.system.email.EmailTemplateDto;
import cn.bunny.dao.dto.system.email.EmailTemplateUpdateDto;
import cn.bunny.dao.entity.system.EmailTemplate;
import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import cn.bunny.dao.vo.system.email.EmailTemplateVo;
import cn.bunny.services.service.EmailTemplateService;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import reactor.core.publisher.Mono;

import java.util.List;

/**
 * <p>
 * 邮件模板表表 前端控制器
 * </p>
 *
 * @author Bunny
 * @since 2024-10-10 21:24:08
 */
@Tag(name = "邮件模板表", description = "邮件模板表相关接口")
@RestController
@RequestMapping("admin/emailTemplate")
public class EmailTemplateController {

    @Autowired
    private EmailTemplateService emailTemplateService;

    @Operation(summary = "分页查询邮件模板表", description = "分页查询邮件模板表")
    @GetMapping("getEmailTemplateList/{page}/{limit}")
    public Mono<Result<PageResult<EmailTemplateVo>>> getEmailTemplateList(
            @Parameter(name = "page", description = "当前页", required = true)
            @PathVariable("page") Integer page,
            @Parameter(name = "limit", description = "每页记录数", required = true)
            @PathVariable("limit") Integer limit,
            EmailTemplateDto dto) {
        Page<EmailTemplate> pageParams = new Page<>(page, limit);
        PageResult<EmailTemplateVo> pageResult = emailTemplateService.getEmailTemplateList(pageParams, dto);
        return Mono.just(Result.success(pageResult));
    }

    @Operation(summary = "查询所有邮件模板", description = "查询所有邮件模板")
    @GetMapping("getAllEmailTemplates")
    public Mono<Result<List<EmailTemplateVo>>> getAllEmailTemplates() {
        List<EmailTemplateVo> voList = emailTemplateService.getAllEmailTemplates();
        return Mono.just(Result.success(voList));
    }

    @Operation(summary = "添加邮件模板表", description = "添加邮件模板表")
    @PostMapping("addEmailTemplate")
    public Mono<Result<String>> addEmailTemplate(@Valid @RequestBody EmailTemplateAddDto dto) {
        emailTemplateService.addEmailTemplate(dto);
        return Mono.just(Result.success(ResultCodeEnum.ADD_SUCCESS));
    }

    @Operation(summary = "更新邮件模板表", description = "更新邮件模板表")
    @PutMapping("updateEmailTemplate")
    public Mono<Result<String>> updateEmailTemplate(@Valid @RequestBody EmailTemplateUpdateDto dto) {
        emailTemplateService.updateEmailTemplate(dto);
        return Mono.just(Result.success(ResultCodeEnum.UPDATE_SUCCESS));
    }

    @Operation(summary = "删除邮件模板表", description = "删除邮件模板表")
    @DeleteMapping("deleteEmailTemplate")
    public Mono<Result<String>> deleteEmailTemplate(@RequestBody List<Long> ids) {
        emailTemplateService.deleteEmailTemplate(ids);
        return Mono.just(Result.success(ResultCodeEnum.DELETE_SUCCESS));
    }
}
