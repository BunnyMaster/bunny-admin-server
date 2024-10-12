package cn.bunny.services.service.impl;

import org.junit.jupiter.api.Test;

class FilesServiceImplTest {
    @Test
    void stringTest() {
        String filepath = "/auth-admin/avatar/2024/10-04/5a56ad8f-4468-4780-8a61-424e7de54e04.png";
        int end = filepath.indexOf("/", 1);

        filepath = filepath.substring(end + 1);
        System.out.println(filepath);
    }

}