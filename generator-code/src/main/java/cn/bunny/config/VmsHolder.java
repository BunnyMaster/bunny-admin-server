package cn.bunny.config;

import jakarta.annotation.PostConstruct;
import org.apache.velocity.app.Velocity;
import org.springframework.stereotype.Component;

import java.util.Properties;

@Component
public class VmsHolder {

    @PostConstruct
    public void init() {
        Properties prop = new Properties();
        prop.put("file.resource.loader.class" , "org.apache.velocity.runtime.resource.loader.ClasspathResourceLoader" );
        Velocity.init(prop);
    }
}
