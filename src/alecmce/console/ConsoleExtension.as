package alecmce.console
{
    import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
    import robotlegs.bender.framework.api.IContext;
    import robotlegs.bender.framework.api.IExtension;

    public class ConsoleExtension implements IExtension
    {
        public function extend(context:IContext):void
        {
            context.extend(SignalCommandMapExtension);
            context.configure(ConsoleConfig);
        }
    }
}
