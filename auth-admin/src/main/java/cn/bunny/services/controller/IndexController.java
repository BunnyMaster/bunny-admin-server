package cn.bunny.services.controller;

import cn.hutool.captcha.CaptchaUtil;
import cn.hutool.captcha.CircleCaptcha;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Tag(name = "访问首页内容", description = "访问首页内容相关接口")
@Controller
@RequestMapping("/")
public class IndexController {

    @Operation(summary = "访问首页", description = "访问首页")
    @GetMapping("")
    public String index() {
        return "index";
    }

    @Operation(summary = "生成验证码", description = "生成验证码")
    @GetMapping("public/checkCode")
    public ResponseEntity<byte[]> checkCode() {
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.IMAGE_JPEG);

        // 生成验证码
        CircleCaptcha captcha = CaptchaUtil.createCircleCaptcha(150, 48, 4, 2);
        byte[] image = captcha.getImageBytes();

        return new ResponseEntity<>(image, headers, HttpStatus.OK);
    }

}