package talk.systems
{
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;
    import alecmce.entitysystem.framework.System;

    import flash.display.BitmapData;

    import talk.data.Slide;
    import talk.data.SpaceInvader;
    import talk.data.SpaceInvaders;

    public class SpaceInvaderMovementSystem implements System
    {
        private const INITIAL_STEP_INTERVAL:int = 1000;
        private const STEPS_BEFORE_CHANGING_INTERVAL:int = 10;
        private const DELTA_INTERVAL:int = -25;
        private const PADDING_X:int = 25;
        private const PADDING_Y:int = 10;

        private const SPACING:int = 50;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var layers:Layers;

        private var grid:SpaceInvaders;
        private var collection:Collection;
        private var node:Node;

        private var stepInterval:int;
        private var lastStepped:int;
        private var stepsWithCurrentInterval:int;

        private var isMovingRight:Boolean;
        private var columns:int;
        private var x:int;
        private var y:int;

        [PostConstruct]
        public function setup():void
        {
            collection = entities.getCollection(new <Class>[SpaceInvader, Slide, Position, BitmapData]);
        }

        public function start(time:int):void
        {
            this.stepInterval = INITIAL_STEP_INTERVAL;
            this.lastStepped = 0;
            this.isMovingRight = 1;

            columns = int((layers.getSize().width - 10) / SPACING);

            grid = new SpaceInvaders();
            for (node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                var invader:SpaceInvader = entity.get(SpaceInvader);
                grid.add(invader);
            }

            collection.entityAdded.add(onEntityAdded);
            collection.entityRemoved.add(onEntityRemoved);
        }

        public function stop(time:int):void
        {
            collection.entityAdded.remove(onEntityAdded);
            collection.entityRemoved.remove(onEntityRemoved);
        }

        private function onEntityAdded(entity:Entity):void
        {
            var invader:SpaceInvader = entity.get(SpaceInvader);
            grid.add(invader);
        }

        private function onEntityRemoved(entity:Entity):void
        {
            var invader:SpaceInvader = entity.get(SpaceInvader);
            grid.remove(invader);
        }

        public function update(time:int, delta:int):void
        {
            if (time - this.lastStepped > stepInterval)
            {
                updateGridPosition();
                updateStepsWithCurrentInterval();
                updateInvaderPosition();

                this.lastStepped += stepInterval;
            }
        }

        private function updateGridPosition():void
        {
            if (isMovingRight)
                handleMoveRight();
            else
                handleMoveLeft();
        }

        private function handleMoveRight():void
        {
            if (++x + grid.getSize().right >= columns)
            {
                ++y;
                --x;
                isMovingRight = false;
            }
        }

        private function handleMoveLeft():void
        {
            if (--x + grid.getSize().left < 0)
            {
                ++x;
                ++y;
                isMovingRight = true;
            }
        }

        private function updateStepsWithCurrentInterval():void
        {
            if (++stepsWithCurrentInterval == STEPS_BEFORE_CHANGING_INTERVAL)
            {
                stepsWithCurrentInterval = 0;
                stepInterval -= DELTA_INTERVAL;
            }
        }

        private function updateInvaderPosition():void
        {
            for (node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                var slide:Slide = entity.get(Slide);
                var invader:SpaceInvader = entity.get(SpaceInvader);
                var position:Position = entity.get(Position);

                position.x = PADDING_X + slide.x + (x + invader.x) * SPACING;
                position.y = PADDING_Y + slide.y + (y + invader.y) * SPACING;
            }
        }
    }
}
