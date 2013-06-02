//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import openfl.ObjectHash;
import robotlegs.bender.framework.api.IMessageDispatcher;
import robotlegs.bender.framework.impl.InlineUtils;

/**

 * Message Dispatcher implementation.

 */class MessageDispatcher implements IMessageDispatcher {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _handlers : ObjectHash<Dynamic,Dynamic>;
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    public function new() {
        _handlers = new ObjectHash();
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    /**

     * @inheritDoc

     */    public function addMessageHandler(message : Dynamic, handler : Dynamic->Void) : Void {
        var messageHandlers : Array<Dynamic> = _handlers.get(message);
        if(messageHandlers != null)  {
            if(Lambda.indexOf(messageHandlers,handler) == -1) 
                messageHandlers.push(handler);
        }

        else  {
            _handlers.set(message,[handler]);
        }

    }

    /**

     * @inheritDoc

     */    public function hasMessageHandler(message : Dynamic) : Bool {
        return _handlers.get(message);
    }

    /**

     * @inheritDoc

     */    public function removeMessageHandler(message : Dynamic, handler : Dynamic->Void) : Void {
        var messageHandlers : Array<Dynamic> = _handlers.get(message);
        var index : Int = (messageHandlers != null) ? Lambda.indexOf(messageHandlers,handler) : -1;
        if(index != -1)  {
            messageHandlers.splice(index, 1);
            if (messageHandlers.length == 0) 
            {
                _handlers.remove(message);
            }
        }
    }

    /**

     * @inheritDoc

     */    public function dispatchMessage(message : Dynamic, callBack : Dynamic->Void = null, reverse : Bool = false) : Void {
        var handlers : Array<Dynamic> = _handlers.get(message);
        if(handlers != null)  {
            handlers = handlers.concat([]);
            reverse == true || handlers.reverse() != null;
            new MessageRunner(message, handlers, callBack).run();
        }

        else  {
            callBack != null && InlineUtils.safelyCallBack(callBack) != null;
        }

    }

}

class MessageRunner {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _message : Dynamic;
    var _handlers : Array<Dynamic>;
    var _callback : Dynamic->Void;
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    public function new(message : Dynamic, handlers : Array<Dynamic>, callBack : Dynamic->Void) {
        _message = message;
        _handlers = handlers;
        _callback = callBack;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function run() : Void {
        next();
    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function next() : Void {
        // Try to keep things synchronous with a simple loop,
        // forcefully breaking out for async handlers and recursing.
        // We do this to avoid increasing the stack depth unnecessarily.
        var handler : Dynamic->Dynamic->Void;
        while((handler = _handlers.pop()) != null) {
            if(_message == null && _callback == null) 
                // sync handler: ()
             {
                Reflect.callMethod(null, handler, null);
            }

            else if(_message != null) 
                // sync handler: (message)
             {
                //handler(_message);
                Reflect.callMethod(null, handler, [_message]);
            }

            else if(_message != null && _callback != null) 
                // sync or async handler: (message, callback)
             {
                var handled : Bool;
                handler(_message, function(error : Dynamic = null, msg : Dynamic = null) : Void {
                        // handler must not invoke the callback more than once
                        /*if(handled == true) 
                            return;
                        handled = true;*/
                        if(error || _handlers.length == 0)  {
                            _callback != null && InlineUtils.safelyCallBack(_callback, error, _message) != null;
                        }

                        else  {
                            next();
                        }
                    }
                );
                // IMPORTANT: MUST break this loop with a RETURN. See top.
                return;
            }

            else // ERROR: this should NEVER happen
             {
                //throw new Error("Bad handler signature");
            }
        }

        // If we got here then this loop finished synchronously.
        // Nobody broke out, so we are done.
        // This relies on the various return statements above. Be careful.
        _callback != null && InlineUtils.safelyCallBack(_callback, null, _message) != null;
    }

}

