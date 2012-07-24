package alecmce.entitysystem.framework
{
    import flash.utils.Dictionary;

    final internal class Collections
    {
        private var reference:TypeIDReference;
        private var collections:Dictionary;
        private var addHandlers:EntityHandlerList;
        private var removeHandlers:EntityHandlerList;
        private var gateways:CollectionGateways;

        public function Collections()
        {
            reference = new TypeIDReference();
            collections = new Dictionary(true);

            addHandlers = new EntityHandlerList();
            addHandlers.reference = reference;

            removeHandlers = new EntityHandlerList();
            removeHandlers.reference = reference;

            gateways = new CollectionGateways(reference);
            gateways.addHandlers = addHandlers;
            gateways.removeHandlers = removeHandlers;
        }

        public function registerEntity(entity:Entity):void
        {
            addToCollectionsForEachComponent(entity);
            entity.componentAdded.add(addToCollections);
            entity.componentRemoved.add(removeFromCollections);
        }

        private function addToCollectionsForEachComponent(entity:Entity):void
        {
            for each (var component:Object in entity.getComponents())
                addToCollections(entity, component);
        }

        public function unregisterEntity(entity:Entity):void
        {
            entity.componentAdded.remove(addToCollections);
            entity.componentRemoved.remove(removeFromCollections);
        }

        public function getCollection(requirements:Vector.<Class>):Collection
        {
            return collections[reference.getCollectionID(requirements)];
        }

        public function makeCollection(requirements:Vector.<Class>):Collection
        {
            var collection:Collection = new Collection();
            makeCollectionGateway(requirements, collection);
            return collection;
        }

        public function collectionMembershipTest(requirements:Vector.<Class>):Function
        {
            return gateways.get(requirements).addEntityIfMeetsRequirements;
        }

        private function makeCollectionGateway(requirements:Vector.<Class>, collection:Collection):void
        {
            var gateway:CollectionGateway = gateways.get(requirements);
            gateway.collection = collection;
        }

        private function addToCollections(entity:Entity, component:Object):void
        {
            addHandlers.addNewCollectionMemberships(entity, component);
        }

        private function removeFromCollections(entity:Entity, klass:Class):void
        {
            removeHandlers.removeOldCollectionMemberships(entity, klass);
        }
    }
}
