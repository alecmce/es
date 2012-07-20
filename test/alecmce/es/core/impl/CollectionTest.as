package alecmce.es.core.impl
{
    import org.flexunit.assertThat;
    import org.hamcrest.object.isFalse;
    import org.hamcrest.object.isTrue;

    public class CollectionTest
    {
        private var entities:Entities;
        private var entity:Entity;

        [Before]
        public function before():void
        {
            entities = new Entities();
            entity = new Entity();
        }

        [Test]
        public function canAddEntityToCollection():void
        {
            var collection:Collection = new Collection();
            collection.add(entity);
            assertThat(collection.has(entity), isTrue());
        }

        [Test]
        public function canRemoveEntityFromCollection():void
        {
            var collection:Collection = new Collection();
            collection.add(entity);
            collection.remove(entity);
            assertThat(collection.has(entity), isFalse());
        }
    }
}
