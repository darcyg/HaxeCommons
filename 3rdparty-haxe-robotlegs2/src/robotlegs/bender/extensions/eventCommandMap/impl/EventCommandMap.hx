//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.eventcommandmap.impl;

import flash.events.IEventDispatcher;
//import openfl.ObjectHash;
import openfl.ObjectHash;
import minject.Injector;
import robotlegs.bender.extensions.commandcenter.api.ICommandCenter;
import robotlegs.bender.extensions.commandcenter.api.ICommandTrigger;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandUnmapper;
import robotlegs.bender.extensions.eventcommandmap.api.IEventCommandMap;

class EventCommandMap implements IEventCommandMap {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _triggers : ObjectHash<Dynamic,ICommandTrigger>;
    
    var _injector : Injector;
    
    var _dispatcher : IEventDispatcher;
    
    var _commandCenter : ICommandCenter;
    
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    @inject
    public function new(injector : Injector, dispatcher : IEventDispatcher, commandCenter : ICommandCenter) {
        _triggers = new ObjectHash();
        _injector = injector;
        _dispatcher = dispatcher;
        _commandCenter = commandCenter;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function map(type : String, eventClass : Class<Dynamic> = null) : ICommandMapper {
        //nme.Lib.trace(this + "::" + "map:" + _injector + "," + _dispatcher + "," + _commandCenter);
        var trigger : ICommandTrigger;
        if (_triggers.exists(type + eventClass))
        {
            trigger= _triggers.get(type + eventClass);
        }else {
            trigger = createTrigger(type, eventClass);
            _triggers.set(type + eventClass, trigger);
        }
        return _commandCenter.map(trigger);
    }

    public function unmap(type : String, eventClass : Class<Dynamic> = null) : ICommandUnmapper {
        return _commandCenter.unmap(getTrigger(type, eventClass));
    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function createTrigger(type : String, eventClass : Class<Dynamic> = null) : ICommandTrigger {
        return new EventCommandTrigger(_injector, _dispatcher, type, eventClass);
    }

    function getTrigger(type : String, eventClass : Class<Dynamic> = null) : ICommandTrigger {
        return _triggers.get(type + eventClass);
    }

}

