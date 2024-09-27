package cn.bunny.dao.pojo.constant;

import lombok.Data;


@Data
public class ExceptionConstant {
    public static final String UNKNOWN_EXCEPTION = "未知错误";

    // 用户相关
    public static final String USER_NOT_LOGIN_EXCEPTION = "用户未登录";
    public static final String USERNAME_IS_EMPTY_EXCEPTION = "用户名不能为空";
    public static final String ALREADY_USER_EXCEPTION = "用户已存在";
    public static final String USER_NOT_FOUND_EXCEPTION = "用户不存在";

    // 密码相关
    public static final String PASSWORD_EXCEPTION = "密码错误";
    public static final String PASSWORD_NOT_EMPTY_EXCEPTION = "密码不能为空";
    public static final String OLD_PASSWORD_EXCEPTION = "旧密码不匹配";
    public static final String PASSWORD_EDIT_EXCEPTION = "密码修改失败";
    public static final String OLD_PASSWORD_SAME_NEW_PASSWORD_EXCEPTION = "旧密码与新密码相同";
}