package talk.data
{
    public class ActionTarget implements Target
    {
        private var name:String;
        private var color:int;
        private var priority:int;

        public function ActionTarget(name:String, priority:int,  color:int)
        {
            this.name = name;
            this.priority = priority;
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

        public function getPriority():int
        {
            return priority;
        }
    }
}
