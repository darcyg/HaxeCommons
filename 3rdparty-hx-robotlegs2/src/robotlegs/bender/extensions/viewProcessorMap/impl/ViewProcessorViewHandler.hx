//------------------------------------------------------------------------------
//  Copyright (c) 2011 the original author or authors. All Rights Reserved.
//
//  NOTICE: You are permitted to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//------------------------------------------------------------------------------
package robotlegs.bender.extensions.viewprocessormap.impl;

import openfl.ObjectHash;
import robotlegs.bender.extensions.matching.ITypeFilter;
import flash.display.DisplayObject;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorMapping;

class ViewProcessorViewHandler implements IViewProcessorViewHandler {

    /*============================================================================*/    
    /* Private Properties                                                         */    
    /*============================================================================*/    
    var _mappings : Array<Dynamic>;
    var _knownMappings : ObjectHash<Dynamic,Dynamic>;
    var _factory : IViewProcessorFactory;
    /*============================================================================*/    
    /* Public Functions                                                           */    
    /*============================================================================*/    
    @inject
    public function new(factory : IViewProcessorFactory) {
        _mappings = [];
        _knownMappings = new ObjectHash();
        _factory = factory;
    }

    public function addMapping(mapping : IViewProcessorMapping) : Void {
        var index : Int = _mappings.indexOf(mapping);
        if(index > -1) 
            return;
        _mappings.push(mapping);
        flushCache();
    }

    public function removeMapping(mapping : IViewProcessorMapping) : Void {
        var index : Int = _mappings.indexOf(mapping);
        if(index == -1) 
            return;
        _mappings.splice(index, 1);
        flushCache();
    }

    public function processItem(item : Dynamic, type : Class<Dynamic>) : Void {
        var interestedMappings : Array<Dynamic> = getInterestedMappingsFor(item, type);
        if(interestedMappings != null) 
            _factory.runProcessors(item, type, interestedMappings);
    }

    public function unprocessItem(item : Dynamic, type : Class<Dynamic>) : Void {
        var interestedMappings : Array<Dynamic> = getInterestedMappingsFor(item, type);
        if(interestedMappings != null) 
            _factory.runUnprocessors(item, type, interestedMappings);
    }

    /*============================================================================*/    /* Private Functions                                                          */    /*============================================================================*/    function flushCache() : Void {
        _knownMappings = new ObjectHash(true);
    }

    function getInterestedMappingsFor(view : Dynamic, type : Class<Dynamic>) : Array<Dynamic> {
        var mapping : IViewProcessorMapping;
        // we've seen this type before and nobody was interested
        if(_knownMappings.get(type) == false) 
            return null;
        // we haven't seen this type before
        if(_knownMappings.get(type) == null)  {
            _knownMappings.set(type, false);
            for(mapping in _mappings) {
                mapping.validate();
                if(mapping.matcher.matches(view))  {
                    if (!_knownMappings.exists(type))
                    {
                        _knownMappings.set(type, [])
                    }
                    _knownMappings.get(type).push(mapping);
                }
            }

            // nobody cares, let's get out of here
            if(_knownMappings.get(type) == false) 
                return null;
        }
;
        // these mappings really do care
        return _knownMappings.get(type);
    }

}

