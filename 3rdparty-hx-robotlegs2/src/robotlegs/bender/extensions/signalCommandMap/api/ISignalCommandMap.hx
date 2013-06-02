//------------------------------------------------------------------------------
//  Copyright (c) 2012 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.signalcommandmap.api;

import robotlegs.bender.extensions.commandcenter.dsl.ICommandMapper;
import robotlegs.bender.extensions.commandcenter.dsl.ICommandUnmapper;

interface ISignalCommandMap {

    function map(signalClass : Class<Dynamic>, once : Bool = false) : ICommandMapper;
    function unmap(signalClass : Class<Dynamic>) : ICommandUnmapper;
}

