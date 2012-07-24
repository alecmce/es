package
{
    import alecmce.entitysystem.extensions.renderer.FullBlitter;
    import alecmce.fonts.BitmapFontDecoder;
    import alecmce.fonts.BitmapFonts;

    import org.swiftsuspenders.Injector;

    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;

    import talk.commands.MakeCameraCommand;
    import talk.commands.MakeSlideEntitiesCommand;
    import talk.commands.SetupFontsCommand;
    import talk.commands.StartupCommand;
    import talk.services.SlideEntitiesFactory;
    import talk.signals.MakeCamera;
    import talk.signals.MakeSlideEntities;
    import talk.signals.SetupFonts;
    import talk.signals.Startup;

    public class TalkConfig
    {
        [Inject]
        public var injector:Injector;

        [Inject]
        public var commandMap:ISignalCommandMap;

        [PostConstruct]
        public function setup():void
        {
            injector.map(SlideEntitiesFactory);
            injector.map(BitmapFontDecoder);

            injector.map(FullBlitter).asSingleton();
            injector.map(BitmapFonts).asSingleton();

            commandMap.map(Startup).toCommand(StartupCommand);
            commandMap.map(SetupFonts).toCommand(SetupFontsCommand);
            commandMap.map(MakeCamera).toCommand(MakeCameraCommand);
            commandMap.map(MakeSlideEntities).toCommand(MakeSlideEntitiesCommand);
        }
    }
}
