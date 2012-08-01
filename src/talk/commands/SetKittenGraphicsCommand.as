package talk.commands
{
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;

    import flash.display.BitmapData;

    import talk.data.Animation;
    import talk.data.Selected;
    import talk.data.Slide;
    import talk.data.Slides;
    import talk.factories.AssetFactory;

    public class SetKittenGraphicsCommand
    {
        [Inject]
        public var entities:Entities;

        [Inject]
        public var assets:AssetFactory;

        private var selected:Slide;

        public function execute():void
        {
            getSelectedSlide();
            if (selected)
                makeKittenGraphics();
        }

        private function getSelectedSlide():void
        {
            var collection:Collection = entities.getCollection(new <Class>[Slides, Slide, Selected]);
            if (collection.head)
            {
                var entity:Entity = collection.head.entity;
                selected = entity.get(Slide);
            }
        }

        private function makeKittenGraphics():void
        {
            var collection:Collection = entities.getCollection(new <Class>[Slide, Position, BitmapData]);

            for (var node:Node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                if (entity.get(Slide) == selected)
                {
                    entity.remove(Animation);
                    entity.add(assets.makeKitten());
                }
            }
        }
    }
}
