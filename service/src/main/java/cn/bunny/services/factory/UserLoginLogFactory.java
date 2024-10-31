package cn.bunny.services.factory;

import cn.bunny.dao.pojo.result.PageResult;
import cn.bunny.dao.vo.log.UserLoginLogVo;
import com.baomidou.mybatisplus.core.metadata.IPage;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class UserLoginLogFactory {

    /**
     * 用户登录日志分页查询通用方法
     *
     * @param page 分页结果
     * @return 分页用户登录日志
     */
    public PageResult<UserLoginLogVo> getUserLoginLogVoPageResult(IPage<UserLoginLogVo> page) {
        List<UserLoginLogVo> voList = page.getRecords().stream().map(userLoginLog -> {
            UserLoginLogVo userLoginLogVo = new UserLoginLogVo();
            BeanUtils.copyProperties(userLoginLog, userLoginLogVo);
            return userLoginLogVo;
        }).toList();

        return PageResult.<UserLoginLogVo>builder()
                .list(voList)
                .pageNo(page.getCurrent())
                .pageSize(page.getSize())
                .total(page.getTotal())
                .build();
    }
}
