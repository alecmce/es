package alecmce.console.controller
{
    import alecmce.console.model.ConsoleModel;
    import alecmce.console.signals.ConsoleLog;

    final public class ListActionsCommand
    {
        [Inject]
        public var console:ConsoleModel;

        [Inject]
        public var log:ConsoleLog;

        public function execute():void
        {
            var names:String = "  " + console.getNames().join("\r  ");
            log.dispatch(names);
        }
    }
}
