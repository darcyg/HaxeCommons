//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.commandcenter.impl;

import robotlegs.bender.extensions.commandcenter.api.ICommandMapping;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandMappingConfig;
import robotlegs.bender.extensions.commandcenter.api.CommandMappingError;
import robotlegs.bender.framework.impl.MappingConfigValidator;

class CommandMapping implements ICommandMapping implements ICommandMappingConfig {
    public var commandClass(getCommandClass, never) : Class<Dynamic>;
    public var guards(getGuards, never) : Array<Dynamic>;
    public var hooks(getHooks, never) : Array<Dynamic>;
    public var fireOnce(getFireOnce, never) : Bool;
    public var next(getNext, setNext) : ICommandMapping;

    /*============================================================================*/    
    /* Public Properties                                                          */    
    /*============================================================================*/    
    var _commandClass : Class<Dynamic>;
    public function getCommandClass() : Class<Dynamic> {
        return _commandClass;
    }

    var _guards : Array<Dynamic>;
    public function getGuards() : Array<Dynamic> {
        return _guards;
    }

    var _hooks : Array<Dynamic>;
    var _once : Bool;
    public function getHooks() : Array<Dynamic> {
        return _hooks;
    }

    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    public function new(commandClass : Class<Dynamic>) {
        _guards = [];
        _hooks = [];
        _commandClass = commandClass;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function withGuards(guards:Array<Dynamic>) : ICommandMappingConfig {
        _validator != null && _validator.checkGuards(guards) != null;
        _guards = _guards.concat(guards);
        return this;
    }

    public function withHooks(hooks:Array<Dynamic>) : ICommandMappingConfig {
        _validator != null && _validator.checkHooks(hooks) != null;
        _hooks = _hooks.concat(hooks);
        return this;
    }

    public function getFireOnce() : Bool {
        return _once;
    }

    public function once(value : Bool = true) : ICommandMappingConfig {
        _validator != null && (!_once) && throwMappingError("You attempted to change an existing mapping for " + _commandClass + " by setting once(). Please unmap first.") != null;
        _once = value;
        return this;
    }

    var _next : ICommandMapping;
    public function getNext() : ICommandMapping {
        return _next;
    }

    public function setNext(value : ICommandMapping) : ICommandMapping {
        _next = value;
        return value;
    }

    function throwMappingError(msg : String) : Void {
        throw new CommandMappingError(msg);
    }

    public function invalidate() : Void {
        if(_validator != null) 
            _validator.invalidate()
        else createValidator();
        _guards = [];
        _hooks = [];
    }

    public function validate() : Void {
        if(_validator == null)  {
            createValidator();
        }

        else if(!_validator.valid)  {
            _validator.validate(_guards, _hooks);
        }
    }

    var _validator : MappingConfigValidator;
    function createValidator() : Void {
        _validator = new MappingConfigValidator(_guards.slice(0,0), _hooks.slice(0,0), null, _commandClass);
    }

}

