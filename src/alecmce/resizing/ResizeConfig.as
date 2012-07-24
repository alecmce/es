package alecmce.resizing
{
    import alecmce.resizing.signals.Resize;
    import alecmce.resizing.view.Resizable;
    import alecmce.resizing.view.ResizableMediator;

    import org.swiftsuspenders.Injector;

    import robotlegs.bender.extensions.mediatorMap.api.IMediatorMap;

    public class ResizeConfig
    {
        [Inject]
        public var injector:Injector;

        [Inject]
        public var mediatorMap:IMediatorMap;

        [PostConstruct]
        public function setup():void
        {
            injector.map(Resize).asSingleton();

            mediatorMap.map(Resizable).toMediator(ResizableMediator);
        }
    }
}
