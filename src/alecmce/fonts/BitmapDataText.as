package alecmce.fonts
{
    import flash.display.BitmapData;
    import flash.errors.IllegalOperationError;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    public class BitmapDataText extends BitmapData
    {
        private var font:BitmapFont;
        private var text:String;
        private var list:Vector.<CharacterVO>;

        public function BitmapDataText(font:BitmapFont, text:String)
        {
            this.font = font;
            this.text = text;
            list = makeCharacterList();

            var width:int = getLineWidth();
            var height:int = getLineHeight();
            super(width, height, true, 0);

            paintText(list);
        }

        private function makeCharacterList():Vector.<CharacterVO>
        {
            var list:Vector.<CharacterVO> = new <CharacterVO>[];

            var characters:Array = text.split("");
            var max:int = characters.length - 1;
            for (var i:int = 0; i <= max; i++)
            {
                var character:String = characters[i];

                var vo:CharacterVO = new CharacterVO();
                vo.character = character;
                vo.kerning = i < max ? font.getKerning(character, characters[i + 1]) : 0;

                if (character != " ")
                {
                    vo.data = font.getCharacter(character);
                    if (vo.data == null)
                        throw new IllegalOperationError("You cannot render bitmap text including characters not present in the bitmap font");
                }
                else
                {
                    vo.kerning += font.getSpace();
                }

                list.push(vo);
            }

            return list;
        }

        private function getLineWidth():int
        {
            var width:Number = 0;

            var max:int = list.length - 1;
            for (var i:int = 0; i <= max; i++)
                width += list[i].getWidth();

            return Math.ceil(width);
        }

        private function getLineHeight():int
        {
            var height:int = 0;

            var length:int = list.length;
            for (var i:int = 0; i < length; i++)
            {
                var h:int = list[i].getHeight();
                if (h > height)
                    height = h;
            }

            return height;
        }

        private function paintText(list:Vector.<CharacterVO>):void
        {
            var point:Point = new Point();

            var length:int = list.length;
            for (var i:int = 0; i < length; i++)
            {
                var vo:CharacterVO = list[i];
                if (vo.character != " ")
                    copyPixels(vo.data, vo.data.rect, point, null, null, true);

                point.x += vo.getWidth();
            }
        }
    }
}

import flash.display.BitmapData;

class CharacterVO
{
    public var character:String;
    public var data:BitmapData;
    public var kerning:Number;

    public function getWidth():Number
    {
        return (data ? data.width : 0) + kerning;
    }

    public function getHeight():int
    {
        return data ? data.height : 0;
    }
}