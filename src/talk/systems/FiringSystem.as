package talk.systems
{
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;
    import alecmce.entitysystem.framework.System;

    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    import talk.data.Bullet;
    import talk.data.Gun;
    import talk.factories.AssetFactory;

    public class FiringSystem implements System
    {
        [Inject]
        public var entities:Entities;

        [Inject]
        public var layers:Layers;

        [Inject]
        public var assets:AssetFactory;

        private var collection:Collection;
        private var node:Node;

        private var entity:Entity;
        private var position:Position;
        private var gun:Gun;
        private var isTriggered:Boolean;

        [PostConstruct]
        public function setup():void
        {
            collection = entities.getCollection(new <Class>[Position, Gun]);
        }

        public function start(time:int):void
        {
            layers.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        }

        public function stop(time:int):void
        {
            layers.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        }

        private function onKeyDown(event:KeyboardEvent):void
        {
            if (event.keyCode == Keyboard.SPACE)
                isTriggered = true;
        }

        public function update(time:int, delta:int):void
        {
            if (!isTriggered)
                return;

            isTriggered = false;

            for (node = collection.head; node; node = node.next)
            {
                entity = node.entity;
                position = entity.get(Position);
                gun = entity.get(Gun);

                if (time - gun.lastFired > gun.frequency && gun.ammo != 0)
                {
                    if (gun.ammo > 0)
                        --gun.ammo;

                    gun.lastFired = time;

                    var pos:Position = new Position();
                    pos.x = position.x + gun.originOffsetX;
                    pos.y = position.y + gun.originOffsetY;

                    var velocity:Bullet = new Bullet();
                    velocity.dx = 0;
                    velocity.dy = -gun.speed;

                    var bullet:Entity = new Entity();
                    bullet.add(pos);
                    bullet.add(velocity);
                    bullet.add(assets.makeBullet());
                    entities.addEntity(bullet);
                }
            }
        }
    }
}
