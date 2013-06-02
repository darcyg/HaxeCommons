//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.eventcommandmap.impl;

import minject.Injector;
import robotlegs.bender.framework.impl.InlineUtils;
import robotlegs.bender.extensions.commandcenter.api.ICommandMapping;

class EventCommandFactory {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _injector : Injector;
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    @inject
    public function new(injector : Injector) {
        _injector = injector;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function create(mapping : ICommandMapping) : Dynamic {
        if(InlineUtils.guardsApprove(mapping.guards, _injector))  {
            var commandClass : Class<Dynamic> = mapping.commandClass;
            _injector.mapSingleton(commandClass);
            var command : Dynamic = _injector.getInstance(commandClass);
            InlineUtils.applyHooks(mapping.hooks, _injector);
            _injector.unmap(commandClass);
            return command;
        }
        return null;
    }

}

