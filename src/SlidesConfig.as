package
{
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.graphics.Brush;

    import flash.display.BitmapData;

    import org.swiftsuspenders.Injector;

    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;

    import talk.data.Selected;
    import talk.data.Slide;
    import talk.data.Slides;
    import talk.view.ButtonsMediator;
    import talk.view.ButtonsView;

    public class SlidesConfig
    {
        public static const WIDTH:int = 800;
        public static const HEIGHT:int = 600;
        public static const PADDING:int = 100;
        public static const INSET_OUTLINE:int = 5;

        [Embed(source="../assets/rotmg.png", mimeType="image/png")]
        public static const RotmgAsset:Class;

        [Embed(source="../assets/hegelquote.png", mimeType="image/png")]
        public static const HegelQuote:Class;

        [Embed(source="../assets/collisions.png", mimeType="image/png")]
        public static const CollisionsQuote:Class;

        [Embed(source="../assets/bobquote.png", mimeType="image/png")]
        public static const UncleBobQuote:Class;

        [Embed(source="../bin/videoLoader.swf")]
        public static const InvadersMovie:Class;

        [Embed(source="../assets/collisionsystem.png", mimeType="image/png")]
        public static const CollisionSystem:Class;

        [Embed(source="../assets/rendersystem.png", mimeType="image/png")]
        public static const RenderSystem:Class;

        [Embed(source="../assets/keyinputsystem.png", mimeType="image/png")]
        public static const KeyInputSystem:Class;

        [Embed(source="../assets/addingandremoving.png", mimeType="image/png")]
        public static const AddingAndRemoving:Class;

        [Embed(source="../assets/sticktennis.png", mimeType="image/png")]
        public static const StickTennisAsset:Class;

        [Embed(source="../assets/myvegas.png", mimeType="image/png")]
        public static const MyVegasAsset:Class;

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

        private var offsetX:int;
        private var offsetY:int;

        public function SlidesConfig()
        {
            list = new <Slide>[];
        }

        [PostConstruct]
        public function setup():void
        {
            offsetX = (layers.getSize().width - WIDTH) * .5;
            offsetY = (layers.getSize().height - HEIGHT) * .5;

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
            slides = new Slides();

            var list:Vector.<Slide> = makeAllSlides();
            for (var i:int = 0; i < list.length; i++)
            {
                var next:Slide = list[i];
                var prev:Slide = list[i == 0 ? list.length - 1 : i - 1];

                slides.addSlide(next);
                prev.addSlideTarget(next.name, next, 2, 0x66FF66);
                next.addSlideTarget(prev.name, prev, 1, 0xFF6666);
            }

            slides.current = list[0];
            injector.map(Slides).toValue(slides);
        }

        private function makeAllSlides():Vector.<Slide>
        {
            var intro:Slide = makeIntroSlide(0, 0, "intro");
            var rotmg:Slide = makeRealmSlide(1, 0, "rotmg");

            var structure:Slide = makeOopSlide(1, 1, "oop");
            var movie:Slide = makeMovieSlide(2, 1, "movie");
            var hegel:Slide = makeHegelQuoteSlide(3, 1, "hegel");
            var colliding:Slide = makeCollisionSlide(4, 1, "colliding");
            var bob:Slide = makeBobQuoteSlide(5, 1, "bob");

            var rethink:Slide = makeRethinkSlide(5, 2, "rethink");
            var systems:Slide = makeSystemsSlide(4, 2, "systems");
            var rendering:Slide = makeRenderSystemSlide(3, 2, "render");
            var collision:Slide = makeCollisionSystemSlide(2, 2, "collisions");
            var input:Slide = makeInputSlide(1, 2, "input");
            var adding:Slide = makeAddingAndRemoving(0, 2, "adding");

            return new <Slide>[intro, rotmg,
                               structure, movie,  hegel, colliding, bob,
                               rethink, systems, rendering, collision, input, adding];
        }

        private function makeIntroSlide(x:int, y:int, name:String):Slide
        {
            var slide:Slide = makeSlide(0, 0, name);
            slide.setTitle(20, 20, "Entity Systems");
            slide.addPoint(100, 200, "Alec McEachran");
            slide.addPoint(100, 280, "github.com/alecmce/es");
            slide.addPoint(100, 360, "@alecmce");
            slide.addAction("collapse");
            slide.addAction("rise");
            return slide;
        }

        private function makeRealmSlide(x:int, y:int, name:String):Slide
        {
            var rotmg:BitmapData = new RotmgAsset().bitmapData;

            var slide:Slide = makeSlide(0, 1, name);
            slide.setTitle(45, 25, "Realm of the Mad God");
            slide.addImage((WIDTH - rotmg.width) * 0.5, 150, rotmg);
            return slide;
        }

        private function makeOopSlide(x:int, y:int, name:String):Slide
        {
            var slide:Slide = makeSlide(x, y, name);
            slide.setTitle(20, 20, "The OOP Paradigm");
            slide.addPoint(100, 200, "Code like we think", 1);
            slide.addPoint(100, 280, "Structure is king", 2);
            slide.addPoint(100, 360, "Model View Controller", 3);
            slide.addAction("step");
            return slide;
        }

        private function makeMovieSlide(x:int, y:int, name:String):Slide
        {
            var slide:Slide = makeSlide(x, y, name);
            slide.addFlashElement(0, 0, new InvadersMovie());
            return slide;
        }

        private function makeHegelQuoteSlide(x:int, y:int, name:String):Slide
        {
            var hegel:BitmapData = new HegelQuote().bitmapData;

            var slide:Slide = makeSlide(x, y, name);
            slide.addImage((WIDTH - hegel.width) * 0.5, 200, hegel);
            slide.addPoint(100, 400, "When you say an object x is a thing P", 1, true);
            slide.addPoint(160, 450, "You're also saying that isn't Q", 1, true);
            slide.addAction("step");
            return slide;
        }

        private function makeCollisionSlide(x:int, y:int, name:String):Slide
        {
            var image:BitmapData = new CollisionsQuote().bitmapData;

            var slide:Slide = makeSlide(x, y, name);
            slide.addPoint(50, 50, "Where do the collisions go?");
            slide.addImage((WIDTH - image.width) * 0.5, 150, image);
            return slide;
        }

        private function makeBobQuoteSlide(x:int, y:int, name:String):Slide
        {
            var bob:BitmapData = new UncleBobQuote().bitmapData;

            var slide:Slide = makeSlide(x, y, name);
            slide.addImage((WIDTH - bob.width) * 0.5, 200, bob);
            return slide;
        }

        private function makeRethinkSlide(x:int, y:int, name:String):Slide
        {
            var slide:Slide = makeSlide(x, y, name);
            slide.setTitle(20, 20, "A Different Approach");
            slide.addPoint(100, 280, "Aggregation over Composition");
            slide.addPoint(100, 360, "Less structure");
            slide.addPoint(100, 440, "Fewer dependencies");
            return slide;
        }

        private function makeSystemsSlide(x:int, y:int, name:String):Slide
        {
            var slide:Slide = makeSlide(x, y, name);
            slide.setTitle(20, 20, "What Do We Need?");
            slide.addPoint(100, 200, "Rendering", 1);
            slide.addPoint(100, 280, "Movement", 2);
            slide.addPoint(100, 360, "Collisions", 3);
            slide.addPoint(100, 440, "User Input", 4);
            slide.addPoint(400, 320, "Systems", 5);
            slide.addAction("step");
            return slide;
        }

        private function makeRenderSystemSlide(x:int, y:int, name:String):Slide
        {
            var render:BitmapData = new RenderSystem().bitmapData;

            var slide:Slide = makeSlide(x, y, name);
            slide.setTitle(20, 20, "Rendering");
            slide.addImage((WIDTH - render.width) * 0.5, 200, render);
            return slide;
        }

        private function makeCollisionSystemSlide(x:int, y:int, name:String):Slide
        {
            var collisions:BitmapData = new CollisionSystem().bitmapData;

            var slide:Slide = makeSlide(x, y, name);
            slide.setTitle(20, 20, "Collisions");
            slide.addImage((WIDTH - collisions.width) * 0.5, 200, collisions);
            return slide;
        }

        private function makeInputSlide(x:int, y:int, name:String):Slide
        {
            var keyboard:BitmapData = new KeyInputSystem().bitmapData;

            var slide:Slide = makeSlide(x, y, name);
            slide.setTitle(20, 20, "Keyboard Input");
            slide.addImage((WIDTH - keyboard.width) * 0.5, 200, keyboard);
            return slide;
        }

        private function makeAddingAndRemoving(x:int, y:int, name:String):Slide
        {
            var addingandremoving:BitmapData = new AddingAndRemoving().bitmapData;

            var slide:Slide = makeSlide(x, y, name);
            slide.setTitle(20, 20, "Keyboard Input");
            slide.addImage((WIDTH - addingandremoving.width) * 0.5, 200, addingandremoving);
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

        private function makeSlide(x:int, y:int, name:String):Slide
        {
            var slide:Slide = new Slide();
            slide.name = name;
            slide.x = x * (WIDTH + PADDING);
            slide.y = y * (HEIGHT + PADDING);
            slide.offsetX = offsetX;
            slide.offsetY = offsetY;
            slide.width = WIDTH;
            slide.height = HEIGHT;
            slide.insetOutline = INSET_OUTLINE;
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
    }
}
