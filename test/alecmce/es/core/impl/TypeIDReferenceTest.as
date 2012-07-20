package alecmce.es.core.impl
{
    import org.flexunit.assertThat;
    import org.hamcrest.core.not;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.notNullValue;

    public class TypeIDReferenceTest
    {
        private var reference:TypeIDReference;

        [Before]
        public function before():void
        {
            reference = new TypeIDReference();
        }

        private function makeAndRegisterComponent(klass:Class):int
        {
            var instance:Object = new klass();
            return reference.register(instance);
        }

        [Test]
        public function canRegisterComponent():void
        {
            var id:int = makeAndRegisterComponent(MockComponent);
            assertThat(id, equalTo(1));
        }

        [Test]
        public function twoComponentsOfSameTypeGetSameId():void
        {
            var a:int = makeAndRegisterComponent(MockComponent);
            var b:int = makeAndRegisterComponent(MockComponent);
            assertThat(a, equalTo(b));
        }

        [Test]
        public function twoComponentsOfDifferentTypesGetDifferentIds():void
        {
            var a:int = makeAndRegisterComponent(MockComponent);
            var b:int = makeAndRegisterComponent(OtherMockComponent);
            assertThat(a, not(equalTo(b)));
        }

        [Test]
        public function canGetIDForVectorOfComponents():void
        {
            var id:String = reference.getCollectionID(new <Class>[MockComponent, OtherMockComponent]);
            assertThat(id, notNullValue());
        }

        [Test]
        public function idsForDifferentVectorsAreDifferent():void
        {
            var a:String = reference.getCollectionID(new <Class>[MockComponent]);
            var b:String = reference.getCollectionID(new <Class>[OtherMockComponent]);
            assertThat(a, not(equalTo(b)));
        }

        [Test]
        public function idsForEqualVectorsAreEqual():void
        {
            var a:String = reference.getCollectionID(new <Class>[MockComponent, OtherMockComponent]);
            var b:String = reference.getCollectionID(new <Class>[MockComponent, OtherMockComponent]);
            assertThat(a, equalTo(b));
        }

        [Test]
        public function idsForEqualButUnsortedVectorsAreEqual():void
        {
            var a:String = reference.getCollectionID(new <Class>[MockComponent, OtherMockComponent]);
            var b:String = reference.getCollectionID(new <Class>[OtherMockComponent, MockComponent]);
            assertThat(a, equalTo(b));
        }
    }
}

class OtherMockComponent {}
