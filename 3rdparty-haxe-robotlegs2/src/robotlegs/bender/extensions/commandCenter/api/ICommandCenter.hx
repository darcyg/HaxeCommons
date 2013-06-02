//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.commandcenter.api;

import robotlegs.bender.extensions.commandcenter.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandUnmapper;

interface ICommandCenter {

    function map(trigger : ICommandTrigger) : ICommandMapper;
    function unmap(trigger : ICommandTrigger) : ICommandUnmapper;
}

