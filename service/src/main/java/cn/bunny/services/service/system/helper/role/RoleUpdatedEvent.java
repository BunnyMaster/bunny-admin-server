package cn.bunny.services.service.system.helper.role;

import lombok.Getter;
import lombok.Setter;
import org.springframework.context.ApplicationEvent;

// 角色更新事件
@Getter
@Setter
public class RoleUpdatedEvent extends ApplicationEvent {
    private final Long roleId;

    public RoleUpdatedEvent(Object source, Long roleId) {
        super(source);
        this.roleId = roleId;
    }
}