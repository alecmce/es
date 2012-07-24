package alecmce.entitysystem.framework
{
    import flash.utils.Dictionary;

    final internal class TypeIDReference
    {
        private var id:int;
        private var idMap:Dictionary;

        public function TypeIDReference()
        {
            id = 0;
            idMap = new Dictionary();
        }

        public function register(component:Object):int
        {
            var klass:Class = component is Class ? component as Class : component["constructor"];
            var id:int = idMap[klass] ||= ++id;
            return id;
        }

        public function getClassID(klass:Class):int
        {
            return idMap[klass] ||= ++id;
        }

        public function getCollectionID(classes:Vector.<Class>):String
        {
            if (classes == null || classes.length == 0)
                return ".";

            var i:int = classes.length;
            var ids:Vector.<int> = new Vector.<int>(i, true);
            while (i--)
                ids[i] = idMap[classes[i]] ||= ++id;

            return ids.sort(sortIds).join(".");
        }

        private function sortIds(a:int, b:int):int
        {
            return a - b;
        }
    }
}
