package talk.commands
{
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;
    import alecmce.entitysystem.framework.System;
    import alecmce.entitysystem.framework.Systems;

    import talk.data.Selected;

    import talk.data.Slide;
    import talk.data.Slides;

    public class RemoveSelectedSlideSystemsCommand
    {
        [Inject]
        public var entities:Entities;

        [Inject]
        public var systems:Systems;

        public function execute():void
        {
            var collection:Collection = entities.getCollection(new <Class>[Slides, Slide, Selected]);
            for (var node:Node = collection.head; node; node = node.next)
                removeSystemsAddedAsComponentsToEntity(node.entity);
        }

        private function removeSystemsAddedAsComponentsToEntity(entity:Entity):void
        {
            var list:Vector.<Class> = entity.getComponents();
            for each (var klass:Class in list)
            {
                var possibleSystem:Object = entity.get(klass);
                if (possibleSystem is System)
                {
                    entity.remove(klass);
                    systems.remove(possibleSystem as System);
                }
            }
        }
    }
}
