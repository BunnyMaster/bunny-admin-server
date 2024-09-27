package cn.bunny.common.service.config;

import cn.bunny.common.service.context.BaseContext;
import com.baomidou.mybatisplus.core.handlers.MetaObjectHandler;
import org.apache.ibatis.reflection.MetaObject;
import org.springframework.stereotype.Component;

import java.util.Date;

/**
 * 配置MP在修改和新增时的操作
 */
@Component
public class MyBatisPlusFieldConfig implements MetaObjectHandler {

    /**
     * 使用mp做添加操作时候，这个方法执行
     */
    @Override
    public void insertFill(MetaObject metaObject) {
        // 设置属性值
        this.strictInsertFill(metaObject, "isDeleted", Integer.class, 0);
        this.setFieldValByName("createTime", new Date(), metaObject);
        this.setFieldValByName("updateTime", new Date(), metaObject);
        if (BaseContext.getUsername() != null) {
            this.setFieldValByName("createUser", BaseContext.getUsername(), metaObject);
            this.setFieldValByName("updateUser", BaseContext.getUsername(), metaObject);
        }
    }

    /**
     * 使用mp做修改操作时候，这个方法执行
     */
    @Override
    public void updateFill(MetaObject metaObject) {
        if (BaseContext.getUserId() != null) {
            this.setFieldValByName("updateTime", new Date(), metaObject);
            this.setFieldValByName("updateUser", BaseContext.getUsername(), metaObject);
        }
    }
}
