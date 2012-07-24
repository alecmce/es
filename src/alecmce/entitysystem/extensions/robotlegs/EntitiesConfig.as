package alecmce.entitysystem.extensions.robotlegs
{
    import alecmce.entitysystem.extensions.renderer.FullBlitter;
    import alecmce.entitysystem.extensions.renderer.Renderer;
    import alecmce.entitysystem.extensions.robotlegs.commands.StartAllSystemsCommand;
    import alecmce.entitysystem.extensions.robotlegs.commands.StartSystemCommand;
    import alecmce.entitysystem.extensions.robotlegs.commands.StopSystemCommand;
    import alecmce.entitysystem.extensions.robotlegs.signals.StartAllSystems;
    import alecmce.entitysystem.extensions.robotlegs.signals.StartSystem;
    import alecmce.entitysystem.extensions.robotlegs.signals.StopSystem;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Systems;

    import org.swiftsuspenders.Injector;

    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;

    public class EntitiesConfig
    {
        [Inject]
        public var injector:Injector;

        [Inject]
        public var commandMap:ISignalCommandMap;

        [PostConstruct]
        public function setup():void
        {
            injector.map(Entities).asSingleton();
            injector.map(Systems).asSingleton();

            injector.map(Renderer).toSingleton(FullBlitter);

            commandMap.map(StartAllSystems).toCommand(StartAllSystemsCommand);
            commandMap.map(StartAllSystems).toCommand(StartAllSystemsCommand);
            commandMap.map(StartSystem).toCommand(StartSystemCommand);
            commandMap.map(StopSystem).toCommand(StopSystemCommand);
        }
    }
}
