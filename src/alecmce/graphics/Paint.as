package alecmce.graphics
{
    import flash.display.Graphics;
    import flash.geom.Rectangle;

    public class Paint
    {
        public var width:int;
        public var lineColor:int;
        public var lineAlpha:int;

        public var fillColor:int;
        public var fillAlpha:int;

        public function Paint()
        {
            this.width = 0;
            this.lineColor = 0x000000;
            this.lineAlpha = 1;

            this.fillColor = 0xFFFFFF;
            this.fillAlpha = 0;
        }

        public function drawRectangle(graphics:Graphics, rectangle:Rectangle):void
        {
            graphics.lineStyle(width, lineColor, lineAlpha);
            fillAlpha && graphics.beginFill(fillColor, fillAlpha);
            graphics.drawRect(rectangle.left, rectangle.top, rectangle.width, rectangle.height);
            fillAlpha && graphics.endFill();
        }
    }
}
