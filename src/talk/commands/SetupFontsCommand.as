package talk.commands
{
    import alecmce.fonts.BitmapFont;
    import alecmce.fonts.BitmapFontDecoder;
    import alecmce.fonts.BitmapFonts;

    import mx.core.ByteArrayAsset;

    public class SetupFontsCommand
    {
        [Embed(source="../../../assets/Cochin75.fnt", mimeType="application/octet-stream")]
        private var TitleFont:Class;

        [Embed(source="../../../assets/Cochin50.fnt", mimeType="application/octet-stream")]
        private var BodyFont:Class;

        [Embed(source="../../../assets/Cochin40.fnt", mimeType="application/octet-stream")]
        private var SmallFont:Class;

        [Inject]
        public var decoder:BitmapFontDecoder;

        [Inject]
        public var fonts:BitmapFonts;

        public function execute():void
        {
            extractFont("title", TitleFont);
            extractFont("body", BodyFont);
            extractFont("small", SmallFont);
        }

        private function extractFont(name:String, FontClass:Class):void
        {
            var byteArray:ByteArrayAsset = new FontClass();
            byteArray.uncompress();

            var font:BitmapFont = decoder.decode(byteArray);
            fonts.addFont(name, font);
        }
    }
}
