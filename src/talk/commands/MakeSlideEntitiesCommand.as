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
    import talk.factories.SlideCharacterEntityFactory;

    public class MakeSlideEntitiesCommand
    {
        [Inject]
        public var fonts:BitmapFonts;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var slide:Slide;

        [Inject]
        public var characterFactory:SlideCharacterEntityFactory;

        private var list:Vector.<Entity>;

        public function execute():void
        {
            list = characterFactory.make(slide);
            makeBorderEntity();

            for each (var entity:Entity in list)
                entities.addEntity(entity);
        }

        private function makeBorderEntity():void
        {
            if (!slide.border)
                return;

            var position:Position = new Position();
            position.x = slide.x;
            position.y = slide.y;

            var rectangle:Rectangle = new Rectangle();
            rectangle.width = slide.width;
            rectangle.height = slide.height;

            var sprite:Sprite = new Sprite();
            sprite.x = slide.x;
            sprite.y = slide.y;

            slide.border.drawRectangle(sprite.graphics, rectangle);

            var display:Display = new Display();
            display.object = sprite;

            var entity:Entity = new Entity();
            entity.add(position);
            entity.add(display);
            entity.add(slide);

            entities.addEntity(entity);
        }
    }
}
