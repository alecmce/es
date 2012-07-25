package alecmce.entitysystem.extensions.view.renderer
{
    import alecmce.entitysystem.framework.System;

    import flash.display.BitmapData;

    public interface Renderer extends System
    {

        function setCanvas(canvas:BitmapData):void

    }
}
