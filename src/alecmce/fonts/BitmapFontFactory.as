package alecmce.fonts
{
    import alecmce.fonts.tools.bitmapFontGenerator.*;
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.BlendMode;
    import flash.display.Sprite;
    import flash.display.Stage;
    import flash.events.Event;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFieldAutoSize;
    import flash.text.TextFormat;

    import org.osflash.signals.Signal;

    public class BitmapFontFactory
    {
        private var config:FontConfig;
        private var stage:Stage;

        private var format:TextFormat;
        private var font:BitmapFont;

        private var container:Sprite;
        private var character:String;
        private var field:TextField;
        private var index:int;
        private var width:int;
        private var height:int;
        private var left:Number;
        private var top:Number;

        private var _finished:Signal;

        public function setConfig(config:FontConfig):void
        {
            this.config = config;
        }

        public function setStage(stage:Stage):void
        {
            this.stage = stage;
        }

        public function start():void
        {
            if (!config)
                throw new Error("Unable to start BitmapFontFactory - no config has been supplied");

            if (!stage)
                throw new Error("Unable to start BitmapFontFactory - needs stage reference");

            container = new Sprite();
            stage.addChild(container);

            font =  new BitmapFont();
            makeFormat();
            makeTextFields();

            stage.addEventListener(Event.ENTER_FRAME, waitFrameToEnsureTextIsRendered);
        }

        private function makeFormat():void
        {
            format = new TextFormat();
            format.font = config.fontName;
            format.size = config.fontSize;
        }

        private function makeTextFields():void
        {
            for each (var char:String in config.characters)
                makeTextFieldFor(char);
        }

        private function makeTextFieldFor(char:String):void
        {
            var field:TextField = new TextField();
            field.x = 50 + Math.random() * (stage.stageWidth - 100);
            field.y = 50 + Math.random() * (stage.stageHeight - 100);
            field.defaultTextFormat = format;
            field.embedFonts = false;
            field.width = int(format.size);
            field.height = format.size + 20;
            field.selectable = false;
            field.wordWrap = true;
            field.text = char;
            field.autoSize = TextFieldAutoSize.LEFT;
            container.addChild(field);
        }

        private function waitFrameToEnsureTextIsRendered(event:Event):void
        {
            stage.removeEventListener(Event.ENTER_FRAME, waitFrameToEnsureTextIsRendered);
            convertTextFieldsIntoBitmaps();
            _finished && _finished.dispatch(font);
        }

        private function convertTextFieldsIntoBitmaps():void
        {
            var count:int = config.characters.length;
            for (index = 0; index < count; index++)
            {
                convertTextFieldAtIndex();
            }
        }

        private function convertTextFieldAtIndex():void
        {
            field = container.getChildAt(index) as TextField;
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

        public function get finished():Signal
        {
            return _finished ||= new Signal(BitmapFont);
        }
    }
}
