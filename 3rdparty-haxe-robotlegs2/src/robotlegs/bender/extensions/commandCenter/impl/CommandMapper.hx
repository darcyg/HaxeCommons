//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.commandcenter.impl;

import openfl.ObjectHash;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandcenter.api.ICommandMapping;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandMappingConfig;
import robotlegs.bender.extensions.commandcenter.api.ICommandTrigger;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandUnmapper;

class CommandMapper implements ICommandMapper implements ICommandUnmapper {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _mappings : ObjectHash<Dynamic,Dynamic>;
    var _trigger : ICommandTrigger;
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    public function new(trigger : ICommandTrigger) {
        _mappings = new ObjectHash();
        _trigger = trigger;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function toCommand(commandClass : Class<Dynamic>) : ICommandMappingConfig {
        var result:ICommandMappingConfig;
        if (_mappings.exists(commandClass))
        {
            result = _mappings.get(commandClass);
        }else {
            result = createMapping(commandClass);
        }
        return locked(cast(result,CommandMapping));
    }

    public function fromCommand(commandClass : Class<Dynamic>) : Void {
        var mapping : ICommandMapping = _mappings.get(commandClass);
        mapping != null && _trigger.removeMapping(mapping) != null;
        _mappings.remove(commandClass);
    }

    public function fromAll() : Void {
        for(mapping in _mappings/* AS3HX WARNING could not determine type for var: mapping exp: EIdent(_mappings) type: Dictionary*/) {
            _trigger.removeMapping(mapping);
            _mappings.remove(mapping.commandClass);
        }

    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function createMapping(commandClass : Class<Dynamic>) : CommandMapping {
        var mapping : CommandMapping = new CommandMapping(commandClass);
        _trigger.addMapping(mapping);
        _mappings.set(commandClass, mapping);
        return mapping;
    }

    function locked(mapping : CommandMapping) : CommandMapping {
        if(mapping == null) 
            return null;
        mapping.invalidate();
        return mapping;
    }

}

