package alecmce.console.model
{
    import alecmce.console.vo.ConsoleAction;

    import org.osflash.signals.Signal;

    final public class Console
    {
        private var hash:ActionHash;
        private var history:ActionHistory;

        public function Console()
        {
            hash = new ActionHash();
            history = new ActionHistory();
        }

        public function register(action:ConsoleAction, signal:Signal):void
        {
            hash.register(action.name, action.description, signal);
        }

        public function hasAction(action:String):Boolean
        {
            return hash.has(action);
        }

        public function execute(data:String):void
        {
            history.add(data);
            hash.execute(data);
        }

        public function getNames():Vector.<String>
        {
            return hash.getNames();
        }

        public function getPreviousAction():String
        {
            return history.getPrevious();
        }

        public function getNextAction():String
        {
            return history.getNext();
        }
    }
}
