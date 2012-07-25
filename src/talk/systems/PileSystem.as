package talk.systems
{
    import Box2D.Collision.Shapes.b2PolygonShape;
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Body;
    import Box2D.Dynamics.b2BodyDef;
    import Box2D.Dynamics.b2FixtureDef;
    import Box2D.Dynamics.b2World;

    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;
    import alecmce.entitysystem.framework.System;

    import flash.display.BitmapData;
    import flash.display.Stage;
    import flash.geom.Rectangle;

    import talk.data.Piled;
    import talk.physics.Box2dObjectFactory;

    public class PileSystem implements System
    {
        private const TO_SCREEN:int = 30;
        private const TO_WORLD:Number = 1 / TO_SCREEN;

        private static const GRAVITY:Number = 0.1;
        private static const RESTITUTION:Number = 0.8;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var layers:Layers;

        private var collection:Collection;
        private var node:Node;

        private var gravity:b2Vec2;
        private var world:b2World;

        [PostConstruct]
        public function setup():void
        {
            collection = entities.getCollection(new <Class>[Piled, Position, BitmapData]);
        }

        public function start(time:int):void
        {
            gravity = new b2Vec2(0, 10);
            world = new b2World(gravity, true);

            var factory:Box2dObjectFactory = new Box2dObjectFactory();
            factory.setWorld(world);

            var rect:Rectangle = layers.getSize().clone();
            rect.left *= TO_WORLD;
            rect.top *= TO_WORLD;
            rect.right *= TO_WORLD;
            rect.bottom *= TO_WORLD;

            factory.makeStaticRect(new Rectangle(rect.left, rect.bottom, rect.width, 1));
            factory.makeStaticRect(new Rectangle(rect.left - 1, rect.top,  1, rect.height));
            factory.makeStaticRect(new Rectangle(rect.right, rect.top, 1, rect.height));

            for (node = collection.head; node; node = node.next)
            {
                body = new 
                factory.makeDynamicRect();
            }
        }

        public function update(time:int, delta:int):void
        {
            for (node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                var piled:Piled = entity.get(Piled);
                var pos:Position = entity.get(Position);

                piled.dy += GRAVITY;

                pos.x += piled.dx;
                if (pos.x < piled.radius)
                {
                    pos.x = piled.radius;
                    piled.dx *= RESTITUTION;
                }
                else if (pos.x >= stage.stageWidth - piled.radius)
                {
                    pos.x = stage.stageWidth;
                    piled.dx *= RESTITUTION;
                }

                pos.y += piled.dy;
                if (pos.y >= stage.stageHeight - piled.radius)
                {
                    entity.remove(Piled);
                }

            }
        }

        public function stop(time:int):void
        {
        }
    }
}
