package talk.commands
{
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Node;

    import talk.data.Spaceship;

    public class RemoveSpaceshipCommand
    {
        [Inject]
        public var entities:Entities;

        public function execute():void
        {
            var collection:Collection = entities.getCollection(new <Class>[Spaceship]);
            for (var node:Node = collection.head; node; node = node.next)
            {
                entities.removeEntity(node.entity);
            }
        }

    }
}
