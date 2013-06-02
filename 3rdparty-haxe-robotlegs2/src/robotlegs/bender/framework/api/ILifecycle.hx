//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.api;

import flash.events.IEventDispatcher;

/**

 * The Robotlegs lifecycle contract

 */interface ILifecycle extends IEventDispatcher {
    var state(getState, never) : String;
    var target(getTarget, never) : Dynamic;
    var initialized(getInitialized, never) : Bool;
    var active(getActive, never) : Bool;
    var suspended(getSuspended, never) : Bool;
    var destroyed(getDestroyed, never) : Bool;

    function getState() : String;
    function getTarget() : Dynamic;
    function getInitialized() : Bool;
    function getActive() : Bool;
    function getSuspended() : Bool;
    function getDestroyed() : Bool;
    function initialize(callBack : Dynamic->Void = null) : Void;
    function suspend(callBack : Dynamic->Void = null) : Void;
    function resume(callBack : Dynamic->Void = null) : Void;
    function destroy(callBack : Dynamic->Void = null) : Void;
    function beforeInitializing(handler : Dynamic->Void) : ILifecycle;
    function whenInitializing(handler : Dynamic->Void) : ILifecycle;
    function afterInitializing(handler : Dynamic->Void) : ILifecycle;
    function beforeSuspending(handler : Dynamic->Void) : ILifecycle;
    function whenSuspending(handler : Dynamic->Void) : ILifecycle;
    function afterSuspending(handler : Dynamic->Void) : ILifecycle;
    function beforeResuming(handler : Dynamic->Void) : ILifecycle;
    function whenResuming(handler : Dynamic->Void) : ILifecycle;
    function afterResuming(handler : Dynamic->Void) : ILifecycle;
    function beforeDestroying(handler : Dynamic->Void) : ILifecycle;
    function whenDestroying(handler : Dynamic->Void) : ILifecycle;
    function afterDestroying(handler : Dynamic->Void) : ILifecycle;
}

