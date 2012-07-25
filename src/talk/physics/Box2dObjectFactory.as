package talk.physics
{
    import Box2D.Collision.Shapes.b2PolygonShape;
    import Box2D.Dynamics.b2Body;
    import Box2D.Dynamics.b2BodyDef;
    import Box2D.Dynamics.b2FixtureDef;
    import Box2D.Dynamics.b2World;

    import flash.geom.Rectangle;

    public class Box2dObjectFactory
    {
        private var world:b2World;

        public function setWorld(world:b2World):void
        {
            this.world = world;
        }

        public function makeStaticRect(rect:Rectangle):void
        {
            var body:b2BodyDef = new b2BodyDef();
            body.position.Set(rect.left, rect.top);

            var shape:b2PolygonShape = new b2PolygonShape();
            shape.SetAsBox(rect.width, rect.height);

            var fixture:b2FixtureDef = new b2FixtureDef();
            fixture.shape = shape;
            fixture.friction = 0.3;
            fixture.density = 0;

            var body:b2Body = world.CreateBody(body);
            body.CreateFixture(fixture);
        }

        public function makeDynamicRect():void
        {

        }
    }
}
