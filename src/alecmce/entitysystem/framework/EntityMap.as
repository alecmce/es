package alecmce.entitysystem.framework
{
    final internal class EntityMap
    {
        private var nameMap:Object;
        private var idMap:Object;

        public function EntityMap()
        {
            nameMap = {};
            idMap = {};
        }

        public function add(entity:Entity):void
        {
            idMap[entity.id] = entity;

            var name:String = entity.name;
            if (name)
            {
                if (nameMap[name] != null)
                    throw new Error("Entity naming collision: " + entity.name);
                else
                    nameMap[name] = entity;
            }
        }

        public function remove(entity:Entity):void
        {
            delete idMap[entity.id];

            var name:String = entity.name;
            if (name)
                delete nameMap[name];
        }

        public function getIndexed(id:int):Entity
        {
            return idMap[id];
        }

        public function getNamed(name:String):Entity
        {
            return nameMap[name];
        }
    }
}
