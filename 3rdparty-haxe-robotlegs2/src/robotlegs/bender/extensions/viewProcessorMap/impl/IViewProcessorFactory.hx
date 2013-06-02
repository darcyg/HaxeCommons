package robotlegs.bender.extensions.viewprocessormap.impl;

interface IViewProcessorFactory {

    function runProcessors(view : Dynamic, type : Class<Dynamic>, processorMappings : Array<Dynamic>) : Void;
    function runUnprocessors(view : Dynamic, type : Class<Dynamic>, processorMappings : Array<Dynamic>) : Void;
    function runAllUnprocessors() : Void;
}

