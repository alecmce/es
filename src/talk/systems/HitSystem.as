package talk.systems
{
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;
    import alecmce.entitysystem.framework.System;
    import alecmce.math.Random;

    import flash.display.BitmapData;
    import flash.filters.BitmapFilter;
    import flash.filters.ColorMatrixFilter;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    import talk.data.Hit;
    import talk.data.HitPixel;

    public class HitSystem implements System
    {
        private static const PIXEL:int = 3;
        private static const SCALAR:int = 4;
        private static const FRICTION:Number = 0.98;
        private static const GRAVITY:Number = 0.25;
        private static const ORIGIN:Point = new Point();
        private static const FADE:BitmapFilter = new ColorMatrixFilter([1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0.98, 0]);

        [Inject]
        public var entities:Entities;

        [Inject]
        public var random:Random;

        private var hitEntities:Collection;
        private var particleEntities:Collection;
        private var node:Node;
        private var rect:Rectangle;
        private var point:Point;

        public function HitSystem()
        {
            rect = new Rectangle(0, 0, PIXEL, PIXEL);
            point = new Point();
        }

        [PostConstruct]
        public function setup():void
        {
            hitEntities = entities.getCollection(new <Class>[Hit, Position, BitmapData]);
            particleEntities = entities.getCollection(new <Class>[HitPixel, Position, BitmapData]);
        }

        public function start(time:int):void
        {
            for (node = hitEntities.head; node; node = node.next)
            {
                onEntityAdded(node.entity);
            }

            hitEntities.entityAdded.add(onEntityAdded);
            hitEntities.entityRemoved.add(onEntityRemoved);
        }

        public function stop(time:int):void
        {
            hitEntities.entityAdded.remove(onEntityAdded);
            hitEntities.entityRemoved.remove(onEntityRemoved);
        }

        private function onEntityAdded(entity:Entity):void
        {
            var hit:Hit = entity.get(Hit);
            var position:Position = entity.get(Position);
            var source:BitmapData = entity.get(BitmapData);

            hit.vanilla = source;
            entity.remove(BitmapData);

            var width:int = source.width;
            var height:int = source.height;
            var middleX:Number = width * 0.5;
            var middleY:Number = height * 0.5;

            for (var x:int = 0; x < width; x += PIXEL)
            {
                for (var y:int = 0; y < height; y += PIXEL)
                {
                    var pixelEntity:Entity = new Entity();

                    var angle:Number = random.rndFloat(Math.PI * 2);

                    var pixel:HitPixel = new HitPixel();
                    pixel.dx = (x - middleX) + Math.cos(angle) * SCALAR;
                    pixel.dy = (y - middleY) + Math.sin(angle) * SCALAR;
                    pixel.entity = pixelEntity;
                    pixel.life = 60;
                    hit.add(pixel);

                    var pixelPos:Position = new Position(position.x + x, position.y + y);

                    rect.setTo(x, y, PIXEL, PIXEL);
                    var target:BitmapData = new BitmapData(PIXEL, PIXEL, true, 0);
                    target.copyPixels(source, rect, ORIGIN, null, null, true);

                    pixelEntity.add(pixel);
                    pixelEntity.add(pixelPos);
                    pixelEntity.add(target);
                    entities.addEntity(pixelEntity);
                }
            }
        }

        private function onEntityRemoved(entity:Entity):void
        {
            var hit:Hit = entity.get(Hit);
            for (var pixel:HitPixel = hit.head; pixel; pixel = pixel.next)
                entities.removeEntity(pixel.entity);

            entity.remove(Hit);
            entity.add(hit.vanilla);
        }

        public function update(time:int, delta:int):void
        {
            for (node = particleEntities.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                var position:Position = entity.get(Position);
                var pixel:HitPixel = entity.get(HitPixel);
                var data:BitmapData = entity.get(BitmapData);

                position.x += pixel.dx;
                position.y += pixel.dy;
                pixel.dx *= FRICTION;
                pixel.dy += GRAVITY;
                pixel.dy *= FRICTION;
                data.applyFilter(data, data.rect, ORIGIN, FADE);

                if (--pixel.life == 0)
                    entities.removeEntity(entity);
            }
        }

    }
}
