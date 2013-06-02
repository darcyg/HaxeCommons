package robotlegs.bender.extensions.viewprocessormap.impl;

import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorMapping;
import robotlegs.bender.extensions.viewprocessormap.dsl.IViewProcessorMappingConfig;
import robotlegs.bender.extensions.matching.ITypeFilter;
import robotlegs.bender.framework.impl.MappingConfigValidator;

class ViewProcessorMapping implements IViewProcessorMapping implements IViewProcessorMappingConfig {
    public var matcher(getMatcher, never) : ITypeFilter;
    public var processor(getProcessor, setProcessor) : Dynamic;
    public var processorClass(getProcessorClass, never) : Class<Dynamic>;
    public var guards(getGuards, never) : Array<Dynamic>;
    public var hooks(getHooks, never) : Array<Dynamic>;

    var _locked : Bool;
    var _validator : MappingConfigValidator;
    public function new(matcher : ITypeFilter, processor : Dynamic) {
        _locked = false;
        _guards = [];
        _hooks = [];
        _matcher = matcher;
        setProcessor(processor);
    }

    //---------------------------------------
        // IViewProcessorMapping Implementation
        //---------------------------------------
        var _matcher : ITypeFilter;
    public function getMatcher() : ITypeFilter {
        return _matcher;
    }

    var _processor : Dynamic;
    public function getProcessor() : Dynamic {
        return _processor;
    }

    public function setProcessor(value : Dynamic) : Dynamic {
        _processor = value;
        return value;
    }

    var _processorClass : Class<Dynamic>;
    public function getProcessorClass() : Class<Dynamic> {
        return _processorClass;
    }

    var _guards : Array<Dynamic>;
    public function getGuards() : Array<Dynamic> {
        return _guards;
    }

    var _hooks : Array<Dynamic>;
    public function getHooks() : Array<Dynamic> {
        return _hooks;
    }

    //---------------------------------------
        // IViewProcessorMappingConfig Implementation
        //---------------------------------------
        public function withGuards() : IViewProcessorMappingConfig {
        _validator && _validator.checkGuards(guards);
        _guards = _guards.concat.apply(null, guards);
        return this;
    }

    public function withHooks() : IViewProcessorMappingConfig {
        _validator && _validator.checkHooks(hooks);
        _hooks = _hooks.concat.apply(null, hooks);
        return this;
    }

    function setProcessor(processor : Dynamic) : Void {
        if(Std.is(processor, Class))  {
            _processorClass = Type.getClass(processor);
        }

        else  {
            _processor = processor;
            _processorClass = _processor.constructor;
        }

    }

    function invalidate() : Void {
        if(_validator != null) 
            _validator.invalidate()
        else createValidator();
        _guards = [];
        _hooks = [];
    }

    public function validate() : Void {
        if(_validator == null)  {
            createValidator();
        }

        else if(!_validator.valid)  {
            _validator.validate(_guards, _hooks);
        }
    }

    function createValidator() : Void {
        var useProcessor : Dynamic = (_processor) ? _processor : _processorClass;
        _validator = new MappingConfigValidator(_guards.slice(), _hooks.slice(), _matcher, useProcessor);
    }

}

