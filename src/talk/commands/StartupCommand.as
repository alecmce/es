package talk.commands
{
    import alecmce.entitysystem.extensions.robotlegs.signals.StartAllSystems;
    import alecmce.entitysystem.extensions.robotlegs.signals.StartSystem;
    import alecmce.entitysystem.extensions.view.display.DisplayUpdateSystem;
    import alecmce.entitysystem.extensions.view.renderer.Renderer;

    import talk.data.Slides;
    import talk.signals.MakeCamera;
    import talk.signals.MakeSlides;
    import talk.signals.SetupFonts;
    import talk.systems.AnimationSystem;
    import talk.systems.BulletSystem;
    import talk.systems.FiringSystem;
    import talk.systems.HitSystem;
    import talk.systems.KeyMovementSystem;
    import talk.systems.SlideSelectionSystem;

    public class StartupCommand
    {
        [Inject]
        public var layers:Layers;

        [Inject]
        public var setupFonts:SetupFonts;

        [Inject]
        public var startSystem:StartSystem;

        [Inject]
        public var startAllSystems:StartAllSystems;

        [Inject]
        public var displayUpdater:DisplayUpdateSystem;

        [Inject]
        public var renderer:Renderer;

        [Inject]
        public var slideSelection:SlideSelectionSystem;

        [Inject]
        public var keyControl:KeyMovementSystem;

        [Inject]
        public var makeCamera:MakeCamera;

        [Inject]
        public var makeSlideEntities:MakeSlides;

        [Inject]
        public var slides:Slides;

        [Inject]
        public var displayUpdate:DisplayUpdateSystem;

        [Inject]
        public var firing:FiringSystem;

        [Inject]
        public var bullet:BulletSystem;

        [Inject]
        public var hits:HitSystem;

        [Inject]
        public var animations:AnimationSystem;

        public function execute():void
        {
            setupFonts.dispatch();
            makeCamera.dispatch();
            makeSlideEntities.dispatch();

            displayUpdater.setContainer(layers.main);
            renderer.setCanvas(layers.canvas.bitmapData);

            startSystem.dispatch(renderer);
            startSystem.dispatch(displayUpdate);
            startSystem.dispatch(keyControl);
            startSystem.dispatch(firing);
            startSystem.dispatch(bullet);
            startSystem.dispatch(hits);
            startSystem.dispatch(animations);
            startAllSystems.dispatch();
        }
    }
}
