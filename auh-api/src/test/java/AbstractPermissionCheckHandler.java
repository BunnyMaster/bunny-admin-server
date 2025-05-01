public abstract class AbstractPermissionCheckHandler {

    private AbstractPermissionCheckHandler abstractPermissionCheckHandler;

    public AbstractPermissionCheckHandler(AbstractPermissionCheckHandler abstractPermissionCheckHandler) {
        this.abstractPermissionCheckHandler = abstractPermissionCheckHandler;
    }

    abstract protected void checkPermission(String requestUrl);
}
