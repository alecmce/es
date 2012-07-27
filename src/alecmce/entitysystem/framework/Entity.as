package alecmce.entitysystem.framework
{
    import flash.utils.Dictionary;

    import org.osflash.signals.Signal;

    final public class Entity
    {
        private static var ID:int = 0;

        public var componentAdded:Signal;
        public var componentRemoved:Signal;

        private var _id:int;
        private var _name:String;

        private var components:Dictionary;
        private var deleting:Dictionary;

        public function Entity(name:String = "")
        {
            _id = ++ID;
            _name = name;
            componentAdded = new Signal(Entity, Object);
            componentRemoved = new Signal(Entity, Class);

            components = new Dictionary();
            deleting = new Dictionary();
        }

        public function get id():int
        {
            return _id;
        }

        public function get name():String
        {
            return _name;
        }

        public function add(component:Object):void
        {
            var klass:Class = component["constructor"];
            components[klass] = component;
            componentAdded.dispatch(this, component);
        }

        public function remove(klass:Class):void
        {
            if (components[klass] && !deleting[klass])
            {
                deleting[klass] = true;
                componentRemoved.dispatch(this, klass);
                delete components[klass];
                delete deleting[klass];
            }
        }

        public function has(klass:Class):Boolean
        {
            return components[klass] != null;
        }

        public function get(klass:Class):*
        {
            return components[klass];
        }

        public function getComponents():Vector.<Class>
        {
            var list:Vector.<Class> = new <Class>[];
            for (var klass:* in components)
                list.push(klass);

            return list;
        }
    }
}
