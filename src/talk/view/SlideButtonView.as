package talk.view
{
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.text.TextField;
    import flash.text.TextFormat;

    public class SlideButtonView extends Sprite
    {
        public static const WIDTH:int = 120;
        public static const HEIGHT:int = 30;
        private const FONT_SIZE:int = 20;
        public static const PADDING_X:int = 40;
        public static const PADDING_Y:int = 5;
        public static const DELTA:int = 2;

        private var container:Sprite;
        private var number:TextField;
        private var field:TextField;
        private var selected:Boolean;
        private var shape:Shape;

        public function SlideButtonView()
        {
            container = new Sprite();
            addEventListener(MouseEvent.MOUSE_OVER, onMouseOver);
            addEventListener(MouseEvent.MOUSE_OUT, onMouseOut);
        }

        public function setName(index:int, name:String, color:int = 0xFFFF66):void
        {
            makeNumber(index);
            makeName(name);
            makeShape(color);

            container.addChild(shape);
            container.addChild(number);
            container.addChild(field);
            addChild(container);
        }

        private function makeNumber(index:int):void
        {
            var format:TextFormat = new TextFormat();
            format.font = "Helvetica";
            format.size = FONT_SIZE * 0.75;

            number = new TextField();
            number.defaultTextFormat = format;
            number.selectable = false;
            number.width = 15;
            number.height = HEIGHT;
            number.text = index.toString();
        }

        private function makeName(name:String):void
        {
            var format:TextFormat = new TextFormat();
            format.font = "Helvetica";
            format.size = FONT_SIZE;

            field = new TextField();
            field.x = 15;
            field.y = 2;
            field.defaultTextFormat = format;
            field.selectable = false;
            field.width = WIDTH;
            field.height = HEIGHT;
            field.text = name;
        }

        private function makeShape(color:int):void
        {
            shape = new Shape();
            shape.graphics.lineStyle(0, 0x000000);
            shape.graphics.beginFill(color, 0.5);
            shape.graphics.drawRect(0, 0, field.width + PADDING_X, HEIGHT);
            shape.graphics.endFill();
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
