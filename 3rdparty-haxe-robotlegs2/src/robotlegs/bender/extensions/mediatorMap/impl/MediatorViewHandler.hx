//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.mediatormap.impl;

import openfl.ObjectHash;
import robotlegs.bender.extensions.mediatormap.api.IMediatorViewHandler;
import robotlegs.bender.extensions.mediatormap.api.IMediatorMapping;
import robotlegs.bender.extensions.matching.ITypeFilter;
import robotlegs.bender.extensions.mediatormap.api.IMediatorFactory;
import flash.display.DisplayObject;
import robotlegs.bender.framework.api.ILogger;

class MediatorViewHandler implements IMediatorViewHandler {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _mappings : Array<IMediatorMapping>;
    var _knownMappings : ObjectHash<Class<Dynamic>,Dynamic>;
    
    var _factory : IMediatorFactory;
                
    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    public function new(factory : IMediatorFactory) {
        _mappings = [];
        _knownMappings = new ObjectHash();
        _factory = factory;
    }

    public function addMapping(mapping : IMediatorMapping) : Void {
        //nme.Lib.trace(this + "::" + "addMapping" + "::" + mapping);
        var index : Int = Lambda.indexOf(_mappings,mapping);
        if(index > -1) 
            return;
        _mappings.push(mapping);
        flushCache();
    }

    public function removeMapping(mapping : IMediatorMapping) : Void {
        //nme.Lib.trace(this + "::" + "removeMapping" + "::" + mapping);
        var index : Int = Lambda.indexOf(_mappings,mapping);
        if(index == -1) 
            return;
        _mappings.splice(index, 1);
        flushCache();
    }

    public function handleView(view : DisplayObject, type : Class<Dynamic>) : Void {
        var interestedMappings : Array<IMediatorMapping> = getInterestedMappingsFor(view, type);
        //nme.Lib.trace(this + "::" + "handleView" + "::" + view + "::" + type + "::" + interestedMappings);
        if(interestedMappings != null) 
            _factory.createMediators(view, type, interestedMappings);
    }

    public function handleItem(item : Dynamic, type : Class<Dynamic>) : Void {
        var interestedMappings : Array<IMediatorMapping> = getInterestedMappingsFor(item, type);
        //nme.Lib.trace(this + "::" + "handleItem" + "::" + item + "::" + type + "::" + interestedMappings);
        if(interestedMappings != null) 
            _factory.createMediators(item, type, interestedMappings);
    }

    /*============================================================================*/    
    /* Private Functions                                                          */    
    /*============================================================================*/    
    function flushCache() : Void {
        _knownMappings = new ObjectHash();
    }

    function getInterestedMappingsFor(view : Dynamic, type : Class<Dynamic>) : Array<IMediatorMapping> {
        //nme.Lib.trace(this + "::" + "getInterestedMappingsFor" + "::" + view + "::" + type);
        var mapping : IMediatorMapping;
        // we've seen this type before and nobody was interested
        if(_knownMappings.exists(type) && _knownMappings.get(type) == false) 
            return null;
        // we haven't seen this type before
        if(!_knownMappings.exists(type))  {
            _knownMappings.set(type, false);
            for(mapping in _mappings/* AS3HX WARNING could not determine type for var: mapping exp: EIdent(_mappings) type: Array<Dynamic>*/) {
                mapping.validate();
                if(mapping.getMatcher().matches(view))  {
                    if (!_knownMappings.exists(type) || _knownMappings.get(type) == false)
                    {
                        _knownMappings.set(type,[]);  
                    }                    
                    _knownMappings.get(type).push(mapping);
                }
            }

            // nobody cares, let's get out of here
            if(_knownMappings.get(type) == false) 
                return null;
        }
        // these mappings really do care
        return _knownMappings.get(type);
    }

}

