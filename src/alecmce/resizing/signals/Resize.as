package alecmce.resizing.signals
{
    import flash.geom.Rectangle;

    import org.osflash.signals.Signal;

    public class Resize extends Signal
    {
        public function Resize()
        {
            super(Rectangle);
        }
    }
}
