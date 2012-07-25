package alecmce.console.controller
{
    import alecmce.console.signals.ClearConsole;
    import alecmce.console.signals.ListActions;
    import alecmce.console.signals.RegisterConsoleAction;
    import alecmce.console.signals.RemoveConsole;
    import alecmce.console.vo.ConsoleAction;

    public class AddDefaultConsoleActionsCommand
    {
        [Inject]
        public var register:RegisterConsoleAction;

        [Inject]
        public var listActions:ListActions;

        [Inject]
        public var clearConsole:ClearConsole;

        [Inject]
        public var removeConsole:RemoveConsole;

        public function execute():void
        {
            var list:ConsoleAction = new ConsoleAction();
            list.name = "list";
            list.description = "lists available console commands";

            var clear:ConsoleAction = new ConsoleAction();
            clear.name = "clear";
            clear.description = "clears the console";

            var exit:ConsoleAction = new ConsoleAction();
            exit.name = "exit";
            exit.description = "closes the console";

            register.dispatch(list, listActions);
            register.dispatch(clear, clearConsole);
            register.dispatch(exit, removeConsole);
        }
    }
}
