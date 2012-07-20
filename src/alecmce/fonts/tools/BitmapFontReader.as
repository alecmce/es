package alecmce.fonts.tools
{
    import alecmce.fonts.BitmapFont;
    import alecmce.fonts.BitmapFontParser;

    import flash.display.Bitmap;

    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    import flash.utils.ByteArray;
    import flash.utils.ByteArray;

    [SWF(width="800", height="600", backgroundColor="#FFCC99", frameRate="60")]
    public class BitmapFontReader extends Sprite
    {
        private const PADDING:int = 3;
        
        private var font:BitmapFont;

        public function BitmapFontReader()
        {
            var file:File = new File();
            file.addEventListener(Event.SELECT, fileSelected);
            file.browseForOpen("open");
        }

        function fileSelected(event:Event):void
        {
            var stream:FileStream = new FileStream();
            stream.open(event.target as File, FileMode.READ);

            readBitmapFontFromFile(stream);
            drawFont();
        }

        private function readBitmapFontFromFile(stream:FileStream):void
        {
            var bytes:ByteArray = new ByteArray();
            stream.readBytes(bytes, 0, stream.bytesAvailable);
            bytes.uncompress();

            var parser:BitmapFontParser = new BitmapFontParser();
            font = parser.parse(bytes);
        }

        private function drawFont():void
        {
            var chars:Array = font.getCharacters();

            var x:int = 20;
            var y:int = 20;
            var dy:int = 0;

            for each (var char:String in chars)
            {
                var data:BitmapData = font.getCharacter(char);

                var bitmap:Bitmap = new Bitmap(data);
                bitmap.x = x;
                bitmap.y = y;
                addChild(bitmap);

                x += data.width + PADDING;
                if (data.height > dy)
                    dy += data.height;

                if (x > stage.stageWidth - 40)
                {
                    x = 20;
                    y += dy + PADDING;
                    dy = 0;
                }
            }
        }
    }
}
