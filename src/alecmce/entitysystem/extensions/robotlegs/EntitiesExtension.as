package alecmce.entitysystem.extensions.robotlegs
{
    import robotlegs.bender.framework.api.IContext;
    import robotlegs.bender.framework.api.IExtension;

    public class EntitiesExtension implements IExtension
    {
        public function extend(context:IContext):void
        {
            context.configure(EntitiesConfig);
        }
    }
}
