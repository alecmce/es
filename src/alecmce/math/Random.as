package alecmce.math
{
    public class Random
    {
        private static const MOD:int = 2147483647;
        private static const SCALAR:int = 16807;

        private var _current:uint;
        private var _seed:uint;

        public function Random()
        {
            setSeed(0);
        }

        public function setSeed(seed:uint):void
        {
            _seed = seed || Math.random() * MOD;
            _current = _seed;
        }

        public function rndInt(range:int = 0):int
        {
            return range == 0 ? next() : next() % range;
        }

        public function rndFloat(range:Number = 1.0):Number
        {
            return range * (next() / MOD);
        }

        public function nextBool(chance:Number = 0.5):Boolean
        {
            return next() < chance;
        }

        public function from(unsorted:Array):*
        {
            return unsorted[rndInt(unsorted.length)];
        }

        public function list(unsorted:Array):Array
        {
            var list:Array = copyArray(unsorted);
            shuffleArray(list);
            return list;
        }

        public function sublist(unsorted:Array, count:int):Array
        {
            return list(unsorted).slice(0, count);
        }

        public function color():uint
        {
            var r = rndInt(0xFF) << 16;
            var g = rndInt(0xFF) << 8;
            var b = rndInt(0xFF);

            return 0xFF000000 | r | g | b;
        }

        private function next():uint
        {
            var n:int = _current = (_current * SCALAR) % MOD;
            return n < 0 ? n + MOD : n;
        }

        private function copyArray(array:Array):Array
        {
            var clone:Array = [];

            var count:uint = array.length;
            for (var i:int = 0; i < count; i++)
                clone[i] = array[i];

            return clone;
        }

        private function shuffleArray(array:Array):void
        {
            var x:uint = array.length - 1;
            for (var i:int = 0; i < x; i++)
            {
                var index:int = rndInt(x--);
                var value:* = array[index];
                array[index] = array[x];
                array[x] = value;
            }
        }
    }
}
