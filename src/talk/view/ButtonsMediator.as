package talk.view
{
    import alecmce.entitysystem.framework.Entities;

    import robotlegs.bender.bundles.mvcs.Mediator;

    import talk.data.Slide;
    import talk.data.SlideTarget;
    import talk.data.Slides;

    import talk.signals.GotoSlide;

    public class ButtonsMediator extends Mediator
    {
        [Inject]
        public var view:ButtonsView;

        [Inject]
        public var slides:Slides;

        [Inject]
        public var gotoSlide:GotoSlide;

        override public function initialize():void
        {
            view.selected.add(onSelected);
            updateTargets();
        }

        override public function destroy():void
        {
            view.selected.remove(onSelected);
        }

        private function onSelected(name:String):void
        {
            view.clear();
            gotoSlide.dispatch(name);
            updateTargets();
        }

        private function updateTargets():void
        {
            view.setTargets(slides.current.targets);
        }
    }
}
