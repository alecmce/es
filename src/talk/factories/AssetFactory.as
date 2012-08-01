package talk.factories
{
    import flash.display.BitmapData;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class AssetFactory
    {
        [Embed(source="../../../assets/spaceship.png", mimeType="image/png")]
        public static const SpaceshipAsset:Class;

        [Embed(source="../../../assets/bullet.png", mimeType="image/png")]
        public static const BulletAsset:Class;

        [Embed(source="../../../assets/spaceinvaders.png", mimeType="image/png")]
        public static const InvaderAsset:Class;

        [Embed(source="../../../assets/kitten.png", mimeType="image/png")]
        public static const KittenAsset:Class;

        private const ORIGIN:Point = new Point();

        private var spaceship:BitmapData;
        private var bullet:BitmapData;
        private var kitten:BitmapData;
        private var invader:Vector.<BitmapData>;

        public function makeSpaceship():BitmapData
        {
            return spaceship ||= new SpaceshipAsset().bitmapData;
        }

        public function makeBullet():BitmapData
        {
            return bullet ||= new BulletAsset().bitmapData;
        }

        public function makeKitten():BitmapData
        {
            return kitten ||= new KittenAsset().bitmapData;
        }

        public function makeInvader():Vector.<BitmapData>
        {
            return invader ||= createInvader();
        }

        private function createInvader():Vector.<BitmapData>
        {
            var source:BitmapData = new InvaderAsset().bitmapData;
            var rect:Rectangle = new Rectangle(0, 0, 40, source.height);

            var first:BitmapData = new BitmapData(40, source.height, true, 0);
            first.copyPixels(source, rect, ORIGIN, null, null, true);

            rect.x += 40;
            var second:BitmapData = new BitmapData(40, source.height, true, 0);
            second.copyPixels(source, rect, ORIGIN, null, null, true);

            return new <BitmapData>[first, second];
        }
    }
}
