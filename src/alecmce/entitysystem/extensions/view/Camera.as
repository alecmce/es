package alecmce.entitysystem.extensions.view
{
    public class Camera
    {
        public var left:Number;
        public var top:Number;
        public var width:Number;
        public var height:Number;

        public function Camera(left:Number = 0, top:Number = 0, width:Number = 0, height:Number = 0)
        {
            this.left = left;
            this.top = top;
            this.width = width;
            this.height = height;
        }

        public function contains(x:Number, y:Number, padding:int = 0):Boolean
        {
            return x >= (left - padding) &&
                   x <= (left + width + padding) &&
                   y >= (top - padding) &&
                   y <= (top + height + padding);
        }
    }
}
