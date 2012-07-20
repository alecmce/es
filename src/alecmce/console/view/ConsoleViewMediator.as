package alecmce.console.view
{
    import alecmce.console.signals.RemoveConsole;
    import alecmce.console.signals.ResizeConsole;
    import alecmce.console.view.components.ConsoleView;

    import flash.geom.Rectangle;

    import robotlegs.bender.bundles.mvcs.Mediator;

    public class ConsoleViewMediator extends Mediator
    {
        [Inject]
        public var view:ConsoleView;

        [Inject]
        public var remove:RemoveConsole;

        [Inject]
        public var resize:ResizeConsole;

        override public function initialize():void
        {
            remove.add(onRemoveConsole);
            resize.add(onResizeConsole);
        }

        override public function destroy():void
        {
            remove.remove(onRemoveConsole);
            resize.remove(onResizeConsole);
        }

        private function onRemoveConsole():void
        {
            view.parent.removeChild(view);
        }

        private function onResizeConsole(rectangle:Rectangle):void
        {
            view.resize(rectangle);
        }
    }
}
