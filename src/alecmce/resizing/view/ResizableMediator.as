package alecmce.resizing.view
{
    import alecmce.resizing.signals.Resize;

    import flash.display.DisplayObject;
    import flash.display.Stage;
    import flash.geom.Rectangle;

    import robotlegs.bender.bundles.mvcs.Mediator;

    public class ResizableMediator extends Mediator
    {
        [Inject]
        public var view:Resizable;

        [Inject]
        public var resize:Resize;

        override public function initialize():void
        {
            trace(view + "is resizable!");
            var stage:Stage = (view as DisplayObject).stage;
            var rectangle:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);

            resize.add(onResize);
            view.resize(rectangle);
        }

        override public function destroy():void
        {
            resize.remove(onResize);
        }

        private function onResize(rectangle:Rectangle):void
        {
            view.resize(rectangle);
        }
    }
}
