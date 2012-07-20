package alecmce.es.entities
{
    import alecmce.es.core.impl.Entities;
    import alecmce.es.core.impl.Entity;

    final internal class EntityDelegateApplicator
    {
        private var entities:Entities;
        private var delegate:EntityVO;

        private var entity:Entity;

        public function apply(entities:Entities, delegate:EntityVO):void
        {
            this.entities = entities;
            this.delegate = delegate;

            getEntity();
            applyComponents();
        }

        private function getEntity():void
        {
            entity = entities.getEntityByID(delegate.id);
            if (entity == null)
            {
                entity = new Entity(delegate.name);
                entities.addEntity(entity);
            }
        }

        private function applyComponents():void
        {
            for each (var component:Object in delegate.components)
            {
                var klass:Class = component["constructor"];
                if (entity.has(klass))
                    overwriteComponent(entity.get(klass), component);
                else
                    entity.add(component);
            }
        }

        private function overwriteComponent(current:Object, target:Object):void
        {
            for (var key:String in current)
                current[key] = target[key];
        }
    }
}
