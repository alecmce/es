package alecmce.console.view.components
{
    import alecmce.ui.api.UIResizes;

    import flash.display.Sprite;
    import flash.geom.Rectangle;

    final public class ConsoleView extends Sprite implements UIResizes
    {
        private var input:ConsoleInput;
        private var output:ConsoleOutput;

        public function ConsoleView()
        {
            input = new ConsoleInput();
            output = new ConsoleOutput();

            addChild(output);
            addChild(input);
        }

        public function resize(rectangle:Rectangle):void
        {
            input.resize(rectangle);
            output.resize(rectangle);
        }
    }
}
