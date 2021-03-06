package talk.systems
{
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;
    import alecmce.entitysystem.framework.System;

    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    import talk.data.KeyControls;
    import talk.data.Slide;
    import talk.data.Slides;

    public class KeyMovementSystem implements System
    {
        [Inject]
        public var entities:Entities;

        [Inject]
        public var layers:Layers;

        [Inject]
        public var slides:Slides

        private var collection:Collection;
        private var node:Node;

        private var entity:Entity;
        private var position:Position;
        private var controls:KeyControls;

        private var left:Boolean;
        private var right:Boolean;
        private var up:Boolean;
        private var down:Boolean;

        public function KeyMovementSystem()
        {
            left = false;
            right = false;
            up = false;
            down = false;
        }

        [PostConstruct]
        public function setup():void
        {
            collection = entities.getCollection(new <Class>[Position, KeyControls]);
        }

        public function start(time:int):void
        {
            layers.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            layers.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        }

        public function stop(time:int):void
        {
            layers.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
            layers.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
        }

        private function onKeyDown(event:KeyboardEvent):void
        {
            switch (event.keyCode)
            {
                case Keyboard.LEFT:
                    left = true;
                    break;
                case Keyboard.RIGHT:
                    right = true;
                    break;
                case Keyboard.UP:
                    up = true;
                    break;
                case Keyboard.DOWN:
                    down = true;
                    break;
            }
        }

        private function onKeyUp(event:KeyboardEvent):void
        {
            switch (event.keyCode)
            {
                case Keyboard.LEFT:
                    left = false;
                    break;
                case Keyboard.RIGHT:
                    right = false;
                    break;
                case Keyboard.UP:
                    up = false;
                    break;
                case Keyboard.DOWN:
                    down = false;
                    break;
            }
        }

        public function update(time:int, delta:int):void
        {
            var current:Slide = slides.current;

            for (node = collection.head; node; node = node.next)
            {
                entity = node.entity;
                position = entity.get(Position);
                controls = entity.get(KeyControls);

                left && (position.x -= controls.delta);
                right && (position.x += controls.delta);
                up && (position.y -= controls.delta);
                down && (position.y += controls.delta);

                if (position.x < current.x + 10)
                    position.x += controls.delta;
                else if (position.x > current.x + current.width - 95)
                    position.x -= controls.delta;

                if (position.y < current.y + 1)
                    position.y += controls.delta;
                else if (position.y > current.y + current.height - 85)
                    position.y -= controls.delta;
            }
        }
    }
}
