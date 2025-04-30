package cn.bunny;

import cn.hutool.crypto.digest.MD5;
import org.junit.jupiter.api.Test;

public class TimeTest {
    @Test
    void timeTest() {
        long currentTimeMillis = System.currentTimeMillis();
        String digestHex = MD5.create().digestHex(currentTimeMillis + "");
        System.out.println(currentTimeMillis);
        System.out.println(digestHex);
    }
}
