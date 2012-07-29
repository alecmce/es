package alecmce.entitysystem.framework
{
    final public class Entities
    {
        private var entities:EntityList;
        private var reference:TypeIDReference;
        private var collections:Collections;
        private var entityMap:EntityMap;

        public function Entities()
        {
            entities = new EntityList();
            reference = new TypeIDReference();
            collections = new Collections();
            collections.setReference(reference);
            entityMap = new EntityMap();
        }

        public function addEntity(entity:Entity):void
        {
            entities.add(entity);
            collections.registerEntity(entity);
            entityMap.add(entity);
        }

        public function removeEntity(entity:Entity):void
        {
            entities.remove(entity);
            collections.unregisterEntity(entity);
            entityMap.remove(entity);
        }

        public function getEntityByID(id:int):Entity
        {
            return entityMap.getIndexed(id);
        }

        public function getNamedEntity(name:String):Entity
        {
            return entityMap.getNamed(name);
        }

        public function getCollection(requirements:Vector.<Class>):Collection
        {
            var id:String = reference.getCollectionID(requirements);
            return collections.getCollection(id) || makeCollection(id, requirements);
        }

        private function makeCollection(id:String, requirements:Vector.<Class>):Collection
        {
            var collection:Collection = collections.makeCollection(id, requirements);
            populateCollection(requirements, collection);
            return collection;
        }

        private function populateCollection(requirements:Vector.<Class>, collection:Collection):void
        {
            entities.forEachEntity(collections.collectionMembershipTest(requirements));
        }
    }
}