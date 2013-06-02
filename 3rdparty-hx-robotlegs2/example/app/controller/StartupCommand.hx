package app.controller;
import app.model.AppModel;
import app.service.AppService;
import app.view.AppView;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import flash.events.IEventDispatcher;
import robotlegs.bender.framework.api.ILogger;

/**
 * ...
 * @author Andras Csizmadia
 */

class StartupCommand 
{    
    @inject
    public var model:AppModel;
    
    @inject
    public var event:Event;
    
    @inject
    public var service:AppService;
    
    @inject
    public var contextView:DisplayObjectContainer;
    
    @inject
    public var dispatcher:IEventDispatcher;
    
    @inject
    public var logger:ILogger;

    public function new() 
    {
    }
    
    public function execute() 
    {
        logger.debug("StartupCommand::execute", [model,service,contextView,dispatcher,event]);
        
        var view:AppView = new AppView();
        contextView.addChild(view);
        
        //Destroy view test
        //contextView.removeChild(view);
        //haxe.Timer.delay(function() { contextView.removeChild(view); }, 100);
    }
    
}