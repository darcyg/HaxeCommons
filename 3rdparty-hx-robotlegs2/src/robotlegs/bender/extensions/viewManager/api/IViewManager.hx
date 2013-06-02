//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewmanager.api;

import flash.display.DisplayObjectContainer;
import flash.events.IEventDispatcher;

@:meta(Event(name="containerAdd",type="robotlegs.bender.extensions.viewManager.impl.ViewManagerEvent"))
@:meta(Event(name="containerRemove",type="robotlegs.bender.extensions.viewManager.impl.ViewManagerEvent"))
@:meta(Event(name="handlerAdd",type="robotlegs.bender.extensions.viewManager.impl.ViewManagerEvent"))
@:meta(Event(name="handlerRemove",type="robotlegs.bender.extensions.viewManager.impl.ViewManagerEvent"))
interface IViewManager extends IEventDispatcher {
    var containers(getContainers, never) : Array<DisplayObjectContainer>;

    function getContainers() : Array<DisplayObjectContainer>;
    function addContainer(container : DisplayObjectContainer) : Void;
    function removeContainer(container : DisplayObjectContainer) : Void;
    function addViewHandler(handler : IViewHandler) : Void;
    function removeViewHandler(handler : IViewHandler) : Void;
    function removeAllHandlers() : Void;
}

