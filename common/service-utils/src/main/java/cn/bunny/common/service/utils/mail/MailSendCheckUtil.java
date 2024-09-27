package cn.bunny.common.service.utils.mail;

import cn.bunny.common.service.utils.EmptyUtil;
import cn.bunny.dao.pojo.common.EmailSend;
import cn.bunny.dao.pojo.constant.MailMessageConstant;

public class MailSendCheckUtil {
    /**
     * 检测发送对象是否为空的对象
     *
     * @param emailSend 邮件发送对象
     */
    public static void check(EmailSend emailSend) {
        // 空发送对象
        EmptyUtil.isEmpty(emailSend, MailMessageConstant.EMPTY_SEND_OBJECT);
        // 收件人不能为空
        EmptyUtil.isEmpty(emailSend.getSendTo(), MailMessageConstant.ADDRESS_NOT_NULL);
        // 标题不能为空
        EmptyUtil.isEmpty(emailSend.getSubject(), MailMessageConstant.TITLE_NOT_NULL);
        // 发送消息不能为空
        EmptyUtil.isEmpty(emailSend.getMessage(), MailMessageConstant.SEND_MESSAGE_NOT_NULL);
    }
}
