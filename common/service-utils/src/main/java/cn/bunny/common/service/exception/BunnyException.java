package cn.bunny.common.service.exception;

import cn.bunny.dao.pojo.result.ResultCodeEnum;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;
import lombok.extern.slf4j.Slf4j;

@NoArgsConstructor
@Getter
@ToString
@Slf4j
public class BunnyException extends RuntimeException {
    Integer code;// 状态码
    String message;// 描述信息

    public BunnyException(Integer code, String message) {
        super(message);
        this.code = code;
        this.message = message;
    }

    public BunnyException(String message) {
        super(message);
        this.message = message;
    }

    public BunnyException(ResultCodeEnum codeEnum) {
        super(codeEnum.getMessage());
        this.code = codeEnum.getCode();
        this.message = codeEnum.getMessage();
    }
}
