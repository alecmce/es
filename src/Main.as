package
{
    import alecmce.console.ConsoleExtension;
    import alecmce.entitysystem.extensions.robotlegs.EntitiesConfig;
    import alecmce.entitysystem.extensions.robotlegs.EntitiesExtension;
    import alecmce.resizing.ResizeExtension;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.display.StageAlign;
    import flash.display.StageDisplayState;
    import flash.display.StageScaleMode;
    import flash.geom.Rectangle;

    import robotlegs.bender.bundles.mvcs.MVCSBundle;
    import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
    import robotlegs.bender.framework.impl.Context;

    import talk.signals.Startup;

    [SWF(width="800", height="600", backgroundColor="#FFFFFF", frameRate="60")]
    public class Main extends Sprite
    {
        private var context:Context;

        private var layers:Layers;

        public function Main()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE;
            stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
            stage.align = StageAlign.TOP_LEFT;

            makeLayers();
            makeContext();
        }

        private function makeLayers():void
        {
            var size:Rectangle = new Rectangle(0, 0, stage.stageWidth, stage.stageHeight);
            layers = new Layers(size);
            addChild(layers);
        }

        private function makeContext():void
        {
            context = new Context();
            context.injector.map(Layers).toValue(layers);

            context.extend(MVCSBundle)
                    .extend(SignalCommandMapExtension)
                    .extend(EntitiesExtension)
                    .extend(ConsoleExtension)
                    .extend(ResizeExtension)
                    .configure(EntitiesConfig)
                    .configure(TalkConfig, this)
                    .configure(SlideConfig, this);

            context.injector.getInstance(Startup).dispatch();
        }

    }
}
