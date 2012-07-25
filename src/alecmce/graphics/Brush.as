package alecmce.graphics
{
    import flash.display.Graphics;
    import flash.geom.Rectangle;

    public class Brush
    {
        public var width:int;
        public var rgb:int;
        public var alpha:int;

        public function Brush()
        {
            this.width = 0;
            this.rgb = 0x000000;
            this.alpha = 1;
        }

        public function drawRectangle(graphics:Graphics, rectangle:Rectangle):void
        {
            graphics.lineStyle(width, rgb, alpha);
            graphics.drawRect(rectangle.left, rectangle.top, rectangle.width, rectangle.height);
        }
    }
}
