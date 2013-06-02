package;   

import app.config.AppConfig;
import app.controller.StartupCommand;
import flash.display.Sprite; 
import flash.events.Event; 
import flash.Lib;
import flash.display.DisplayObjectContainer;
import flash.events.IEventDispatcher;
import minject.Injector;
import robotlegs.bender.framework.api.IConfig;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.ILogger;
import robotlegs.bender.framework.api.LogLevel;
import robotlegs.bender.framework.impl.Context;
import robotlegs.bender.bundles.mvcs.MVCSBundle;
import robotlegs.bender.extensions.signalcommandmap.SignalCommandMapExtension;

class Main extends Sprite 
{
  public var context:Context;
    
  public function new()  
  {
    openfl.Lib.trace(this+"new");
    super();
    
    Lib.current.addChild(this);
    
    context = new Context();
    context.logLevel = LogLevel.DEBUG; 
    context.extend([MVCSBundle, SignalCommandMapExtension]).configure([AppConfig, this]);
    
    // Destroy context test:
    // Lib.current.removeChild(this);

  } 
  
}

