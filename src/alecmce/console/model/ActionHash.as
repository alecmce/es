package alecmce.console.model
{
    import org.osflash.signals.Signal;

    final internal class ActionHash
    {
        private var signalMap:Object;
        private var descriptionMap:Object;

        public function ActionHash()
        {
            signalMap = {};
            descriptionMap = {};
        }

        public function register(name:String, description:String, signal:Signal):void
        {
            signalMap[name] = signal;
            descriptionMap[name] = description;
        }

        public function getNames():Vector.<String>
        {
            var names:Vector.<String> = new <String>[];
            for (var name:String in signalMap)
            {
                names.push(name + " - " + descriptionMap[name]);
            }

            return names;
        }

        public function execute(input:String):void
        {
            var data:Array = input.split(" ");
            if (data.length == 0)
                return;

            var name:String = data.shift();
            var signal:Signal = signalMap[name];
            if (signal)
                signal.dispatch.apply(this, data);
        }

        public function has(action:String):Boolean
        {
            var data:Array = action.split(" ");
            return data.length > 0 && signalMap[data[0]] != null;
        }
    }
}
