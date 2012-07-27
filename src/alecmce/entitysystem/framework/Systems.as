package alecmce.entitysystem.framework
{
    import flash.display.Shape;
    import flash.events.Event;
    import flash.utils.getTimer;

    final public class Systems
    {
        private var list:Vector.<System>;
        private var count:int;

        private var ticker:Shape;
        private var timeOffset:int;
        private var _time:int;
        private var isRunning:Boolean;

        public function Systems()
        {
            list = new <System>[];
            count = 0;
            _time = 0;

            ticker = new Shape();
            isRunning = false;
        }

        public function get time():int { return _time; }

        public function add(system:System, priority:int = 0):void
        {
            if (list.indexOf(system) == -1)
                addSystem(system);
        }

        public function has(system:System):Boolean
        {
            return list.indexOf(system) != -1;
        }

        public function remove(system:System):void
        {
            var i:int = list.indexOf(system);
            if (i != -1)
                removeSystem(system, i);
        }

        public function getList():Vector.<System>
        {
            return list.concat();
        }

        public function start():void
        {
            if (!isRunning)
            {
                isRunning = true;
                startAllSystems();
                startIterating();
            }
        }

        public function stop():void
        {
            if (isRunning)
            {
                isRunning = false;
                stopAllSystems();
            }
        }

        private function addSystem(system:System):void
        {
            list.unshift(system);
            ++count;

            if (isRunning)
                system.start(_time);
        }

        private function removeSystem(system:System, index:int):void
        {
            list.splice(index, 1);
            --count;

            if (isRunning)
                system.stop(_time);
        }

        private function startAllSystems():void
        {
            var i:int = count;
            while (i--)
                list[i].start(_time);
        }

        private function stopAllSystems():void
        {
            var i:int = count;
            while (i--)
                list[i].stop(_time);
        }

        private function startIterating():void
        {
            ticker.addEventListener(Event.ENTER_FRAME, iterate);
            timeOffset = getTimer();
        }

        private function iterate(event:Event):void
        {
            var timer:int = getTimer();
            var delta:int = timer - timeOffset;
            timeOffset = timer;
            _time += delta;

            var i:int = count;
            while (i--)
                list[i].update(_time, delta);
        }
    }
}