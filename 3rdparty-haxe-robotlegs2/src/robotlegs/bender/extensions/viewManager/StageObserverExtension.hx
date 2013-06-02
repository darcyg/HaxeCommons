//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager;

import minject.Injector;
import robotlegs.bender.extensions.viewmanager.impl.ContainerRegistry;
import robotlegs.bender.extensions.viewmanager.impl.StageObserver;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.impl.UID;

class StageObserverExtension implements IExtension {

    /*============================================================================*/    
    /* Private Static Properties                                                  */    
    /*============================================================================*/    
    // Really? Yes, there can be only one.
        static var _stageObserver : StageObserver;
    static var _installCount : Int;
    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _uid : String;
    var _injector : Injector;
    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function extend(context : IContext) : Void {
        _installCount++;
        _injector = context.injector;
        context.lifecycle.whenInitializing(whenInitializing);
        context.lifecycle.whenDestroying(whenDestroying);
    }

    public function toString() : String {
        return _uid;
    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function whenInitializing(?params : Dynamic = null) : Void {
        if(_stageObserver == null)  {
            var containerRegistry : ContainerRegistry = _injector.getInstance(ContainerRegistry);
            _stageObserver = new StageObserver(containerRegistry);
        }
    }

    function whenDestroying(?params : Dynamic = null) : Void {
        _installCount--;
        if(_installCount == 0)  {
            _stageObserver.destroy();
            _stageObserver = null;
        }
    }


    public function new() {
        _uid = UID.create(StageObserverExtension);
    }
}

