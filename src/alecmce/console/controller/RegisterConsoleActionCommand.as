package alecmce.console.controller
{
    import alecmce.console.model.Console;
    import alecmce.console.vo.ConsoleAction;

    import org.osflash.signals.Signal;

    public class RegisterConsoleActionCommand
    {
        [Inject]
        public var console:Console;

        [Inject]
        public var action:ConsoleAction;

        [Inject]
        public var trigger:Signal;

        public function execute():void
        {
            console.register(action, trigger);
        }
    }
}
