package alecmce.entitysystem.extensions.view
{
    public class Rotation
    {
        private var matrix:Vector.<Number>;
        private var external:Vector.<Number>;
        private var angle:Number;

        public function Rotation()
        {
            matrix = new <Number>[1, 0, 0, 1];
            matrix.fixed = true;

            external = new <Number>[1, 0, 0, 1];
            external.fixed = true;

            angle = 0;
        }

        public function resetAngle():void
        {
            matrix[0] = 1;
            matrix[1] = 0;
            matrix[2] == 0;
            matrix[3] == 1;
        }

        public function getMatrix():Vector.<Number>
        {
            external[0] = matrix[0];
            external[1] = matrix[1];
            external[2] = matrix[2];
            external[3] = matrix[3];
            return external;
        }

        public function setMatrix(matrix:Vector.<Number>):void
        {
            this.matrix[0] = matrix[0];
            this.matrix[1] = matrix[1];
            this.matrix[2] = matrix[2];
            this.matrix[3] = matrix[3];
            angle = Number.NaN;
        }

        public function getAngle():Number
        {
            return angle;
        }

        public function setAngle(angle:Number):void
        {
            this.angle = angle;
            matrix[0] = matrix[3] = Math.cos(angle);
            matrix[2] = Math.sin(angle);
            matrix[1] = -matrix[2];
        }
    }
}
