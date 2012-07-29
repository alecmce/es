package alecmce.entitysystem.framework
{
    import org.flexunit.assertThat;
    import org.hamcrest.object.sameInstance;

    public class CollectionsTest
    {
        private var typeReference:TypeIDReference;
        private var collections:Collections;

        [Before]
        public function before():void
        {
            typeReference = new TypeIDReference();
            collections = new Collections();
        }

        [Test]
        public function passingSameRequirementsGivesBackSameCollection():void
        {
            var id:String = "blah";
            var collection:Collection = collections.getCollection(id);
            assertThat(collections.getCollection(id), sameInstance(collection));
        }
    }
}
