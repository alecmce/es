package talk.systems
{
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.extensions.view.Rotation;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;
    import alecmce.entitysystem.framework.System;
    import alecmce.math.easing.Quad;

    import talk.data.Character;
    import talk.data.Rising;

    public class RiseSystem implements System
    {
        public static const DURATION:int = 1000;
        public static const INV_DURATION:Number = 1 / DURATION;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var layers:Layers;

        private var collection:Collection;
        private var node:Node;
        private var working:Vector.<Number>;

        [PostConstruct]
        public function setup():void
        {
            collection = entities.getCollection(new <Class>[Rising, Position, Character]);
            working = new Vector.<Number>(4, true);
        }

        public function start(time:int):void
        {
            collection.entityAdded.add(onEntityAdded);
            collection.entityRemoved.add(onEntityRemoved);

            for (node = collection.head; node; node = node.next)
                onEntityAdded(node.entity);
        }

        public function stop(time:int):void
        {
            collection.entityAdded.remove(onEntityAdded);
            collection.entityRemoved.remove(onEntityRemoved);

            for (node = collection.head; node; node = node.next)
                onEntityRemoved(node.entity);
        }

        private function onEntityAdded(entity:Entity):void
        {
            var character:Character = entity.get(Character);
            var position:Position = entity.get(Position);
            var rotation:Rotation = position.rotation;
            var matrix:Vector.<Number> = rotation.getMatrix();

            var a:Number = matrix[0];
            var b:Number = matrix[1];
            var c:Number = matrix[2];
            var d:Number = matrix[3];
            var x:Number = position.x;
            var y:Number = position.y;

            var data:RiseData = new RiseData();
            data.matrixStarts[0] = a;
            data.matrixStarts[1] = b;
            data.matrixStarts[2] = c;
            data.matrixStarts[3] = d;
            data.xStart = x;
            data.yStart = y;

            data.matrixDeltas[0] = 1 - a;
            data.matrixDeltas[1] = 0 - b;
            data.matrixDeltas[2] = 0 - c;
            data.matrixDeltas[3] = 1 - d;
            data.xDelta = character.x - x;
            data.yDelta = character.y - y;

            entity.add(data);
        }

        private function onEntityRemoved(entity:Entity):void
        {
            entity.remove(RiseData);
        }

        public function update(time:int, delta:int):void
        {
            for (node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                var rise:RiseData = entity.get(RiseData);
                var position:Position = entity.get(Position);
                var rotation:Rotation = position.rotation;

                rise.progress += delta;

                var proportion:Number = rise.progress * INV_DURATION;
                if (proportion >= 1)
                {
                    proportion = 1;
                    entity.remove(RiseData);
                    entity.remove(Rising);
                }

                proportion = Quad.easeOut(proportion);

                position.x = rise.xStart + rise.xDelta * proportion;
                position.y = rise.yStart + rise.yDelta * proportion;

                working[0] = rise.matrixStarts[0] + rise.matrixDeltas[0] * proportion;
                working[1] = rise.matrixStarts[1] + rise.matrixDeltas[1] * proportion;
                working[2] = rise.matrixStarts[2] + rise.matrixDeltas[2] * proportion;
                working[3] = rise.matrixStarts[3] + rise.matrixDeltas[3] * proportion;
                position.rotation.setMatrix(working);
            }
        }
    }
}

class RiseData
{
    public var matrixStarts:Vector.<Number>;
    public var matrixDeltas:Vector.<Number>;

    public var xStart:Number;
    public var xDelta:Number;

    public var yStart:Number;
    public var yDelta:Number;

    public var progress:int;

    public function RiseData()
    {
        matrixStarts = new Vector.<Number>(4, true);
        matrixDeltas = new Vector.<Number>(4, true);

        progress = 0;
    }
}