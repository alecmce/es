package talk.data
{
    import alecmce.entitysystem.framework.Entity;

    public class HitPixel
    {
        public var prev:HitPixel;
        public var next:HitPixel;
        public var entity:Entity;

        public var dx:Number;
        public var dy:Number;

        public var life:int;
    }
}
