package alecmce.entitysystem.framework
{
    import org.hamcrest.assertThat;
    import org.hamcrest.core.isA;
    import org.hamcrest.object.isFalse;
    import org.hamcrest.object.isNull;
    import org.hamcrest.object.isTrue;

    public class EntitiesTest
    {
        private var entities:Entities;
        private var entity:Entity;

        [Before]
        public function before():void
        {
            entities = new Entities();
            entity = new Entity("talk");
            entities.addEntity(entity);
        }

        [Test]
        public function canGetEntity():void
        {
            assertThat(entities.getNamedEntity("talk"), isA(Entity));
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
        public function whenOnlyEntityIsRemovedCollectionHeadIsNullified():void
        {
            var collection:Collection = entities.getCollection(new <Class>[MockComponent]);
            entity.add(new MockComponent());
            entity.remove(MockComponent);
            assertThat(collection.head, isNull());
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

        [Test]
        public function partialSatisfactionEntityIsntAddedToCollection():void
        {
            var collection:Collection = entities.getCollection(new <Class>[MockComponent, MockAltComponent]);

            var entity:Entity = new Entity();
            entities.addEntity(entity);
            entity.add(new MockComponent());

            assertThat(collection.has(entity), isFalse());
        }

        [Test]
        public function multipleComponentsEntityIsAddedToCollection():void
        {
            var collection:Collection = entities.getCollection(new <Class>[MockComponent, MockAltComponent]);

            var entity:Entity = new Entity();
            entities.addEntity(entity);
            entity.add(new MockComponent());
            entity.add(new MockAltComponent());

            assertThat(collection.has(entity), isTrue());
        }

        [Test]
        public function removingNecessaryComponentRemovesEntityFromCollection():void
        {
            var collection:Collection = entities.getCollection(new <Class>[MockComponent, MockAltComponent]);

            var entity:Entity = new Entity();
            entities.addEntity(entity);
            entity.add(new MockComponent());
            entity.add(new MockAltComponent());

            entity.remove(MockComponent);
            assertThat(collection.has(entity), isFalse());
        }

        [Test]
        public function partialSatisfactionEntityIsntAddedToCollectionWhenAdded():void
        {
            var collection:Collection = entities.getCollection(new <Class>[MockComponent, MockAltComponent]);

            var entity:Entity = new Entity();
            entity.add(new MockComponent());
            entities.addEntity(entity);

            assertThat(collection.has(entity), isFalse());
        }

        [Test]
        public function multipleComponentsEntityIsAddedToCollectionWhenAdded():void
        {
            var collection:Collection = entities.getCollection(new <Class>[MockComponent, MockAltComponent]);

            var entity:Entity = new Entity();
            entity.add(new MockComponent());
            entity.add(new MockAltComponent());
            entities.addEntity(entity);

            assertThat(collection.has(entity), isTrue());
        }

        [Test]
        public function removingEntityInAddedLoopIsHandledCorrectly():void
        {
            var collection:Collection = entities.getCollection(new <Class>[MockComponent]);
            var entity:Entity = new Entity();
            entities.addEntity(entity);

            function onEntityAdded(entity:Entity):void
            {
                entity.remove(MockComponent);
            }

            collection.entityAdded.addOnce(onEntityAdded);
            entity.add(new MockComponent());

            assertThat(collection.has(entity), isFalse());
        }
    }
}
