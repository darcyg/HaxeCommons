//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.modularity.impl;

import flash.display.DisplayObjectContainer;
import minject.Injector;
import robotlegs.bender.extensions.viewmanager.api.IViewManager;
import robotlegs.bender.extensions.viewmanager.impl.ViewManagerEvent;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.ILogger;
import robotlegs.bender.framework.impl.UID;

class ViewManagerBasedExistenceWatcher {

    /*============================================================================*/    /* Private Properties                                                         */    /*============================================================================*/    var _uid : String;
    var _logger : ILogger;
    var _injector : Injector;
    var _viewManager : IViewManager;
    var _childContext : IContext;
    /*============================================================================*/    /* Constructor                                                                */    /*============================================================================*/    public function new(context : IContext, viewManager : IViewManager) {
        _uid = UID.create(ViewManagerBasedExistenceWatcher);
        _logger = context.getLogger(this);
        _injector = context.injector;
        _viewManager = viewManager;
        context.lifecycle.whenDestroying(destroy);
        init();
    }

    /*============================================================================*/    /* Public Functions                                                           */    /*============================================================================*/    public function toString() : String {
        return _uid;
    }

    /*============================================================================*/    /* Private Functions                                                          */    /*============================================================================*/    function init() : Void {
        for(container in _viewManager.containers/* AS3HX WARNING could not determine type for var: container exp: EField(EIdent(_viewManager),containers) type: null*/) {
            _logger.debug("Adding context existence event listener to container {0}", [container]);
            container.addEventListener(ModularContextEvent.CONTEXT_ADD, onContextAdd);
        }

        _viewManager.addEventListener(ViewManagerEvent.CONTAINER_ADD, onContainerAdd);
        _viewManager.addEventListener(ViewManagerEvent.CONTAINER_REMOVE, onContainerRemove);
    }

    function destroy(?params : Dynamic = null) : Void 
    {
        for(container in _viewManager.containers/* AS3HX WARNING could not determine type for var: container exp: EField(EIdent(_viewManager),containers) type: null*/) {
            _logger.debug("Removing context existence event listener from container {0}", [container]);
            container.removeEventListener(ModularContextEvent.CONTEXT_ADD, onContextAdd);
        }

        _viewManager.removeEventListener(ViewManagerEvent.CONTAINER_ADD, onContainerAdd);
        _viewManager.removeEventListener(ViewManagerEvent.CONTAINER_REMOVE, onContainerRemove);
        if(_childContext != null)  {
            _logger.debug("Unlinking parent injector for child context {0}", [_childContext]);
            _childContext.injector.parentInjector = null;
        }
    }

    function onContainerAdd(event : ViewManagerEvent) : Void {
        _logger.debug("Adding context existence event listener to container {0}", [event.container]);
        event.container.addEventListener(ModularContextEvent.CONTEXT_ADD, onContextAdd);
    }

    function onContainerRemove(event : ViewManagerEvent) : Void {
        _logger.debug("Removing context existence event listener from container {0}", [event.container]);
        event.container.removeEventListener(ModularContextEvent.CONTEXT_ADD, onContextAdd);
    }

    function onContextAdd(event : ModularContextEvent) : Void {
        event.stopImmediatePropagation();
        _childContext = event.context;
        _logger.debug("Context existence event caught. Configuring child context {0}", [_childContext]);
        _childContext.injector.parentInjector = _injector;
    }

}

