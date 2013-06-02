//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.signalcommandmap;

import robotlegs.bender.extensions.signalcommandmap.api.ISignalCommandMap;
import robotlegs.bender.extensions.signalcommandmap.impl.SignalCommandMap;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.impl.UID;

class SignalCommandMapExtension implements IExtension {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _uid : String;
    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function extend(context : IContext) : Void {
        context.injector.mapSingletonOf(ISignalCommandMap,SignalCommandMap);
    }

    public function toString() : String {
        return _uid;
    }


    public function new() {
        _uid = UID.create(SignalCommandMapExtension);
    }
}

