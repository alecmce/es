package talk.commands
{
    import talk.data.Slide;
    import talk.data.Slides;
    import talk.signals.MakeSlideStep;

    public class StepSlideCommand
    {
        [Inject]
        public var slides:Slides;

        [Inject]
        public var makeSlideStep:MakeSlideStep;

        public function execute():void
        {
            var slide:Slide = slides.current;
            ++slide.step;
            makeSlideStep.dispatch(slide);
        }
    }
}
