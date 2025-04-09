package cn.bunny;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.transaction.annotation.EnableTransactionManagement;

@EnableTransactionManagement
@SpringBootApplication
public class GeneratorCodeMainApplication {
    public static void main(String[] args) {
        SpringApplication.run(GeneratorCodeMainApplication.class, args);
    }
}
