package cn.bunny.services.domain.common.enums;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Getter;

@Getter
@Schema(description = "Email Template Types")
public enum EmailTemplateEnums {
    VERIFICATION_CODE("verification_code", "邮箱验证码发送"),
    NOTIFICATION("notification", "通知型邮件"),
    WARNING("warning", "警告型邮件"),
    ;

    private final String type;
    private final String summary;

    EmailTemplateEnums(String type, String summary) {
        this.type = type;
        this.summary = summary;
    }
}