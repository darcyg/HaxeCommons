package app.config;
import app.controller.StartupCommand;
import app.controller.SignalCommandTest;
import app.controller.TestSignal;
import app.view.AppView;
import app.view.AppMediator;
import app.model.AppModel;
import app.service.AppService;
import flash.display.DisplayObjectContainer;
import flash.events.IEventDispatcher;
import flash.events.Event;
import minject.Injector;
import msignal.Signal;
import robotlegs.bender.extensions.eventcommandmap.api.IEventCommandMap;
import robotlegs.bender.extensions.mediatormap.api.IMediatorMap;
import robotlegs.bender.extensions.signalcommandmap.api.ISignalCommandMap;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.ILogger;
import robotlegs.bender.framework.api.LogLevel;

/**
 * ...
 * @author Andras Csizmadia
 */

class AppConfig implements IConfig
{       
    @inject
    public var mediatorMap:IMediatorMap;
    
    @inject
    public var eventCommandMap:IEventCommandMap; 
    
    @inject
    public var signalCommandMap:ISignalCommandMap; 
        
    @inject
    public var context:IContext; 
    
    @inject
    public var dispatcher:IEventDispatcher;
    
    @inject
    public var contextView:DisplayObjectContainer;
    
    @inject
    public var injector:Injector;
    
    @inject
    public var logger:ILogger;
            
    public function MainConfig()
    {    
    }
    
    public function configure():Void
    {    
        context.logLevel = LogLevel.DEBUG; 
        logger.debug("AppConfig::configure");
        
        //view mediator mapping
        mediatorMap.map(AppView).toMediator(AppMediator);
        
        //dependency injection
        injector.mapSingleton(AppService);
        injector.mapSingleton(AppModel);
        //injector.mapSingleton(TestSignal);
        
        //event and signal command mapping
        eventCommandMap.map(Event.INIT).toCommand(StartupCommand); // .once()
        //signalCommandMap.map(TestSignal).toCommand(SignalCommandTest);
                    
        // startup
        context.lifecycle
            .afterInitializing(init); 
    }
    
    function init(?params:Dynamic=null):Void
    {        
        logger.debug("AppConfig::init");
        
        // dispatch the event that is bound to the command
        dispatcher.dispatchEvent(new Event(Event.INIT));
    }
}