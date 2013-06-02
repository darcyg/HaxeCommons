//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.messagecommandmap.impl;

import minject.Injector;
import robotlegs.bender.framework.api.IMessageDispatcher;
import robotlegs.bender.extensions.commandcenter.api.ICommandMapping;
import robotlegs.bender.extensions.commandcenter.api.ICommandTrigger;
import robotlegs.bender.extensions.commandcenter.impl.CommandMapping;

class MessageCommandTrigger implements ICommandTrigger {

    /*============================================================================*/    /* Private Properties                                                         */    /*============================================================================*/    var _mappings : Array<ICommandMapping>;
    var _injector : Injector;
    var _dispatcher : IMessageDispatcher;
    var _message : Dynamic;
    /*============================================================================*/    /* Constructor                                                                */    /*============================================================================*/    public function new(injector : Injector, dispatcher : IMessageDispatcher, message : Dynamic) {
        _mappings = new Array<ICommandMapping>();
        _injector = injector.createChildInjector();
        _dispatcher = dispatcher;
        _message = message;
    }

    /*============================================================================*/    /* Public Functions                                                           */    /*============================================================================*/    public function addMapping(mapping : ICommandMapping) : Void {
        verifyCommandClass(mapping);
        _mappings.push(mapping);
        if(_mappings.length == 1) 
            addHandler();
    }

    public function removeMapping(mapping : ICommandMapping) : Void {
        var index : Int = _mappings.indexOf(mapping);
        if(index != -1)  {
            _mappings.splice(index, 1);
            if(_mappings.length == 0) 
                removeHandler();
        }
    }

    /*============================================================================*/    /* Private Functions                                                          */    /*============================================================================*/    function verifyCommandClass(mapping : ICommandMapping) : Void {
    }

    function addHandler() : Void {
        _dispatcher.addMessageHandler(_message, handleMessage);
    }

    function removeHandler() : Void {
        _dispatcher.removeMessageHandler(_message, handleMessage);
    }

    function handleMessage(message : Dynamic, callBack : Dynamic->Void) : Void {
        var mappings : Array<ICommandMapping> = _mappings.concat().reverse();
        next(mappings, callBack);
    }

    function next(mappings : Array<ICommandMapping>, callBack : Dynamic->Void) : Void {
        // Try to keep things synchronous with a simple loop,
        // forcefully breaking out for async handlers and recursing.
        // We do this to avoid increasing the stack depth unnecessarily.
        var mapping : ICommandMapping;
        while(mapping = mappings.pop()) {
            mapping.validate();
            if(guardsApprove(mapping.guards, _injector))  {
                mapping.fireOnce && removeMapping(mapping);
                _injector.map(mapping.commandClass).asSingleton();
                var command : Dynamic = _injector.getInstance(mapping.commandClass);
                var handler : Dynamic->Void = command.execute;
                applyHooks(mapping.hooks, _injector);
                _injector.unmap(mapping.commandClass);
                if(handler.length == 0) 
                    // sync handler: ()
                 {
                    handler();
                }

                else if(handler.length == 1) 
                    // sync handler: (message)
                 {
                    handler(_message);
                }

                else if(handler.length == 2) 
                    // sync or async handler: (message, callBack)
                 {
                    var handled : Bool;
                    handler(_message, function(error : Dynamic = null, msg : Dynamic = null) : Void {
                        // handler must not invoke the callBack more than once
                        if(handled) 
                            return;
                        handled = true;
                        if(error || mappings.length == 0)  {
                            callBack && safelyCallBack(callBack, error, _message);
                        }

                        else  {
                            next(mappings, callBack);
                        }

                    }
);
                    // IMPORTANT: MUST break this loop with a RETURN. See above.
                    return;
                }

                else // ERROR: this should NEVER happen
                 {
                }
;
            }
        }

        // If we got here then this loop finished synchronously.
        // Nobody broke out, so we are done.
        // This relies on the various return statements above. Be careful.
        callBack && safelyCallBack(callBack, null, _message);
    }

}

