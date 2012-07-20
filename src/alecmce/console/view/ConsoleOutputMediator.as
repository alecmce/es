package alecmce.console.view
{
    import alecmce.console.signals.ConsoleLog;
    import alecmce.console.view.components.ConsoleOutput;

    import robotlegs.bender.bundles.mvcs.Mediator;

    final public class ConsoleOutputMediator extends Mediator
    {
        [Inject]
        public var log:ConsoleLog;

        [Inject]
        public var view:ConsoleOutput;

        override public function initialize():void
        {
            log.add(onLog);
        }

        override public function destroy():void
        {
            log.remove(onLog);
        }

        private function onLog(data:String):void
        {
            view.log(data);
        }
    }
}
