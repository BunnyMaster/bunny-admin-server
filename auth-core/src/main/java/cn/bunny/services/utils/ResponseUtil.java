package cn.bunny.services.utils;

import cn.bunny.services.domain.common.model.vo.result.Result;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;

import java.io.IOException;

public class ResponseUtil {

    public static void out(HttpServletResponse response, Result<Object> result) {
        try {
            ObjectMapper mapper = new ObjectMapper();

            // 注册JavaTimeModule模块
            mapper.registerModule(new JavaTimeModule());
            response.setContentType("application/json;charset=UTF-8");
            response.setStatus(HttpStatus.OK.value());
            mapper.writeValue(response.getWriter(), result);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}