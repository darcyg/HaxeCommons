package robotlegs.bender.extensions.viewprocessormap.dsl;

interface IViewProcessorMappingConfig {

    function withGuards(guards:Array<Dynamic>) : IViewProcessorMappingConfig;
    function withHooks(hooks:Array<Dynamic>) : IViewProcessorMappingConfig;
}

