package alecmce.entitysystem.extensions.io.model
{
    import alecmce.entitysystem.framework.Entities;

    import net.sfmultimedia.argonaut.IArgonaut;

    final public class EntitiesIO
    {
        [Inject]
        public var argonaut:IArgonaut;

        private var factory:EntitiesDelegateFactory;
        private var applicator:EntitiesDelegateApplicator;

        public function EntitiesIO()
        {
            factory = new EntitiesDelegateFactory();
            factory.entityDelegateFactory = new EntityDelegateFactory();

            applicator = new EntitiesDelegateApplicator();
            applicator.entityDelegateApplicator = new EntityDelegateApplicator();
        }

        public function parse(entities:Entities, data:String):void
        {
            var delegate:EntitiesVO = argonaut.parse(data);
            applicator.apply(entities, delegate);
        }

        public function stringify(entities:Entities):String
        {
            var delegate:EntitiesVO = factory.makeDelegate(entities);
            return argonaut.stringify(delegate);
        }

    }
}
