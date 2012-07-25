package alecmce.console.view
{
    import alecmce.resizing.view.Resizable;
    import alecmce.util.StageLifecycleUtil;

    import flash.display.BlendMode;

    import flash.display.Sprite;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFormat;
    import flash.utils.Dictionary;

    import org.osflash.signals.Signal;

    final public class ConsoleOutputView extends Sprite implements Resizable
    {
        private static const DEFAULT_OUTPUT:String = "alecmce/console";

        private const PATTERN:RegExp = /\[0x(.+)\:(.+)\]/ig;
        private const HTML_TEMPLATE:String = "<font color='#$1'>$2</font>";

        private var textfield:TextField;

        private var logged:Array;
        private var lastSource:Signal;
        private var delegateMap:Dictionary;

        private var lifecycle:StageLifecycleUtil;

        public function ConsoleOutputView()
        {
            alpha = 0.8;
            blendMode = BlendMode.LAYER;

            logged = [];
            delegateMap = new Dictionary();

            addChild(textfield = new TextField());
            textfield.alpha = 0.6;
            textfield.defaultTextFormat = new TextFormat("_sans", 14, 0xFFFFFF, true);
            textfield.htmlText = DEFAULT_OUTPUT;
            textfield.selectable = false;
            textfield.multiline = true;

            mouseEnabled = false;

            lifecycle = new StageLifecycleUtil(this);
            lifecycle.addedToStage.add(onAddedToStage);
        }

        private function onAddedToStage():void
        {
            resize(new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
        }

        public function log(data:String):void
        {
            data = data.replace(PATTERN, HTML_TEMPLATE);

            lastSource = null;
            logged.push(data);
            updateOutputText();
        }

        public function clear():void
        {
            logged.length = 0;
            lastSource = null;
            textfield.htmlText = DEFAULT_OUTPUT;
        }

        public function resize(rectangle:Rectangle):void
        {
            var h:int = rectangle.height - ConsoleInputView.HEIGHT;
            if (h < 0)
                h = 0;

            x = rectangle.x;
            y = rectangle.y;

            textfield.width = rectangle.width;
            textfield.height = h;

            graphics.clear();
            graphics.beginFill(0x003300);
            graphics.drawRect(0, 0, width, height);
            graphics.endFill();
        }

        private function updateOutputText():void
        {
            textfield.htmlText = logged.join("\r");
        }
    }
}