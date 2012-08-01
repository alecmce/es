package talk.systems
{
    import Box2D.Common.Math.b2Mat22;
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Body;
    import Box2D.Dynamics.b2DebugDraw;
    import Box2D.Dynamics.b2World;

    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;
    import alecmce.entitysystem.framework.System;

    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.geom.Rectangle;

    import talk.data.Collapsing;
    import talk.data.Debug;
    import talk.data.Slide;
    import talk.data.Slides;
    import talk.factories.Box2dObjectFactory;

    public class CollapseSystem implements System
    {
        private const TO_SCREEN:int = 30;
        private const TO_SIMULATION:Number = 1 / TO_SCREEN;
        private const VELOCITY_ITERATIONS:int = 10;
        private const POSITION_ITERATIONS:int = 10;
        private const WIDTH_SCALAR:Number = 0.6;
        private const HEIGHT_SCALAR:Number = 0.5;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var layers:Layers;

        [Inject]
        public var slides:Slides;

        [Inject]
        public var debugModel:Debug;

        private var collection:Collection;
        private var node:Node;

        private var factory:Box2dObjectFactory;
        private var debug:Sprite;
        private var simulation:b2World;
        private var drawer:b2DebugDraw;
        private var matrix:Vector.<Number>;

        [PostConstruct]
        public function setup():void
        {
            collection = entities.getCollection(new <Class>[Collapsing, Slide, Position, BitmapData]);
            factory = new Box2dObjectFactory();
            matrix = new Vector.<Number>(4, true);
        }

        public function start(time:int):void
        {
            setupSimulation();

            if (debugModel.isDebug)
                addDebugRendering();

            for (node = collection.head; node; node = node.next)
                addEntityToSimulation(node.entity);

            collection.entityAdded.add(addEntityToSimulation);
            collection.entityRemoved.add(removeEntityFromSimulation);
        }

        public function update(time:int, delta:int):void
        {
            simulation.Step(delta * 0.001, VELOCITY_ITERATIONS, POSITION_ITERATIONS);

            if (debugModel.isDebug)
                simulation.DrawDebugData();

            for (node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                var body:b2Body = entity.get(b2Body);
                var slide:Slide = entity.get(Slide);

                var bodyPos:b2Vec2 = body.GetPosition();
                var x:Number = bodyPos.x;
                var y:Number = bodyPos.y;

                var data:UserData = body.GetUserData();
                var w:Number = data.w;
                var h:Number = data.h;

                var R:b2Mat22 = body.GetTransform().R;
                var a:Number = R.col1.x;
                var b:Number = R.col1.y;
                var c:Number = R.col2.x;
                var d:Number = R.col2.y;

                matrix[0] = a;
                matrix[1] = b;
                matrix[2] = c;
                matrix[3] = d;

                var pos:Position = entity.get(Position);
                pos.rotation.setMatrix(matrix);
                pos.x = (x - a * w + b * h) * TO_SCREEN + slide.x;
                pos.y = (y + c * w - d * h) * TO_SCREEN + slide.y;
            }
        }

        public function stop(time:int):void
        {
            for (node = collection.head; node; node = node.next)
                removeEntityFromSimulation(node.entity);

            collection.entityAdded.remove(addEntityToSimulation);
            collection.entityRemoved.remove(removeEntityFromSimulation);

            if (debug && debug.parent)
                debug.parent.removeChild(debug);
        }

        private function setupSimulation():void
        {
            var gravity:b2Vec2 = new b2Vec2(0, 10);

            simulation = new b2World(gravity, true);
            factory.setWorld(simulation);

            var rect:Rectangle = new Rectangle(0, 0, 800, 600);
            rect.left *= TO_SIMULATION;
            rect.top *= TO_SIMULATION;
            rect.right *= TO_SIMULATION;
            rect.bottom *= TO_SIMULATION;

            factory.makeStaticRect(new Rectangle(rect.left, rect.bottom, rect.width, 1));
            factory.makeStaticRect(new Rectangle(rect.left - 1, rect.top, 1, rect.height));
            factory.makeStaticRect(new Rectangle(rect.right, rect.top, 1, rect.height));

            factory.makeRoughFloor(rect.left, rect.bottom, rect.width);
        }

        private function addDebugRendering():void
        {
            debug = new Sprite();
            layers.dialog.addChild(debug);
            debug.x = slides.current.offsetX;
            debug.y = slides.current.offsetY;

            drawer = new b2DebugDraw();
            drawer.SetSprite(debug);
            drawer.SetDrawScale(TO_SCREEN);
            drawer.SetFillAlpha(0.5);
            drawer.SetLineThickness(1);
            drawer.SetFlags(b2DebugDraw.e_shapeBit);

            simulation.SetDebugDraw(drawer);
        }

        private function addEntityToSimulation(entity:Entity):void
        {
            var bitmap:BitmapData = entity.get(BitmapData);
            var pos:Position = entity.get(Position);
            var slide:Slide = entity.get(Slide);

            var rect:Rectangle = new Rectangle();
            rect.x = (pos.x - slide.x) * TO_SIMULATION;
            rect.y = (pos.y - slide.y) * TO_SIMULATION;
            rect.width = bitmap.width * TO_SIMULATION * WIDTH_SCALAR;
            rect.height = bitmap.height * TO_SIMULATION * HEIGHT_SCALAR;

            var data:UserData = new UserData();
            data.entity = entity;
            data.w = rect.width * 0.5;
            data.h = rect.height * 0.5;

            var body:b2Body = factory.makeDynamicRect(rect);
            factory.applyRandomForce(body, 1, 0.1);

            body.SetUserData(data);
            entity.add(body);
        }

        private function removeEntityFromSimulation(entity:Entity):void
        {
            var body:b2Body = entity.get(b2Body);
            entity.remove(b2Body);
            entity.remove(Collapsing);
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

import alecmce.entitysystem.framework.Entity;

class UserData
{
    public var entity:Entity;
    public var w:Number;
    public var h:Number;
}