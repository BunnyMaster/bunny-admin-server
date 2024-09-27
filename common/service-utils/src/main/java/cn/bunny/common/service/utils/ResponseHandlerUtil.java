package cn.bunny.common.service.utils;

import cn.bunny.dao.pojo.result.Result;
import cn.bunny.dao.pojo.result.ResultCodeEnum;
import jakarta.servlet.http.HttpServletResponse;

public class ResponseHandlerUtil {
    public static boolean loginAuthHandler(HttpServletResponse response, ResultCodeEnum loginAuth) {
        ResponseUtil.out(response, Result.error(loginAuth));
        return false;
    }
}
