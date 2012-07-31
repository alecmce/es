package talk.signals
{
    import org.osflash.signals.Signal;

    import talk.data.Slide;

    public class MakeSlideStep extends Signal
    {
        public function MakeSlideStep()
        {
            super(Slide);
        }
    }
}
