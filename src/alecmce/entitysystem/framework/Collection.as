package alecmce.entitysystem.framework
{
    import org.osflash.signals.Signal;

    final public class Collection extends EntityList
    {
        public var entityAdded:Signal;
        public var entityRemoved:Signal;

        public function Collection()
        {
            super();

            entityAdded = new Signal(Entity);
            entityRemoved = new Signal(Entity);
        }

        override public function add(entity:Entity):Entity
        {
            super.add(entity);
            entityAdded.dispatch(entity);
            return entity;
        }

        override public function remove(entity:Entity):Entity
        {
            entity = super.remove(entity);
            if (entity)
                entityRemoved.dispatch(entity);

            return entity;
        }
    }
}
