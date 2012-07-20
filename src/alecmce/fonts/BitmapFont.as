package alecmce.fonts
{
    import flash.display.BitmapData;

    public class BitmapFont
    {
        private var characters:Array;
        private var data:Object;

        public function BitmapFont()
        {
            characters = [];
            data = {};
        }

        public function getCharacters():Array
        {
            return characters;
        }

        public function getCharacter(character:String):BitmapData
        {
            return data[character];
        }

        public function setCharacter(character:String, bitmapData:BitmapData):void
        {
            data[character] = bitmapData;
            characters.push(character);
        }

    }
}
