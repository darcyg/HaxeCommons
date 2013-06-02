package app;
import flash.events.Event;
import flash.events.IEventDispatcher;

/**
 * ...
 * @author Andras Csizmadia
 */

class BaseActor 
{
    @inject
    public var eventDispatcher:IEventDispatcher;

    public function new() 
    {
        
    }
        
    public function dispatch(event:Event):Void
    {
        if (eventDispatcher.hasEventListener(event.type))
            eventDispatcher.dispatchEvent(event);
    }
    
}
