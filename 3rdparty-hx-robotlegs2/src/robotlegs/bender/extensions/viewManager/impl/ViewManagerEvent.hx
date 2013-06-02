//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager.impl;

import flash.display.DisplayObjectContainer;
import flash.events.Event;
import robotlegs.bender.extensions.viewmanager.api.IViewHandler;

class ViewManagerEvent extends Event {
    public var container(getContainer, never) : DisplayObjectContainer;
    public var handler(getHandler, never) : IViewHandler;

    /*============================================================================*/    
    /* Public Static Properties                                                   */    
    /*============================================================================*/    
    static public inline var CONTAINER_ADD : String = "containerAdd";
    static public inline var CONTAINER_REMOVE : String = "containerRemove";
    static public inline var HANDLER_ADD : String = "handlerAdd";
    static public inline var HANDLER_REMOVE : String = "handlerRemove";
    /*============================================================================*/    
    /* Public Properties                                                          */    
    /*============================================================================*/    
    var _container : DisplayObjectContainer;
    public function getContainer() : DisplayObjectContainer {
        return _container;
    }

    var _handler : IViewHandler;
    public function getHandler() : IViewHandler {
        return _handler;
    }

    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    public function new(type : String, container : DisplayObjectContainer = null, handler : IViewHandler = null) {
        super(type);
        //nme.Lib.trace("ViewManagerEvent::" + type);
        _container = container;
        _handler = handler;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    override public function clone() : Event {
        return new ViewManagerEvent(type, _container, _handler);
    }

}

