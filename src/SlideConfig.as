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
            var intro:Slide = makeIntroSlide();
            var rotmg:Slide = makeRealmSlide();
            var structure:Slide = makeStructureSlide();
            var invaders:Slide = makeInvadersSlide();
            var robotlegs:Slide = makeRobotlegsSlide();
            var games:Slide = makeGamesSlide();
            var rethink:Slide = makeRethinkingStructureSlide();
            var entities:Slide = makeEntitySystemsSlide();

            intro.addSlideTarget("rotmg", rotmg, 0x0099FF);
            intro.addSlideTarget("structure", structure);
            intro.addActionTarget("invaders");

            rotmg.addSlideTarget("intro", intro);

            structure.addSlideTarget("intro", intro, 0xFF6666);
            structure.addSlideTarget("invaders", invaders);

            invaders.addSlideTarget("structure", structure, 0xFF6666);
            invaders.addSlideTarget("robotlegs", robotlegs);

            robotlegs.addSlideTarget("invaders", invaders, 0xFF6666);
            robotlegs.addSlideTarget("games", games);

            games.addSlideTarget("robotlegs", robotlegs, 0xFF6666);
            games.addSlideTarget("rethink", rethink);

            rethink.addSlideTarget("games", games, 0xFF6666);
            rethink.addSlideTarget("entities", entities);

            entities.addSlideTarget("rethink", rethink,  0xFF6666);

            slides = new Slides();
            slides.current = intro;
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

        private function makeIntroSlide():Slide
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

        private function makeStructureSlide():Slide
        {
            var slide:Slide = makeSlide(1, 0);
            slide.setTitle(20, 20, "Seeking Structure");
            slide.addPoint(20, 200, "Everyone models reality");
            slide.addPoint(20, 280, "Developers write it down");
            return slide;
        }

        private function makeInvadersSlide():Slide
        {
            var slide:Slide = makeSlide(2, 0);
            slide.setTitle(20, 20, "Space Invaders");
            return slide;
        }

        private function makeRobotlegsSlide():Slide
        {
            var slide:Slide = makeSlide(3, 0);
            slide.setTitle(20, 20, "RobotLegs");
            return slide;
        }

        private function makeGamesSlide():Slide
        {
            var slide:Slide = makeSlide(3, 1);
            slide.setTitle(20, 20, "RobotLegs and Games");
            slide.addPoint(20, 200, "From RIAs to games")
            return slide;
        }

        private function makeRethinkingStructureSlide():Slide
        {
            var slide:Slide = makeSlide(4, 0);
            slide.setTitle(20, 20, "Rethinking Structure");
            return slide;
        }

        private function makeEntitySystemsSlide():Slide
        {
            var slide:Slide = makeSlide(5, 0);
            slide.setTitle(20, 20, "Entity Systems");
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
