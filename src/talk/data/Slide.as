package talk.data
{
    import alecmce.graphics.Brush;

    public class Slide
    {
        public var x:int;
        public var y:int;
        public var width:int;
        public var height:int;

        public var title:SlideText;
        public var points:Vector.<SlideText>;
        public var index:int;
        public var border:Brush;
    }
}
