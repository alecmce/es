package alecmce.console.view.components
{
    import alecmce.console.view.ConsoleEvent;
    import alecmce.ui.api.UIResizes;

    import flash.display.DisplayObject;
    import flash.events.KeyboardEvent;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import flash.ui.Keyboard;

    final public class ConsoleInput extends TextField implements UIResizes
    {
        public static const HEIGHT:int = 20;

        public function ConsoleInput()
        {
            background = true;
            backgroundColor = 0x003300;
            border = true;
            borderColor = 0x333333;
            defaultTextFormat = new TextFormat("_sans", 14, 0xFFFFFF, true);

            text = "";
            type = TextFieldType.INPUT;
            addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        }

        private function onKeyDown(event:KeyboardEvent):void
        {
            var value:String = text;
            switch (event.keyCode)
            {
                case Keyboard.ENTER:
                    text = "";
                    dispatchEvent(new ConsoleEvent(ConsoleEvent.INPUT, value));
                    break;
                case Keyboard.UP:
                    dispatchEvent(new ConsoleEvent(ConsoleEvent.GET_PREVIOUS));
                    break;
                case Keyboard.DOWN:
                    dispatchEvent(new ConsoleEvent(ConsoleEvent.GET_NEXT));
                    break;
            }
        }

        public function resize(rectangle:Rectangle):void
        {
            var h:int = rectangle.height;
            if (h > HEIGHT)
                h = HEIGHT;

            width = rectangle.width;
            height = h;
            x = rectangle.x;
            y = rectangle.bottom - height;
        }
    }
}
