package cn.bunny.services.security.service.impl;

import org.junit.jupiter.api.Test;

class CustomAuthorizationManagerServiceImplTest {
    @Test
    void testRequestUrl() {
        String requestURI = "http://localhost:7000/api/user/noManage/getAdminUserList";
        System.out.println(requestURI.contains("noManage"));
    }
}