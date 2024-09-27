package cn.bunny.dao.pojo.constant;

import lombok.Data;

/**
 * 邮箱消息
 */
@Data
public class MailMessageConstant {
    public static final String EMPTY_SEND_OBJECT = "空发送对象";
    public static final String ADDRESS_NOT_NULL = "收件人不能为空";
    public static final String TITLE_NOT_NULL = "标题不能为空";
    public static final String SEND_MESSAGE_NOT_NULL = "发送消息不能为空";
    public static final String EMAIL_CONFIG_NOT_FOUND = "邮箱配置为空";
}
