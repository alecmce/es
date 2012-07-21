package alecmce.util
{
    import flash.display.Shape;
    import flash.events.Event;

    import org.osflash.signals.Signal;

    final public class Invalidator
    {
        private static var eventHook:Shape;

        private var _update:Signal;

        public function Invalidator()
        {
            eventHook ||= new Shape();
        }

        public function get update():Signal
        {
            return _update ||= new Signal();
        }

        public function invalidate():void
        {
            eventHook.addEventListener(Event.ENTER_FRAME, onEnterFrame);
        }

        private function onEnterFrame(event:Event):void
        {
            eventHook.removeEventListener(Event.ENTER_FRAME, onEnterFrame);
            _update && _update.dispatch();
        }

    }
}
