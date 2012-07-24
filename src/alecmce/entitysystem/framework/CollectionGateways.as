package alecmce.entitysystem.framework
{
    final internal class CollectionGateways
    {
        public var addHandlers:EntityHandlerList;
        public var removeHandlers:EntityHandlerList;

        private var reference:TypeIDReference;
        private var map:Object;

        public function CollectionGateways(reference:TypeIDReference)
        {
            this.reference = reference;
            map = {};
        }

        public function get(requirements:Vector.<Class>):CollectionGateway
        {
            var id:String = reference.getCollectionID(requirements);
            return map[id] ||= makeGateway(requirements);
        }

        private function makeGateway(requirements:Vector.<Class>):CollectionGateway
        {
            var gateway:CollectionGateway = new CollectionGateway(requirements);
            addHandlers.add(requirements, gateway.addEntityIfMeetsRequirements);
            removeHandlers.add(requirements, gateway.removeEntityFromCollection);
            return gateway;
        }


    }
}
