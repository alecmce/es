package
{
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.graphics.Brush;

    import org.swiftsuspenders.Injector;

    import talk.data.Selected;

    import talk.data.Slide;
    import talk.data.SlideText;
    import talk.data.Slides;

    public class TempConfig
    {
        [Inject]
        public var injector:Injector;

        [Inject]
        public var entities:Entities;

        private var slides:Slides;

        [PostConstruct]
        public function setup():void
        {
            makeSlides();
            makeSlideEntities();
            selectFirstSlide();

            injector.map(Slides).toValue(slides);
        }

        private function makeSlides():void
        {
            slides = new Slides();
            slides.index = 0;
            slides.list = new <Slide>[makeFirstSlide(), makeSecondSlide()];
        }

        private function makeSlideEntities():void
        {
            for each (var slide:Slide in slides.list)
            {
                var entity:Entity = new Entity();
                entity.add(slide);
                entity.add(slides);
                slide.entity = entity;
                entities.addEntity(entity);
            }
        }

        private function selectFirstSlide():void
        {
            slides.list[0].entity.add(new Selected());
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
