package alecmce.entitysystem.framework
{
    final public class Node
    {
        public var prev:Node;
        public var next:Node;

        public var entity:Entity;

        public function Node(entity:Entity)
        {
            this.entity = entity;
        }
    }
}
