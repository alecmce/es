package alecmce.entitysystem.extensions.robotlegs.signals
{
    import alecmce.entitysystem.framework.System;

    import org.osflash.signals.Signal;

    final public class StopSystem extends Signal
    {
        public function StopSystem()
        {
            super(System);
        }
    }
}
