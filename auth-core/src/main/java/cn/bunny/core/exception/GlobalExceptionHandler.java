package cn.bunny.core.exception;


import cn.bunny.domain.common.model.vo.result.Result;
import cn.bunny.domain.common.enums.ResultCodeEnum;
import cn.bunny.core.context.BaseContext;
import lombok.extern.slf4j.Slf4j;
import org.mybatis.spring.MyBatisSystemException;
import org.springframework.context.support.DefaultMessageSourceResolvable;
import org.springframework.security.authorization.AuthorizationDeniedException;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.nio.file.AccessDeniedException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

/**
 * 全局异常拦截器
 */
@RestControllerAdvice
@Slf4j
public class GlobalExceptionHandler {
    // 自定义异常信息
    @ExceptionHandler(AuthCustomerException.class)
    @ResponseBody
    public Result<Object> exceptionHandler(AuthCustomerException exception) {
        Integer code = exception.getCode() != null ? exception.getCode() : 500;
        return Result.error(null, code, exception.getMessage());
    }

    // 运行时异常信息
    @ExceptionHandler(RuntimeException.class)
    @ResponseBody
    public Result<Object> exceptionHandler(RuntimeException exception) {
        String message = exception.getMessage();
        message = StringUtils.hasText(message) ? message : "服务器异常";
        exception.printStackTrace();

        // 解析异常
        String jsonParseError = "JSON parse error (.*)";
        Matcher jsonParseErrorMatcher = Pattern.compile(jsonParseError).matcher(message);
        if (jsonParseErrorMatcher.find()) {
            return Result.error(null, 500, "JSON解析异常 " + jsonParseErrorMatcher.group(1));
        }

        // 数据过大
        String dataTooLongError = "Data too long for column (.*?) at row 1";
        Matcher dataTooLongErrorMatcher = Pattern.compile(dataTooLongError).matcher(message);
        if (dataTooLongErrorMatcher.find()) {
            return Result.error(null, 500, dataTooLongErrorMatcher.group(1) + " 字段数据过大");
        }

        // 主键冲突
        String primaryKeyError = "Duplicate entry '(.*?)' for key .*";
        Matcher primaryKeyErrorMatcher = Pattern.compile(primaryKeyError).matcher(message);
        if (primaryKeyErrorMatcher.find()) {
            return Result.error(null, 500, "[" + primaryKeyErrorMatcher.group(1) + "]已存在");
        }

        // corn表达式错误
        String cronExpression = "CronExpression '(.*?)' is invalid";
        Matcher cronExpressionMatcher = Pattern.compile(cronExpression).matcher(message);
        if (cronExpressionMatcher.find()) {
            return Result.error(null, 500, "表达式 " + cronExpressionMatcher.group(1) + " 不合法");
        }

        if (exception instanceof MyBatisSystemException) {
            return Result.error(null, 500, "数据库异常");
        }

        log.error("GlobalExceptionHandler===>运行时异常信息：{}", message);
        return Result.error(null, 500, message);
    }

    // 表单验证字段
    @ExceptionHandler(MethodArgumentNotValidException.class)
    public Result<String> handleValidationExceptions(MethodArgumentNotValidException ex) {
        log.error("表单验证失败，用户Id：{}", BaseContext.getUserId());
        String errorMessage = ex.getBindingResult().getFieldErrors().stream()
                .map(DefaultMessageSourceResolvable::getDefaultMessage)
                .collect(Collectors.joining(", "));
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

        return Result.error(ResultCodeEnum.FAIL_NO_ACCESS_DENIED);
    }

    // spring security异常
    @ExceptionHandler(AuthorizationDeniedException.class)
    @ResponseBody
    public Result<String> error(AuthorizationDeniedException exception) throws AccessDeniedException {
        log.warn("AuthorizationDeniedException===>spring security异常：{}", exception.getMessage());

        return Result.error(ResultCodeEnum.FAIL_NO_ACCESS_DENIED);
    }

    // 处理SQL异常
    @ExceptionHandler(SQLIntegrityConstraintViolationException.class)
    @ResponseBody
    public Result<String> exceptionHandler(SQLIntegrityConstraintViolationException exception) {
        log.error("GlobalExceptionHandler===>处理SQL异常:{}", exception.getMessage());

        String message = exception.getMessage();
        if (message.contains("Duplicate entry")) {
            // 错误信息
            return Result.error(ResultCodeEnum.USER_IS_EMPTY);
        } else {
            return Result.error(ResultCodeEnum.UNKNOWN_EXCEPTION);
        }
    }
}
