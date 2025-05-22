package cn.bunny.services.domain.common.enums;

import lombok.Getter;

/**
 * 统一返回结果状态信息类
 */
@Getter
public enum ResultCodeEnum {
    // 成功操作 200
    SUCCESS(200, "操作成功"),
    CREATE_SUCCESS(200, "添加成功"),
    UPDATE_SUCCESS(200, "修改成功"),
    DELETE_SUCCESS(200, "删除成功"),
    SORT_SUCCESS(200, "排序成功"),
    SUCCESS_UPLOAD(200, "上传成功"),
    SUCCESS_LOGOUT(200, "退出成功"),
    LOGOUT_SUCCESS(200, "退出成功"),
    EMAIL_CODE_REFRESH(200, "邮箱验证码已刷新"),
    EMAIL_CODE_SEND_SUCCESS(200, "邮箱验证码已发送"),

    // 验证错误 201
    USERNAME_OR_PASSWORD_NOT_EMPTY(201, "用户名或密码不能为空"),
    EMAIL_CODE_NOT_EMPTY(201, "邮箱验证码不能为空"),
    SEND_EMAIL_CODE_NOT_EMPTY(201, "请先发送邮箱验证码"),
    EMAIL_CODE_NOT_MATCHING(201, "邮箱验证码不匹配"),
    LOGIN_ERROR(500, "账号或密码错误"),
    LOGIN_ERROR_USERNAME_PASSWORD_NOT_EMPTY(201, "登录信息不能为空"),
    GET_BUCKET_EXCEPTION(201, "获取文件信息失败"),
    SEND_MAIL_CODE_ERROR(201, "邮件发送失败"),
    EMAIL_CODE_EMPTY(201, "邮箱验证码过期或不存在"),
    EMAIL_EXIST(201, "邮箱已存在"),
    REQUEST_IS_EMPTY(201, "请求数据为空"),
    DATA_TOO_LARGE(201, "请求数据为空"),
    UPDATE_NEW_PASSWORD_SAME_AS_OLD_PASSWORD(201, "新密码与密码相同"),

    // 数据相关 206
    ILLEGAL_REQUEST(206, "非法请求"),
    REPEAT_SUBMIT(206, "重复提交"),
    DATA_ERROR(206, "数据异常"),
    EMAIL_USER_TEMPLATE_IS_EMPTY(206, "邮件模板为空"),
    EMAIL_TEMPLATE_IS_EMPTY(206, "邮件模板为空"),
    EMAIL_USER_IS_EMPTY(206, "关联邮件用户配置为空"),
    DATA_EXIST(206, "数据已存在"),
    DATA_NOT_EXIST(206, "数据不存在"),
    ALREADY_USER_EXCEPTION(206, "用户已存在"),
    USER_IS_EMPTY(206, "用户不存在"),
    FILE_NOT_EXIST(206, "文件不存在"),
    NEW_PASSWORD_SAME_OLD_PASSWORD(206, "新密码不能和旧密码相同"),
    MISSING_TEMPLATE_FILES(206, "缺少模板文件"),

    // 身份过期 208
    LOGIN_AUTH(208, "请先登陆"),
    AUTHENTICATION_EXPIRED(208, "身份验证过期"),
    SESSION_EXPIRATION(208, "会话过期"),
    FAIL_NO_ACCESS_DENIED_USER_LOCKED(208, "该账户已封禁"),

    // 209
    THE_SAME_USER_HAS_LOGGED_IN(209, "相同用户已登录"),

    // 提示错误
    UPDATE_ERROR(216, "修改失败"),
    URL_ENCODE_ERROR(216, "URL编码失败"),
    ILLEGAL_CALLBACK_REQUEST_ERROR(217, "非法回调请求"),
    FETCH_USERINFO_ERROR(219, "获取用户信息失败"),
    ILLEGAL_DATA_REQUEST(219, "非法数据请求"),
    CLASS_NOT_FOUND(219, "类名不存在"),
    ADMIN_ROLE_CAN_NOT_DELETED(219, "无法删除admin角色"),
    ROUTER_RANK_NEED_LARGER_THAN_THE_PARENT(219, "设置路由等级需要大于或等于父级的路由等级"),

    // 无权访问 403
    FAIL_NO_ACCESS_DENIED(403, "无权访问"),
    FAIL_NO_ACCESS_DENIED_USER_OFFLINE(403, "用户强制下线"),
    TOKEN_PARSING_FAILED(403, "token解析失败"),

    // 系统错误 500
    UNKNOWN_EXCEPTION(500, "服务异常"),
    SERVICE_ERROR(500, "服务异常"),
    UPLOAD_ERROR(500, "上传失败"),
    FAIL(500, "失败"),
    ;

    private final Integer code;
    private final String message;

    ResultCodeEnum(Integer code, String message) {
        this.code = code;
        this.message = message;
    }
}