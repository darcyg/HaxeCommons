//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewprocessormap.utils;

import minject.Injector;
import openfl.ObjectHash;

class MediatorCreator {

    var _mediatorClass : Class<Dynamic>;
    var _createdMediatorsByView : ObjectHash<Dynamic,Dynamic>;
    public function new(mediatorClass : Class<Dynamic>) {
        _createdMediatorsByView = new ObjectHash();
        _mediatorClass = mediatorClass;
    }

    public function process(view : Dynamic, type : Class<Dynamic>, injector : Injector) : Void {
        if(_createdMediatorsByView.exists(view))  {
            return;
        }
        var mediator : Dynamic = injector.getInstance(_mediatorClass);
        _createdMediatorsByView.set(view, mediator);
        initializeMediator(view, mediator);
    }

    public function unprocess(view : Dynamic, type : Class<Dynamic>, injector : Injector) : Void {
        if(_createdMediatorsByView.exists(view))  {
            destroyMediator(_createdMediatorsByView.get(view));
            _createdMediatorsByView.remove(view);
        }
    }

    function initializeMediator(view : Dynamic, mediator : Dynamic) : Void {
        if(mediator.hasOwnProperty("viewComponent")) 
            mediator.viewComponent = view;
        if(mediator.hasOwnProperty("initialize")) 
            mediator.initialize();
    }

    function destroyMediator(mediator : Dynamic) : Void {
        if(mediator.hasOwnProperty("destroy")) 
            mediator.destroy();
    }

}

