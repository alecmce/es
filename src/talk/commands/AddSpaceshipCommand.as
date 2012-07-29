package talk.commands
{
    import alecmce.entitysystem.extensions.view.Camera;
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;

    import flash.geom.Rectangle;

    import talk.data.Gun;

    import talk.data.KeyControls;
    import talk.data.Selected;
    import talk.data.Slide;
    import talk.data.Slides;
    import talk.factories.AssetFactory;

    public class AddSpaceshipCommand
    {
        [Inject]
        public var entities:Entities;

        [Inject]
        public var camera:Camera;

        [Inject]
        public var assets:AssetFactory;

        public function execute():void
        {
            var x:int = camera.left + camera.width * 0.5;
            var y:int = camera.top + camera.height + 50;
            var position:Position = new Position(x, y);

            var slide:Slide = getSelectedSlide();
            var controls:KeyControls = new KeyControls();
            controls.limits = new Rectangle(slide.x + 10, slide.height - 85, slide.width - 95, 1);
            controls.delta = 5;

            var gun:Gun = new Gun();
            gun.ammo = -1;
            gun.frequency = 150;
            gun.originOffsetX = 30;
            gun.originOffsetY = 0;
            gun.speed = 10;

            var entity:Entity = new Entity();
            entity.add(position);
            entity.add(assets.makeSpaceship());
            entity.add(controls);
            entity.add(gun);
            entities.addEntity(entity);
        }

        private function getSelectedSlide():Slide
        {
            var collection:Collection = entities.getCollection(new <Class>[Slides, Slide, Selected]);
            return collection.head ? collection.head.entity.get(Slide) : null;
        }
    }
}
