package cn.bunny.services.core.event.event;

import lombok.Getter;
import lombok.Setter;
import org.springframework.context.ApplicationEvent;

import java.util.List;

@Getter
@Setter
public class UpdateUserinfoByPermissionIdsEvent extends ApplicationEvent {
    private final List<Long> permissionIds;

    public UpdateUserinfoByPermissionIdsEvent(Object source, List<Long> permissionIds) {
        super(source);
        this.permissionIds = permissionIds;
    }
}
