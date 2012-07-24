package alecmce.entitysystem.extensions.robotlegs.commands
{
    import alecmce.entitysystem.framework.Systems;

    public class StartAllSystemsCommand
    {
        [Inject]
        public var systems:Systems;

        public function execute():void
        {
            systems.start();
        }
    }
}
