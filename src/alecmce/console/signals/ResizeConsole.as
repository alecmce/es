package alecmce.console.signals
{
    import flash.geom.Rectangle;

    import org.osflash.signals.Signal;

    final public class ResizeConsole extends Signal
    {
        public function ResizeConsole()
        {
            super(Rectangle);
        }
    }
}
