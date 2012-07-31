package talk.data
{
    public class ActionTarget implements Target
    {
        private var name:String;
        private var color:int;

        public function ActionTarget(name:String, color:int)
        {
            this.name = name;
            this.color = color;
        }

        public function getName():String
        {
            return name;
        }

        public function getColor():int
        {
            return color;
        }
    }
}
