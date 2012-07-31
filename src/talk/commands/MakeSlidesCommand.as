package talk.commands
{
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.extensions.view.display.Display;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.fonts.BitmapFonts;

    import flash.display.Sprite;
    import flash.geom.Rectangle;

    import talk.data.Slide;
    import talk.data.SlideTarget;
    import talk.data.Slides;
    import talk.data.Target;
    import talk.factories.SlideCharacterEntityFactory;
    import talk.signals.MakeSlideStep;

    public class MakeSlidesCommand
    {
        [Inject]
        public var fonts:BitmapFonts;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var slides:Slides;

        [Inject]
        public var makeSlideStep:MakeSlideStep;

        [Inject]
        public var characterFactory:SlideCharacterEntityFactory;

        private var made:Vector.<Slide>;
        private var current:Slide;

        public function execute():void
        {
            made = new <Slide>[];
            makeSlide(slides.current);
        }

        private function makeSlide(slide:Slide):void
        {
            if (made.indexOf(slide) == -1)
            {
                setCurrentSlide(slide);
                makeBorderEntity();
                makeSlideStep.dispatch(slide);
                makeTargets();
            }
        }

        private function setCurrentSlide(slide:Slide):void
        {
            current = slide;
            made.push(current);
        }

        private function makeBorderEntity():void
        {
            if (!current.border)
                return;

            var position:Position = new Position();
            position.x = current.x;
            position.y = current.y;

            var rectangle:Rectangle = new Rectangle();
            rectangle.x = current.padding;
            rectangle.y = current.padding;
            rectangle.width = current.width - current.padding * 2;
            rectangle.height = current.height - current.padding * 2;

            var sprite:Sprite = new Sprite();
            sprite.x = current.x;
            sprite.y = current.y;

            current.border.drawRectangle(sprite.graphics, rectangle);

            var display:Display = new Display();
            display.object = sprite;

            var entity:Entity = new Entity();
            entity.add(position);
            entity.add(display);
            entity.add(current);

            entities.addEntity(entity);
        }

        private function makeTargets():void
        {
            var parent:Slide = current;
            for each (var child:Target in parent.targets)
            {
                if (child is SlideTarget)
                    makeSlide((child as SlideTarget).getSlide());
            }
        }
    }
}
