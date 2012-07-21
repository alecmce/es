package alecmce.fonts
{
    import alecmce.util.Invalidator;

    import flash.display.Bitmap;

    public class BitmapTextField extends Bitmap
    {
        private var invalidator:Invalidator;
        private var font:BitmapFont;
        private var text:String;

        public function BitmapTextField()
        {
            invalidator = new Invalidator();
            invalidator.update.add(update);

            smoothing = true;
        }

        public function getFont():BitmapFont
        {
            return font;
        }

        public function setFont(font:BitmapFont):void
        {
            this.font = font;
            invalidator.invalidate();
        }

        public function getText():String
        {
            return text;
        }

        public function setText(text:String):void
        {
            this.text = text;
            invalidator.invalidate();
        }

        private function update():void
        {
            clearBitmapData();
            if (font && text)
            {
                cutMissingCharacters();
                bitmapData = new BitmapDataText(font, text);
            }
        }

        private function clearBitmapData():void
        {
            if (bitmapData)
            {
                bitmapData.dispose();
                bitmapData = null;
            }
        }

        private function cutMissingCharacters():void
        {
            var verified:String = "";

            var length:int = text.length;
            for (var i:int = 0; i < length; i++)
            {
                var character:String = text.charAt(i);
                if (font.hasCharacter(character) || character == " ")
                    verified += character;
            }

            text = verified;
        }
    }
}