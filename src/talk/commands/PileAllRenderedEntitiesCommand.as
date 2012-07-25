package talk.commands
{
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;

    import flash.display.BitmapData;

    import talk.data.Piled;

    public class PileAllRenderedEntitiesCommand
    {
        [Inject]
        public var entities:Entities;

        public function execute():void
        {
            var collection:Collection = entities.getCollection(new <Class>[Position, BitmapData]);

            for (var node:Node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                var data:BitmapData = entity.get(BitmapData);

                var piled:Piled = new Piled();
                piled.dx = Math.random() * 2 - 1;
                piled.dy = Math.random() * 2 - 1;
                piled.da = Math.random() * (Math.random() - 0.5);
                piled.radius = data.width < data.height ? data.width : data.height;

                node.entity.add(piled);
            }

        }
    }
}
