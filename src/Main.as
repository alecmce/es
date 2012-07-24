package
{
    import alecmce.console.ConsoleExtension;
    import alecmce.entitysystem.extensions.robotlegs.EntitiesConfig;
    import alecmce.entitysystem.extensions.robotlegs.EntitiesExtension;
    import alecmce.resizing.ResizeExtension;

    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;

    import robotlegs.bender.bundles.mvcs.MVCSBundle;
    import robotlegs.bender.extensions.signalCommandMap.SignalCommandMapExtension;
    import robotlegs.bender.framework.impl.Context;

    import talk.signals.Startup;

    [SWF(width="800", height="600", backgroundColor="#FFFFFF", frameRate="60")]
    public class Main extends Sprite
    {
        private var context:Context;

        private var bitmapData:BitmapData;
        private var bitmap:Bitmap;

        public function Main()
        {
            makeBitmapData();
            makeBitmap();

            context = new Context();
            context.extend(MVCSBundle)
                   .extend(SignalCommandMapExtension)
                   .extend(EntitiesExtension)
                   .extend(ConsoleExtension)
                   .extend(ResizeExtension)
                   .configure(EntitiesConfig)
                   .configure(TalkConfig, this)
                   .configure(TempConfig, this);

            context.injector.map(BitmapData).toValue(bitmapData);
            context.injector.getInstance(Startup).dispatch();
        }

        private function makeBitmapData():void
        {
            var width:int = stage.stageWidth;
            var height:int = stage.stageHeight;
            bitmapData = new BitmapData(width, height, true, 0x00000000);
        }

        private function makeBitmap():void
        {
            bitmap = new Bitmap(bitmapData);
            addChild(bitmap);
        }
    }
}
