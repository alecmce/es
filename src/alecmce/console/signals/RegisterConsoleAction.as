package alecmce.console.signals
{
    import alecmce.console.vo.ConsoleAction;

    import org.osflash.signals.Signal;

    final public class RegisterConsoleAction extends Signal
    {
        public function RegisterConsoleAction()
        {
            super(ConsoleAction, Signal);
        }
    }
}
