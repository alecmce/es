package talk.physics
{
    import Box2D.Collision.Shapes.b2PolygonShape;
    import Box2D.Common.Math.b2Vec2;
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
            var definition:b2BodyDef = new b2BodyDef();
            definition.position.Set(rect.left, rect.top);

            var shape:b2PolygonShape = new b2PolygonShape();
            shape.SetAsBox(rect.width, rect.height);

            var fixture:b2FixtureDef = new b2FixtureDef();
            fixture.shape = shape;
            fixture.friction = 0.3;
            fixture.density = 0;

            var body:b2Body = world.CreateBody(definition);
            body.CreateFixture(fixture);
        }

        public function makeDynamicRect(rect:Rectangle, userData:* = null):b2Body
        {
            var definition:b2BodyDef = new b2BodyDef();
            definition.position.Set(rect.left, rect.top);

            var shape:b2PolygonShape = new b2PolygonShape();
            shape.SetAsBox(rect.width, rect.height);

            var fixture:b2FixtureDef = new b2FixtureDef();
            fixture.shape = shape;
            fixture.density = 1.0;
            fixture.friction - 0.5;
            fixture.restitution = 0.2;

            var body:b2Body = world.CreateBody(definition);
            body.CreateFixture(fixture);

            if (userData)
                definition.userData = userData;

            return body
        }

        public function applyRandomForce(body:b2Body):void
        {
            var dx:Number = Math.random() - 0.5;
            var dy:Number = Math.random() - 0.5;
            var px:Number = (Math.random() - 0.5) * 0.5;
            var py:Number = (Math.random() - 0.5) * 0.5;

            var force:b2Vec2 = new b2Vec2(dx, dy);
            var position:b2Vec2 = new b2Vec2(px, py);
            body.ApplyForce(force, position);
        }
    }
}
