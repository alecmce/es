package alecmce.fonts
{
    import flash.display.BitmapData;
    import flash.utils.ByteArray;

    public class BitmapFontDecoder
    {
        public function decode(bytes:ByteArray):BitmapFont
        {
            var font:BitmapFont = new BitmapFont();

            decodeConfig(bytes, font);
            decodeSpace(bytes, font);
            decodeImages(bytes, font);
            decodeKerning(bytes, font);

            return font;
        }

        private function decodeConfig(bytes:ByteArray, font:BitmapFont):void
        {
            bytes.readUnsignedInt(); // throw away block-length, not needed

            var config:BitmapFontConfig = new BitmapFontConfig();
            config.setFontName(bytes.readUTFBytes(bytes.readUnsignedInt()));
            config.setFontSize(bytes.readUnsignedInt());
            config.setCharacters(bytes.readUTFBytes(bytes.readUnsignedInt()).split(""));
            font.setConfig(config);
        }

        private function decodeSpace(bytes:ByteArray, font:BitmapFont):void
        {
            bytes.readUnsignedInt(); // throw away block-length, not needed

            font.setSpace(bytes.readFloat());
        }

        private function decodeImages(bytes:ByteArray, font:BitmapFont):void
        {
            var endOfImageData:int = bytes.position + bytes.readUnsignedInt();
            while (bytes.position < endOfImageData)
                getNextBitmapFontCharacter(bytes, font);
        }

        private function getNextBitmapFontCharacter(bytes:ByteArray, font:BitmapFont):void
        {
            var character:String = String.fromCharCode(bytes.readUnsignedInt());
            var width:int = bytes.readUnsignedInt();
            var height:int = bytes.readUnsignedInt();
            var len:uint = bytes.readUnsignedInt();

            var data:ByteArray = new ByteArray();
            bytes.readBytes(data, 0, len);

            var bitmap:BitmapData = new BitmapData(width, height, true, 0);
            bitmap.setPixels(bitmap.rect, data);

            font.setCharacter(character, bitmap);
        }

        private function decodeKerning(bytes:ByteArray, font:BitmapFont):void
        {
            var endOfKerningData:int = bytes.position + bytes.readUnsignedInt();
            while (bytes.position < endOfKerningData)
                getNextKerningInfo(bytes, font);
        }

        private function getNextKerningInfo(bytes:ByteArray, font:BitmapFont):void
        {
            var first:String = String.fromCharCode(bytes.readUnsignedInt());
            var second:String = String.fromCharCode(bytes.readUnsignedInt());
            var kerning:Number = bytes.readFloat();

            font.setKerning(first, second, kerning);
        }
    }
}
