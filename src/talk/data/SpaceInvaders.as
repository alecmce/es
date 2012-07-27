package talk.data
{
    public class SpaceInvaders
    {
        private var count:int;

        private var rowMax:int;
        private var rowCount:int;
        private var rows:Vector.<Vector.<SpaceInvader>>;
        private var size:Size;

        public function SpaceInvaders(rowMax:int = 10)
        {
            this.rowMax = rowMax;
            this.rows = new Vector.<Vector.<SpaceInvader>>();
            this.size = new Size();
            size.left = size.top = size.right = size.bottom = 0;
        }

        public function add(invader:SpaceInvader):void
        {
            if (!has(invader))
            {
                if (++count > rowMax * rowCount)
                {
                    ++rowCount;
                    rows.push(new Vector.<SpaceInvader>());
                }

                var rowIndex:int = rowCount - 1;
                if (rowIndex > size.bottom)
                    ++size.bottom;

                var row:Vector.<SpaceInvader> = rows[rowIndex];
                var columnIndex:int = row.length;
                if (columnIndex > size.right)
                    ++size.right;

                row.push(invader);
                invader.container = this;
                invader.x = columnIndex;
                invader.y = rowIndex;
            }
        }

        public function get(x:int, y:int):SpaceInvader
        {
            var row:Vector.<SpaceInvader> = rows[y];
            return row[x];
        }

        public function has(invader:SpaceInvader):Boolean
        {
            return invader.container == this;
        }

        public function remove(invader:SpaceInvader):void
        {
            if (has(invader))
            {
                var row:Vector.<SpaceInvader> = rows[invader.y];
                row[invader.x] = null;
                handleSizeChange(invader);
                invader.reset();
            }
        }

        public function getRowMax():int
        {
            return rowMax;
        }

        public function getCount():int
        {
            return rows.length;
        }

        public function getRows():int
        {
            return rows.length > 0 ? 1 : 0;
        }

        public function getSize():Size
        {
            return size;
        }

        private function handleSizeChange(invader:SpaceInvader):void
        {
            if (invader.x == size.left)
                checkLeftBounds();
            else if (invader.x == size.right)
                checkRightBounds();

            if (invader.y == size.top)
                checkTopBounds();
            else if (invader.y == size.bottom)
                checkBottomBounds();
        }

        private function checkLeftBounds():void
        {
            var left:int = size.left;
            for (var y:int = size.top; y < size.bottom; y++)
            {
                if (get(left, y) != null)
                    return;
            }

            ++size.left;
        }

        private function checkRightBounds():void
        {
            var right:int = size.right;
            for (var y:int = size.top; y < size.bottom; y++)
            {
                if (get(right, y) != null)
                    return;
            }

            --size.right;
        }

        private function checkTopBounds():void
        {
            var top:int = size.top;
            for (var x:int = size.left; x < size.right; x++)
            {
                if (get(x, top) != null)
                    return;
            }

            ++size.top;
        }

        private function checkBottomBounds():void
        {
            var bottom:int = size.bottom;
            for (var x:int = size.left; x < size.right; x++)
            {
                if (get(x, bottom) != null)
                    return;
            }

            --size.bottom;
        }
    }
}
