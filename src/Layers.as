package
{
    import alecmce.resizing.view.Resizable;

    import flash.display.Bitmap;
    import flash.display.BitmapData;

    import flash.display.Sprite;
    import flash.geom.Rectangle;

    public class Layers extends Sprite implements Resizable
    {
        public var console:Sprite;
        public var dialog:Sprite;
        public var main:Sprite;
        public var canvas:Bitmap;
        public var background:Sprite;

        private var size:Rectangle;

        public function Layers(size:Rectangle)
        {
            this.size = size;

            makeBitmap();
            makeLayers();
            addLayers();
        }

        private function makeBitmap():void
        {
            var bitmapData:BitmapData = new BitmapData(size.width, size.height, true, 0x00000000);
            canvas = new Bitmap(bitmapData);
        }

        private function makeLayers():void
        {
            background = new Sprite();
            main = new Sprite();
            dialog = new Sprite();
            console = new Sprite();
        }

        private function addLayers():void
        {
            addChild(background);
            addChild(canvas);
            addChild(main);
            addChild(dialog);
            addChild(console);
        }

        public function getSize():Rectangle
        {
            return size;
        }

        public function resize(rectangle:Rectangle):void
        {
            this.size = rectangle;
        }
    }
}
