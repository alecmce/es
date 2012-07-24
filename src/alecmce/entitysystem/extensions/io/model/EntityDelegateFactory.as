package alecmce.entitysystem.extensions.io.model
{
    import alecmce.entitysystem.framework.Entity;

    final internal class EntityDelegateFactory
    {
        private var delegate:EntityVO;

        public function makeDelegate(entity:Entity):EntityVO
        {
            delegate = new EntityVO();
            delegate.id = entity.id;
            delegate.name = entity.name;
            delegate.components = parseComponents(entity);
            return delegate;
        }

        private function parseComponents(entity:Entity):Array
        {
            var components:Array = [];

            var klasses:Vector.<Class> = entity.getComponents();
            for each (var klass:Class in klasses)
                components.push(entity.get(klass));

            return components;
        }

    }
}
