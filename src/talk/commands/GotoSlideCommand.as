package talk.commands
{
    import talk.systems.Selected;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;

    import talk.data.Slide;

    import talk.data.Slides;

    public class GotoSlideCommand
    {
        [Inject]
        public var entities:Entities;

        [Inject]
        public var slides:Slides;

        [Inject]
        public var index:String;

        public function execute():void
        {
            var slide:Slide = slides.slides[int(index)];
            var selected:Selected = new Selected();

            // TODO this isn't the right way to do it, we need a go-to entity for each slide
            var entity:Entity = new Entity();
            entity.add(slide);
            entity.add(selected);
            entities.addEntity(entity);
        }
    }
}
