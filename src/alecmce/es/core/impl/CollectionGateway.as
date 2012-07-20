package alecmce.es.core.impl
{
    final internal class CollectionGateway
    {
        public var collection:Collection;

        private var requirements:Vector.<Class>;

        public function CollectionGateway(requirements:Vector.<Class>)
        {
            this.requirements = requirements;
        }

        public function addEntityIfMeetsRequirements(entity:Entity):void
        {
            for each (var klass:Class in requirements)
            {
                if (!entity.has(klass))
                    return;
            }

            collection.add(entity);
        }

        public function removeEntityFromCollection(entity:Entity):void
        {
            collection.remove(entity);
        }
    }
}
