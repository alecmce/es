package talk.commands
{
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Node;
    import alecmce.entitysystem.framework.Systems;

    import talk.data.Selected;
    import talk.data.Slide;
    import talk.data.Slides;
    import talk.systems.SlideSelectionSystem;

    public class GotoSlideCommand
    {
        [Inject]
        public var entities:Entities;

        [Inject]
        public var slides:Slides;

        [Inject]
        public var systems:Systems;

        [Inject]
        public var selection:SlideSelectionSystem;

        [Inject]
        public var name:String;

        public function execute():void
        {
            removePreviouslySelected();
            addNewSelected();
            addSelectionSystem();
        }

        private function removePreviouslySelected():void
        {
            var collection:Collection = entities.getCollection(new <Class>[Slides, Slide, Selected]);
            for (var node:Node = collection.head; node; node = node.next)
                node.entity.remove(Selected);
        }

        private function addNewSelected():void
        {
            var slide:Slide = slides.current.getSlideTarget(name);
            if (slide)
            {
                slides.current = slide;
                slide.entity.add(new Selected());
            }
        }

        private function addSelectionSystem():void
        {
            systems.add(selection);
        }
    }
}
