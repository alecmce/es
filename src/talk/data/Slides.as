package talk.data
{
    public class Slides
    {
        public var current:Slide;

        public var slideMap:Object;

        public function Slides()
        {
            slideMap = {};
        }

        public function addSlide(slide:Slide):void
        {
            slideMap[slide.name] = slide;
        }

        public function getSlide(name:String):Slide
        {
            return slideMap[name];
        }
    }
}
