package cn.bunny.services.controller;

import org.junit.jupiter.api.AfterEach;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.openqa.selenium.chrome.ChromeDriver;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.Duration;
import java.util.concurrent.TimeUnit;

@SpringBootTest
@AutoConfigureMockMvc
public class LoginTest {
    private ChromeDriver chromeDriver;

    @BeforeEach
    void setUpMockMvc() {
        chromeDriver = new ChromeDriver();
    }

    @AfterEach
    void tearDown() {
        chromeDriver.quit();
    }

    // 测试登录页面
    @Test
    // @WithMockUser(username = "Administrator", password = "admin123", roles = "admin")
    // @WithUserDetails("Administrator")
    void testLogin() throws InterruptedException {
        chromeDriver.get("http://localhost:7000/");
        TimeUnit.MINUTES.sleep(100);
        chromeDriver.manage().timeouts().implicitlyWait(Duration.of(1000L, TimeUnit.SECONDS.toChronoUnit()));
    }
}
