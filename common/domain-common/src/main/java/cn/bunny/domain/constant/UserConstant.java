package cn.bunny.domain.constant;

import lombok.Data;

import java.util.List;

@Data
public class UserConstant {
    public static final String USER_AVATAR = "https://thirdwx.qlogo.cn/mmopen/vi_32/DYAIOgq83eoj0hHXhgJNOTSOFsS4uZs8x1ConecaVOB8eIl115xmJZcT4oCicvia7wMEufibKtTLqiaJeanU2Lpg3w/132";
    public static final String PERSON_DESCRIPTION = "这个人很懒没有介绍...";
    public static final List<String> allAuths = List.of("*::*::*", "*::*", "*");
}
