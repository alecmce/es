package talk.commands
{
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.fonts.BitmapFonts;

    import talk.data.Slide;
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
            entity.add(image.data);
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
