package cn.bunny.common.service.exception;

import cn.bunny.dao.vo.result.ResultCodeEnum;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@NoArgsConstructor
@Getter
@ToString
@Slf4j
public class AuthCustomerException extends RuntimeException {
    // 状态码
    Integer code;

    // 描述信息
    String message;

    // 返回结果状态
    ResultCodeEnum resultCodeEnum;


    public AuthCustomerException(Integer code, String message) {
        super(message);
        this.code = code;
        this.message = message;
    }

    public AuthCustomerException(String message) {
        super(message);
        this.message = message;
    }

    public AuthCustomerException(ResultCodeEnum codeEnum) {
        super(codeEnum.getMessage());
        this.code = codeEnum.getCode();
        this.message = codeEnum.getMessage();
        this.resultCodeEnum = codeEnum;
    }
}
