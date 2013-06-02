//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.impl;

import flash.events.EventDispatcher;
import openfl.ObjectHash;
import minject.Injector;
import robotlegs.bender.framework.impl.InlineUtils;
import robotlegs.bender.extensions.mediatormap.api.IMediatorFactory;
import robotlegs.bender.extensions.mediatormap.api.IMediatorMapping;
import robotlegs.bender.extensions.mediatormap.api.MediatorFactoryEvent;
import robotlegs.bender.extensions.matching.ITypeFilter;

//@:meta(Event(name="mediatorCreate",type="robotlegs.bender.extensions.mediatorMap.api.MediatorFactoryEvent"))
//@:meta(Event(name="mediatorRemove",type="robotlegs.bender.extensions.mediatorMap.api.MediatorFactoryEvent"))
class MediatorFactory extends EventDispatcher implements IMediatorFactory {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _mediators : ObjectHash<Dynamic,Dynamic>;
    var _injector : Injector;
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    @inject
    public function new(injector : Injector) {
        super();
        _mediators = new ObjectHash();
        //nme.Lib.trace(injector);
        _injector = injector;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function getMediator(view : Dynamic, mapping : IMediatorMapping) : Dynamic {
        return _mediators.get(view) !=  null ? _mediators.get(view).get(mapping) : null;
    }

    public function createMediators(view : Dynamic, type : Class<Dynamic>, mappings : Array<IMediatorMapping>) : Array<Dynamic> {
        var createdMediators : Array<Dynamic> = [];
        var filter : ITypeFilter;
        var mediator : Dynamic;
        for(mapping in mappings/* AS3HX WARNING could not determine type for var: mapping exp: EIdent(mappings) type: Array<Dynamic>*/) {
            mediator = getMediator(view, mapping);
            if(!mediator)  {
                filter = mapping.getMatcher();
                mapTypeForFilterBinding(filter, type, view);
                mediator = createMediator(view, mapping);
                unmapTypeForFilterBinding(filter, type, view);
            }
            if(mediator) 
                createdMediators.push(mediator);
        }

        return createdMediators;
    }

    public function removeMediators(view : Dynamic) : Void {
        var mediators : ObjectHash<IMediatorMapping,Dynamic> = _mediators.get(view);
        if(mediators == null) 
            return;
        if(hasEventListener(MediatorFactoryEvent.MEDIATOR_REMOVE))  {
            for(mapping in mediators.keys()) {
                dispatchEvent(new MediatorFactoryEvent(MediatorFactoryEvent.MEDIATOR_REMOVE, mediators.get(mapping), view, mapping, this));
            }

        }
        _mediators.remove(view);
    }

    public function removeAllMediators() : Void {
        for(view in _mediators) {
            removeMediators(view);
        }

    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function createMediator(view : Dynamic, mapping : IMediatorMapping) : Dynamic {
        var mediator : Dynamic = getMediator(view, mapping);
        if(mediator) 
            return mediator;
        if(InlineUtils.guardsApprove(mapping.getGuards(), _injector))  {
            mediator = _injector.instantiate(mapping.getMediatorClass()); // was getInstance()
            _injector.mapValue(mapping.getMediatorClass(),mediator);
            InlineUtils.applyHooks(mapping.getHooks(), _injector);
            _injector.unmap(mapping.getMediatorClass());
            addMediator(mediator, view, mapping);
        }
        return mediator;
    }

    function addMediator(mediator : Dynamic, view : Dynamic, mapping : IMediatorMapping) : Void {
        
        var subHash:ObjectHash<IMediatorMapping, Dynamic>;
        if(!_mediators.exists(view))
        {
            subHash = new ObjectHash();
            _mediators.set(view, subHash);
        } else {
            subHash = _mediators.get(view);
        }
        subHash.set(mapping, mediator);
       
        if(hasEventListener(MediatorFactoryEvent.MEDIATOR_CREATE)) 
            dispatchEvent(new MediatorFactoryEvent(MediatorFactoryEvent.MEDIATOR_CREATE, mediator, view, mapping, this));
    }

    function mapTypeForFilterBinding(filter : ITypeFilter, type : Class<Dynamic>, view : Dynamic) : Void {
        var requiredType : Class<Dynamic>;
        var requiredTypes : Array<Class<Dynamic>> = requiredTypesFor(filter, type);
        for(requiredType in requiredTypes/* AS3HX WARNING could not determine type for var: requiredType exp: EIdent(requiredTypes) type: Array<Class<Dynamic>>*/) {
            _injector.mapValue(requiredType,view);
        }

    }

    function unmapTypeForFilterBinding(filter : ITypeFilter, type : Class<Dynamic>, view : Dynamic) : Void {
        var requiredType : Class<Dynamic>;
        var requiredTypes : Array<Class<Dynamic>> = requiredTypesFor(filter, type);
        for(requiredType in requiredTypes/* AS3HX WARNING could not determine type for var: requiredType exp: EIdent(requiredTypes) type: Array<Class<Dynamic>>*/) {
            if(_injector.hasMapping(requiredType)) 
                _injector.unmap(requiredType);
        }

    }

    function requiredTypesFor(filter : ITypeFilter, type : Class<Dynamic>) : Array<Class<Dynamic>> {
        var requiredTypes : Array<Class<Dynamic>> = filter.allOfTypes.concat(filter.anyOfTypes);
        if(Lambda.indexOf(requiredTypes,type) == -1) 
            requiredTypes.push(type);
        return requiredTypes;
    }

}

