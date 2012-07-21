package alecmce.fonts.tools
{
    import alecmce.fonts.BitmapFont;
    import alecmce.fonts.BitmapFontDecoder;
    import alecmce.fonts.BitmapTextField;

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

            font = new BitmapFontDecoder().decode(bytes);
        }

        private function drawFont():void
        {
            var field:BitmapTextField = new BitmapTextField();
            field.setFont(font);
            field.setText("Hello World!");
            addChild(field);
        }
    }
}
