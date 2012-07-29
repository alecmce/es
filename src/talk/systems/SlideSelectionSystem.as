package talk.systems
{
    import alecmce.entitysystem.extensions.view.Camera;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.System;
    import alecmce.entitysystem.framework.Systems;
    import alecmce.math.easing.Expo;

    import talk.data.Selected;
    import talk.data.Slide;
    import talk.data.Slides;

    public class SlideSelectionSystem implements System
    {
        private static const DURATION:int = 1000;
        private static const INV_DURATION:Number = 1 / DURATION;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var systems:Systems;

        [Inject]
        public var camera:Camera;

        private var collection:Collection;

        private var selected:Entity;
        private var startX:Number;
        private var startY:Number;
        private var deltaX:Number;
        private var deltaY:Number;
        private var value:Number;
        private var proportion:Number;

        [PostConstruct]
        public function setup():void
        {
            collection = entities.getCollection(new <Class>[Slides, Slide, Selected]);
        }

        public function start(time:int):void
        {
            if (collection.head)
                prepareMovement(selected = collection.head.entity);
        }

        public function update(time:int, delta:int):void
        {
            if (collection.head)
            {
                if (selected != collection.head.entity)
                    prepareMovement(selected = collection.head.entity);

                value += delta;

                if (value > DURATION)
                {
                    proportion = 1;
                    systems.remove(this);
                }
                else
                {
                    proportion = Expo.easeInOut(value * INV_DURATION);
                }

                camera.left = startX + deltaX * proportion;
                camera.top = startY + deltaY * proportion;
            }
        }

        public function stop(time:int):void
        {
            selected = null;
        }

        private function prepareMovement(entity:Entity):void
        {
            var slide:Slide = entity.get(Slide);

            startX = camera.left;
            startY = camera.top;
            deltaX = slide.x - startX;
            deltaY = slide.y - startY;
            value = 0;
        }
    }
}
