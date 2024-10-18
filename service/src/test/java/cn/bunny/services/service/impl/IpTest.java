package cn.bunny.services.service.impl;

import cn.bunny.common.service.utils.ip.IpUtil;
import org.junit.jupiter.api.Test;

public class IpTest {
    @Test
    void ipTest() {
        String ip = "58.214.13.154";
        System.out.println(IpUtil.getIpRegion(ip));
    }
}
