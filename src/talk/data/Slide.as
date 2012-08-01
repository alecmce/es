package talk.data
{
    import alecmce.entitysystem.framework.Entity;
    import alecmce.graphics.Brush;

    import flash.display.BitmapData;
    import flash.display.DisplayObject;

    public class Slide
    {
        public var entity:Entity;
        public var name:String;

        public var x:int;
        public var y:int;
        public var offsetX:int;
        public var offsetY:int;
        public var width:int;
        public var height:int;

        public var title:SlideText;
        public var border:Brush;
        public var insetOutline:int;

        public var points:Vector.<SlideText>;
        public var images:Vector.<SlideImage>;
        public var flashes:Vector.<SlideFlash>;
        public var targets:Vector.<Target>;

        public var step:int = 0;
        private var targetMap:Object;

        public function Slide()
        {
            points = new <SlideText>[];
            images = new <SlideImage>[];
            flashes = new <SlideFlash>[];
            targets = new <Target>[];
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

        public function addSlideTarget(name:String, slide:Slide, priority:int,  color:int = 0xFFFF66):void
        {
            var target:SlideTarget = new SlideTarget(name, slide, priority, color);
            targets.push(target);
            targetMap[name] = target;
        }

        public function addAction(name:String,  color:int = 0xFFEE00):void
        {
            var target:ActionTarget = new ActionTarget(name, color);
            targets.push(target);
        }

        public function getSlideTarget(name:String):Slide
        {
            var target:SlideTarget = targetMap[name];
            return target ? target.getSlide() : null;
        }

        public function addImage(x:int, y:int, data:BitmapData, step:int = 0):void
        {
            var image:SlideImage = new SlideImage();
            image.x = x;
            image.y = y;
            image.data = data;
            image.step = step;

            images.push(image);
        }

        public function addPoint(x:int, y:int, point:String, step:int = 0, isSmall:Boolean = false):void
        {
            var text:SlideText = new SlideText();
            text.font = isSmall ? "small" : "body";
            text.x = x;
            text.y = y;
            text.text = point;
            text.step = step;

            points.push(text);
        }

        public function addFlashElement(x:int, y:int, data:DisplayObject, step:int = 0):void
        {
            var flash:SlideFlash = new SlideFlash();
            flash.data = data;
            flash.x = x;
            flash.y = y;
            flash.step = step;

            flashes.push(flash);
        }
    }
}
