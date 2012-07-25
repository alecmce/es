package alecmce.console.view
{
    import alecmce.console.signals.ClearConsole;
    import alecmce.console.signals.ConsoleLog;

    import robotlegs.bender.bundles.mvcs.Mediator;

    final public class ConsoleOutputMediator extends Mediator
    {
        [Inject]
        public var log:ConsoleLog;

        [Inject]
        public var clear:ClearConsole;

        [Inject]
        public var view:ConsoleOutputView;

        override public function initialize():void
        {
            log.add(onLog);
            clear.add(onClear);
        }

        override public function destroy():void
        {
            log.remove(onLog);
            clear.remove(onClear);
        }

        private function onLog(data:String):void
        {
            view.log(data);
        }

        private function onClear():void
        {
            view.clear();
        }
    }
}
