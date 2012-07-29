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
        public var index:String;

        private var i:int;

        public function execute():void
        {
            i = int(index);
            if (i < 0 || i >= slides.list.length)
                return;

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
            var slide:Slide = slides.list[i];
            slide.entity.add(new Selected());
        }

        private function addSelectionSystem():void
        {
            systems.add(selection);
        }
    }
}
