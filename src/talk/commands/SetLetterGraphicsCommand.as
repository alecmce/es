package talk.commands
{
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;

    import talk.data.Animation;
    import talk.data.Character;
    import talk.data.Selected;
    import talk.data.Slide;
    import talk.data.Slides;

    public class SetLetterGraphicsCommand
    {
        [Inject]
        public var entities:Entities;

        private var selected:Slide;

        public function execute():void
        {
            getSelectedSlide();
            if (selected)
                reinstateTextGraphics();
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

        private function reinstateTextGraphics():void
        {
            var collection:Collection = entities.getCollection(new <Class>[Slide, Position, Character]);

            for (var node:Node = collection.head; node; node = node.next)
            {
                var entity:Entity = node.entity;
                if (entity.get(Slide) == selected)
                {
                    var character:Character = entity.get(Character);
                    entity.remove(Animation);
                    entity.add(character.data);
                }
            }
        }
    }
}
