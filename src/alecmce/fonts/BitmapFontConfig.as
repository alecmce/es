package alecmce.fonts
{
    public class BitmapFontConfig
    {
        private var fontName:String;
        private var fontSize:int;
        private var characters:Array;

        public function getFontName():String
        {
            return fontName;
        }

        public function setFontName(fontName:String):void
        {
            this.fontName = fontName;
        }

        public function getFontSize():int
        {
            return fontSize;
        }

        public function setFontSize(fontSize:int):void
        {
            this.fontSize = fontSize;
        }

        public function getCharacters():Array
        {
            return characters
        }

        public function setCharacters(characters:Array):void
        {
            const i:int = characters.indexOf(" ");
            if (i != -1)
                characters.splice(i, 1);

            this.characters = characters;
        }
    }
}
