package talk.physics
{
    import flash.display.Sprite;

    public class PhysGround extends Sprite
    {
        public function PhysGround()
        {
            graphics.beginFill(0xFFFF0000);
            graphics.drawRect(0, 0, 40, 40);
            graphics.endFill();
        }
    }
}
