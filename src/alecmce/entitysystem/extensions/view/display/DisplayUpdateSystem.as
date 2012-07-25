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

        private var container:DisplayObjectContainer;
        private var cameras:Collection;
        private var displays:Collection;
        private var node:Node;

        [PostConstruct]
        public function setup():void
        {
            displays = entities.getCollection(new <Class>[Display]);
            cameras = entities.getCollection(new <Class>[Position, Camera]);
        }

        public function setContainer(container:DisplayObjectContainer):void
        {
            this.container = container;
        }

        public function start(time:int):void
        {
            for (node = displays.head; node; node = node.next)
                onEntityAdded(node.entity);

            displays.entityAdded.add(onEntityAdded);
            displays.entityRemoved.add(onEntityRemoved);
        }

        public function update(time:int, delta:int):void
        {
            var entity:Entity = cameras.head ? cameras.head.entity : null;
            if (!entity)
                return;

            var center:Position = entity.get(Position);

            for (node = displays.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                var sprite:DisplayObject = entity.get(Display).object;
                var position:Position = entity.get(Position);

                sprite.x = position.x - center.x;
                sprite.y = position.y - center.y;
                sprite.transform.matrix = position.getTransform();
            }
        }

        public function stop(time:int):void
        {
            for (node = displays.head; node; node = node.next)
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
