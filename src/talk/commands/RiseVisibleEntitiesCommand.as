package talk.commands
{
    import alecmce.entitysystem.extensions.view.Camera;
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;
    import alecmce.entitysystem.framework.Systems;

    import flash.display.BitmapData;

    import talk.data.Collapsing;

    import talk.data.Rising;
    import talk.systems.CollapseSystem;
    import talk.systems.RiseSystem;

    public class RiseVisibleEntitiesCommand
    {
        private const PADDING:int = 0;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var systems:Systems;

        [Inject]
        public var rise:RiseSystem;

        [Inject]
        public var collapse:CollapseSystem;

        [Inject]
        public var camera:Camera;

        public function execute():void
        {
            addRisingComponentToAllVisibleEntities();
            endCollapseSystem();
            startRiseSystem();
        }

        private function addRisingComponentToAllVisibleEntities():void
        {
            var collection:Collection = entities.getCollection(new <Class>[Position, BitmapData]);

            for (var node:Node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                var position:Position = entity.get(Position);
                var data:BitmapData = entity.get(BitmapData);

                if (camera.contains(position.x, position.y, PADDING))
                {
                    entity.remove(Collapsing);
                    entity.add(new Rising());
                }
            }
        }

        private function endCollapseSystem():void
        {
            systems.remove(collapse);
        }

        private function startRiseSystem():void
        {
            systems.add(rise);
        }
    }
}
