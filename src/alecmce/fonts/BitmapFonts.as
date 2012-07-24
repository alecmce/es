package alecmce.fonts
{
    public class BitmapFonts
    {
        private var fontMap:Object;

        public function BitmapFonts()
        {
            fontMap = {};
        }

        public function addFont(key:String, font:BitmapFont):void
        {
            fontMap[key] = font;
        }

        public function getFont(key:String):BitmapFont
        {
            return fontMap[key];
        }
    }
}
