package
{
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
            slide.title = title;
            slide.points = new <SlideText>[first, second];

            var slides:Slides = new Slides();
            slides.index = 0;
            slides.slides = new <Slide>[slide];

            injector.map(Slides).toValue(slides);
        }
    }
}
