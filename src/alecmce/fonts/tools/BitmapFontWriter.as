package alecmce.fonts.tools
{
    import alecmce.fonts.BitmapFont;
    import alecmce.fonts.BitmapFontConfig;
    import alecmce.fonts.BitmapFontEncoder;
    import alecmce.fonts.BitmapFontFactory;
    import alecmce.fonts.BitmapTextField;

    import com.bit101.components.ComboBox;
    import com.bit101.components.InputText;
    import com.bit101.components.NumericStepper;
    import com.bit101.components.PushButton;

    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.net.FileReference;
    import flash.text.Font;
    import flash.utils.ByteArray;

    [SWF(width="800", height="600", backgroundColor="#FFCC99", frameRate="60")]
    public class BitmapFontWriter extends Sprite
    {
        private var config:BitmapFontConfig;
        private var factory:BitmapFontFactory;

        private var fontList:Array;
        private var fontMap:Object;

        private var fontSelector:ComboBox;
        private var inputText:InputText;
        private var sizeSelector:NumericStepper;
        private var textfield:BitmapTextField;
        private var button:PushButton;

        public function BitmapFontWriter()
        {
            makeFontMap();

            makeCharacterChoice();
            makeFontSelector();
            makeSizeSelector();
            makePreviewTextfield();
            makeButton();
        }

        private function makeFontMap():void
        {
            fontList = [];
            fontMap = {};

            var fonts:Array = Font.enumerateFonts(true);
            for each (var font:Font in fonts)
            {
                fontList.push(font.fontName);
                fontMap[font.fontName] = font;
            }

            fontList.sort(Array.CASEINSENSITIVE);
        }

        private function makeFontSelector():void
        {
            fontSelector = new ComboBox();
            fontSelector.defaultLabel = "pick a font...";
            fontSelector.x = 20;
            fontSelector.y = 20;
            fontSelector.width = 300;

            for each (var fontName:String in fontList)
                fontSelector.addItem(fontName);

            fontSelector.addEventListener(Event.SELECT, updatePreview);

            addChild(fontSelector);
        }

        private function makeSizeSelector():void
        {
            sizeSelector = new NumericStepper();
            sizeSelector.minimum = 10;
            sizeSelector.value = 20;
            sizeSelector.maximum = 200;
            sizeSelector.x = 340;
            sizeSelector.y = 21;

            sizeSelector.addEventListener(Event.CHANGE, updatePreview);

            addChild(sizeSelector);
        }

        private function makeCharacterChoice():void
        {
            inputText = new InputText();
            inputText.text = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789[]{}()?!@#$£";
            inputText.x = 20;
            inputText.y = 50;
            inputText.width = 500;

            inputText.addEventListener(Event.CHANGE, updatePreview);

            addChild(inputText);
        }

        private function makePreviewTextfield():void
        {
            textfield = new BitmapTextField();
            textfield.x = 20;
            textfield.y = 140;

            addChild(textfield);
        }

        private function makeButton():void
        {
            button = new PushButton();
            button.label = "save";
            button.x = 680;
            button.y = 20;

            button.addEventListener(MouseEvent.CLICK, onClick);

            addChild(button);
        }

        private function updatePreview(event:Event):void
        {
            config = new BitmapFontConfig();
            config.setFontName(fontSelector.selectedItem as String);
            config.setFontSize(sizeSelector.value);
            config.setCharacters(inputText.text.split(""));

            factory = new BitmapFontFactory();
            factory.setConfig(config);
            factory.setStage(stage);
            factory.finished.addOnce(renderBitmapFont);
            factory.start();
        }

        private function renderBitmapFont(font:BitmapFont):void
        {
            textfield.setFont(font);
            textfield.setText(inputText.text);
        }

        private function onClick(event:MouseEvent):void
        {
            var factory:BitmapFontFactory = new BitmapFontFactory();
            factory.setConfig(config);
            factory.setStage(stage);
            factory.finished.addOnce(onFactoryFinished);
            factory.start();
        }

        private function onFactoryFinished(font:BitmapFont):void
        {
            var bytes:ByteArray = new BitmapFontEncoder().encode(font);
            bytes.compress();

            saveByteArray(bytes);
        }

        private function saveByteArray(bytes:ByteArray):void
        {
            var file:FileReference = new FileReference();
            file.save(bytes, getFilename());
        }

        private function getFilename():String
        {
            return [config.getFontName().replace(/ /ig, ""), config.getFontSize(), ".fnt"].join("");
        }
    }
}