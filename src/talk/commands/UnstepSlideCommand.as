package talk.commands
{
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;

    import talk.data.Slide;

    import talk.data.Slides;
    import talk.data.Step;

    public class UnstepSlideCommand
    {
        [Inject]
        public var slides:Slides;

        [Inject]
        public var entities:Entities;

        public function execute():void
        {
            var slide:Slide = slides.current;
            var step:int = slide.step;
            if (step == 0)
                return;

            var collection:Collection = entities.getCollection(new <Class>[Slide, Step]);
            for (var node:Node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                if (entity.get(Slide) == slide && entity.get(Step).value == step)
                    entities.removeEntity(node.entity);
            }

            --slide.step;
        }
    }
}
