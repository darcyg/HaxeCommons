//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.signalcommandmap.impl;

import openfl.ObjectHash;
import msignal.Signal;
import minject.Injector;
import robotlegs.bender.extensions.commandcenter.api.ICommandMapping;
import robotlegs.bender.extensions.commandcenter.api.ICommandTrigger;
import robotlegs.bender.framework.impl.InlineUtils;

class SignalCommandTrigger implements ICommandTrigger {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _mappings : Array<ICommandMapping>;
    var _signal : AnySignal;
    var _signalClass : Class<Dynamic>;
    var _once : Bool;
    /*============================================================================*/    
    /* Protected Properties                                                         */    
    /*============================================================================*/    
    var _injector : Injector;
    var _signalMap : ObjectHash<Dynamic,Dynamic>;
    var _verifiedCommandClasses : ObjectHash<Dynamic,Dynamic>;
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    @inject
    public function new(injector : Injector, signalClass : Class<Dynamic>, once : Bool = false) {
        _mappings = new Array<ICommandMapping>();
        _injector = injector;
        _signalClass = signalClass;
        _once = once;
        _signalMap = new ObjectHash();
        _verifiedCommandClasses = new ObjectHash();
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function addMapping(mapping : ICommandMapping) : Void {
        verifyCommandClass(mapping);
        _mappings.push(mapping);
        if(_mappings.length == 1) 
            addSignal(mapping.commandClass);
    }

    public function removeMapping(mapping : ICommandMapping) : Void {
        var index : Int = Lambda.indexOf(_mappings,mapping);
        if(index != -1)  {
            _mappings.splice(index, 1);
            if(_mappings.length == 0) 
                removeSignal(mapping.commandClass);
        }
    }

    /*============================================================================*/    
    /* Protected Functions                                                          */    
    /*============================================================================*/    
    function verifyCommandClass(mapping : ICommandMapping) : Void {
        if(_verifiedCommandClasses.get(mapping.commandClass)) 
            return;
        /*TODO:if (describeType(mapping.commandClass).factory.method.(@name == "execute").length() == 0)

            throw new Error("Command Class must expose an execute method");*/_verifiedCommandClasses.set(mapping.commandClass, true);
    }

    function routeSignalToCommand(signal : AnySignal, valueObjects : Array<Dynamic>, commandClass : Class<Dynamic>, oneshot : Bool) : Void {
        var mappings : Array<ICommandMapping> = _mappings.concat([]);
        for(mapping in mappings/* AS3HX WARNING could not determine type for var: mapping exp: EIdent(mappings) type: Array<ICommandMapping>*/) {
            if(InlineUtils.guardsApprove(mapping.guards, _injector))  {
                _once && removeMapping(mapping) != null;
                _injector.mapSingleton(mapping.commandClass);
                var command : Dynamic = createCommandInstance(signal.valueClasses, valueObjects, mapping.commandClass);
                InlineUtils.applyHooks(mapping.hooks, _injector);
                _injector.unmap(mapping.commandClass);
                command.execute();
                unmapSignalValues(signal.valueClasses, valueObjects);
            }
        }

        if(_once) 
            removeSignal(commandClass);
    }

    function mapSignalValues(valueClasses : Array<Dynamic>, valueObjects : Array<Dynamic>) : Void {
        var i : Int = 0;
        while(i < valueClasses.length) {
            _injector.mapValue(valueClasses[i],valueObjects[i]);
            i++;
        }
    }

    function unmapSignalValues(valueClasses : Array<Dynamic>, valueObjects : Array<Dynamic>) : Void {
        var i : Int = 0;
        while(i < valueClasses.length) {
            _injector.unmap(valueClasses[i]);
            i++;
        }
    }

    function createCommandInstance(valueClasses : Array<Dynamic>, valueObjects : Array<Dynamic>, commandClass : Class<Dynamic>) : Dynamic {
        mapSignalValues(valueClasses, valueObjects);
        return _injector.getInstance(commandClass);
    }

    function hasSignalCommand(signal : AnySignal, commandClass : Class<Dynamic>) : Bool {
        var callBacksByCommandClass : ObjectHash<Dynamic,Dynamic> = Reflect.field(_signalMap, Std.string(signal));
        if(callBacksByCommandClass == null) 
            return false;
        var callBack : Dynamic->Void = Reflect.field(callBacksByCommandClass, Std.string(commandClass));
        return callBack != null;
    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function addSignal(commandClass : Class<Dynamic>,?args:Array<Dynamic>) : Void {
        if(hasSignalCommand(_signal, commandClass)) 
            return;
        _signal = _injector.getInstance(_signalClass);
        _injector.mapValue(_signalClass,_signal);
        var signalCommandMap : ObjectHash<Dynamic,Dynamic>;
        if (_signalMap.exists(_signal))
        {
            signalCommandMap = _signalMap.get(_signal); 
        } else {
            signalCommandMap = new ObjectHash();
            _signalMap.set(_signal,signalCommandMap); 
        }
        var callBack : Dynamic->Void = function(?params:Dynamic=null) : Void {
            routeSignalToCommand(_signal, args, commandClass, _once);
        }

        signalCommandMap.set(commandClass, callBack);
        _signal.add(callBack);
    }

    function removeSignal(commandClass : Class<Dynamic>) : Void {
        var callBacksByCommandClass : ObjectHash<Dynamic,Dynamic> = Reflect.field(_signalMap, Std.string(_signal));
        if(callBacksByCommandClass == null) 
            return;
        var callBack : Dynamic->Void = callBacksByCommandClass.get(commandClass);
        if(callBack == null) 
            return;
        _signal.remove(callBack);
        callBacksByCommandClass.remove(commandClass);
    }

}

