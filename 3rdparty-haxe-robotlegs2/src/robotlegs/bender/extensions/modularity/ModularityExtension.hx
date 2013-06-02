//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.modularity;

import flash.display.DisplayObjectContainer;
import minject.Injector;
import robotlegs.bender.extensions.modularity.impl.ContextViewBasedExistenceWatcher;
import robotlegs.bender.extensions.modularity.impl.ModularContextEvent;
import robotlegs.bender.extensions.modularity.impl.ViewManagerBasedExistenceWatcher;
import robotlegs.bender.extensions.viewmanager.api.IViewManager;
import robotlegs.bender.framework.api.IContext;
import robotlegs.bender.framework.api.IExtension;
import robotlegs.bender.framework.api.ILogger;
import robotlegs.bender.framework.impl.UID;

/**

 * This extension allows a context to inherit dependencies from a parent context,

 * and/or expose its dependencies to child contexts.

 *

 * <p>It must be installed before context initialization.</p>

 */class ModularityExtension implements IExtension {

    /*============================================================================*/    /* Private Properties                                                         */    /*============================================================================*/    var _uid : String;
    var _context : IContext;
    var _injector : Injector;
    var _logger : ILogger;
    var _inherit : Bool;
    var _expose : Bool;
    /*============================================================================*/    /* Constructor                                                                */    /*============================================================================*/    /**

     * Modularity

     *

     * @param inherit Should this context inherit dependencies?

     * @param expose Should this context expose its dependencies?

     */    public function new(inherit : Bool = true, expose : Bool = true) {
        _uid = UID.create(ModularityExtension);
        _inherit = inherit;
        _expose = expose;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function extend(context : IContext) : Void {
        _context = context;
        _injector = context.injector;
        _logger = context.getLogger(this);
        _context.lifecycle.beforeInitializing(beforeInitializing);
    }

    public function toString() : String {
        return _uid;
    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function beforeInitializing(?params : Dynamic = null) : Void {
        _inherit && broadcastContextExistence() != null ;
        _expose && createContextWatcher() != null ;
    }

    function broadcastContextExistence() : Void {
        if(_injector.hasMapping(DisplayObjectContainer))  {
            _logger.debug("Context configured to inherit. Broadcasting existence event...");
            var contextView : DisplayObjectContainer = _injector.getInstance(DisplayObjectContainer);
            contextView.dispatchEvent(new ModularContextEvent(ModularContextEvent.CONTEXT_ADD, _context));
        }

        else  {
            _logger.warn("Context has been configured to inherit dependencies but has no way to do so");
        }

    }

    function createContextWatcher() : Void {
        if(_injector.hasMapping(IViewManager))  {
            _logger.debug("Context has a ViewManager. Configuring view manager based context existence watcher...");
            var viewManager : IViewManager = _injector.getInstance(IViewManager);
            new ViewManagerBasedExistenceWatcher(_context, viewManager);
        }

        else if(_injector.hasMapping(DisplayObjectContainer))  {
            _logger.debug("Context has a ContextView. Configuring context view based context existence watcher...");
            var contextView : DisplayObjectContainer = _injector.getInstance(DisplayObjectContainer);
            new ContextViewBasedExistenceWatcher(_context, contextView);
        }

        else  {
            _logger.warn("Context has been configured to expose its dependencies but has no way to do so");
        }

    }

}

