package alecmce.fonts
{
    import flash.display.BitmapData;

    public class BitmapFont
    {
        private var config:BitmapFontConfig;
        private var characters:Array;
        private var dataMap:Object;
        private var kerningMap:Object;
        private var space:Number;

        public function BitmapFont()
        {
            characters = [];
            dataMap = {};
            kerningMap = {};
        }

        public function getConfig():BitmapFontConfig
        {
            return config;
        }

        public function getCharacters():Array
        {
            return config.getCharacters();
        }

        public function setConfig(config:BitmapFontConfig):void
        {
            this.config = config;
        }

        public function getCharacter(character:String):BitmapData
        {
            return dataMap[character];
        }

        public function hasCharacter(character:String):Boolean
        {
            return characters.indexOf(character) != -1;
        }

        public function setCharacter(character:String, bitmapData:BitmapData):void
        {
            dataMap[character] = bitmapData;
            characters.push(character);
        }

        public function getKerning(first:String, second:String):Number
        {
            var id:String = first + second;
            return kerningMap[id] || 0;
        }

        public function setKerning(first:String, second:String, kerning:Number):void
        {
            var id:String = first + second;
            kerningMap[id] = kerning;
        }

        public function getSpace():Number
        {
            return space;
        }

        public function setSpace(space:Number):void
        {
            this.space = space;
        }
    }
}
