package
{
    import alecmce.console.signals.RegisterConsoleAction;
    import alecmce.console.view.ConsoleView;
    import alecmce.console.vo.ConsoleAction;
    import alecmce.entitysystem.extensions.view.Camera;
    import alecmce.entitysystem.extensions.view.display.DisplayUpdateSystem;
    import alecmce.fonts.BitmapFontDecoder;
    import alecmce.fonts.BitmapFonts;
    import alecmce.math.Random;

    import org.swiftsuspenders.Injector;

    import robotlegs.bender.extensions.signalCommandMap.api.ISignalCommandMap;

    import talk.commands.SetInvaderGraphicsCommand;

    import talk.commands.AddSpaceshipCommand;

    import talk.commands.CollapseSlideEntitiesCommand;
    import talk.commands.GotoSlideCommand;
    import talk.commands.MakeSlideEntitiesCommand;
    import talk.commands.RemoveSelectedSlideSystemsCommand;
    import talk.commands.RiseSlideEntitiesCommand;
    import talk.commands.SetLetterGraphicsCommand;
    import talk.commands.SetupFontsCommand;
    import talk.commands.InvaderSlideEntitiesCommand;
    import talk.commands.StartupCommand;
    import talk.factories.AssetFactory;
    import talk.factories.SlideCharacterEntityFactory;
    import talk.signals.SetInvaderGraphics;
    import talk.signals.AddSpaceship;
    import talk.signals.CollapseVisible;
    import talk.signals.GotoSlide;
    import talk.signals.MakeSlideEntities;
    import talk.signals.RemoveSelectedSlideSystems;
    import talk.signals.RiseVisible;
    import talk.signals.SetLetterGraphics;
    import talk.signals.SetupFonts;
    import talk.signals.SpaceInvadersVisible;
    import talk.signals.Startup;
    import talk.systems.AnimationSystem;
    import talk.systems.BulletSystem;
    import talk.systems.CollapseSystem;
    import talk.systems.FiringSystem;
    import talk.systems.HitSystem;
    import talk.systems.KeyMovementSystem;
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

            injector.map(Random);
            injector.map(DisplayUpdateSystem).asSingleton();
            injector.map(BitmapFonts).asSingleton();

            injector.map(RiseSystem).asSingleton();
            injector.map(CollapseSystem).asSingleton();
            injector.map(SlideSelectionSystem).asSingleton();
            injector.map(KeyMovementSystem).asSingleton();
            injector.map(FiringSystem).asSingleton();
            injector.map(BulletSystem).asSingleton();
            injector.map(HitSystem).asSingleton();
            injector.map(AnimationSystem).asSingleton();

            injector.map(AssetFactory).asSingleton();

            commandMap.map(Startup).toCommand(StartupCommand);
            commandMap.map(SetupFonts).toCommand(SetupFontsCommand);
            commandMap.map(MakeSlideEntities).toCommand(MakeSlideEntitiesCommand);
            commandMap.map(CollapseVisible).toCommand(CollapseSlideEntitiesCommand);
            commandMap.map(RiseVisible).toCommand(RiseSlideEntitiesCommand);
            commandMap.map(SpaceInvadersVisible).toCommand(InvaderSlideEntitiesCommand);
            commandMap.map(GotoSlide).toCommand(GotoSlideCommand);
            commandMap.map(RemoveSelectedSlideSystems).toCommand(RemoveSelectedSlideSystemsCommand);
            commandMap.map(AddSpaceship).toCommand(AddSpaceshipCommand);
            commandMap.map(SetInvaderGraphics).toCommand(SetInvaderGraphicsCommand);
            commandMap.map(SetLetterGraphics).toCommand(SetLetterGraphicsCommand);

            layers.console.addChild(new ConsoleView());

            var camera:Camera = new Camera(0, 0, 800, 600);
            injector.map(Camera).toValue(camera);

            makeRiseAction();
            makeCollapseAction();
            makeSpaceInvaderAction();
            makeSpaceshipAction();
            makeGotoSlideAction();
            makeInvaderAnimationsAction();
            makeLetterGraphicsAction();
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

        private function makeSpaceInvaderAction():void
        {
            var action:ConsoleAction = new ConsoleAction();
            action.name = "invasion";
            action.description = "makes space invaders out of visible entities";
            registerConsole.dispatch(action, injector.getInstance(SpaceInvadersVisible));
        }

        private function makeSpaceshipAction():void
        {
            var action:ConsoleAction = new ConsoleAction();
            action.name = "spaceship";
            action.description = "makes a spaceship";
            registerConsole.dispatch(action, injector.getInstance(AddSpaceship));
        }

        private function makeInvaderAnimationsAction():void
        {
            var action:ConsoleAction = new ConsoleAction();
            action.name = "invaders";
            action.description = "makes entities look like space invaders";
            registerConsole.dispatch(action, injector.getInstance(SetInvaderGraphics));
        }

        private function makeLetterGraphicsAction():void
        {
            var action:ConsoleAction = new ConsoleAction();
            action.name = "letters";
            action.description = "makes entities look like letters";
            registerConsole.dispatch(action, injector.getInstance(SetLetterGraphics));
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
