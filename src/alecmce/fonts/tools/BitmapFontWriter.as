package alecmce.fonts.tools
{
    import alecmce.fonts.BitmapFont;
    import alecmce.fonts.BitmapFontEncoder;
    import alecmce.fonts.BitmapFontFactory;
    import alecmce.fonts.BitmapFontConfig;

    import flash.display.Sprite;
    import flash.net.FileReference;
    import flash.utils.ByteArray;

    [SWF(width="800", height="600", backgroundColor="#FFCC99", frameRate="60")]
    public class BitmapFontWriter extends Sprite
    {
        private var config:BitmapFontConfig;

        public function BitmapFontWriter()
        {
            config = new BitmapFontConfig();
            config.setFontName("Helvetica");
            config.setFontSize(50);
            config.setCharacters("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789[]{}()?!@#$£".split(""));

            var factory:BitmapFontFactory = new BitmapFontFactory();
            factory.setConfig(config);
            factory.setStage(stage);
            factory.finished.addOnce(onFactoryFinished);
            factory.start();
        }

        private function onFactoryFinished(font:BitmapFont):void
        {
            var bytes:ByteArray = new BitmapFontEncoder().encode(font);
            bytes.compress();

            saveByteArray(bytes);
        }

        private function saveByteArray(bytes:ByteArray):void
        {
            var file:FileReference = new FileReference();
            file.save(bytes, getFilename());
        }

        private function getFilename():String
        {
            return [config.getFontName(), config.getFontSize(), ".fnt"].join("");
        }
    }
}