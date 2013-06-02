//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.eventcommandmap.impl;

import flash.events.IEventDispatcher;
import minject.Injector;
import robotlegs.bender.extensions.commandcenter.api.ICommandMapping;
import robotlegs.bender.extensions.commandcenter.api.ICommandTrigger;
import robotlegs.bender.extensions.commandcenter.impl.CommandMappingList;

class EventCommandTrigger implements ICommandTrigger {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _mappings : Array<ICommandMapping>;
    var _mappingList : CommandMappingList;
    var _dispatcher : IEventDispatcher;
    var _type : String;
    var _executor : EventCommandExecutor;
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    public function new(injector : Injector, dispatcher : IEventDispatcher, type : String, eventClass : Class<Dynamic> = null) {
        _mappings = new Array<ICommandMapping>();
        _mappingList = new CommandMappingList();
        _dispatcher = dispatcher;
        _type = type;
        _executor = new EventCommandExecutor(this, _mappingList, injector, eventClass);
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function addMapping(mapping : ICommandMapping) : Void {
        verifyCommandClass(mapping);
        if(_mappingList.tail != null)  {
            _mappingList.tail.next = mapping;
        }

        else  {
            _mappingList.head = mapping;
            addListener();
        }

    }

    public function removeMapping(mapping : ICommandMapping) : Void {
        _mappingList.remove(mapping);
        if(_mappingList.head == null) 
            removeListener();
    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function verifyCommandClass(mapping : ICommandMapping) : Void {
    }

    function addListener() : Void {
        _dispatcher.addEventListener(_type, _executor.execute);
    }

    function removeListener() : Void {
        _dispatcher.removeEventListener(_type, _executor.execute);
    }

}

