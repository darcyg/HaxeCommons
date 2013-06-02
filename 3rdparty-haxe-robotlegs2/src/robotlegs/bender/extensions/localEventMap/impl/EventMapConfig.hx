//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.localeventmap.impl;

import flash.events.IEventDispatcher;

class EventMapConfig {
    public var dispatcher(getDispatcher, never) : IEventDispatcher;
    public var eventString(getEventString, never) : String;
    public var listener(getListener, never) : Dynamic->Void;
    public var eventClass(getEventClass, never) : Class<Dynamic>;
    public var callBack(getCallback, never) : Dynamic->Void;
    public var useCapture(getUseCapture, never) : Bool;

    /*============================================================================*/    /* Public Properties                                                          */    /*============================================================================*/    var _dispatcher : IEventDispatcher;
    public function getDispatcher() : IEventDispatcher {
        return _dispatcher;
    }

    var _eventString : String;
    public function getEventString() : String {
        return _eventString;
    }

    var _listener : Dynamic->Void;
    public function getListener() : Dynamic->Void {
        return _listener;
    }

    var _eventClass : Class<Dynamic>;
    public function getEventClass() : Class<Dynamic> {
        return _eventClass;
    }

    var _callback : Dynamic->Void;
    public function getCallback() : Dynamic->Void {
        return _callback;
    }

    var _useCapture : Bool;
    public function getUseCapture() : Bool {
        return _useCapture;
    }

    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    public function new(dispatcher : IEventDispatcher, eventString : String, listener : Dynamic->Void, eventClass : Class<Dynamic>, callBack : Dynamic->Void, useCapture : Bool) {
        _dispatcher = dispatcher;
        _eventString = eventString;
        _listener = listener;
        _eventClass = eventClass;
        _callback = callBack;
        _useCapture = useCapture;
    }

}

