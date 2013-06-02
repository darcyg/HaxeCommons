//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.commandcenter;

import robotlegs.bender.extensions.commandcenter.api.ICommandCenter;
import robotlegs.bender.extensions.commandcenter.impl.CommandCenter;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.impl.UID;

class CommandCenterExtension implements IExtension {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _uid : String;
    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function extend(context : IContext) : Void {
        context.injector.mapSingletonOf(ICommandCenter,CommandCenter);
    }

    public function toString() : String {
        return _uid;
    }


    public function new() {
        _uid = UID.create(CommandCenterExtension);
    }
}

