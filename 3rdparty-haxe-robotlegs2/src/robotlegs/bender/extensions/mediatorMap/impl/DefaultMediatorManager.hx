//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.impl;

import flash.display.DisplayObject;
import flash.events.Event;
import openfl.ObjectHash;
import robotlegs.bender.extensions.mediatormap.api.IMediatorFactory;
import robotlegs.bender.extensions.mediatormap.api.IMediatorMapping;
import robotlegs.bender.extensions.mediatormap.api.MediatorFactoryEvent;
import robotlegs.bender.framework.api.ILogger;

class DefaultMediatorManager {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _factory : IMediatorFactory;
    
    /*============================================================================*/    
    /* Injected Properties                                                         */    
    /*============================================================================*/    
    @inject
    public var logger:ILogger;
    
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    @inject
    public function new(factory : IMediatorFactory) {
        _factory = factory;
        _factory.addEventListener(MediatorFactoryEvent.MEDIATOR_CREATE, onMediatorCreate);
        _factory.addEventListener(MediatorFactoryEvent.MEDIATOR_REMOVE, onMediatorRemove);
    }    
    
    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function onMediatorCreate(event : MediatorFactoryEvent) : Void {
        logger.debug(this + "::" + "onMediatorCreate", [event.view, event.mediator]);
        var mediator : Dynamic = event.mediator;
        var displayObject : DisplayObject = cast(event.view, DisplayObject);
        if(displayObject == null)  {
            // Non-display-object was added, initialize and exit
            initializeMediator(event.view, mediator);
            return;
        }
        // Watch this view for removal
        displayObject.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
        initializeMediator(displayObject, mediator);
    }

    function onMediatorRemove(event : MediatorFactoryEvent) : Void {
        logger.debug(this + "::" + "onMediatorRemove", [event.view, event.mediator]);
        var displayObject : DisplayObject = cast(event.view, DisplayObject);
        if(displayObject != null) 
            displayObject.removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
        if(event.mediator) 
            destroyMediator(event.mediator);
    }

    function onRemovedFromStage(event : Event) : Void {
        logger.debug(this + "::" + "onRemovedFromStage", [event]);
        _factory.removeMediators(event.target);
    }

    function initializeMediator(view : Dynamic, mediator : Dynamic) : Void {
        logger.debug(this + "::" + "initializeMediator", [view,mediator]);
        if(mediator.hasOwnProperty("viewComponent")) 
            mediator.viewComponent = view;
        if(mediator.hasOwnProperty("initialize")) 
            mediator.initialize();
    }

    function destroyMediator(mediator : Dynamic) : Void {
        logger.debug(this + "::" + "destroyMediator", [mediator]);
        if(mediator.hasOwnProperty("destroy")) 
            mediator.destroy();
    }

}

