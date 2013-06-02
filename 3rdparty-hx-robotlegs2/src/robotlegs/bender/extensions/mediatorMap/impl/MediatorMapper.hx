//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.impl;

import openfl.ObjectHash;
import robotlegs.bender.extensions.mediatormap.api.IMediatorMapping;
import robotlegs.bender.extensions.mediatormap.api.IMediatorViewHandler;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorMapper;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorMappingConfig;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorMappingFinder;
import robotlegs.bender.extensions.mediatormap.dsl.IMediatorUnmapper;
import robotlegs.bender.extensions.matching.ITypeMatcher;
import robotlegs.bender.extensions.matching.ITypeFilter;

class MediatorMapper implements IMediatorMapper implements IMediatorMappingFinder implements IMediatorUnmapper {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _mappings : ObjectHash<Dynamic,Dynamic>;
    var _matcher : ITypeFilter;
    var _handler : IMediatorViewHandler;
    /*============================================================================*/    
    /* Constructor                                                                */    
    /*============================================================================*/    
    public function new(matcher : ITypeFilter, handler : IMediatorViewHandler) {
        _mappings = new ObjectHash();
        _matcher = matcher;
        _handler = handler;
    }

    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function toMediator(mediatorClass : Class<Dynamic>) : IMediatorMappingConfig {
        var result:IMediatorMappingConfig = lockedMappingFor(mediatorClass);
        if (result == null)
        {
            result = createMapping(mediatorClass);
        }
        return result;
    }

    public function forMediator(mediatorClass : Class<Dynamic>) : IMediatorMapping {
        return _mappings.get(mediatorClass);
    }

    public function fromMediator(mediatorClass : Class<Dynamic>) : Void {
        var mapping : IMediatorMapping = _mappings.get(mediatorClass);
        _mappings.remove(mediatorClass);
        _handler.removeMapping(mapping);
    }

    public function fromMediators() : Void {
        for(mapping in _mappings/* AS3HX WARNING could not determine type for var: mapping exp: EIdent(_mappings) type: Dictionary*/) {
            _mappings.remove(mapping.mediatorClass);
            _handler.removeMapping(cast(mapping,IMediatorMapping));
        }

    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function createMapping(mediatorClass : Class<Dynamic>) : MediatorMapping {
        var mapping : MediatorMapping = new MediatorMapping(_matcher, mediatorClass);
        _handler.addMapping(mapping);
        _mappings.set(mediatorClass, mapping);
        return mapping;
    }

    function lockedMappingFor(mediatorClass : Class<Dynamic>) : MediatorMapping {
        var mapping : MediatorMapping = _mappings.get(mediatorClass);
        if(mapping != null) 
            mapping.invalidate();
        return mapping;
    }

}

