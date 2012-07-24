package alecmce.util
{
    import flash.display.DisplayObject;
    import flash.events.Event;

    import org.osflash.signals.Signal;

    public class StageLifecycleUtil
    {
        private var target:DisplayObject;

        private var _addedToStage:Signal;
        private var _removedFromStage:Signal;

        public function StageLifecycleUtil(target:DisplayObject)
        {
            this.target = target;

            target.addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
        }

        private function handleAddedToStage(event:Event):void
        {
            target.removeEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
            target.addEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
            _addedToStage && _addedToStage.dispatch();
        }

        private function handleRemovedFromStage(event:Event):void
        {
            target.addEventListener(Event.ADDED_TO_STAGE, handleAddedToStage);
            target.removeEventListener(Event.REMOVED_FROM_STAGE, handleRemovedFromStage);
            _removedFromStage && _removedFromStage.dispatch();
        }

        public function get addedToStage():Signal
        {
            return _addedToStage ||= new Signal();
        }

        public function get removedFromStage():Signal
        {
            return _removedFromStage ||= new Signal();
        }
    }
}
