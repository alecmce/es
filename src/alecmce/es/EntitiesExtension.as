package alecmce.es
{
    import alecmce.es.core.impl.Entities;
    import alecmce.es.core.impl.Systems;

    import robotlegs.bender.framework.api.IContext;
    import robotlegs.bender.framework.api.IExtension;

    public class EntitiesExtension implements IExtension
    {
        public function extend(context:IContext):void
        {
            context.injector.map(Entities).asSingleton();
            context.injector.map(Systems).asSingleton();
        }
    }
}
