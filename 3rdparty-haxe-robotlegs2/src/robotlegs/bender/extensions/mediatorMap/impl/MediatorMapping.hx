//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.impl;

import robotlegs.bender.extensions.mediatormap.api.IMediatorMapping;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorMappingConfig;
import robotlegs.bender.extensions.matching.ITypeFilter;
import robotlegs.bender.framework.impl.MappingConfigValidator;

class MediatorMapping implements IMediatorMapping implements IMediatorMappingConfig {
    
    var _locked : Bool;
    var _validator : MappingConfigValidator;
    /*============================================================================*/    
    /* Public Properties                                                          */    
    /*============================================================================*/    
    var _matcher : ITypeFilter;
    /*public var matcher(getMatcher, never) : ITypeFilter;*/
    public function getMatcher() : ITypeFilter {
        return _matcher;
    }

    var _mediatorClass : Class<Dynamic>;
    /*public var mediatorClass(getMediatorClass, never) : Class<Dynamic>;*/
    public function getMediatorClass() : Class<Dynamic> {
        return _mediatorClass;
    }

    var _guards : Array<Dynamic>;
   /* public var guards(getGuards, never) : Array<Dynamic>;*/
    public function getGuards() : Array<Dynamic> {
        return _guards;
    }

    var _hooks : Array<Dynamic>;
    /*public var hooks(getHooks, never) : Array<Dynamic>;*/
    public function getHooks() : Array<Dynamic> {
        return _hooks;
    }

    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    @inject
    public function new(matcher : ITypeFilter, mediatorClass : Class<Dynamic>) {
        //nme.Lib.trace(matcher+"::"+mediatorClass);
        _locked = false;
        _guards = [];
        _hooks = [];
        _matcher = matcher;
        _mediatorClass = mediatorClass;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function withGuards(guards:Array<Dynamic>) : IMediatorMappingConfig {
        _validator != null && _validator.checkGuards(guards) != null;
        _guards = _guards.concat(guards);
        return this;
    }

    public function withHooks(hooks:Array<Dynamic>) : IMediatorMappingConfig {
        _validator != null && _validator.checkHooks(hooks) != null;
        _hooks = _hooks.concat(hooks);
        return this;
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

    function createValidator() : Void {
        _validator = new MappingConfigValidator(_guards.slice(0,0), _hooks.slice(0,0), _matcher, _mediatorClass);
    }

}

