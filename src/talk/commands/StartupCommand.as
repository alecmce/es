package talk.commands
{
    import alecmce.entitysystem.extensions.view.display.DisplayUpdateSystem;
    import alecmce.entitysystem.extensions.view.renderer.Renderer;
    import alecmce.entitysystem.extensions.robotlegs.signals.StartAllSystems;
    import alecmce.entitysystem.extensions.robotlegs.signals.StartSystem;

    import flash.display.BitmapData;
    import flash.display.DisplayObjectContainer;

    import talk.data.Slides;
    import talk.signals.MakeCamera;
    import talk.signals.MakeSlideEntities;
    import talk.signals.SetupFonts;
    import talk.systems.CollapseSystem;
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
        public var makeCamera:MakeCamera;

        [Inject]
        public var makeSlideEntities:MakeSlideEntities;

        [Inject]
        public var slides:Slides;

        [Inject]
        public var displayUpdate:DisplayUpdateSystem;

        public function execute():void
        {
            setupFonts.dispatch();
            makeCamera.dispatch();
            makeSlideEntities.dispatch(slides.list[0]);
            makeSlideEntities.dispatch(slides.list[1]);

            displayUpdater.setContainer(layers.main);
            renderer.setCanvas(layers.canvas.bitmapData);

            startSystem.dispatch(renderer);
            startSystem.dispatch(displayUpdate);
            startAllSystems.dispatch();
        }
    }
}
