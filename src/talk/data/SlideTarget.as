package talk.data
{
    public class SlideTarget implements Target
    {
        private var name:String;
        private var slide:Slide;
        private var priority:int;
        private var color:int = 0xFFFF66;

        public function SlideTarget(name:String, slide:Slide, priority:int, color:int)
        {
            this.name = name;
            this.slide = slide;
            this.priority = priority;
            this.color = color;
        }

        public function getName():String
        {
            return name;
        }

        public function getSlide():Slide
        {
            return slide;
        }

        public function getColor():int
        {
            return color;
        }

        public function getPriority():int
        {
            return priority;
        }
    }
}
