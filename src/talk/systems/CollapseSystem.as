package talk.systems
{
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Body;
    import Box2D.Dynamics.b2World;

    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;
    import alecmce.entitysystem.framework.System;

    import flash.display.BitmapData;
    import flash.geom.Rectangle;

    import talk.data.Collapsing;
    import talk.physics.Box2dObjectFactory;

    public class CollapseSystem implements System
    {
        private const TO_SCREEN:int = 30;
        private const TO_WORLD:Number = 1 / TO_SCREEN;
        private const VELOCITY_ITERATIONS:int = 10;
        private const POSITION_ITERATIONS:int = 10;

        private static const GRAVITY:Number = 0.1;
        private static const RESTITUTION:Number = 0.8;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var layers:Layers;

        private var collection:Collection;
        private var node:Node;

        private var factory:Box2dObjectFactory;
        private var gravity:b2Vec2;
        private var simulation:b2World;

        [PostConstruct]
        public function setup():void
        {
            collection = entities.getCollection(new <Class>[Collapsing, Position, BitmapData]);
        }

        public function start(time:int):void
        {
            setupSimulation();

            for (node = collection.head; node; node = node.next)
                addEntityToSimulation(node.entity);

            collection.entityAdded.add(addEntityToSimulation);
            collection.entityRemoved.add(removeEntityFromSimulation);
        }

        public function update(time:int, delta:int):void
        {
            simulation.Step(delta, VELOCITY_ITERATIONS, POSITION_ITERATIONS);

            var allAtRest:Boolean = true;

            for (node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity;

                var body:b2Body = entity.get(b2Body);
                var bodyPos:b2Vec2 = body.GetPosition();

                var pos:Position = entity.get(Position);
                pos.x = bodyPos.x * TO_SCREEN;
                pos.y = bodyPos.y * TO_SCREEN;
                pos.rotation.setAngle(body.GetAngle());

                allAtRest &&= body.IsAwake();
            }

            if (allAtRest)
                removeAllFromSimulation();
        }

        public function stop(time:int):void
        {
            for (node = collection.head; node; node = node.next)
                removeEntityFromSimulation(node.entity);

            collection.entityAdded.remove(addEntityToSimulation);
            collection.entityRemoved.remove(removeEntityFromSimulation);
        }

        private function setupSimulation():void
        {
            factory = new Box2dObjectFactory();

            gravity = new b2Vec2(0, 10);

            simulation = new b2World(gravity, true);
            factory.setWorld(simulation);

            var rect:Rectangle = layers.getSize().clone();
            rect.left *= TO_WORLD;
            rect.top *= TO_WORLD;
            rect.right *= TO_WORLD;
            rect.bottom *= TO_WORLD;

            factory.makeStaticRect(new Rectangle(rect.left, rect.bottom, rect.width, 1));
            factory.makeStaticRect(new Rectangle(rect.left - 1, rect.top, 1, rect.height));
            factory.makeStaticRect(new Rectangle(rect.right, rect.top, 1, rect.height));
        }

        private function addEntityToSimulation(entity:Entity):void
        {
            var entity:Entity = node.entity;
            var bitmap:BitmapData = entity.get(BitmapData);
            var pos:Position = entity.get(Position);

            var rect:Rectangle = new Rectangle();
            rect.left = pos.x * TO_WORLD;
            rect.top = pos.y * TO_WORLD;
            rect.width = bitmap.width * TO_WORLD;
            rect.height = bitmap.height * TO_WORLD;

            var body:b2Body = factory.makeDynamicRect(rect, entity);
            factory.applyRandomForce(body);
            entity.add(body);
        }

        private function removeEntityFromSimulation(entity:Entity):void
        {
            var body:b2Body = entity.get(b2Body);
            simulation.DestroyBody(body);
            entity.remove(b2Body);
        }

        private function removeAllFromSimulation():void
        {
            for (node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                var body:b2Body = entity.get(b2Body);

                simulation.DestroyBody(body);
                entity.remove(b2Body);
                entity.remove(Collapsing);
            }
        }
    }
}
