package talk.view
{
    import alecmce.math.Random;
    import alecmce.resizing.view.Resizable;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Graphics;

    import flash.display.Shape;
    import flash.geom.Rectangle;

    public class BackgroundFill extends Bitmap implements Resizable
    {
        public function BackgroundFill()
        {
            super();
        }

        public function resize(rectangle:Rectangle):void
        {
            var shape:Shape = new Shape();
            var graphics:Graphics = shape.graphics;

            graphics.beginFill(0xFF9966);
            graphics.drawRect(rectangle.x, rectangle.y, rectangle.width, rectangle.height);
            graphics.endFill();

            var random:Random = new Random();
            for (var i:int = 0; i < 1000; i++)
            {
                var x:int = random.rndInt(rectangle.width);
                var y:int = random.rndInt(rectangle.height);
                var r:int = random.rndInt(50);

                graphics.beginFill(random.color(), random.rndFloat());
                graphics.drawCircle(x, y, r);
                graphics.endFill();
            }

            bitmapData = new BitmapData(rectangle.width, rectangle.height, false, 0);
            bitmapData.draw(shape, null, null, null, null, true);
        }
    }
}
