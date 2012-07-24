package alecmce.console.view
{
    import alecmce.console.signals.ConsoleLog;

    import robotlegs.bender.bundles.mvcs.Mediator;

    final public class ConsoleOutputMediator extends Mediator
    {
        [Inject]
        public var log:ConsoleLog;

        [Inject]
        public var view:ConsoleOutputView;

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
