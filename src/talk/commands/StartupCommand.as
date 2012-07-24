package talk.commands
{
    import alecmce.entitysystem.extensions.renderer.Renderer;
    import alecmce.entitysystem.extensions.robotlegs.signals.StartAllSystems;
    import alecmce.entitysystem.extensions.robotlegs.signals.StartSystem;

    import flash.display.BitmapData;

    import talk.data.Slides;
    import talk.signals.MakeCamera;
    import talk.signals.MakeSlideEntities;
    import talk.signals.SetupFonts;

    public class StartupCommand
    {
        [Inject]
        public var setupFonts:SetupFonts;

        [Inject]
        public var startSystem:StartSystem;

        [Inject]
        public var startAllSystems:StartAllSystems;

        [Inject]
        public var canvas:BitmapData;

        [Inject]
        public var renderer:Renderer;

        [Inject]
        public var makeCamera:MakeCamera;

        [Inject]
        public var makeSlideEntities:MakeSlideEntities;

        [Inject]
        public var slides:Slides;

        public function execute():void
        {
            setupFonts.dispatch();
            makeCamera.dispatch();
            makeSlideEntities.dispatch(slides.slides[0]);

            renderer.setCanvas(canvas);
            startSystem.dispatch(renderer);
            startAllSystems.dispatch();
        }
    }
}
