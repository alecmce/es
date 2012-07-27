package
{
    import alecmce.console.signals.RegisterConsoleAction;
    import alecmce.console.view.ConsoleView;
    import alecmce.console.vo.ConsoleAction;
    import alecmce.entitysystem.extensions.view.Camera;
    import alecmce.entitysystem.extensions.view.display.DisplayUpdateSystem;
    import alecmce.fonts.BitmapFontDecoder;
    import alecmce.fonts.BitmapFonts;

    import org.swiftsuspenders.Injector;

    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;

    import talk.commands.CollapseVisibleEntitiesCommand;
    import talk.commands.GotoSlideCommand;
    import talk.commands.MakeSlideEntitiesCommand;
    import talk.commands.RiseVisibleEntitiesCommand;
    import talk.commands.SetupFontsCommand;
    import talk.commands.StartupCommand;
    import talk.factories.SlideCharacterEntityFactory;
    import talk.signals.CollapseVisible;
    import talk.signals.GotoSlide;
    import talk.signals.MakeSlideEntities;
    import talk.signals.RiseVisible;
    import talk.signals.SetupFonts;
    import talk.signals.Startup;
    import talk.systems.CollapseSystem;
    import talk.systems.RiseSystem;
    import talk.systems.SlideSelectionSystem;

    public class TalkConfig
    {
        [Inject]
        public var injector:Injector;

        [Inject]
        public var layers:Layers;

        [Inject]
        public var commandMap:ISignalCommandMap;

        [Inject]
        public var registerConsole:RegisterConsoleAction;

        [PostConstruct]
        public function setup():void
        {
            injector.map(SlideCharacterEntityFactory);
            injector.map(BitmapFontDecoder);

            injector.map(DisplayUpdateSystem).asSingleton();
            injector.map(BitmapFonts).asSingleton();

            injector.map(RiseSystem).asSingleton();
            injector.map(CollapseSystem).asSingleton();
            injector.map(SlideSelectionSystem).asSingleton();

            commandMap.map(Startup).toCommand(StartupCommand);
            commandMap.map(SetupFonts).toCommand(SetupFontsCommand);
            commandMap.map(MakeSlideEntities).toCommand(MakeSlideEntitiesCommand);
            commandMap.map(CollapseVisible).toCommand(CollapseVisibleEntitiesCommand);
            commandMap.map(RiseVisible).toCommand(RiseVisibleEntitiesCommand);
            commandMap.map(GotoSlide).toCommand(GotoSlideCommand);

            layers.console.addChild(new ConsoleView());

            var camera:Camera = new Camera(0, 0, 800, 600);
            injector.map(Camera).toValue(camera);

            makeRiseAction();
            makeCollapseAction();
            makeGotoSlideAction();
        }

        private function makeRiseAction():void
        {
            var action:ConsoleAction = new ConsoleAction();
            action.name = "rise";
            action.description = "move entities to their character positions";
            registerConsole.dispatch(action, injector.getInstance(RiseVisible));
        }

        private function makeCollapseAction():void
        {
            var action:ConsoleAction = new ConsoleAction();
            action.name = "collapse";
            action.description = "creates a simulation that collapses all visible entities";
            registerConsole.dispatch(action, injector.getInstance(CollapseVisible));
        }

        private function makeGotoSlideAction():void
        {
            var action:ConsoleAction = new ConsoleAction();
            action.name = "gotoSlide";
            action.description = "goes to a given slide index";
            registerConsole.dispatch(action, injector.getInstance(GotoSlide));
        }
    }
}
