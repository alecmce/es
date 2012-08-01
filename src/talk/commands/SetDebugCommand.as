package talk.commands
{
    import talk.data.Debug;

    public class SetDebugCommand
    {
        [Inject]
        public var debug:Debug;

        public function execute():void
        {
            debug.isDebug = true;
        }
    }
}
