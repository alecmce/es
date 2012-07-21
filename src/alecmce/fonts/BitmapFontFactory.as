package alecmce.fonts
{
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    import org.osflash.signals.Signal;

    public class BitmapFontFactory
    {
        private var config:BitmapFontConfig;
        private var stage:Stage;

        private var format:TextFormat;
        private var font:BitmapFont;

        private var container:Sprite;
        private var characterContainer:Sprite;
        private var kerningPairContainer:Sprite;
        private var spaceContainer:Sprite;

        private var character:String;
        private var field:TextField;
        private var index:int;
        private var width:int;
        private var height:int;
        private var left:Number;
        private var top:Number;

        private var _finished:Signal;

        public function setConfig(config:BitmapFontConfig):void
        {
            this.config = config;
        }

        public function setStage(stage:Stage):void
        {
            this.stage = stage;
        }

        public function get finished():Signal
        {
            return _finished ||= new Signal(BitmapFont);
        }

        public function start():void
        {
            if (!config)
                throw new Error("Unable to start BitmapFontFactory - no config has been supplied");

            if (!stage)
                throw new Error("Unable to start BitmapFontFactory - needs stage reference");

            container = new Sprite();
            container.addChild(characterContainer = new Sprite());
            container.addChild(kerningPairContainer = new Sprite());
            container.addChild(spaceContainer = new Sprite());

            stage.addChild(container);

            font =  new BitmapFont();
            font.setConfig(config);

            makeFormat();
            makeSpace();
            makeCharacters();
            makeKerningPairs();

            stage.addEventListener(Event.ENTER_FRAME, waitFrameToEnsureTextIsRendered);
        }

        private function makeFormat():void
        {
            format = new TextFormat();
            format.font = config.getFontName();
            format.size = config.getFontSize();
            format.kerning = true;
        }

        private function makeSpace():void
        {
            spaceContainer.addChild(makeTextField(" M"));
        }

        private function makeCharacters():void
        {
            for each (var char:String in config.getCharacters())
                characterContainer.addChild(makeTextField(char));
        }

        private function makeKerningPairs():void
        {
            var characters:Array = config.getCharacters();
            for each (var first:String in characters)
            {
                for each (var second:String in characters)
                {
                    if (first != " " && second != " ")
                        kerningPairContainer.addChild(makeTextField(first + second));
                }
            }
        }

        private function makeTextField(text:String):TextField
        {
            var field:TextField = new TextField();
            field.x = 50 + Math.random() * (stage.stageWidth - 100 - config.getFontSize());
            field.y = 50 + Math.random() * (stage.stageHeight - 100 - config.getFontSize());
            field.defaultTextFormat = format;
            field.embedFonts = false;
            field.width = config.getFontSize() * 5;
            field.height = config.getFontSize() + 20;
            field.selectable = false;
            field.wordWrap = true;
            field.text = text;
            field.autoSize = TextFieldAutoSize.LEFT;
            return field;
        }

        private function waitFrameToEnsureTextIsRendered(event:Event):void
        {
            stage.removeEventListener(Event.ENTER_FRAME, waitFrameToEnsureTextIsRendered);

            measureSpace();
            convertTextFieldsIntoBitmaps();
            measureKerningForPairs();

            stage.removeChild(container);
            _finished && _finished.dispatch(font);
        }

        private function measureSpace():void
        {
            var field:TextField = spaceContainer.getChildAt(0) as TextField;
            font.setSpace(field.getCharBoundaries(0).width);
        }

        private function convertTextFieldsIntoBitmaps():void
        {
            var count:int = config.getCharacters().length;
            for (index = 0; index < count; index++)
                convertTextFieldAtIndex();
        }

        private function convertTextFieldAtIndex():void
        {
            field = characterContainer.getChildAt(index) as TextField;
            character = field.text;

            getCharacterInfo();
            if (canBeRendered())
                makeBitmap();
        }

        private function getCharacterInfo():void
        {
            var bounds:Rectangle = field.getCharBoundaries(0);
            width = bounds.width;
            height = bounds.height;
            left = bounds.left;
            top = bounds.top;
        }

        private function canBeRendered():Boolean
        {
            return width > 0 && height > 0 && character != " " && character != "";
        }

        private function makeBitmap():void
        {
            var matrix:Matrix = new Matrix();
            matrix.translate(-left, -top);

            var bitmapData:BitmapData = new BitmapData(width, height, true, 0x00000000);
            bitmapData.draw(field, matrix, null, BlendMode.NORMAL, null, true);

            if (bitmapData)
                font.setCharacter(character, bitmapData);
        }

        private function measureKerningForPairs():void
        {
            var count:int = config.getCharacters().length;
            count *= count;
            for (index = 0; index < count; index++)
                measureKerningForPair();
        }

        private function measureKerningForPair():void
        {
            field = kerningPairContainer.getChildAt(index) as TextField;
            var pair:Array = field.text.split("");

            var first:Rectangle = field.getCharBoundaries(0);
            var second:Rectangle = field.getCharBoundaries(1);
            var kerning:Number = second.left - first.right;

            font.setKerning(pair[0], pair[1], kerning);

            if (kerning != 0)
                trace(pair[0], pair[1], kerning);
        }
    }
}
