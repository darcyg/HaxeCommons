//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.signalcommandmap.impl;

import openfl.ObjectHash;
import msignal.Signal;
import minject.Injector;
import robotlegs.bender.extensions.commandcenter.api.ICommandCenter;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandUnmapper;
import robotlegs.bender.extensions.commandcenter.api.ICommandTrigger;
import robotlegs.bender.extensions.signalcommandmap.api.ISignalCommandMap;

class SignalCommandMap implements ISignalCommandMap {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _signalTriggers : ObjectHash<Dynamic,Dynamic>;
    var _injector : Injector;
    var _commandMap : ICommandCenter;
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    @inject
    public function new(injector : Injector, commandMap : ICommandCenter) {
        _signalTriggers = new ObjectHash();
        _injector = injector;
        _commandMap = commandMap;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function map(signalClass : Class<Dynamic>, once : Bool = false) : ICommandMapper {
        var trigger : ICommandTrigger;
        if (_signalTriggers.exists(signalClass))
        {
            trigger = _signalTriggers.get(signalClass);
        } else {
            trigger = createSignalTrigger(signalClass, once);
            _signalTriggers.set(signalClass,trigger);
        }
        return _commandMap.map(trigger);
    }

    public function unmap(signalClass : Class<Dynamic>) : ICommandUnmapper {
        return _commandMap.unmap(getSignalTrigger(signalClass));
    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function createSignalTrigger(signalClass : Class<Dynamic>, once : Bool = false) : ICommandTrigger {
        return new SignalCommandTrigger(_injector, signalClass, once);
    }

    function getSignalTrigger(signalClass : Class<Dynamic>) : ICommandTrigger {
        return _signalTriggers.get(signalClass);
    }

}

