package alecmce.es.core.impl
{
    import flash.utils.Dictionary;

    internal class EntityList
    {
        public var head:Node;
        public var tail:Node;
        public var count:int;

        private var map:Dictionary;

        public function EntityList()
        {
            map = new Dictionary();
        }

        public function add(entity:Entity):Entity
        {
            addNode(new Node(entity));
            return entity;
        }

        public function has(entity:Entity):Boolean
        {
            return map[entity] != null;
        }

        public function remove(entity:Entity):Entity
        {
            var node:Node = map[entity];
            if (node)
            {
                removeNode(node);
                return entity;
            }
            else
            {
                return null;
            }
        }

        public function forEachEntity(fn:Function):void
        {
            for (var node:Node = head; node; node = node.next)
            {
                fn(node.entity);
            }
        }

        public function pop():Entity
        {
            return count ? removeNode(tail).entity : null;
        }

        private function addNode(node:Node):void
        {
            if (tail)
            {
                tail.next = node;
                node.prev = tail;
                tail = node;
            }
            else
            {
                head = tail = node;
            }

            map[node.entity] = node;
            ++count;
        }

        private function removeNode(node:Node):Node
        {
            if (head == node)
                head = node.next;

            if (tail == node)
                tail = node.prev;

            if (node.prev)
                node.prev.next = node.next;

            if (node.next)
                node.next.prev = node.prev;

            --count;
            delete map[node.entity];
            return node;
        }
    }
}
