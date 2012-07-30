package talk.data
{
    import alecmce.entitysystem.framework.Entity;
    import alecmce.graphics.Brush;

    import flash.display.BitmapData;

    public class Slide
    {
        public var entity:Entity;

        public var x:int;
        public var y:int;
        public var width:int;
        public var height:int;

        public var title:SlideText;
        public var border:Brush;
        public var padding:int;

        public var points:Vector.<SlideText>;
        public var images:Vector.<SlideImage>;
        public var targets:Vector.<SlideTarget>;

        private var targetMap:Object;

        public function Slide()
        {
            points = new <SlideText>[];
            images = new <SlideImage>[];
            targets = new <SlideTarget>[];
            targetMap = {};
        }

        public function setTitle(x:int, y:int, text:String):void
        {
            title = new SlideText();
            title.font = "title";
            title.x = x;
            title.y = y;
            title.text = text;
        }

        public function addTarget(name:String, slide:Slide, color:int = 0xFFFF66):void
        {
            var target:SlideTarget = new SlideTarget();
            target.name = name;
            target.slide = slide;
            target.color = color;

            targets.push(target);
            targetMap[name] = target;
        }

        public function getTarget(name:String):Slide
        {
            var target:SlideTarget = targetMap[name];
            return target ? target.slide : null;
        }

        public function addImage(x:int, y:int, data:BitmapData):void
        {
            var image:SlideImage = new SlideImage();
            image.x = x;
            image.y = y;
            image.data = data;

            images.push(image);
        }

        public function addPoint(x:int, y:int, point:String):void
        {
            var text:SlideText = new SlideText();
            text.font = "body";
            text.x = x;
            text.y = y;
            text.text = point;

            points.push(text);
        }
    }
}
