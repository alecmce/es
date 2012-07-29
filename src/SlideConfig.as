package
{
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.graphics.Brush;

    import org.swiftsuspenders.Injector;

    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;

    import talk.data.Selected;

    import talk.data.Slide;
    import talk.data.SlideImage;
    import talk.data.SlideText;
    import talk.data.Slides;
    import talk.signals.GotoSlide;
    import talk.view.ButtonsMediator;
    import talk.view.ButtonsView;

    public class SlideConfig
    {
        [Embed(source="../assets/rotmg.png", mimeType="image/png")]
        public static const RotmgAsset:Class;

        [Inject]
        public var injector:Injector;

        [Inject]
        public var mediatorMap:IMediatorMap;

        [Inject]
        public var layers:Layers;

        [Inject]
        public var entities:Entities;

        private var brush:Brush;
        private var slides:Slides;
        private var list:Vector.<Slide>;

        public function SlideConfig()
        {
            list = new <Slide>[];
        }

        [PostConstruct]
        public function setup():void
        {
            makeBrush();
            makeSlides();
            makeSlideEntities();
            selectFirstSlide();
            makeButtons();
        }

        private function makeBrush():void
        {
            brush = new Brush();
            brush.width = 2;
            brush.rgb = 0x000000;
            brush.alpha = 1;
        }

        private function makeSlides():void
        {
            var title:Slide = makeFirstSlide();
            var rotmg:Slide = makeRealmSlide();
            var second:Slide = makeSecondSlide();

            title.addTarget("rotmg", rotmg);
            title.addTarget("second", second);

            rotmg.addTarget("title", title);

            slides = new Slides();
            slides.current = title;
            injector.map(Slides).toValue(slides);
        }

        private function makeSlide(x:int, y:int):Slide
        {
            var slide:Slide = new Slide();
            slide.x = x * 800;
            slide.y = y * 600;
            slide.width = 800;
            slide.height = 600;
            slide.padding = 5;
            slide.border = brush;
            list.push(slide);
            return slide;
        }

        private function makeSlideEntities():void
        {
            for each (var slide:Slide in list)
            {
                var entity:Entity = new Entity();
                entity.add(slide);
                entity.add(slides);
                slide.entity = entity;
                entities.addEntity(entity);
            }
        }

        private function makeFirstSlide():Slide
        {
            var slide:Slide = makeSlide(0, 0);
            slide.setTitle(20, 20, "Entity Systems");
            slide.addPoint(20, 200, "github.com/alecmce/es");
            slide.addPoint(20, 280, "@alecmce");
            return slide;
        }

        private function makeRealmSlide():Slide
        {
            var slide:Slide = makeSlide(0, 1);
            slide.setTitle(45, 25, "Realm of the Mad God");
            slide.addImage(121, 150, new RotmgAsset().bitmapData);
            return slide;
        }

        private function makeSecondSlide():Slide
        {
            var slide:Slide = makeSlide(1, 0);
            slide.setTitle(20, 20, "Second Slide");
            slide.addPoint(20, 200, "This is the first point of a new slide");
            slide.addPoint(20, 280, "It's a brave new world!");
            return slide;
        }

        private function selectFirstSlide():void
        {
            slides.current.entity.add(new Selected());
        }

        private function makeButtons():void
        {
            mediatorMap.map(ButtonsView).toMediator(ButtonsMediator);

            var view:ButtonsView = new ButtonsView();
            layers.dialog.addChild(view);
        }
    }
}
