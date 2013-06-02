//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.commandcenter.api;

interface ICommandMapping {
    var commandClass(getCommandClass, never) : Class<Dynamic>;
    var guards(getGuards, never) : Array<Dynamic>;
    var hooks(getHooks, never) : Array<Dynamic>;
    var fireOnce(getFireOnce, never) : Bool;
    var next(getNext, setNext) : ICommandMapping;

    function getCommandClass() : Class<Dynamic>;
    function getGuards() : Array<Dynamic>;
    function getHooks() : Array<Dynamic>;
    function getFireOnce() : Bool;
    function validate() : Void;
    function getNext() : ICommandMapping;
    function setNext(value : ICommandMapping) : ICommandMapping;
}

