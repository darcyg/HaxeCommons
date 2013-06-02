package app.view;
import robotlegs.bender.bundles.mvcs.Mediator;
import robotlegs.bender.framework.api.ILogger;

/**
 * ...
 * @author Andras Csizmadia
 */

class AppMediator extends Mediator
{
    @inject
    public var logger:ILogger;
    
    @inject
    public var view:AppView;

    public function new() 
    {
        openfl.Lib.trace(this+"::"+"new");
        super();
    }
    
    override public function initialize():Void
    {
        logger.debug(this+"::"+"initialize", [view]);
    }
    
    override public function destroy():Void
    {
        logger.debug(this+"::"+"destroy", [view]);        
    }
    
}