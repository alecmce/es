package alecmce.console.signals
{
    import org.osflash.signals.Signal;

    final public class ConsoleLog extends Signal
    {
        public function ConsoleLog()
        {
            super(String);
        }
    }
}
