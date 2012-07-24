package talk.commands
{
    import alecmce.entitysystem.extensions.concepts.Camera;
    import alecmce.entitysystem.extensions.concepts.Position;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;

    import flash.geom.Rectangle;

    public class MakeCameraCommand
    {
        [Inject]
        public var entities:Entities;

        public function execute():void
        {
            var rectangle:Rectangle = new Rectangle(0, 0, 800, 600);
            rectangle.inflate(100, 100);

            var position:Position = new Position();
            position.x = 0;
            position.y = 0;

            var camera:Camera = new Camera();
            camera.bounds = rectangle;

            var entity:Entity = new Entity();
            entity.add(position);
            entity.add(camera);

            entities.addEntity(entity);
        }
    }
}
