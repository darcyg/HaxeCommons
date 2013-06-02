package robotlegs.bender.extensions.viewprocessormap.impl;

import openfl.ObjectHash;
import robotlegs.bender.extensions.matching.ITypeFilter;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorMapper;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorMapping;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorMappingConfig;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorUnmapper;
import robotlegs.bender.extensions.viewprocessormap.impl.IViewProcessorViewHandler;

class ViewProcessorMapper implements IViewProcessorMapper implements IViewProcessorUnmapper {

    var _handler : IViewProcessorViewHandler;
    var _matcher : ITypeFilter;
    var _mappings : ObjectHash<Dynamic,Dynamic>;
    public function new(matcher : ITypeFilter, handler : IViewProcessorViewHandler) {
        _mappings = new ObjectHash();
        _handler = handler;
        _matcher = matcher;
    }

    //---------------------------------------
        // IViewProcessorMapper Implementation
        //---------------------------------------
        public function toProcess(processClassOrInstance : Dynamic) : IViewProcessorMappingConfig {
        return lockedMappingFor(processClassOrInstance) || createMapping(processClassOrInstance);
    }

    public function toInjection() : IViewProcessorMappingConfig {
        return toProcess(ViewInjectionProcessor);
    }

    public function toNoProcess() : IViewProcessorMappingConfig {
        return toProcess(NullProcessor);
    }

    //---------------------------------------
        // IViewProcessorUnmapper Implementation
        //---------------------------------------
        public function fromProcess(processorClassOrInstance : Dynamic) : Void {
        var mapping : IViewProcessorMapping = _mappings.get(processorClassOrInstance);
        _mappings.remove(processorClassOrInstance);
        _handler.removeMapping(mapping);
    }

    public function fromProcesses() : Void {
        for(processor in _mappings) {
            fromProcess(processor);
        }

    }

    public function fromNoProcess() : Void {
        fromProcess(NullProcessor);
    }

    public function fromInjection() : Void {
        fromProcess(ViewInjectionProcessor);
    }

    function createMapping(processor : Dynamic) : ViewProcessorMapping {
        var mapping : ViewProcessorMapping = new ViewProcessorMapping(_matcher, processor);
        _handler.addMapping(mapping);
        _mappings.set(processor, mapping);
        return mapping;
    }

    function lockedMappingFor(processorClassOrInstance : Dynamic) : ViewProcessorMapping {
        var mapping : ViewProcessorMapping = _mappings.get(processorClassOrInstance);
        if(mapping != null) 
            mapping.invalidate();
        return mapping;
    }

}

