package robotlegs.bender.extensions.viewprocessormap.dsl;

import robotlegs.bender.extensions.matching.ITypeFilter;

interface IViewProcessorMapping {
    var matcher(getMatcher, never) : ITypeFilter;
    var processor(getProcessor, setProcessor) : Dynamic;
    var processorClass(getProcessorClass, never) : Class<Dynamic>;
    var guards(getGuards, never) : Array<Dynamic>;
    var hooks(getHooks, never) : Array<Dynamic>;

    function getMatcher() : ITypeFilter;
    function getProcessor() : Dynamic;
    function setProcessor(value : Dynamic) : Dynamic;
    function getProcessorClass() : Class<Dynamic>;
    function getGuards() : Array<Dynamic>;
    function getHooks() : Array<Dynamic>;
    function validate() : Void;
}

