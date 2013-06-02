//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.modularity.impl;

import flash.display.DisplayObjectContainer;
import minject.Injector;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.ILogger;
import robotlegs.bender.framework.impl.UID;

class ContextViewBasedExistenceWatcher {

    /*============================================================================*/    /* Private Properties                                                         */    /*============================================================================*/    var _uid : String;
    var _logger : ILogger;
    var _injector : Injector;
    var _contextView : DisplayObjectContainer;
    var _childContext : IContext;
    /*============================================================================*/    /* Constructor                                                                */    /*============================================================================*/    public function new(context : IContext, contextView : DisplayObjectContainer) {
        _uid = UID.create(ContextViewBasedExistenceWatcher);
        _logger = context.getLogger(this);
        _injector = context.injector;
        _contextView = contextView;
        context.lifecycle.whenDestroying(destroy);
        init();
    }

    /*============================================================================*/    /* Public Functions                                                           */    /*============================================================================*/    public function toString() : String {
        return _uid;
    }

    /*============================================================================*/    /* Private Functions                                                          */    /*============================================================================*/    function init() : Void {
        _logger.debug("Listening for context existence events on contextView {0}", [_contextView]);
        _contextView.addEventListener(ModularContextEvent.CONTEXT_ADD, onContextAdd);
    }

    function destroy(?params : Dynamic = null) : Void {
        _logger.debug("Removing modular context existence event listener from contextView {0}", [_contextView]);
        _contextView.removeEventListener(ModularContextEvent.CONTEXT_ADD, onContextAdd);
        if(_childContext != null)  {
            _logger.debug("Unlinking parent injector for child context {0}", [_childContext]);
            _childContext.injector.parentInjector = null;
        }
    }

    function onContextAdd(event : ModularContextEvent) : Void {
        event.stopImmediatePropagation();
        _childContext = event.context;
        _logger.debug("Context existence event caught. Configuring child context {0}", [_childContext]);
        _childContext.injector.parentInjector = _injector;
    }

}

