//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager.impl;

import flash.display.DisplayObjectContainer;
import flash.events.EventDispatcher;
import robotlegs.bender.extensions.viewmanager.api.IViewHandler;
import robotlegs.bender.extensions.viewmanager.api.IViewManager;
import robotlegs.bender.framework.api.ILogger;

/*@:meta(Event(name="containerAdd",type="robotlegs.bender.extensions.viewManager.impl.ViewManagerEvent"))
@:meta(Event(name="containerRemove",type="robotlegs.bender.extensions.viewManager.impl.ViewManagerEvent"))
@:meta(Event(name="handlerAdd",type="robotlegs.bender.extensions.viewManager.impl.ViewManagerEvent"))
@:meta(Event(name="handlerRemove",type="robotlegs.bender.extensions.viewManager.impl.ViewManagerEvent"))*/
class ViewManager extends EventDispatcher implements IViewManager {
    public var containers(getContainers, never) : Array<DisplayObjectContainer>;

    /*============================================================================*/    
    /* Public Properties                                                          */    
    /*============================================================================*/    
    var _containers : Array<DisplayObjectContainer>;
    public function getContainers() : Array<DisplayObjectContainer> {
        return _containers;
    }

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _handlers : Array<IViewHandler>;
    
    var _registry : ContainerRegistry;
    
    @inject
    public var logging : ILogger;
    
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    @inject
    public function new(containerRegistry : ContainerRegistry) 
    {
        super();
        _containers = new Array<DisplayObjectContainer>();
        _handlers = new Array<IViewHandler>();
        _registry = containerRegistry;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function addContainer(container : DisplayObjectContainer) : Void {
        logging.debug("ViewManager::addContainer", [container]);
        if(!validContainer(container)) 
            return;
        _containers.push(container);
        for(handler in _handlers) {
            _registry.addContainer(container).addHandler(handler);
        }

        dispatchEvent(new ViewManagerEvent(ViewManagerEvent.CONTAINER_ADD, container));
    }

    public function removeContainer(container : DisplayObjectContainer) : Void {
        logging.debug("ViewManager::removeContainer", [container]);
        var index : Int = Lambda.indexOf(_containers,container);
        if(index == -1) 
            return;
        _containers.splice(index, 1);
        var binding : ContainerBinding = _registry.getBinding(container);
        for(handler in _handlers) {
            binding.removeHandler(handler);
        }

        dispatchEvent(new ViewManagerEvent(ViewManagerEvent.CONTAINER_REMOVE, container));
    }

    public function addViewHandler(handler : IViewHandler) : Void {
        logging.debug("ViewManager::addViewHandler", [handler]);
        if(Lambda.indexOf(_handlers,handler) != -1) 
            return;
        _handlers.push(handler);
        for(container in _containers) {
            _registry.addContainer(container).addHandler(handler);
        }

        dispatchEvent(new ViewManagerEvent(ViewManagerEvent.HANDLER_ADD, null, handler));
    }

    public function removeViewHandler(handler : IViewHandler) : Void {
        logging.debug("ViewManager::removeViewHandler", [handler]);
        var index : Int = Lambda.indexOf(_handlers,handler);
        if(index == -1) 
            return;
        _handlers.splice(index, 1);
        for(container in _containers) {
            _registry.getBinding(container).removeHandler(handler);
        }

        dispatchEvent(new ViewManagerEvent(ViewManagerEvent.HANDLER_REMOVE, null, handler));
    }

    public function removeAllHandlers() : Void {
        for(container in _containers) {
            var binding : ContainerBinding = _registry.getBinding(container);
            for(handler in _handlers) {
                binding.removeHandler(handler);
            }

        }

    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function validContainer(container : DisplayObjectContainer) : Bool {
        for(registeredContainer in _containers) {
            if(container == registeredContainer) 
                return false;
            if (registeredContainer.contains(container) || container.contains(registeredContainer)) 
            {                
                //TODO: throw new Error("Containers can not be nested");
            }
        }

        return true;
    }

}

