//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager;

import minject.Injector;
import robotlegs.bender.extensions.viewmanager.api.IViewManager;
import robotlegs.bender.extensions.viewmanager.impl.ContainerRegistry;
import robotlegs.bender.extensions.viewmanager.impl.ViewManager;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.impl.UID;

class ViewManagerExtension implements IExtension {

    /*============================================================================*/    
    /* Private Static Properties                                                  */    
    /*============================================================================*/    
    // Really? Yes, there can be only one.
        static var _containerRegistry : ContainerRegistry;
    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _uid : String;
    var _injector : Injector;
    var _viewManager : IViewManager;
    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function extend(context : IContext) : Void {
        _injector = context.injector;
        // Just one Container Registry
        if (_containerRegistry == null)
        {
            _containerRegistry = new ContainerRegistry();
        }        
        _injector.mapValue(ContainerRegistry,_containerRegistry);
        // But you get your own View Manager
        _injector.mapSingletonOf(IViewManager,ViewManager);
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
        _viewManager = _injector.getInstance(IViewManager);
    }

    function whenDestroying(?params : Dynamic = null) : Void {
        _viewManager.removeAllHandlers();
        _injector.unmap(IViewManager);
        _injector.unmap(ContainerRegistry);
    }


    public function new() {
        _uid = UID.create(ViewManagerExtension);
    }
}

