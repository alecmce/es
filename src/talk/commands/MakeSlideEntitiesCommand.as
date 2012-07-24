package talk.commands
{
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.fonts.BitmapFonts;

    import talk.data.Slide;
    import talk.services.SlideEntitiesFactory;

    public class MakeSlideEntitiesCommand
    {
        [Inject]
        public var fonts:BitmapFonts;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var slide:Slide;

        [Inject]
        public var factory:SlideEntitiesFactory;

        public function execute():void
        {
            var list:Vector.<Entity> = factory.make(slide);

            for each (var entity:Entity in list)
                entities.addEntity(entity);
        }
    }
}
