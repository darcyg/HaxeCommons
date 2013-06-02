//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager.impl;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.Event;

class StageObserver {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _filter : EReg;
    var _registry : ContainerRegistry;
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    public function new(containerRegistry : ContainerRegistry) {
        _filter = new EReg('^mx\\.|^spark\\.|^flash\\.', "");
        _registry = containerRegistry;
        // We only care about roots
        _registry.addEventListener(ContainerRegistryEvent.ROOT_CONTAINER_ADD, onRootContainerAdd);
        _registry.addEventListener(ContainerRegistryEvent.ROOT_CONTAINER_REMOVE, onRootContainerRemove);
        // We might have arrived late on the scene
        for(binding in _registry.rootBindings) {
            addRootListener(binding.container);
        }
;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function destroy() : Void {
        _registry.removeEventListener(ContainerRegistryEvent.ROOT_CONTAINER_ADD, onRootContainerAdd);
        _registry.removeEventListener(ContainerRegistryEvent.ROOT_CONTAINER_REMOVE, onRootContainerRemove);
        for(binding in _registry.rootBindings) {
            removeRootListener(binding.container);
        }

    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function onRootContainerAdd(event : ContainerRegistryEvent) : Void {
        addRootListener(event.container);
    }

    function onRootContainerRemove(event : ContainerRegistryEvent) : Void {
        removeRootListener(event.container);
    }

    function addRootListener(container : DisplayObjectContainer) : Void {
        // The magical, but extremely expensive, capture-phase ADDED_TO_STAGE listener
        container.addEventListener(Event.ADDED_TO_STAGE, onViewAddedToStage, true);
        // Watch the root container itself - nobody else is going to pick it up!
        container.addEventListener(Event.ADDED_TO_STAGE, onContainerRootAddedToStage);
    }

    function removeRootListener(container : DisplayObjectContainer) : Void {
        container.removeEventListener(Event.ADDED_TO_STAGE, onViewAddedToStage, true);
        container.removeEventListener(Event.ADDED_TO_STAGE, onContainerRootAddedToStage);
    }

    function onViewAddedToStage(event : Event) : Void {
        //nme.Lib.trace("StageObserver::onViewAddedToStage"+event);
        var view : DisplayObject = cast(event.target, DisplayObject);
        // Question: would it be worth caching QCNs by view in a weak dictionary,
        // to avoid getQualifiedClassName() cost?
        var qcn : String = Type.getClassName(Type.getClass(view));
        var filtered : Bool = _filter.match(qcn);
        if(filtered) 
            return;
        var type : Class<Dynamic> = Reflect.field(view, "constructor");
        // Walk upwards from the nearest binding
        var binding : ContainerBinding = _registry.findParentBinding(view);
        while(binding != null) {
            binding.handleView(view, type);
            binding = binding.parent;
        }

    }

    function onContainerRootAddedToStage(event : Event) : Void {
        //nme.Lib.trace("StageObserver::onContainerRootAddedToStage"+event);
        var container : DisplayObjectContainer = cast(event.target, DisplayObjectContainer);
        container.removeEventListener(Event.ADDED_TO_STAGE, onContainerRootAddedToStage);
        var type : Class<Dynamic> = Reflect.field(container, "constructor");
        var binding : ContainerBinding = _registry.getBinding(container);
        binding.handleView(container, type);
    }

}

