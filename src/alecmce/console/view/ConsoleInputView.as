package alecmce.console.view
{
    import alecmce.resizing.view.Resizable;
    import alecmce.util.StageLifecycleUtil;

    import flash.events.KeyboardEvent;
    import flash.geom.Rectangle;
    import flash.text.TextField;
    import flash.text.TextFieldType;
    import flash.text.TextFormat;
    import flash.ui.Keyboard;

    final public class ConsoleInputView extends TextField implements Resizable
    {
        public static const HEIGHT:int = 20;

        private var lifecycle:StageLifecycleUtil;

        public function ConsoleInputView()
        {
            background = true;
            backgroundColor = 0x003300;
            border = true;
            borderColor = 0x333333;
            defaultTextFormat = new TextFormat("_sans", 14, 0xFFFFFF, true);

            text = "";
            type = TextFieldType.INPUT;

            lifecycle = new StageLifecycleUtil(this);
            lifecycle.addedToStage.add(onAddedToStage);
            lifecycle.removedFromStage.add(onRemovedFromStage);
        }

        private function onAddedToStage():void
        {
            addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        }

        private function onRemovedFromStage():void
        {
            removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
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
            var h:int = rectangle.height * 0.5;
            if (h > HEIGHT)
                h = HEIGHT;

            width = rectangle.width;
            height = h;
            x = rectangle.x;
            y = rectangle.bottom - height;
        }
    }
}
