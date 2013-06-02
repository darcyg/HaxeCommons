//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.logging;

import robotlegs.bender.extensions.logging.impl.TraceLogTarget;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.impl.UID;

class TraceLoggingExtension implements IExtension {

    /*============================================================================*/    /* Private Properties                                                         */    /*============================================================================*/    var _uid : String;
    /*============================================================================*/    /* Public Functions                                                           */    /*============================================================================*/    public function extend(context : IContext) : Void {
        context.addLogTarget(new TraceLogTarget(context));
    }

    public function toString() : String {
        return _uid;
    }


    public function new() {
        _uid = UID.create(TraceLoggingExtension);
    }
}

