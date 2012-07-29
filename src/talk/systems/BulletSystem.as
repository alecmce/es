package talk.systems
{
    import alecmce.entitysystem.extensions.view.Camera;
    import alecmce.entitysystem.extensions.view.Position;
    import alecmce.entitysystem.framework.Collection;
    import alecmce.entitysystem.framework.Entities;
    import alecmce.entitysystem.framework.Entity;
    import alecmce.entitysystem.framework.Node;
    import alecmce.entitysystem.framework.System;

    import flash.display.BitmapData;
    import flash.geom.Point;

    import talk.data.Bullet;
    import talk.data.Hit;
    import talk.data.Slide;
    import talk.data.SpaceInvader;

    public class BulletSystem implements System
    {
        private const THRESHOLD:int = 255;

        [Inject]
        public var entities:Entities;

        [Inject]
        public var layers:Layers;

        [Inject]
        public var camera:Camera;

        private var bullets:Collection;
        private var bulletNode:Node;
        private var bulletEntity:Entity;
        private var bulletPos:Position;
        private var bulletBitmap:BitmapData;
        private var bulletPt:Point;
        private var bulletDef:Bullet;

        private var targets:Collection;
        private var targetNode:Node;
        private var targetEntity:Entity;
        private var targetPos:Position;
        private var targetBitmap:BitmapData;
        private var targetPt:Point;

        public function BulletSystem()
        {
            bulletPt = new Point();
            targetPt = new Point();
        }

        public function start(time:int):void
        {
            targets = entities.getCollection(new <Class>[Slide, Position, BitmapData]);
            bullets = entities.getCollection(new <Class>[Position, Bullet, BitmapData]);
        }

        public function stop(time:int):void
        {


        }

        public function update(time:int, delta:int):void
        {
            for (bulletNode = bullets.head; bulletNode; bulletNode = bulletNode.next)
            {
                bulletEntity = bulletNode.entity;
                bulletPos = bulletEntity.get(Position);

                if (camera.contains(bulletPos.x, bulletPos.y))
                {
                    bulletDef = bulletEntity.get(Bullet);
                    bulletBitmap = bulletEntity.get(BitmapData);
                    bulletPt.setTo(bulletPos.x += bulletDef.dx, bulletPos.y += bulletDef.dy);

                    for (targetNode = targets.head; targetNode; targetNode = targetNode.next)
                    {
                        targetEntity = targetNode.entity;
                        targetBitmap = targetEntity.get(BitmapData);

                        if (!targetBitmap)
                        {
                            trace("FIXME! BitmapData-less entity found in BitmapData-required collection");
                            continue;
                        }

                        targetPos = targetEntity.get(Position);
                        targetPt.setTo(targetPos.x, targetPos.y);

                        if (targetBitmap.hitTest(targetPt, THRESHOLD, bulletBitmap, bulletPt, THRESHOLD))
                        {
                            targetEntity.remove(SpaceInvader);
                            targetEntity.add(new Hit());

                            entities.removeEntity(bulletEntity);
                            targetEntity = null;
                        }
                    }
                }
                else
                {
                    entities.removeEntity(bulletEntity);
                }
            }
        }

    }
}
