package alecmce.console.view
{
    import flash.display.Sprite;

    final public class ConsoleView extends Sprite
    {
        public var input:ConsoleInputView;
        public var output:ConsoleOutputView;

        public function ConsoleView()
        {
            input = new ConsoleInputView();
            output = new ConsoleOutputView();

            addChild(output);
            addChild(input);
        }

    }
}
