//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.framework.impl;

import minject.Injector;

class InlineUtils {

    /**
     * <p>A hook can be a function, object or class.</p>
     *
     * <p>When an object is passed it is expected to expose a "hook" method.</p>
     *
     * <p>When a class is passed, an instance of that class will be instantiated and called.
     * If an injector is provided the instance will be created using that injector,
     * otherwise the instance will be created manually.</p>
     *
     * @param hooks An array of hooks
     * @param injector An optional Injector
     */
    public static function applyHooks(hooks:Array<Dynamic>, injector:Injector = null):Void
    {
        for (hook in hooks)
        {
            if (Reflect.isFunction(hook))
            {
                Reflect.callMethod(null, hook, null);
                //hook();
                continue;
            }
            if (Std.is(hook,Class))
            {
                /*TODO:hook = injector
                    ? injector.getInstance(cast(hook, Class))
                    : new cast(hook, Class)();*/
            }
            hook.hook();
        }
    }
    
    /**
     * <p>Helper function to call any of the 3 forms of eventual callback:</p>
     *
     * <code>(), (error) and (error, message)</code>
     *
     * <p>NOTE: This helper will not handle null callbacks. You should check
     * if the callback is null from the calling location:</p>
     *
     * <code>callback &amp;&amp; safelyCallBack(callback, error, message);</code>
     *
     * <p>This prevents the overhead of calling safelyCallBack()
     * when there is no callback to call. Likewise it reduces the overhead
     * of a null check in safelyCallBack().</p>
     *
     * <p>QUESTION: Is this too harsh? Should we protect from null?</p>
     *
     * @param callback The actual callback
     * @param error An optional error
     * @param message An optional message
     */
    public static function safelyCallBack(callBack:Dynamic, error:Dynamic = null, message:Dynamic = null):Void
    {
        if (error == null && message == null)
        {
            Reflect.callMethod(null, callBack, null);
            //callBack();
        }
        else if (message == null)
        {
            //callBack(error);
            Reflect.callMethod(null, callBack, [error]);
        }
        else
        {
            //callBack(error, message);
            //Reflect.callMethod(null, callBack, [error, message]);
            Reflect.callMethod(null, callBack, [message]);
        }
    }
    
    /**
     * <p>A guard can be a function, object or class.</p>
     * 
     * <p>When a function is provided it is expected to return a Boolean when called.</p>
     *
     * <p>When an object is provided it is expected to expose an "approve" method
     * that returns a Boolean.</p>
     *
     * <p>When a class is provided, an instance of that class will be instantiated and tested.
     * If an injector is provided the instance will be created using that injector,
     * otherwise the instance will be created manually.</p>
     *
     * @param guards An array of guards
     * @param injector An optional Injector
     *
     * @return A Boolean value of false if any guard returns false
     */
    public static function guardsApprove(guards:Array<Dynamic>, injector:Injector = null):Bool
    {
        /*for (guard in guards)
        {
            if (Std.is(guard,Dynamic))
            {
                if (cast(guard,Dynamic)())
                    continue;
                return false;
            }
            if (Std.is(guard,Class))
            {
                guard = injector
                    ? injector.getInstance(cast(guard, Class))
                    : new (guard as Class);
            }
            if (guard.approve() == false)
                return false;
        }*/
        return true;
    }


    public function new() {
    }
}

