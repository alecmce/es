package alecmce.fonts
{
    import flash.display.BitmapData;
    import flash.utils.ByteArray;

    public class BitmapFontEncoder
    {
        public function encode(font:BitmapFont):ByteArray
        {
            var parts:Vector.<ByteArray> = encodeFontParts(font);
            return joinEncodedParts(parts);
        }

        private function encodeFontParts(font:BitmapFont):Vector.<ByteArray>
        {
            var parts:Vector.<ByteArray> = new <ByteArray>[];
            parts.push(makeConfigBytes(font.getConfig()));
            parts.push(makeSpace(font));
            parts.push(makeImageBytes(font));
            parts.push(makeKerningBytes(font));
            return parts;
        }

        private function makeConfigBytes(config:BitmapFontConfig):ByteArray
        {
            var name:ByteArray = new ByteArray();
            name.writeUTFBytes(config.getFontName());

            var characters:ByteArray = new ByteArray();
            characters.writeUTFBytes(config.getCharacters().join(""));

            var bytes:ByteArray = new ByteArray();
            bytes.writeUnsignedInt(name.length);
            bytes.writeBytes(name);
            bytes.writeUnsignedInt(config.getFontSize());
            bytes.writeUnsignedInt(characters.length);
            bytes.writeBytes(characters);

            return bytes;
        }

        private function makeSpace(font:BitmapFont):ByteArray
        {
            var bytes:ByteArray = new ByteArray();
            bytes.writeFloat(font.getSpace());
            return bytes;
        }

        private function makeKerningBytes(font:BitmapFont):ByteArray
        {
            var bytes:ByteArray = new ByteArray();

            var characters:Array = font.getCharacters();
            for each (var first:String in characters)
            {
                for each (var second:String in characters)
                {
                    var kerning:Number = font.getKerning(first, second);
                    bytes.writeUnsignedInt(first.charCodeAt(0));
                    bytes.writeUnsignedInt(second.charCodeAt(0));
                    bytes.writeFloat(kerning);
                }
            }

            return bytes;
        }

        private function makeImageBytes(font:BitmapFont):ByteArray
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

            return bytes;
        }

        private function joinEncodedParts(parts:Vector.<ByteArray>):ByteArray
        {
            var bytes:ByteArray = new ByteArray();
            for each (var part:ByteArray in parts)
            {
                bytes.writeUnsignedInt(part.length);
                bytes.writeBytes(part);
            }
            return bytes;
        }
    }
}
