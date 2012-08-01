package talk.commands
{
    import talk.data.Debug;

    public class ClearDebugCommand
    {
        [Inject]
        public var debug:Debug;

        public function execute():void
        {
            debug.isDebug = false;
        }
    }
}
