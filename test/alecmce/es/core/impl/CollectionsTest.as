package alecmce.es.core.impl
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
            var requirements:Vector.<Class> = new <Class>[];
            var collection:Collection = collections.getCollection(requirements);
            assertThat(collections.getCollection(requirements), sameInstance(collection));
        }

        [Test]
        public function stillSameCollectionIfRequirementsIsDifferentInstance():void
        {
            var a:Collection = collections.getCollection(new <Class>[]);
            var b:Collection = collections.getCollection(new <Class>[]);
            assertThat(a, b);
        }
    }
}
