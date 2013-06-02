//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.eventcommandmap;

import robotlegs.bender.extensions.eventcommandmap.api.IEventCommandMap;
import robotlegs.bender.extensions.eventcommandmap.impl.EventCommandMap;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.impl.UID;

class EventCommandMapExtension implements IExtension {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _uid : String;
    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function extend(context : IContext) : Void {
        context.injector.mapSingletonOf(IEventCommandMap,EventCommandMap);
    }

    public function toString() : String {
        return _uid;
    }


    public function new() {
        _uid = UID.create(EventCommandMapExtension);
    }
}

