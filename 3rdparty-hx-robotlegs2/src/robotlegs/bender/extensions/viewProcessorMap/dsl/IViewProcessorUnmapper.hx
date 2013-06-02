package robotlegs.bender.extensions.viewprocessormap.dsl;

interface IViewProcessorUnmapper {

    function fromProcess(processorClassOrInstance : Dynamic) : Void;
    function fromProcesses() : Void;
    function fromNoProcess() : Void;
    function fromInjection() : Void;
}

