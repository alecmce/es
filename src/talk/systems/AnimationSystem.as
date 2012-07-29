package talk.systems
{
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;
    import alecmce.entitysystem.framework.System;

    import flash.display.BitmapData;

    import talk.data.Animation;

    public class AnimationSystem implements System
    {
        [Inject]
        public var entities:Entities;

        private var collection:Collection;
        private var node:Node;

        [PostConstruct]
        public function setup():void
        {
            collection = entities.getCollection(new <Class>[Animation, BitmapData]);
        }

        public function start(time:int):void {}

        public function stop(time:int):void {}

        public function update(time:int, delta:int):void
        {
            for (node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                var anim:Animation = entity.get(Animation);

                anim.index = (anim.index + anim.delta) % anim.frames.length;
                var index:int = int(anim.index);
                entity.add(anim.frames[index]);
            }
        }
    }
}
