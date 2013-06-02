//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.eventcommandmap.impl;

import flash.events.Event;
import minject.Injector;
import robotlegs.bender.extensions.commandcenter.api.ICommandMapping;
import robotlegs.bender.extensions.commandcenter.api.ICommandTrigger;
import robotlegs.bender.extensions.commandcenter.impl.CommandMapping;
import robotlegs.bender.extensions.commandcenter.impl.CommandMappingList;

class EventCommandExecutor {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _trigger : ICommandTrigger;
    var _mappings : Array<ICommandMapping>;
    var _mappingList : CommandMappingList;
    var _injector : Injector;
    var _eventClass : Class<Dynamic>;
    var _factory : EventCommandFactory;
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    public function new(trigger : ICommandTrigger, mappingList : CommandMappingList, injector : Injector, eventClass : Class<Dynamic>) {
        _trigger = trigger;
        _mappingList = mappingList;
        _injector = injector.createChildInjector();
        _eventClass = eventClass;
        _factory = new EventCommandFactory(_injector);
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function execute(event : Event) : Void {
        var eventConstructor : Class<Dynamic> = Type.getClass(Reflect.field(event, "constructor"));
        if(isTriggerEvent(eventConstructor))  {
            runCommands(event, eventConstructor);
        }
    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function isTriggerEvent(eventConstructor : Class<Dynamic>) : Bool {
        return _eventClass == null || eventConstructor == _eventClass;
    }

    function isStronglyTyped(eventConstructor : Class<Dynamic>) : Bool {
        return eventConstructor != Event;
    }

    function mapEventForInjection(event : Event, eventConstructor : Class<Dynamic>) : Void {
        _injector.mapValue(Event,event);
        if (isStronglyTyped(eventConstructor)) 
        {
            if (_eventClass != null)
            {
                _injector.mapValue(_eventClass,event);
            }else {
                _injector.mapValue(eventConstructor,event);
            }            
        }
    }

    function unmapEventAfterInjection(eventConstructor : Class<Dynamic>) : Void {
        _injector.unmap(Event);
        if (isStronglyTyped(eventConstructor)) 
        {
             if (_eventClass != null)
            {
                _injector.unmap(_eventClass);
            }else {
                _injector.unmap(eventConstructor);
            }
        }
    }

    function runCommands(event : Event, eventConstructor : Class<Dynamic>) : Void {
        var command : Dynamic;
        var mapping : ICommandMapping = _mappingList.head;
        while(mapping != null) {
            mapping.validate();
            mapEventForInjection(event, eventConstructor);
            command = _factory.create(mapping);
            unmapEventAfterInjection(eventConstructor);
            if(command)  {
                removeFireOnceMapping(mapping);
                command.execute();
            }
            mapping = mapping.next;
        }
    }

    function removeFireOnceMapping(mapping : ICommandMapping) : Void {
        if(mapping.fireOnce) 
            _trigger.removeMapping(mapping);
    }

}

