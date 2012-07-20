package alecmce.fonts
{
    import flash.display.BitmapData;
    import flash.utils.ByteArray;

    public class BitmapFontParser
    {
        public function parse(bytes:ByteArray):BitmapFont
        {
            var font:BitmapFont = new BitmapFont();

            while (bytes.bytesAvailable)
                getNextBitmapFontCharacter(bytes, font);

            return font;
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
    }
}
