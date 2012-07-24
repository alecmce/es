package alecmce.entitysystem.extensions.io.model
{
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;

    final internal class EntitiesDelegateFactory
    {
        private const UNIVERSAL_COLLECTION:Vector.<Class> = new <Class>[];

        public var entityDelegateFactory:EntityDelegateFactory;

        private var entitiesDelegate:EntitiesVO;

        public function makeDelegate(entities:Entities):EntitiesVO
        {
            entitiesDelegate = new EntitiesVO();
            entitiesDelegate.list = [];
            parseEntities(entities);
            return entitiesDelegate;
        }

        private function parseEntities(entities:Entities):void
        {
            var collection:Collection = entities.getCollection(UNIVERSAL_COLLECTION);
            collection.forEachEntity(parseEntity);
        }

        private function parseEntity(entity:Entity):void
        {
            var entityDelegate:EntityVO = entityDelegateFactory.makeDelegate(entity);
            entitiesDelegate.list.push(entityDelegate);
        }
    }
}