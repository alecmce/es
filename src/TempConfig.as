package
{
    import alecmce.graphics.Brush;

    import org.swiftsuspenders.Injector;

    import talk.data.Slide;
    import talk.data.SlideText;
    import talk.data.Slides;

    public class TempConfig
    {
        [Inject]
        public var injector:Injector;

        [PostConstruct]
        public function setup():void
        {
            var slides:Slides = new Slides();
            slides.index = 0;
            slides.slides = new <Slide>[makeFirstSlide(), makeSecondSlide()];

            injector.map(Slides).toValue(slides);
        }

        private function makeFirstSlide():Slide
        {
            var title:SlideText = new SlideText();
            title.font = "title";
            title.x = 20;
            title.y = 20;
            title.text = "Hello World";

            var first:SlideText = new SlideText();
            first.font = "body";
            first.x = 20;
            first.y = 200;
            first.text = "This is a first bullet point";

            var second:SlideText = new SlideText();
            second.font = "body";
            second.x = 20;
            second.y = 280;
            second.text = "This is a second bullet point";

            var slide:Slide = new Slide();
            slide.x = 5;
            slide.y = 5;
            slide.width = 790;
            slide.height = 590;
            slide.border = new Brush();
            slide.border.width = 2;
            slide.border.rgb = 0x000000;
            slide.border.alpha = 1;
            slide.title = title;
            slide.points = new <SlideText>[first, second];
            return slide;
        }

        private function makeSecondSlide():Slide
        {
            var title:SlideText = new SlideText();
            title.font = "title";
            title.x = 20;
            title.y = 20;
            title.text = "Second Slide";

            var first:SlideText = new SlideText();
            first.font = "body";
            first.x = 20;
            first.y = 200;
            first.text = "This is the first point of a new slide";

            var second:SlideText = new SlideText();
            second.font = "body";
            second.x = 20;
            second.y = 280;
            second.text = "It's a brave new world!";

            var slide:Slide = new Slide();
            slide.x = 805;
            slide.y = 5;
            slide.width = 790;
            slide.height = 590;
            slide.border = new Brush();
            slide.border.width = 2;
            slide.border.rgb = 0x000000;
            slide.border.alpha = 1;
            slide.title = title;
            slide.points = new <SlideText>[first, second];

            return slide;
        }
    }
}
