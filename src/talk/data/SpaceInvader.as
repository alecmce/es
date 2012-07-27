package talk.data
{
    public class SpaceInvader
    {
        internal var container:SpaceInvaders;

        public var x:int;
        public var y:int;

        public function SpaceInvader()
        {
            reset();
        }

        public function reset():void
        {
            container = null;
            x = -1;
            y = -1;
        }
    }
}
