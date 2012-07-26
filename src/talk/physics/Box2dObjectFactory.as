package talk.physics
{
    import Box2D.Collision.Shapes.b2MassData;
    import Box2D.Collision.Shapes.b2PolygonShape;
    import Box2D.Common.Math.b2Vec2;
    import Box2D.Dynamics.b2Body;
    import Box2D.Dynamics.b2BodyDef;
    import Box2D.Dynamics.b2FixtureDef;
    import Box2D.Dynamics.b2World;

    import flash.geom.Rectangle;

    public class Box2dObjectFactory
    {
        private const DENSITY:Number = 2.0;
        private const FRICTION:Number = 0.5;
        private const RESTITUTION:Number = 0.0;
        private const MASS_SCALAR:Number = 1.0;

        private var world:b2World;

        public function setWorld(world:b2World):void
        {
            this.world = world;
        }

        public function makeStaticRect(rect:Rectangle):void
        {
            var w:Number = rect.width * 0.5;
            var h:Number = rect.height * 0.5;

            var definition:b2BodyDef = new b2BodyDef();
            definition.position.Set(rect.x + w, rect.y + h);

            var shape:b2PolygonShape = new b2PolygonShape();
            shape.SetAsBox(w, h);

            var fixture:b2FixtureDef = new b2FixtureDef();
            fixture.shape = shape;
            fixture.friction = FRICTION;
            fixture.restitution = RESTITUTION;

            var body:b2Body = world.CreateBody(definition);
            body.CreateFixture(fixture);
        }

        public function makeRoughFloor(x:int, y:int, width:int):void
        {
            for (var i:int = 0; i <= width; i ++)
            {
                var definition:b2BodyDef = new b2BodyDef();
                definition.position.Set(x + i, y);

                var shape:b2PolygonShape = new b2PolygonShape();
                shape.SetAsOrientedBox(Math.random(), Math.random(), new b2Vec2(), Math.random() * Math.PI * 2);

                var fixture:b2FixtureDef = new b2FixtureDef();
                fixture.shape = shape;
                fixture.friction = FRICTION;
                fixture.restitution = RESTITUTION;

                var body:b2Body = world.CreateBody(definition);
                body.CreateFixture(fixture);
            }
        }

        public function makeDynamicRect(rect:Rectangle):b2Body
        {
            var w:Number = rect.width * 0.5;
            var h:Number = rect.height * 0.5;

            var definition:b2BodyDef = new b2BodyDef();
            definition.position.Set(rect.x + w, rect.y + h);
            definition.type = b2Body.b2_dynamicBody;

            var shape:b2PolygonShape = new b2PolygonShape();
            shape.SetAsBox(w, h);

            var fixture:b2FixtureDef = new b2FixtureDef();
            fixture.shape = shape;
            fixture.density = DENSITY;
            fixture.friction = FRICTION;
            fixture.restitution = RESTITUTION;

            var body:b2Body = world.CreateBody(definition);
            body.CreateFixture(fixture);
            body.SetAngularDamping(0.2);

            var mass:b2MassData = new b2MassData();
            mass.mass = w * h * MASS_SCALAR;
            body.SetMassData(mass);


            return body
        }

        public function applyRandomForce(body:b2Body, force:Number, angular:Number):void
        {
            var angle:Number = Math.random() * Math.PI * 2;

            var dx:Number = Math.cos(angle) * force;
            var dy:Number = Math.sin(angle) * force;

            body.SetLinearVelocity(new b2Vec2(dx, dy));
            body.SetAngularVelocity((Math.random() - 0.5) * angular);
        }
    }
}
