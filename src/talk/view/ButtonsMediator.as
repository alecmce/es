package talk.view
{
    import alecmce.console.model.Console;

    import flash.events.Event;

    import robotlegs.bender.bundles.mvcs.Mediator;

    import talk.data.ActionTarget;

    import talk.data.SlideTarget;
    import talk.data.Slides;
    import talk.data.Target;
    import talk.signals.GotoSlide;

    public class ButtonsMediator extends Mediator
    {
        [Inject]
        public var view:ButtonsView;

        [Inject]
        public var slides:Slides;

        [Inject]
        public var gotoSlide:GotoSlide;

        [Inject]
        public var console:Console;

        override public function initialize():void
        {
            view.selected.add(onSelected);
            gotoSlide.add(onGotoSlide);
            updateTargets();
        }

        override public function destroy():void
        {
            view.selected.remove(onSelected);
            gotoSlide.remove(onGotoSlide);
        }

        private function onSelected(target:Target):void
        {
            view.clear();

            //FIXME this is shit
            if (target is SlideTarget)
            {
                gotoSlide.remove(onGotoSlide);
                gotoSlide.dispatch(target.getName());
                gotoSlide.add(onGotoSlide);
            }
            else if (target is ActionTarget)
            {
                console.execute(target.getName());
            }

            updateTargets();
        }

        private function onGotoSlide(name:String):void
        {
            view.clear();

            //FIXME disgusting hack
            view.addEventListener(Event.ENTER_FRAME, waitAFrame);
        }

        private function waitAFrame(event:Event):void
        {
            view.removeEventListener(Event.ENTER_FRAME, waitAFrame);
            updateTargets();
        }

        private function updateTargets():void
        {
            view.setTargets(slides.current.targets);
        }
    }
}
