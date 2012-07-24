package alecmce.console.view
{
    import alecmce.console.signals.RemoveConsole;

    import flash.events.Event;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    import robotlegs.bender.bundles.mvcs.Mediator;

    public class ConsoleMediator extends Mediator
    {
        [Inject]
        public var view:ConsoleView;

        [Inject]
        public var remove:RemoveConsole;

        override public function initialize():void
        {
            remove.add(onRemoveConsole);
            view.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        }

        override public function destroy():void
        {
            remove.remove(onRemoveConsole);
            view.stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        }

        private function onRemoveConsole():void
        {
            view.parent.removeChild(view);
        }

        private function onKeyDown(event:KeyboardEvent):void
        {
            if (event.keyCode == Keyboard.TAB)
            {
                view.visible = !view.visible;
                if (view.visible)
                    view.stage.focus = view.input;
            }
        }

        override protected function dispatch(event:Event):void
        {
            super.dispatch(event);
        }
    }
}
