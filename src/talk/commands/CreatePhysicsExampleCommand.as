package talk.commands
{
    import flash.display.DisplayObjectContainer;

    import talk.physics.PhysicsExample;

    public class CreatePhysicsExampleCommand
    {
        [Inject]
        public var contextView:DisplayObjectContainer;

        public function execute():void
        {
            var example:PhysicsExample = new PhysicsExample();
            contextView.addChild(example);
        }
    }
}
