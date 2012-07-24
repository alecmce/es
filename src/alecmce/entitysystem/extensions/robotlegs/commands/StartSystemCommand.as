package alecmce.entitysystem.extensions.robotlegs.commands
{
    import alecmce.entitysystem.framework.System;
    import alecmce.entitysystem.framework.Systems;

    public class StartSystemCommand
    {
        [Inject]
        public var systems:Systems;

        [Inject]
        public var system:System;

        public function execute():void
        {
            systems.add(system);
        }
    }
}
