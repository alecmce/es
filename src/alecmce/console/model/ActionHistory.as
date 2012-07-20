package alecmce.console.model
{
    final internal class ActionHistory
    {
        private var stack:Vector.<String>;
        private var index:int;

        public function ActionHistory()
        {
            stack = new Vector.<String>();
            index = 0;
        }

        public function add(line:String):void
        {
            index = stack.push(line);
        }

        public function get length():int
        {
            return stack.length;
        }

        public function getPrevious():String
        {
            return index > 0 ? stack[--index] : "";
        }

        public function getNext():String
        {
            return index < stack.length - 1 ? stack[++index] : "";
        }
    }

}
