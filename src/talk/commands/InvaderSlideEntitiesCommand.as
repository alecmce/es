package talk.commands
{
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;
    import alecmce.entitysystem.framework.Systems;

    import flash.display.BitmapData;

    import talk.data.Selected;
    import talk.data.Slide;
    import talk.data.Slides;
    import talk.data.SpaceInvader;
    import talk.signals.RemoveSelectedSlideSystems;
    import talk.systems.SpaceInvaderMovementSystem;

    public class InvaderSlideEntitiesCommand
    {
        private const PADDING:int = 0;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var removeSelectedSlideSystems:RemoveSelectedSlideSystems;

        [Inject]
        public var systems:Systems;

        [Inject]
        public var invaders:SpaceInvaderMovementSystem;

        private var entity:Entity;
        private var selected:Slide;

        public function execute():void
        {
            getSelectedSlide();
            if (!selected)
                return;

            removeSelectedSlideSystems.dispatch();
            addSpaceInvaderComponentToSlideEntities();
            startInvaderSystem();
        }

        private function getSelectedSlide():void
        {
            var collection:Collection = entities.getCollection(new <Class>[Slides, Slide, Selected]);
            if (collection.head)
            {
                entity = collection.head.entity;
                selected = entity.get(Slide);
            }
        }

        private function addSpaceInvaderComponentToSlideEntities():void
        {
            var collection:Collection = entities.getCollection(new <Class>[Slide, Position, BitmapData]);

            for (var node:Node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                if (entity.get(Slide) == selected)
                    entity.add(new SpaceInvader());
            }
        }

        private function startInvaderSystem():void
        {
            entity.add(invaders);
            systems.add(invaders);
        }

    }
}
