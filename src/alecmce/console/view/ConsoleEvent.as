package alecmce.console.view
{
    import flash.events.Event;

    final public class ConsoleEvent extends Event
    {
        public static const INPUT:String = "ConsoleEvent.INPUT";
        public static const GET_PREVIOUS:String = "ConsoleEvent.GET_PREVIOUS";
        public static const GET_NEXT:String = "ConsoleEvent.GET_NEXT";
        public static const OUTPUT:String = "ConsoleEvent.OUTPUT";

        public var data:String;

        public function ConsoleEvent(type:String, data:String = "")
        {
            super(type, false, false);
            this.data = data;
        }
    }
}
