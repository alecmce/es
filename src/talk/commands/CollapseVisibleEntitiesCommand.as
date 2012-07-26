package talk.commands
{
    import alecmce.entitysystem.extensions.view.Camera;
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;

    import flash.display.BitmapData;

    import talk.data.Collapsing;

    public class CollapseVisibleEntitiesCommand
    {
        private const PADDING:int = 0;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var camera:Camera;

        public function execute():void
        {
            var collection:Collection = entities.getCollection(new <Class>[Position, BitmapData]);

            for (var node:Node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity
                var position:Position = entity.get(Position);
                var data:BitmapData = entity.get(BitmapData);

                if (camera.contains(position.x, position.y, PADDING))
                    node.entity.add(new Collapsing());
            }

        }
    }
}
