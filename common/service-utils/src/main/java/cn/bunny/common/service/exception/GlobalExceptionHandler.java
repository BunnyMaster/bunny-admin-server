package cn.bunny.common.service.exception;


import cn.bunny.dao.pojo.constant.ExceptionConstant;
import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import lombok.extern.slf4j.Slf4j;
import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.io.FileNotFoundException;
import java.nio.file.AccessDeniedException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {
    // 自定义异常信息
    @ExceptionHandler(BunnyException.class)
    @ResponseBody
    public Result<Object> exceptionHandler(BunnyException exception) {
        log.error("GlobalExceptionHandler===>自定义异常信息：{}", exception.getMessage());

        Integer code = exception.getCode() != null ? exception.getCode() : 500;
        return Result.error(null, code, exception.getMessage());
    }

    // 运行时异常信息
    @ExceptionHandler(RuntimeException.class)
    @ResponseBody
    public Result<Object> exceptionHandler(RuntimeException exception) throws FileNotFoundException {
        log.error("GlobalExceptionHandler===>运行时异常信息：{}", exception.getMessage());
        exception.printStackTrace();
        return Result.error(null, 500, "出错了");
    }

    // 捕获系统异常
    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Result<Object> error(Exception exception) {
        log.error("捕获系统异常：{}", exception.getMessage());
        log.error("GlobalExceptionHandler===>系统异常信息：{}", (Object) exception.getStackTrace());

        // 错误消息
        String message = exception.getMessage();

        // 匹配到内容
        String patternString = "Request method '(\\w+)' is not supported";
        Matcher matcher = Pattern.compile(patternString).matcher(message);
        if (matcher.find()) return Result.error(null, 500, "请求方法错误，不是 " + matcher.group(1));

        // 请求API不存在
        String noStaticResource = "No static resource (.*)\\.";
        Matcher noStaticResourceMatcher = Pattern.compile(noStaticResource).matcher(message);
        if (noStaticResourceMatcher.find())
            return Result.error(null, 500, "请求API不存在 " + noStaticResourceMatcher.group(1));

        // 返回错误内容
        return Result.error(null, 500, "系统异常");
    }

    // 表单验证字段
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Result<String> handleValidationExceptions(MethodArgumentNotValidException ex) {
        log.error("表单验证失败：{}", ex.getMessage());
        String errorMessage = ex.getBindingResult().getFieldErrors().stream().map(DefaultMessageSourceResolvable::getDefaultMessage).collect(Collectors.joining(", "));
        return Result.error(null, 201, errorMessage);
    }

    // 特定异常处理
    @ExceptionHandler(ArithmeticException.class)
    @ResponseBody
    public Result<Object> error(ArithmeticException exception) {
        log.error("GlobalExceptionHandler===>特定异常信息：{}", exception.getMessage());

        return Result.error(null, 500, exception.getMessage());
    }

    // spring security异常
    @ExceptionHandler(AccessDeniedException.class)
    @ResponseBody
    public Result<String> error(AccessDeniedException exception) throws AccessDeniedException {
        log.error("GlobalExceptionHandler===>spring security异常：{}", exception.getMessage());

        return Result.error(ResultCodeEnum.SERVICE_ERROR);
    }

    // 处理SQL异常
    @ExceptionHandler(SQLIntegrityConstraintViolationException.class)
    @ResponseBody
    public Result<String> exceptionHandler(SQLIntegrityConstraintViolationException exception) {
        log.error("GlobalExceptionHandler===>处理SQL异常:{}", exception.getMessage());

        String message = exception.getMessage();
        if (message.contains("Duplicate entry")) {
            // 截取用户名
            String username = message.split(" ")[2];
            // 错误信息
            String errorMessage = username + ExceptionConstant.ALREADY_USER_EXCEPTION;
            return Result.error(errorMessage);
        } else {
            return Result.error(ExceptionConstant.UNKNOWN_EXCEPTION);
        }
    }
}
