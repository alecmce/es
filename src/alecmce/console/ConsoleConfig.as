package alecmce.console
{
    import alecmce.console.controller.AddDefaultConsoleActionsCommand;
    import alecmce.console.controller.ListActionsCommand;
    import alecmce.console.controller.RegisterConsoleActionCommand;
    import alecmce.console.model.ConsoleModel;
    import alecmce.console.signals.AddDefaultConsoleActions;
    import alecmce.console.signals.ClearConsole;
    import alecmce.console.signals.ConsoleLog;
    import alecmce.console.signals.ListActions;
    import alecmce.console.signals.RegisterConsoleAction;
    import alecmce.console.signals.RemoveConsole;
    import alecmce.console.view.ConsoleInputMediator;
    import alecmce.console.view.ConsoleInputView;
    import alecmce.console.view.ConsoleMediator;
    import alecmce.console.view.ConsoleOutputMediator;
    import alecmce.console.view.ConsoleOutputView;
    import alecmce.console.view.ConsoleView;

    import flash.display.DisplayObjectContainer;

    import org.swiftsuspenders.Injector;

    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;
    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;

    public class ConsoleConfig
    {
        [Inject]
        public var injector:Injector;

        [Inject]
        public var mediatorMap:IMediatorMap;

        [Inject]
        public var commandMap:ISignalCommandMap;

        [Inject]
        public var contextView:DisplayObjectContainer;

        [PostConstruct]
        public function setup():void
        {
            mapModel();
            mapCommands();
            mapViewSignals();
            mapMediators();

            injector.getInstance(AddDefaultConsoleActions).dispatch();
        }

        private function mapModel():void
        {
            injector.map(ConsoleModel).asSingleton();
            injector.map(ConsoleLog).asSingleton();
            injector.map(RemoveConsole).asSingleton();
        }

        private function mapCommands():void
        {
            commandMap.map(RegisterConsoleAction).toCommand(RegisterConsoleActionCommand);
            commandMap.map(ListActions).toCommand(ListActionsCommand);
            commandMap.map(AddDefaultConsoleActions).toCommand(AddDefaultConsoleActionsCommand);
        }

        private function mapViewSignals():void
        {
            injector.map(ClearConsole).asSingleton();
        }

        private function mapMediators():void
        {
            mediatorMap.map(ConsoleInputView).toMediator(ConsoleInputMediator);
            mediatorMap.map(ConsoleOutputView).toMediator(ConsoleOutputMediator);
            mediatorMap.map(ConsoleView).toMediator(ConsoleMediator);
        }
    }
}
