//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap;

import minject.Injector;
import robotlegs.bender.extensions.mediatormap.api.IMediatorFactory;
import robotlegs.bender.extensions.mediatormap.api.IMediatorMap;
import robotlegs.bender.extensions.mediatormap.impl.DefaultMediatorManager;
import robotlegs.bender.extensions.mediatormap.impl.MediatorFactory;
import robotlegs.bender.extensions.mediatormap.impl.MediatorMap;
import robotlegs.bender.extensions.viewmanager.api.IViewHandler;
import robotlegs.bender.extensions.viewmanager.api.IViewManager;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.impl.UID;

class MediatorMapExtension implements IExtension {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _uid : String;
    var _injector : Injector;
    var _mediatorMap : IMediatorMap;
    var _viewManager : IViewManager;
    var _mediatorManager : DefaultMediatorManager;
    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function extend(context : IContext) : Void {
        _injector = context.injector;
        _injector.mapSingletonOf(IMediatorFactory,MediatorFactory);
        _injector.mapSingletonOf(IMediatorMap,MediatorMap);
        context.lifecycle.beforeInitializing(beforeInitializing);
        context.lifecycle.beforeDestroying(beforeDestroying);
        context.lifecycle.whenDestroying(whenDestroying);
    }

    public function toString() : String {
        return _uid;
    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function beforeInitializing(?params : Dynamic = null) : Void {
        _mediatorMap = _injector.getInstance(IMediatorMap);
        _mediatorManager = _injector.instantiate(DefaultMediatorManager);
        
        if(_injector.hasMapping(IViewManager))  {
            _viewManager = _injector.getInstance(IViewManager);
            _viewManager.addViewHandler(cast(_mediatorMap, IViewHandler));
        }
    }

    function beforeDestroying(?params : Dynamic = null) : Void {
        var mediatorFactory : IMediatorFactory = _injector.getInstance(IMediatorFactory);
        mediatorFactory.removeAllMediators();
        if(_injector.hasMapping(IViewManager))  {
            _viewManager = _injector.getInstance(IViewManager);
            _viewManager.removeViewHandler(cast(_mediatorMap, IViewHandler));
        }
    }

    function whenDestroying(?params : Dynamic = null) : Void {
        if(_injector.hasMapping(IMediatorMap))  {
            _injector.unmap(IMediatorMap);
        }
        if(_injector.hasMapping(IMediatorFactory))  {
            _injector.unmap(IMediatorFactory);
        }
    }


    public function new() {
        _uid = UID.create(MediatorMapExtension);
    }
}

