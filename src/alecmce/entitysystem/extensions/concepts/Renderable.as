package alecmce.entitysystem.extensions.concepts
{
    import flash.display.BitmapData;
    import flash.geom.Matrix;

    public class Renderable
    {
        public var data:BitmapData;
        public var matrix:Matrix;

        public function Renderable(data:BitmapData = null)
        {
            this.data = data;
        }
    }
}
