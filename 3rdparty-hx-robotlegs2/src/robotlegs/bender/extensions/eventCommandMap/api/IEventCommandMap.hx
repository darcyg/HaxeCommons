//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.eventcommandmap.api;

import robotlegs.bender.extensions.commandcenter.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandUnmapper;

interface IEventCommandMap {

    function map(type : String, eventClass : Class<Dynamic> = null) : ICommandMapper;
    function unmap(type : String, eventClass : Class<Dynamic> = null) : ICommandUnmapper;
}

