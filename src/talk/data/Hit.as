package talk.data
{
    import flash.display.BitmapData;

    public class Hit
    {
        public var vanilla:BitmapData;

        public var head:HitPixel;
        public var tail:HitPixel;

        public function add(pixel:HitPixel):void
        {
            if (tail)
            {
                tail.next = pixel;
                pixel.prev = tail;
                tail = pixel;
            }
            else
            {
                head = tail = pixel;
            }
        }

        public function remove(pixel:HitPixel):void
        {
            if (pixel == head)
                head = head.next;

            if (pixel == tail)
                tail = tail.prev;

            if (pixel.next)
                pixel.next.prev = pixel.prev;

            if (pixel.prev)
                pixel.prev.next = pixel.next;
        }
    }
}
