package alecmce.resizing
{
    import robotlegs.bender.extensions.mediatorMap.MediatorMapExtension;
    import robotlegs.bender.framework.api.IContext;
    import robotlegs.bender.framework.api.IExtension;

    public class ResizeExtension implements IExtension
    {
        public function extend(context:IContext):void
        {
            context.extend(MediatorMapExtension);
            context.configure(ResizeConfig);
        }
    }
}
