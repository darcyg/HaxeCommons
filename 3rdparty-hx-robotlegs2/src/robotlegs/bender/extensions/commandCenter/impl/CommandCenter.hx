//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.commandcenter.impl;

//import openfl.ObjectHash;
import openfl.ObjectHash;
import robotlegs.bender.extensions.commandcenter.api.ICommandCenter;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandcenter.api.ICommandTrigger;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandUnmapper;

class CommandCenter implements ICommandCenter {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _mappers : ObjectHash<ICommandTrigger,Dynamic>;
    var NULL_UNMAPPER : ICommandUnmapper;
    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function map(trigger : ICommandTrigger) : ICommandMapper {
        var result:ICommandMapper;
        if (_mappers.exists(trigger))
        {
            result = _mappers.get(trigger);
        } else {
            result = new CommandMapper(trigger);
            _mappers.set(trigger, result);
        }
        return result;
    }

    public function unmap(trigger : ICommandTrigger) : ICommandUnmapper {
        var result:ICommandUnmapper;
        if (_mappers.exists(trigger))
        {
            result = _mappers.get(trigger);
        } else {
            result = NULL_UNMAPPER;
        }
        return result;
    }


    public function new() {
        _mappers = new ObjectHash();
        NULL_UNMAPPER = new NullCommandUnmapper();
    }
}

