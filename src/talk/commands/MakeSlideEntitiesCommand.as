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
    import talk.data.SlideImage;
    import talk.data.SlideTarget;
    import talk.data.Slides;
    import talk.factories.SlideCharacterEntityFactory;

    public class MakeSlideEntitiesCommand
    {
        [Inject]
        public var fonts:BitmapFonts;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var slides:Slides;

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
                makeImageEntities();
                addEntities();
                makeTargets();
            }
        }

        private function setCurrentSlide(slide:Slide):void
        {
            current = slide;
            made.push(current);
        }

        private function makeImageEntities():void
        {
            var images:Vector.<SlideImage> = current.images;
            if (!images)
                return;

            for each (var image:SlideImage in current.images)
            {
                var position:Position = new Position();
                position.x = image.x + current.x;
                position.y = image.y + current.y;

                var entity:Entity = new Entity();
                entity.add(position);
                entity.add(image.data);

                entities.addEntity(entity);
            }
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

        private function addEntities():void
        {
            var list:Vector.<Entity> = characterFactory.make(current);
            for each (var entity:Entity in list)
                entities.addEntity(entity);
        }

        private function makeTargets():void
        {
            var parent:Slide = current;
            for each (var child:SlideTarget in parent.targets)
                makeSlide(child.slide);
        }
    }
}
