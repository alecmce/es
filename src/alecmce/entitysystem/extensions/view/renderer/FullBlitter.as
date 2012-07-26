package alecmce.entitysystem.extensions.view.renderer
{
    import alecmce.entitysystem.extensions.view.Camera;
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;

    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.geom.Matrix;
    import flash.geom.Point;

    public class FullBlitter implements Renderer
    {
        private static const PADDING:int = 100;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var camera:Camera;

        private var canvas:BitmapData;
        private var point:Point;
        private var matrix:Matrix;

        private var collection:Collection;
        private var node:Node;
        private var entity:Entity;

        public function FullBlitter()
        {
            point = new Point();
            matrix = new Matrix();
        }

        [PostConstruct]
        public function setup():void
        {
            collection = entities.getCollection(new <Class>[Position, BitmapData]);
        }

        public function setCanvas(canvas:BitmapData):void
        {
            this.canvas = canvas;
        }

        public function start(time:int):void {}

        public function update(time:int, delta:int):void
        {
            if (!canvas)
                return;

            canvas.fillRect(canvas.rect, 0x00000000);

            for (node = collection.head; node; node = node.next)
            {
                entity = node.entity;
                var pos:Position = entity.get(Position);
                var data:BitmapData = entity.get(BitmapData);

                if (camera.contains(pos.x, pos.y, PADDING))
                {
                    var x:Number = pos.x - camera.left;
                    var y:Number = pos.y - camera.top;

                    if (pos.hasRotation())
                    {
                        var r:Vector.<Number> = pos.rotation.getMatrix();
                        matrix.setTo(r[0], r[1], r[2], r[3], x, y);
                        canvas.draw(data, matrix, null, BlendMode.NORMAL, null, true);
                    }
                    else
                    {
                        point.setTo(x, y);
                        canvas.copyPixels(data, data.rect, point, null, null, true);
                    }
                }
            }
        }

        public function stop(time:int):void {}
    }
}
