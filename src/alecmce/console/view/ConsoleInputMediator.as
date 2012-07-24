package alecmce.console.view
{
    import alecmce.console.model.ConsoleModel;
    import alecmce.console.signals.ConsoleLog;

    import robotlegs.bender.bundles.mvcs.Mediator;

    final public class ConsoleInputMediator extends Mediator
    {
        private static const ERROR_PATTERN:String = "[0xFF3333:error - \"${value}\" not found]";
        private static const ACTION_PATTERN:String = "[0xFFEE00:${value}]";

        [Inject]
        public var view:ConsoleInputView;

        [Inject]
        public var console:ConsoleModel;

        [Inject]
        public var log:ConsoleLog;

        override public function initialize():void
        {
            addViewListener(ConsoleEvent.INPUT, onInput, ConsoleEvent);
            addViewListener(ConsoleEvent.GET_PREVIOUS, onGetPrevious, ConsoleEvent);
            addViewListener(ConsoleEvent.GET_NEXT, onGetNext, ConsoleEvent);
        }

        override public function destroy():void
        {
            removeViewListener(ConsoleEvent.INPUT, onInput, ConsoleEvent);
            removeViewListener(ConsoleEvent.GET_PREVIOUS, onGetPrevious, ConsoleEvent);
            removeViewListener(ConsoleEvent.GET_NEXT, onGetNext, ConsoleEvent);
        }

        private function onInput(event:ConsoleEvent):void
        {
            var data:String = event.data;
            logInput(data);
            console.execute(data);
        }

        private function logInput(data:String):void
        {
            if (console.hasAction(data))
                logAction(data);
            else
                logError(data);
        }

        private function logAction(data:String):void
        {
            var split:Array = data.split(" ");
            split[0] = ACTION_PATTERN.replace("${value}", split[0]);
            log.dispatch(split.join(" "));
        }

        private function logError(data:String):void
        {
            var message:String = ERROR_PATTERN.replace("${value}", data);
            log.dispatch(message);
        }

        private function onGetPrevious(event:ConsoleEvent):void
        {
            view.text = console.getPreviousAction();
        }

        private function onGetNext(event:ConsoleEvent):void
        {
            view.text = console.getNextAction();
        }

    }
}
