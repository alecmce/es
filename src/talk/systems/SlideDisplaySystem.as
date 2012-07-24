package talk.systems
{
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.System;

    import talk.data.Character;

    public class SlideDisplaySystem implements System
    {
        [Inject]
        public var entities:Entities;

        private var collection:Collection;

        [PostConstruct]
        public function setup():void
        {
            entities.getCollection(new <Class>[Character]);
        }

        public function start(time:int):void
        {

        }

        public function update(time:int, delta:int):void
        {
        }

        public function stop(time:int):void
        {
        }
    }
}
