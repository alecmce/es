package alecmce.entitysystem.framework
{
    import org.flexunit.assertThat;
    import org.hamcrest.core.isA;
    import org.hamcrest.object.isFalse;
    import org.hamcrest.object.isTrue;

    public class EntitiesTest
    {
        private var entities:Entities;
        private var entity:Entity;

        [Before]
        public function before():void
        {
            entities = new Entities();
            entity = new Entity("test");
            entities.addEntity(entity);
        }

        [Test]
        public function canGetEntity():void
        {
            assertThat(entities.getNamedEntity("test"), isA(Entity));
        }

        [Test]
        public function canGetCollection():void
        {
            assertThat(entities.getCollection(new <Class>[]), isA(Collection));
        }

        [Test]
        public function onMeetingRequirementsEntityAddedToCollection()
        {
            var collection:Collection = entities.getCollection(new <Class>[MockComponent]);
            entity.add(new MockComponent());
            assertThat(collection.has(entity), isTrue());
        }

        [Test]
        public function onNotMeetingRequirementsEntityRemovedFromCollection():void
        {
            var collection:Collection = entities.getCollection(new <Class>[MockComponent]);
            entity.add(new MockComponent());
            entity.remove(MockComponent);
            assertThat(collection.has(entity), isFalse());
        }

        [Test]
        public function newlyRegisteredEntityIsAddedToCollectionsForWhichItMeetsRequirements():void
        {
            var collection:Collection = entities.getCollection(new <Class>[MockComponent]);
            var alternate:Entity = new Entity();
            alternate.add(new MockComponent());
            entities.addEntity(alternate);
            assertThat(collection.has(alternate), isTrue());
        }
    }
}
