package alecmce.console.model
{
    import alecmce.console.model.ActionHash;

    import org.hamcrest.assertThat;
    import org.hamcrest.object.equalTo;
    import org.osflash.signals.Signal;

    public class ConsoleSignalMapTest
    {
        private var console:ActionHash;

        @Before
        public function before()
        {
            console = new ActionHash();
        }

        @Test
        public function onceRegisteredCanTriggerSignalThroughConsole():void
        {
            var data:String;
            function onSignal(str:String):void
            {
                data = str;
            }

            var signal:Signal = new MockDataSignal();
            signal.addOnce(onSignal);

            console.register("test", signal);
            console.execute("test hello");

            assertThat(data, equalTo("hello"));
        }


    }
}

import org.osflash.signals.Signal;

class MockDataSignal extends Signal
{
    public function MockDataSignal()
    {
        super(String);
    }
}