package alecmce.es
{
    import alecmce.es.entities.EntitiesIO;

    import net.sfmultimedia.argonaut.Argonaut;
    import net.sfmultimedia.argonaut.IArgonaut;

    import robotlegs.bender.framework.api.IContext;
    import robotlegs.bender.framework.api.IExtension;

    public class EntitiesIOExtension implements IExtension
    {
        public function extend(context:IContext):void
        {
            context.injector.map(EntitiesIO).asSingleton();
            context.injector.map(IArgonaut).toSingleton(Argonaut);
        }
    }
}
