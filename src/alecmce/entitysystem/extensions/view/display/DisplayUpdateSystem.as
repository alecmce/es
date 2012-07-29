package alecmce.entitysystem.extensions.view.display
{
    import alecmce.entitysystem.extensions.view.Camera;
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;
    import alecmce.entitysystem.framework.System;

    import flash.display.DisplayObject;

    import flash.display.DisplayObjectContainer;

    public class DisplayUpdateSystem implements System
    {
        [Inject]
        public var entities:Entities;

        [Inject]
        public var camera:Camera;

        private var container:DisplayObjectContainer;
        private var collection:Collection;
        private var node:Node;

        [PostConstruct]
        public function setup():void
        {
            collection = entities.getCollection(new <Class>[Display]);
        }

        public function setContainer(container:DisplayObjectContainer):void
        {
            this.container = container;
        }

        public function start(time:int):void
        {
            for (node = collection.head; node; node = node.next)
                onEntityAdded(node.entity);

            collection.entityAdded.add(onEntityAdded);
            collection.entityRemoved.add(onEntityRemoved);
        }

        public function update(time:int, delta:int):void
        {
            for (node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                var sprite:DisplayObject = entity.get(Display).object;
                var position:Position = entity.get(Position);

                sprite.transform.matrix = position.getTransform();
                sprite.x = position.x - camera.left;
                sprite.y = position.y - camera.top;
            }
        }

        public function stop(time:int):void
        {
            for (node = collection.head; node; node = node.next)
                onEntityRemoved(node.entity);
        }

        private function onEntityAdded(entity:Entity):void
        {
            var sprite:Display = entity.get(Display);
            if (sprite.container == null)
                sprite.container = container;

            sprite.container.addChild(sprite.object);
        }

        private function onEntityRemoved(entity:Entity):void
        {
            var sprite:Display = entity.get(Display);
            sprite.container.removeChild(sprite.object);
        }
    }
}
