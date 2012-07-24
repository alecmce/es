package alecmce.entitysystem.extensions.renderer
{
    import alecmce.entitysystem.framework.System;

    import flash.display.BitmapData;

    public interface Renderer extends System
    {

        function setCanvas(canvas:BitmapData):void

    }
}
