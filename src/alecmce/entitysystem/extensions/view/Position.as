package alecmce.entitysystem.extensions.view
{
    import flash.geom.Matrix;

    final public class Position
    {
        public var x:Number;
        public var y:Number;
        public var rotation:Rotation;

        private var matrix:Matrix;

        public function Position(x:Number = 0, y:Number = 0)
        {
            this.x = x;
            this.y = y;
            this.rotation = new Rotation();

            matrix = new Matrix();
        }

        public function hasRotation():Boolean
        {
            return rotation.getAngle() != 0;
        }

        public function getTransform():Matrix
        {
            var transform:Vector.<Number> = rotation.getMatrix();

            matrix.a = transform[0];
            matrix.b = transform[1];
            matrix.c = transform[2];
            matrix.d = transform[3];
            matrix.tx = x;
            matrix.ty = y;

            return matrix;
        }
    }
}
