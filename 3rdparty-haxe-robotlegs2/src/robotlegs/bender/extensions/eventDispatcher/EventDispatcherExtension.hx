//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.eventdispatcher;

import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.impl.UID;

/**

 * This extension maps an IEventDispatcher into a context's injector.

 */class EventDispatcherExtension implements IExtension {

    /*============================================================================*/    /* Private Properties                                                         */    /*============================================================================*/    var _uid : String;
    var _eventDispatcher : IEventDispatcher;
    /*============================================================================*/    /* Constructor                                                                */    /*============================================================================*/    public function new(eventDispatcher : IEventDispatcher = null) {
        _uid = UID.create(EventDispatcherExtension);
        if (eventDispatcher == null)
        {
            eventDispatcher = new EventDispatcher();
        }
        _eventDispatcher = eventDispatcher;
    }

    /*============================================================================*/    /* Public Functions                                                           */    /*============================================================================*/    public function extend(context : IContext) : Void {
        context.injector.mapValue(IEventDispatcher,_eventDispatcher);
    }

    public function toString() : String {
        return _uid;
    }

}

