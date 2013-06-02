//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewprocessormap;

import minject.Injector;
import robotlegs.bender.extensions.viewprocessormap.impl.IViewProcessorFactory;
import robotlegs.bender.extensions.viewprocessormap.api.IViewProcessorMap;
import robotlegs.bender.extensions.viewprocessormap.impl.ViewProcessorFactory;
import robotlegs.bender.extensions.viewprocessormap.impl.ViewProcessorMap;
import robotlegs.bender.extensions.viewmanager.api.IViewHandler;
import robotlegs.bender.extensions.viewmanager.api.IViewManager;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.impl.UID;
import robotlegs.bender.extensions.viewprocessormap.impl.IViewProcessorFactory;

class ViewProcessorMapExtension implements IExtension {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _uid : String;
    var _injector : Injector;
    var _viewProcessorMap : IViewProcessorMap;
    var _viewManager : IViewManager;
    var _viewProcessorFactory : IViewProcessorFactory;
    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function extend(context : IContext) : Void {
        _injector = context.injector;
        _injector.map(IViewProcessorFactory).toSingleton(ViewProcessorFactory);
        _injector.map(IViewProcessorMap).toSingleton(ViewProcessorMap);
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
    function beforeInitializing() : Void {
        _viewProcessorMap = _injector.getInstance(IViewProcessorMap);
        _viewProcessorFactory = _injector.getInstance(IViewProcessorFactory);
        if(_injector.hasMapping(IViewManager))  {
            _viewManager = _injector.getInstance(IViewManager);
            _viewManager.addViewHandler(cast(_viewProcessorMap, IViewHandler));
        }
    }

    function beforeDestroying() : Void {
        _viewProcessorFactory.runAllUnprocessors();
        if(_injector.hasMapping(IViewManager))  {
            _viewManager = _injector.getInstance(IViewManager);
            _viewManager.removeViewHandler(cast(_viewProcessorMap, IViewHandler));
        }
    }

    function whenDestroying() : Void {
        if(_injector.hasMapping(IViewProcessorMap))  {
            _injector.unmap(IViewProcessorMap);
        }
        if(_injector.hasMapping(IViewProcessorFactory))  {
            _injector.unmap(IViewProcessorFactory);
        }
    }


    public function new() {
        _uid = UID.create(ViewProcessorMapExtension);
    }
}

