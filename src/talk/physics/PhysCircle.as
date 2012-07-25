package talk.physics
{
    import flash.display.Sprite;

    public class PhysCircle extends Sprite
    {
        public function PhysCircle()
        {
            graphics.lineStyle(2, 0xFF000000);
            graphics.drawCircle(0, 0, 20);
        }
    }
}
