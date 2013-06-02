package robotlegs.bender.extensions.viewprocessormap.dsl;

interface IViewProcessorMapper {

    function toProcess(processClassOrInstance : Dynamic) : IViewProcessorMappingConfig;
    function toInjection() : IViewProcessorMappingConfig;
    function toNoProcess() : IViewProcessorMappingConfig;
}

