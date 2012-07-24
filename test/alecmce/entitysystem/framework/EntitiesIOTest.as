package alecmce.entitysystem.framework
{
    import alecmce.entitysystem.extensions.io.model.EntitiesIO;
    import alecmce.entitysystem.extensions.io.model.EntitiesVO;
    import alecmce.entitysystem.extensions.io.model.EntityVO;

    import net.sfmultimedia.argonaut.Argonaut;

    import org.flexunit.assertThat;
    import org.hamcrest.core.isA;
    import org.hamcrest.object.equalTo;
    import org.hamcrest.object.isNotNull;

    public class EntitiesIOTest
    {
        private var entities:Entities;
        private var io:EntitiesIO;

        [Before]
        public function before():void
        {
            entities = new Entities();
            io = new EntitiesIO();
            io.argonaut = new Argonaut();
        }

        [Test]
        public function canStringify():void
        {
            assertThat(io.stringify(entities), isA(String));
        }

        [Test]
        public function stringifyCreatesValidJSON():void
        {
            var data:String = io.stringify(entities);
            var object:Object = JSON.parse(data);
            assertThat(object, isA(Object));
        }

        [Test]
        public function namedEntityRoundtrips():void
        {
            var entity:Entity = new Entity("test");
            entities.addEntity(entity);

            var alternate:Entities = new Entities();
            var data:String = io.stringify(entities);
            io.parse(alternate, data);

            assertThat(alternate.getNamedEntity("test"), isNotNull());
        }

        [Test]
        public function roundtripWithoutFluff():void
        {
            var entityVO:EntityVO = new EntityVO();
            entityVO.name = "name";
            var entitiesVO:EntitiesVO = new EntitiesVO();
            entitiesVO.list = [entityVO];

            var json:String = io.argonaut.stringify(entitiesVO);
            var roundtripped:EntitiesVO = io.argonaut.parse(json);

            assertThat(roundtripped.list[0].name, equalTo("name"));
        }
    }
}