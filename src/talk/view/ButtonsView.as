package talk.view
{
    import alecmce.resizing.view.Resizable;

    import avmplus.implementsXml;

    import flash.display.Sprite;
    import flash.events.MouseEvent;
    import flash.geom.Rectangle;

    import org.osflash.signals.Signal;

    import talk.data.SlideTarget;

    public class ButtonsView extends Sprite implements Resizable
    {
        private var list:Vector.<ButtonView>;
        private var rectangle:Rectangle;

        public var selected:Signal;

        public function ButtonsView()
        {
            list = new <ButtonView>[];

            selected = new Signal(String);
        }

        public function resize(rectangle:Rectangle):void
        {
            this.rectangle = rectangle;
            updatePositions();
        }

        public function setTargets(targets:Vector.<SlideTarget>):void
        {
            for each (var target:SlideTarget in targets)
                addName(target);

            updatePositions();
        }

        public function addName(target:SlideTarget):void
        {
            var button:ButtonView = new ButtonView();
            button.addEventListener(MouseEvent.CLICK, onClick);
            button.setName(target.name, target.color);
            addChild(button);
            list.push(button);
        }

        private function onClick(event:MouseEvent):void
        {
            var target:ButtonView = event.currentTarget as ButtonView;
            selected.dispatch(target.getName());
        }

        public function clear():void
        {
            for each (var view:ButtonView in list)
                removeChild(view);

            list.length = 0;
        }

        private function updatePositions():void
        {
            var y:int = rectangle.bottom - ButtonView.PADDING_Y - (ButtonView.HEIGHT + ButtonView.PADDING_Y) * list.length;

            var length:int = list.length;
            for (var i:int = 0; i < length; i++)
            {
                var button:ButtonView = list[i];
                button.x = rectangle.right - button.width + ButtonView.PADDING_X;
                button.y = y + i * (ButtonView.HEIGHT + ButtonView.PADDING_Y);
            }
        }
    }
}
