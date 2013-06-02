package app.controller;
import app.model.AppModel;
import msignal.Signal;
import app.service.AppService;
import flash.display.DisplayObjectContainer;
import flash.events.Event;
import robotlegs.bender.framework.api.ILogger;

/**
 * ...
 * @author Andras Csizmadia
 */

class SignalCommandTest 
{
    @inject
    public var model:AppModel;
    
    @inject
    public var signal:AnySignal;
    
    @inject
    public var service:AppService;
    
    @inject
    public var contextView:DisplayObjectContainer;
        
    @inject
    public var logger:ILogger;

    public function new() 
    {
    }
    
    public function execute() 
    {
        logger.debug("SignalCommandTest::execute", [model,service,contextView,signal]);        
    }
    
}