//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import openfl.ObjectHash;
import robotlegs.bender.framework.api.ILifecycle;
import robotlegs.bender.framework.api.LifecycleEvent;
import robotlegs.bender.framework.api.LifecycleState;

class Lifecycle extends EventDispatcher implements ILifecycle {
    public var state(getState, never) : String;
    public var target(getTarget, never) : Dynamic;
    public var initialized(getInitialized, never) : Bool;
    public var active(getActive, never) : Bool;
    public var suspended(getSuspended, never) : Bool;
    public var destroyed(getDestroyed, never) : Bool;

    /*============================================================================*/    
    /* Public Properties                                                          */    
    /*============================================================================*/    
    var _state : String;
    public function getState() : String {
        return _state;
    }

    var _target : Dynamic;
    public function getTarget() : Dynamic {
        return _target;
    }

    public function getInitialized() : Bool {
        return _state != LifecycleState.UNINITIALIZED && _state != LifecycleState.INITIALIZING;
    }

    public function getActive() : Bool {
        return _state == LifecycleState.ACTIVE;
    }

    public function getSuspended() : Bool {
        return _state == LifecycleState.SUSPENDED;
    }

    public function getDestroyed() : Bool {
        return _state == LifecycleState.DESTROYED;
    }

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _reversedEventTypes : ObjectHash<Dynamic,Dynamic>;
    var _reversePriority : Int;
    var _initialize : LifecycleTransition;
    var _suspend : LifecycleTransition;
    var _resume : LifecycleTransition;
    var _destroy : LifecycleTransition;
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    public function new(target : Dynamic) {
        super();
        _state = LifecycleState.UNINITIALIZED;
        _reversedEventTypes = new ObjectHash();
        _target = target;
        configureTransitions();
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function initialize(callBack : Dynamic->Void = null) : Void {
        _initialize.enter(callBack);
    }

    public function suspend(callBack : Dynamic->Void = null) : Void {
        _suspend.enter(callBack);
    }

    public function resume(callBack : Dynamic->Void = null) : Void {
        _resume.enter(callBack);
    }

    public function destroy(callBack : Dynamic->Void = null) : Void {
        _destroy.enter(callBack);
    }

    public function beforeInitializing(handler : Dynamic->Void) : ILifecycle {
        _initialize.addBeforeHandler(handler);
        return this;
    }

    public function beforeSuspending(handler : Dynamic->Void) : ILifecycle {
        _suspend.addBeforeHandler(handler);
        return this;
    }

    public function beforeResuming(handler : Dynamic->Void) : ILifecycle {
        _resume.addBeforeHandler(handler);
        return this;
    }

    public function beforeDestroying(handler : Dynamic->Void) : ILifecycle {
        _destroy.addBeforeHandler(handler);
        return this;
    }

    public function whenInitializing(handler : Dynamic->Void) : ILifecycle {
        addEventListener(LifecycleEvent.INITIALIZE, createLifecycleListener(handler, true));
        return this;
    }

    public function whenSuspending(handler : Dynamic->Void) : ILifecycle {
        addEventListener(LifecycleEvent.SUSPEND, createLifecycleListener(handler));
        return this;
    }

    public function whenResuming(handler : Dynamic->Void) : ILifecycle {
        addEventListener(LifecycleEvent.RESUME, createLifecycleListener(handler));
        return this;
    }

    public function whenDestroying(handler : Dynamic->Void) : ILifecycle {
        addEventListener(LifecycleEvent.DESTROY, createLifecycleListener(handler, true));
        return this;
    }

    public function afterInitializing(handler : Dynamic->Void) : ILifecycle {
        addEventListener(LifecycleEvent.POST_INITIALIZE, createLifecycleListener(handler, true));
        return this;
    }

    public function afterSuspending(handler : Dynamic->Void) : ILifecycle {
        addEventListener(LifecycleEvent.POST_SUSPEND, createLifecycleListener(handler));
        return this;
    }

    public function afterResuming(handler : Dynamic->Void) : ILifecycle {
        addEventListener(LifecycleEvent.POST_RESUME, createLifecycleListener(handler));
        return this;
    }

    public function afterDestroying(handler : Dynamic->Void) : ILifecycle {
        addEventListener(LifecycleEvent.POST_DESTROY, createLifecycleListener(handler, true));
        return this;
    }

    override public function addEventListener(type : String, listener : Dynamic->Void, useCapture : Bool = false, priority : Int = 0, useWeakReference : Bool = false) : Void {
                
        priority = flipPriority(type, priority);
        super.addEventListener(type, listener, useCapture, priority, useWeakReference);
    }

    /*============================================================================*/    
    /* Internal Functions                                                         */    
    /*============================================================================*/    
    public function setCurrentState(state : String) : Void {        
        if(_state == state) 
            return;
        _state = state;
    }

     public function addReversedEventTypes(types:Array<Dynamic>) : Void {
        for(type in types)
            _reversedEventTypes.set(type, true);
    }

    /*============================================================================*/    /* Private Functions                                                          */    /*============================================================================*/    
    function configureTransitions() : Void {
        _initialize = new LifecycleTransition(LifecycleEvent.PRE_INITIALIZE, this)
        .fromStates([LifecycleState.UNINITIALIZED])
        .toStates(LifecycleState.INITIALIZING, LifecycleState.ACTIVE)
        .withEvents(LifecycleEvent.PRE_INITIALIZE, LifecycleEvent.INITIALIZE, LifecycleEvent.POST_INITIALIZE);
        
        _suspend = new LifecycleTransition(LifecycleEvent.PRE_SUSPEND, this)
        .fromStates([LifecycleState.ACTIVE])
        .toStates(LifecycleState.SUSPENDING, LifecycleState.SUSPENDED)
        .withEvents(LifecycleEvent.PRE_SUSPEND, LifecycleEvent.SUSPEND, LifecycleEvent.POST_SUSPEND).inReverse();
        
        _resume = new LifecycleTransition(LifecycleEvent.PRE_RESUME, this)
        .fromStates([LifecycleState.SUSPENDED])
        .toStates(LifecycleState.RESUMING, LifecycleState.ACTIVE)
        .withEvents(LifecycleEvent.PRE_RESUME, LifecycleEvent.RESUME, LifecycleEvent.POST_RESUME);
        
        _destroy = new LifecycleTransition(LifecycleEvent.PRE_DESTROY, this)
        .fromStates([LifecycleState.SUSPENDED, LifecycleState.ACTIVE])
        .toStates(LifecycleState.DESTROYING, LifecycleState.DESTROYED)
        .withEvents(LifecycleEvent.PRE_DESTROY, LifecycleEvent.DESTROY, LifecycleEvent.POST_DESTROY).inReverse();
    }

    function flipPriority(type : String, priority : Int) : Int {
        return priority == 0 && _reversedEventTypes.exists(type) ? _reversePriority++ : priority;
    }

    function createLifecycleListener(handler : Dynamic->Void, once : Bool = false) : Dynamic->Void {
        
        // When and After handlers can not be asynchronous
        /*if(handler.length > 1)  {
            //throw new Error("When and After handlers must accept 0-1 arguments");
        }*/
        
        // A handler that accepts 1 argument is provided with the event type
        /*TODO: if(handler.length == 1)  {
            return function(event : LifecycleEvent) : Void {
                once == true && cast((event.target), IEventDispatcher).removeEventListener(event.type, arguments.callee) != null;
                handler(event.type);
            }
        }*/
        // Or, just call the handler
        /*TODO: return function(event : LifecycleEvent) : Void {
            once == true && cast((event.target), IEventDispatcher).removeEventListener(event.type, arguments.callee) != null;
            //handler();
            Reflect.callMethod(null, handler, null);
        }*/
        var result:LifecycleEvent->Void = function(event : LifecycleEvent) { 
            //once == true && cast((event.target), IEventDispatcher).removeEventListener(event.type, arguments.callee) != null;
            Reflect.callMethod(null, handler, null);
        }
        return result;
    }

}

