package alecmce.es.core.impl
{
    final public class Entities
    {
        private var entities:EntityList;
        private var collections:Collections;
        private var entityMap:EntityMap;

        public function Entities()
        {
            entities = new EntityList();
            collections = new Collections();
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
            return collections.getCollection(requirements) || makeCollection(requirements);
        }

        private function makeCollection(requirements:Vector.<Class>):Collection
        {
            var collection:Collection = collections.makeCollection(requirements);
            populateCollection(requirements, collection);
            return collection;
        }

        private function populateCollection(requirements:Vector.<Class>, collection:Collection):void
        {
            entities.forEachEntity(collections.collectionMembershipTest(requirements));
        }
    }
}