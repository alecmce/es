package alecmce.es.entities
{
    import alecmce.es.core.impl.Entities;

    final internal class EntitiesDelegateApplicator
    {
        public var entityDelegateApplicator:EntityDelegateApplicator;

        private var entities:Entities;
        private var delegate:EntitiesVO;

        public function apply(entities:Entities, delegate:EntitiesVO):void
        {
            this.entities = entities;
            this.delegate = delegate;

            applyEntityDelegates();
        }

        private function applyEntityDelegates():void
        {
            for each (var d:EntityVO in delegate.list)
                entityDelegateApplicator.apply(entities, d);
        }
    }
}
