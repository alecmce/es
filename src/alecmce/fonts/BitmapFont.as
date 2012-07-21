package alecmce.fonts
{
    import flash.display.BitmapData;

    public class BitmapFont
    {
        private var config:BitmapFontConfig;
        private var characters:Array;
        private var data:Object;
        private var kerning:Object;
        private var space:Number;

        public function BitmapFont()
        {
            characters = [];
            data = {};
            kerning = {};
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
            return data[character];
        }

        public function hasCharacter(character:String):Boolean
        {
            return characters.indexOf(character) != -1;
        }

        public function setCharacter(character:String, bitmapData:BitmapData):void
        {
            data[character] = bitmapData;
            characters.push(character);
        }

        public function getKerning(first:String, second:String):Number
        {
            return kerning[first+second] || space;
        }

        public function setKerning(first:String, second:String, dx:Number):void
        {
            kerning[first+second] = dx;
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
