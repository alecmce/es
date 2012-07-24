package alecmce.entitysystem.extensions.robotlegs.signals
{
    import alecmce.entitysystem.framework.System;

    import org.osflash.signals.Signal;

    final public class StartSystem extends Signal
    {
        public function StartSystem()
        {
            super(System);
        }
    }
}
