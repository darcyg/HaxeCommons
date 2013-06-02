//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.scopedeventdispatcher;

import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import minject.Injector;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.impl.UID;

/**

 * This extensions maps a series of named IEventDispatcher instances

 * provided those names have not been mapped by a parent context.

 */class ScopedEventDispatcherExtension implements IExtension {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _uid : String;
    var _names : Array<String>;
    var _injector : Injector;
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    public function new(names:Array<String>) {
        _uid = UID.create(ScopedEventDispatcherExtension);
        _names = ((names.length > 0)) ? names : ["global"];
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function extend(context : IContext) : Void {
        _injector = context.injector;
        context.lifecycle.whenInitializing(whenInitializing);
    }

    public function toString() : String {
        return _uid;
    }

    /*============================================================================*/    /* Private Functions                                                          */    /*============================================================================*/    function whenInitializing() : Void {
        for(name in _names/* AS3HX WARNING could not determine type for var: name exp: EIdent(_names) type: Array<Dynamic>*/) {
            if(!_injector.satisfies(IEventDispatcher, name))  {
                _injector.map(IEventDispatcher, name).toValue(new EventDispatcher());
            }
        }

    }

}

