package talk.data
{
    public class Size
    {
        public var left:int;
        public var right:int;
        public var top:int;
        public var bottom:int;

        public function getWidth():int
        {
            return right + 1 - left;
        }

        public function getHeight():int
        {
            return bottom + 1 - top;
        }
    }
}
