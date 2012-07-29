package talk.view
{
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;

    public class ButtonView extends Sprite
    {
        public static const WIDTH:int = 100;
        public static const HEIGHT:int = 30;
        private const FONT_SIZE:int = 20;
        public static const PADDING_X:int = 40;
        public static const PADDING_Y:int = 5;
        public static const DELTA:int = 2;

        private var container:Sprite;
        private var field:TextField;
        private var selected:Boolean;

        public function ButtonView()
        {
            container = new Sprite();
            addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
        }

        public function setName(name:String, color:int = 0xFFFF66):void
        {
            var format:TextFormat = new TextFormat();
            format.font = "Helvetica";
            format.size = FONT_SIZE;

            field = new TextField();
            field.y = 2;
            field.defaultTextFormat = format;
            field.selectable = false;
            field.width = WIDTH;
            field.height = HEIGHT;
            field.text = name;

            var shape:Shape = new Shape();
            shape.graphics.lineStyle(0, 0x000000);
            shape.graphics.beginFill(color, 0.5);
            shape.graphics.drawRect(0, 0, field.width + PADDING_X, HEIGHT);
            shape.graphics.endFill();

            container.addChild(shape);
            container.addChild(field);
            addChild(container);
        }

        public function getName():String
        {
            return field.text;
        }

        private function onMouseOver(event:MouseEvent):void
        {
            selected = true;
            removeEventListener(Event.ENTER_FRAME, makeUnselected);
            addEventListener(Event.ENTER_FRAME, makeSelected);
        }

        private function onMouseOut(event:MouseEvent):void
        {
            selected = false;
            removeEventListener(Event.ENTER_FRAME, makeSelected);
            addEventListener(Event.ENTER_FRAME, makeUnselected);
        }

        private function makeSelected(event:Event):void
        {
            if ((container.x -= DELTA) <= -10)
                removeEventListener(Event.ENTER_FRAME, makeSelected);
        }

        private function makeUnselected(event:Event):void
        {
            if ((container.x += DELTA) >= 0)
                removeEventListener(Event.ENTER_FRAME, makeUnselected);
        }
    }
}
