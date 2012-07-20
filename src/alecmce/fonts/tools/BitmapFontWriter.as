package alecmce.fonts.tools
{
    import alecmce.fonts.BitmapFont;
    import alecmce.fonts.BitmapFontFactory;
    import alecmce.fonts.FontConfig;

    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.net.FileReference;
    import flash.utils.ByteArray;

    [SWF(width="800", height="600", backgroundColor="#FFCC99", frameRate="60")]
    public class BitmapFontWriter extends Sprite
    {
        private var config:FontConfig;
        private var bytes:ByteArray;
        private var file:FileReference;

        public function BitmapFontWriter()
        {
            config = new FontConfig();
            config.fontName = "Helvetica";
            config.fontSize = 50;
            config.characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789[]{}()?!@#$£".split("");

            var factory:BitmapFontFactory = new BitmapFontFactory();
            factory.setConfig(config);
            factory.setStage(stage);
            factory.finished.addOnce(onFactoryFinished);
            factory.start();
        }

        private function onFactoryFinished(font:BitmapFont):void
        {
            bytes = makeByteArray(font);
            saveByteArray();
        }

        private function makeByteArray(font:BitmapFont):ByteArray
        {
            var bytes:ByteArray = new ByteArray();

            var characters:Array = font.getCharacters();
            for each (var char:String in characters)
            {
                var bitmap:BitmapData = font.getCharacter(char);
                var data:ByteArray = bitmap.getPixels(bitmap.rect);

                bytes.writeUnsignedInt(uint(char.charCodeAt(0)));
                bytes.writeUnsignedInt(bitmap.width);
                bytes.writeUnsignedInt(bitmap.height);
                bytes.writeUnsignedInt(data.length);
                bytes.writeBytes(data);
            }

            bytes.compress();
            return bytes;
        }

        private function saveByteArray():void
        {
            file = new FileReference();
            file.save(bytes, getFilename());
        }

        private function getFilename():String
        {
            return [config.fontName, config.fontSize, ".fnt"].join("");
        }
    }
}