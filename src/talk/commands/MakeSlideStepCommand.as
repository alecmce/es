package talk.commands
{
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.extensions.view.display.Display;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.fonts.BitmapFonts;

    import talk.data.Slide;
    import talk.data.SlideFlash;
    import talk.data.SlideImage;
    import talk.data.Step;
    import talk.factories.SlideCharacterEntityFactory;

    public class MakeSlideStepCommand
    {
        [Inject]
        public var fonts:BitmapFonts;

        [Inject]
        public var characterFactory:SlideCharacterEntityFactory;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var slide:Slide;

        private var step:int;

        public function execute():void
        {
            this.step = slide.step;

            makeImageEntities();
            makeFlashEntities();
            addEntities();
        }

        private function makeImageEntities():void
        {
            var images:Vector.<SlideImage> = slide.images;
            if (!images)
                return;

            for each (var image:SlideImage in slide.images)
            {
                if (image.step == step)
                    makeImageEntity(image);
            }
        }

        private function makeImageEntity(image:SlideImage):void
        {
            var position:Position = new Position();
            position.x = image.x + slide.x;
            position.y = image.y + slide.y;

            var entity:Entity = new Entity();
            entity.add(position);
            entity.add(slide);
            entity.add(image.data);
            entity.add(new Step(step));

            entities.addEntity(entity);
        }

        private function makeFlashEntities():void
        {
            var flashes:Vector.<SlideFlash> = slide.flashes;
            if (!flashes)
                return;

            for each (var flash:SlideFlash in slide.flashes)
            {
                if (flash.step == step)
                    makeFlashEntity(flash);
            }
        }

        private function makeFlashEntity(flash:SlideFlash):void
        {
            var position:Position = new Position();
            position.x = flash.x + slide.x;
            position.y = flash.y + slide.y;

            var display:Display = new Display();
            display.object = flash.data;

            var entity:Entity = new Entity();
            entity.add(position);
            entity.add(display);
            entity.add(new Step(step));

            entities.addEntity(entity);
        }

        private function addEntities():void
        {
            var list:Vector.<Entity> = characterFactory.make(slide);
            for each (var entity:Entity in list)
            {
                entity.add(new Step(step));
                entities.addEntity(entity);
            }
        }

    }
}
