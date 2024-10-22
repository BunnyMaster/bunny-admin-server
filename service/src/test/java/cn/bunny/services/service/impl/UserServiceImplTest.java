package cn.bunny.services.service.impl;

import org.junit.jupiter.api.Test;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

class UserServiceImplTest {

    @Test
    void updateAdminUserByLocalUser() {
        String url1 = "http://192.168.3.98:9000/auth-admin/avatar/2024/10-22/a9f1794e-610a-471d-8f4f-75c8c738ef46";

        String regex = "https?://.*?/(.*)";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(url1);
        if (matcher.matches()) {
            System.out.println(matcher.group(1));
        }
    }
}