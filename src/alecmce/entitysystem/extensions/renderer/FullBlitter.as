package alecmce.entitysystem.extensions.renderer
{
    import alecmce.entitysystem.extensions.concepts.Camera;
    import alecmce.entitysystem.extensions.concepts.Position;
    import alecmce.entitysystem.extensions.concepts.Renderable;
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
        [Inject]
        public var entities:Entities;

        private var canvas:BitmapData;
        private var point:Point;
        private var matrix:Matrix;

        private var renderables:Collection;
        private var cameras:Collection;

        public function FullBlitter()
        {
            point = new Point();
            matrix = new Matrix();
        }

        [PostConstruct]
        public function setup():void
        {
            renderables = entities.getCollection(new <Class>[Position, Renderable]);
            cameras = entities.getCollection(new <Class>[Position, Camera]);
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

            var entity:Entity = cameras.head ? cameras.head.entity : null;
            if (!entity)
                return;

            var center:Position = entity.get(Position);
            var camera:Camera = entity.get(Camera);

            for (var node:Node = renderables.head; node; node = node.next)
            {
                entity = node.entity;
                var position:Position = entity.get(Position);
                var renderable:Renderable = entity.get(Renderable);

                var x:Number = position.x - center.x;
                var y:Number = position.y - center.y;
                if (camera.bounds.contains(x, y))
                {
                    if (renderable.matrix)
                    {
                        var m:Matrix = renderable.matrix;
                        matrix.setTo(m.a, m.b, m.c, m.d, x, y);
                        canvas.draw(renderable.data, matrix, null, BlendMode.NORMAL, null, true);
                    }
                    else
                    {
                        point.setTo(x, y);
                        canvas.copyPixels(renderable.data, renderable.data.rect, point, null, null, true);
                    }
                }
            }
        }

        public function stop(time:int):void {}
    }
}
