//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager.impl;

import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.events.EventDispatcher;
import openfl.ObjectHash;

@:meta(Event(name="containerAdd",type="robotlegs.bender.extensions.viewManager.impl.ContainerRegistryEvent"))
@:meta(Event(name="containerRemove",type="robotlegs.bender.extensions.viewManager.impl.ContainerRegistryEvent"))
@:meta(Event(name="rootContainerAdd",type="robotlegs.bender.extensions.viewManager.impl.ContainerRegistryEvent"))
@:meta(Event(name="rootContainerRemove",type="robotlegs.bender.extensions.viewManager.impl.ContainerRegistryEvent"))
class ContainerRegistry extends EventDispatcher {
    public var bindings(getBindings, never) : Array<ContainerBinding>;
    public var rootBindings(getRootBindings, never) : Array<ContainerBinding>;

    /*============================================================================*/    
    /* Public Properties                                                          */    
    /*============================================================================*/    
    var _bindings : Array<ContainerBinding>;
    public function getBindings() : Array<ContainerBinding> {
        return _bindings;
    }

    var _rootBindings : Array<ContainerBinding>;
    public function getRootBindings() : Array<ContainerBinding> {
        return _rootBindings;
    }

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _bindingByContainer : ObjectHash<DisplayObjectContainer,ContainerBinding>;
    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function addContainer(container : DisplayObjectContainer) : ContainerBinding {
        var result:ContainerBinding;
        if (_bindingByContainer.exists(container))
        {
            result = _bindingByContainer.get(container);
        } else {
            result = createBinding(container);
            _bindingByContainer.set(container, result);
        }
        return result;
    }

    public function removeContainer(container : DisplayObjectContainer) : ContainerBinding {
        var binding : ContainerBinding = _bindingByContainer.get(container);
        binding != null && removeBinding(binding) != null ;
        return binding;
    }

    public function findParentBinding(target : DisplayObject) : ContainerBinding {
        var parent : DisplayObjectContainer = target.parent;
        while(parent != null) {
            var binding : ContainerBinding = _bindingByContainer.get(parent);
            if(binding != null)  {
                return binding;
            }
            parent = parent.parent;
        }

        return null;
    }

    public function getBinding(container : DisplayObjectContainer) : ContainerBinding {
        return _bindingByContainer.get(container);
    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function createBinding(container : DisplayObjectContainer) : ContainerBinding {
        var binding : ContainerBinding = new ContainerBinding(container);
        _bindings.push(binding);
        // Add a listener so that we can remove this binding when it has no handlers
        binding.addEventListener(ContainerBindingEvent.BINDING_EMPTY, onBindingEmpty);
        // If the new binding doesn't have a parent it is a Root
        binding.parent = findParentBinding(container);
        if(binding.parent == null)  {
            addRootBinding(binding);
        }
        // Reparent any bindings which are contained within the new binding AND
        // A. Don't have a parent, OR
        // B. Have a parent that is not contained within the new binding
        for(childBinding in _bindingByContainer/* AS3HX WARNING could not determine type for var: childBinding exp: EIdent(_bindingByContainer) type: Dictionary*/) {
            if(container.contains(childBinding.container))  {
                if(childBinding.parent == null)  {
                    removeRootBinding(childBinding);
                    childBinding.parent = binding;
                }

                else if(container.contains(childBinding.parent.container) == false)  {
                    childBinding.parent = binding;
                }
            }
        }
        dispatchEvent(new ContainerRegistryEvent(ContainerRegistryEvent.CONTAINER_ADD, binding.container));
        return binding;
    }

    function removeBinding(binding : ContainerBinding) : Void {
        // Remove the binding itself
        _bindingByContainer.remove(binding.container);
        var index : Int = Lambda.indexOf(_bindings,binding);
        _bindings.splice(index, 1);
        // Drop the empty binding listener
        binding.removeEventListener(ContainerBindingEvent.BINDING_EMPTY, onBindingEmpty);
        if(binding.parent == null)  {
            // This binding didn't have a parent, so it was a Root
            removeRootBinding(binding);
        }
        // Re-parent the bindings
        for(childBinding in _bindingByContainer/* AS3HX WARNING could not determine type for var: childBinding exp: EIdent(_bindingByContainer) type: Dictionary*/) {
            if(childBinding.parent == binding)  {
                childBinding.parent = binding.parent;
                if(childBinding.parent == null)  {
                    // This binding used to have a parent,
                    // but no longer does, so it is now a Root
                    addRootBinding(childBinding);
                }
            }
        }
        dispatchEvent(new ContainerRegistryEvent(ContainerRegistryEvent.CONTAINER_REMOVE, binding.container));
    }

    function addRootBinding(binding : ContainerBinding) : Void {
        _rootBindings.push(binding);
        dispatchEvent(new ContainerRegistryEvent(ContainerRegistryEvent.ROOT_CONTAINER_ADD, binding.container));
    }

    function removeRootBinding(binding : ContainerBinding) : Void {
        var index : Int = Lambda.indexOf(_rootBindings,binding);
        _rootBindings.splice(index, 1);
        dispatchEvent(new ContainerRegistryEvent(ContainerRegistryEvent.ROOT_CONTAINER_REMOVE, binding.container));
    }

    function onBindingEmpty(event : ContainerBindingEvent) : Void {
        removeBinding(cast(event.target, ContainerBinding));
    }


    public function new() {
        super();
        _bindings = new Array<ContainerBinding>();
        _rootBindings = new Array<ContainerBinding>();
        _bindingByContainer = new ObjectHash();
    }
}

