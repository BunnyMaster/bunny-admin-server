package cn.bunny.services.core.event.event;

import lombok.Getter;
import lombok.Setter;
import org.springframework.context.ApplicationEvent;

import java.util.List;

@Getter
@Setter
public class UpdateUserinfoByRoleIdsEvent extends ApplicationEvent {
    private final List<Long> roleIds;

    public UpdateUserinfoByRoleIdsEvent(Object source, List<Long> roleIds) {
        super(source);
        this.roleIds = roleIds;
    }
}