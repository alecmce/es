package talk.view
{
    import flash.events.MouseEvent;

    import robotlegs.bender.bundles.mvcs.Mediator;

    import talk.signals.GotoSlide;

    public class SlideButtonMediator extends Mediator
    {
        [Inject]
        public var view:SlideButtonView;

        [Inject]
        public var gotoSlide:GotoSlide;

        override public function initialize():void
        {
            addViewListener(MouseEvent.CLICK, onClick);
        }

        override public function destroy():void
        {
            removeViewListener(MouseEvent.CLICK, onClick);
        }

        private function onClick(event:MouseEvent):void
        {
            gotoSlide.dispatch(view.getName());
        }
    }
}
