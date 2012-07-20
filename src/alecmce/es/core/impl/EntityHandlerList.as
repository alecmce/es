package alecmce.es.core.impl
{
    final internal class EntityHandlerList
    {
        public var reference:TypeIDReference;

        private var hash:Object;

        public function EntityHandlerList()
        {
            hash = {};
        }

        public function add(components:Vector.<Class>, method:Function):void
        {
            var i:int = components.length;
            while (i--)
            {
                var id:int = reference.getClassID(components[i]);
                (hash[id] ||= new <Function>[]).push(method);
            }
        }

        public function addNewCollectionMemberships(entity:Entity, component:Object):void
        {
            call(reference.register(component), entity);
        }

        public function removeOldCollectionMemberships(entity:Entity, klass:Class):void
        {
            call(reference.getClassID(klass), entity);
        }

        private function call(id:int, entity:Entity):void
        {
            var list:Vector.<Function> = hash[id];
            if (list)
            {
                var i:int = list.length;
                while (i--)
                    list[i](entity);
            }
        }
    }
}
