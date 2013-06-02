//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.localeventmap;

import robotlegs.bender.extensions.localeventmap.api.IEventMap;
import robotlegs.bender.extensions.localeventmap.impl.EventMap;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.impl.UID;

/**

 * This extension creates local EventMaps on request

 */class LocalEventMapExtension implements IExtension {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _uid : String;
    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function extend(context : IContext) : Void {
        context.injector.mapSingletonOf(IEventMap,EventMap);
    }

    public function toString() : String {
        return _uid;
    }


    public function new() {
        _uid = UID.create(LocalEventMapExtension);
    }
}

